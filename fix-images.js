/**
 * fix-images.js
 * Gán lại imgSrc cho các bài đăng trong DB bằng các file ảnh
 * thực tế đang có trong dist/posts/
 * 
 * Chạy: node fix-images.js
 */

require('dotenv').config()
const fs = require('fs')
const path = require('path')
const mysql = require('mysql2/promise')

async function fixImages() {
  // Lấy danh sách file ảnh thực có trong dist/posts/
  const postsDir = path.join(process.cwd(), 'dist', 'posts')
  const availableFiles = fs.readdirSync(postsDir)
    .filter(f => /\.(jpg|jpeg|png|gif|webp|mp4|webm)$/i.test(f))
    .sort()

  if (availableFiles.length === 0) {
    console.error('❌ Không có file ảnh nào trong dist/posts/')
    process.exit(1)
  }

  console.log(`✅ Tìm thấy ${availableFiles.length} file ảnh trong dist/posts/`)
  console.log('📋 Danh sách:', availableFiles.slice(0, 5).join(', '), '...')

  // Kết nối DB
  const conn = await mysql.createConnection({
    host: process.env.MYSQL_HOST || 'localhost',
    port: process.env.MYSQL_PORT || 3306,
    user: process.env.MYSQL_USER || 'root',
    password: process.env.MYSQL_PASSWORD || '',
    database: process.env.MYSQL_DATABASE || 'vsocial',
  })

  console.log(`\n🔌 Đã kết nối DB: ${process.env.MYSQL_DATABASE}`)

  // Lấy tất cả bài đăng có imgSrc không khớp với file thực
  const [posts] = await conn.query(
    "SELECT post_id, imgSrc FROM posts WHERE imgSrc != '' AND imgSrc IS NOT NULL ORDER BY post_id"
  )

  console.log(`\n📦 Tổng số bài đăng có ảnh trong DB: ${posts.length}`)

  let fixedCount = 0
  let okCount = 0

  for (let i = 0; i < posts.length; i++) {
    const { post_id, imgSrc } = posts[i]
    const filePath = path.join(postsDir, imgSrc)

    if (fs.existsSync(filePath)) {
      // File đã có sẵn, không cần sửa
      okCount++
      continue
    }

    // File không tồn tại → gán file ảnh theo vòng tròn
    const replacementFile = availableFiles[i % availableFiles.length]

    await conn.query(
      'UPDATE posts SET imgSrc = ? WHERE post_id = ?',
      [replacementFile, post_id]
    )

    console.log(`  🔄 post_id=${post_id}: ${imgSrc} → ${replacementFile}`)
    fixedCount++
  }

  await conn.end()

  console.log('\n========================================')
  console.log(`✅ Hoàn tất!`)
  console.log(`   - Bài đã có ảnh đúng: ${okCount}`)
  console.log(`   - Bài đã được sửa:    ${fixedCount}`)
  console.log('========================================')
  console.log('\n🚀 Restart server để áp dụng: npm start')
}

fixImages().catch(err => {
  console.error('❌ Lỗi:', err.message)
  process.exit(1)
})
