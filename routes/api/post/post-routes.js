// ALL POST-RELATED ROUTES ARE HANDLED BY THIS FILE

const app = require('express').Router(),
  db = require('../../../config/db'),
  Post = require('../../../config/Post'),
  User = require('../../../config/User'),
  root = process.cwd(),
  upload = require('multer')({
    dest: `${root}/dist/temp/`,
  }),
  { ProcessImage, DeleteAllOfFolder } = require('../../../config/ImageProcessor')

// NSFW keyword filter
const NSFW_KEYWORDS = [
  'nsfw', 'xxx', 'porn', 'nude', 'naked', 'explicit',
  'gore', 'violence', 'abuse', 'drug', 'illegal',
]

const checkNSFW = (text) => {
  if (!text) return { isNSFW: false, flaggedWords: [] }
  const lower = text.toLowerCase()
  const flaggedWords = NSFW_KEYWORDS.filter(word => lower.includes(word))
  return { isNSFW: flaggedWords.length > 0, flaggedWords }
}

// POST [REQ = DESC, FILTER, LOCATION, TYPE, GROUP, IMAGES(FILES) ]
app.post('/post-it', upload.array('images', 10), async (req, res) => {
  try {
    let { id } = req.session,
      { desc, filter, location, type, group, isNSFW: isNSFWStr, filtersJson } = req.body,
      isNSFWClient = isNSFWStr === 'true',
      groupId = group === 'undefined' || !group ? 0 : parseInt(group, 10),
      path = require('path'),
      files = req.files || [],
      filtersArr = (() => {
        try { return JSON.parse(filtersJson || '[]') } catch (e) { return [] }
      })()

    // Check for NSFW content
    const nsfwResult = checkNSFW(desc)
    const finalIsNSFW = isNSFWClient || nsfwResult.isNSFW
    const postStatus = 'pending'
    const rejectionReason = finalIsNSFW ? `NSFW Review needed: ${nsfwResult.flaggedWords.join(', ')} (User Tagged: ${isNSFWClient})` : ''
    if (finalIsNSFW) {
      desc = desc ? `${desc} #nsfw` : '#nsfw'
    }

    // Process each uploaded file and collect filenames
    const processedFilenames = []
    for (let i = 0; i < files.length; i++) {
      const file = files[i]
      const ext = path.extname(file.originalname).toLowerCase()
      const filename = `instagram_${new Date().getTime()}_${i}${ext || '.jpg'}`
      const isVideo = file.mimetype && file.mimetype.startsWith('video/')

      if (isVideo) {
        // Copy video directly without jimp processing
        require('fs').copyFileSync(file.path, `${root}/dist/posts/${filename}`)
      } else {
        await ProcessImage({
          srcFile: file.path,
          destFile: `${root}/dist/posts/${filename}`,
        })
      }
      processedFilenames.push(filename)
    }

    DeleteAllOfFolder(`${root}/dist/temp/`)

    // Primary image = first file (for backward compat)
    const primaryImg = processedFilenames.length > 0 ? processedFilenames[0] : ''
    const primaryFilter = filtersArr[0] || filter || 'filter-normal'

    let insert = {
      user: id,
      description: desc,
      imgSrc: primaryImg,
      filter: primaryFilter,
      location,
      type,
      group_id: groupId,
      post_time: new Date().getTime(),
      status: postStatus,
      rejection_reason: rejectionReason,
      isNSFW: finalIsNSFW ? 1 : 0,
      nsfwTaggedByAuthor: isNSFWClient ? 1 : 0,
    }

    let { insertId } = await db.query('INSERT INTO posts SET ?', insert)

    // Insert all media into post_media table
    for (let i = 0; i < processedFilenames.length; i++) {
      await db.query('INSERT INTO post_media SET ?', {
        post_id: insertId,
        filename: processedFilenames[i],
        filter: filtersArr[i] || 'filter-normal',
        sort_order: i,
      })
    }

    let firstname = await User.getWhat('firstname', id),
      surname = await User.getWhat('surname', id)

    await db.toHashtag(desc, id, insertId)
    await User.mentionUsers(desc, id, insertId, 'post')

    let responseMsg = finalIsNSFW
      ? 'Posted! Your post is flagged as NSFW and is pending admin review.'
      : 'Posted! Your post is pending admin approval.'

    res.json({
      success: true,
      mssg: responseMsg,
      post_id: insertId,
      firstname,
      surname,
      filename: primaryImg,
      status: postStatus,
      nsfw_flagged: nsfwResult.isNSFW,
    })
  } catch (error) {
    db.catchError(error, res)
  }
})

// TAGS USERS FOR A POST [REQ = TAGS, POST_ID]
app.post('/tag-post', (req, res) => {
  let { tags, post_id } = req.body
  tags.forEach(async t => {
    let tagInsert = {
      post_id: post_id,
      user: t.user,
    }
    await db.query('INSERT INTO post_tags SET ?', tagInsert)
  })
  res.json(null)
})

// EDIT POST [REQ = POST, DESCRIPTION]
app.post('/edit-post', async (req, res) => {
  try {
    let { post_id, description } = req.body
    let { id } = req.session

    await db.query('UPDATE posts SET description=? WHERE post_id=?', [
      description,
      post_id,
    ])
    await db.query('DELETE FROM hashtags WHERE post_id=?', [post_id])
    await db.toHashtag(description, id, post_id)

    res.json({
      success: true,
      mssg: 'Post updated!!',
    })
  } catch (error) {
    db.catchError(error, res)
  }
})

// GET POST TAGS [REQ = POST]
app.post('/get-post-tags', async (req, res) => {
  let { post } = req.body,
    { id } = req.session,
    tags = await db.query(
      'SELECT post_tags.post_tag_id, post_tags.post_id, post_tags.user, users.username, users.firstname, users.surname FROM post_tags, users WHERE post_tags.post_id = ? AND post_tags.user = users.id ORDER BY post_tag_id DESC',
      [post]
    ),
    array = []

  for (let t of tags) {
    array.push({
      ...t,
      isFollowing: await User.isFollowing(id, t.user),
    })
  }

  res.json({
    tags: array,
    isPostMine: await Post.isPostMine(id, post),
  })
})

// UNTAG [REQ = POST, USER]
app.post('/untag', async (req, res) => {
  let { user, post } = req.body
  await db.query('DELETE FROM post_tags WHERE post_id=? AND user=?', [
    post,
    user,
  ])
  res.json('Hello, World!!')
})

// DELETE POST [REQ = POST]
app.post('/delete-post', async (req, res) => {
  try {
    await Post.deletePost({
      post: req.body.post,
      when: 'user',
    })
    res.json({
      success: true,
      mssg: 'Post deleted!!',
    })
  } catch (error) {
    db.catchError(error, res)
  }
})

module.exports = app
