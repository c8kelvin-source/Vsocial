// RETURNS MYSQL DATABASE (using Pool for auto-reconnect)

const mysql = require('mysql2'),
  { error, rainbow } = require('handy-log'),
  { MYSQL_HOST, MYSQL_PORT, MYSQL_USER, MYSQL_PASSWORD, MYSQL_DATABASE } = process.env

// CREATES A CONNECTION POOL (tự động reconnect, không bị "closed state")
const pool = mysql.createPool({
  host: MYSQL_HOST,
  port: MYSQL_PORT || 3306,
  user: MYSQL_USER,
  password: MYSQL_PASSWORD,
  database: MYSQL_DATABASE,
  charset: 'utf8mb4',
  connectionLimit: 10,       // tối đa 10 connection đồng thời
  waitForConnections: true,  // chờ nếu hết slot thay vì báo lỗi
  queueLimit: 0,             // không giới hạn hàng chờ
  enableKeepAlive: true,     // giữ connection sống
  keepAliveInitialDelay: 0,
})

// Kiểm tra kết nối khi khởi động
pool.getConnection((err, connection) => {
  if (err) {
    error(`MySQL Pool Error: ${err.message}`)
    return
  }
  rainbow(`MySQL Pool connected to ${MYSQL_DATABASE}`)
  connection.release()
})

module.exports = pool
