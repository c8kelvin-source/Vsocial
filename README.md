# 🌐 Vsocial — Mạng Xã Hội Clone Instagram

> Ứng dụng mạng xã hội full-stack được xây dựng với **Node.js**, **Express**, **React**, **Redux** và **MySQL**.  
> Tính năng: đăng bài, bình luận, theo dõi, nhắn tin real-time (Socket.io), thông báo, quản trị viên, v.v.

---

## 📋 Mục Lục

1. [Yêu cầu hệ thống](#-yêu-cầu-hệ-thống)
2. [Cài đặt môi trường](#-bước-1--cài-đặt-môi-trường)
3. [Clone dự án](#-bước-2--clone-dự-án)
4. [Cài đặt dependencies](#-bước-3--cài-đặt-dependencies)
5. [Cấu hình biến môi trường](#-bước-4--cấu-hình-biến-môi-trường-env)
6. [Thiết lập cơ sở dữ liệu](#-bước-5--thiết-lập-cơ-sở-dữ-liệu-mysql)
7. [Build frontend](#-bước-6--build-frontend-webpack)
8. [Chạy ứng dụng](#-bước-7--chạy-ứng-dụng)
9. [Kiểm tra & Test](#-bước-8--kiểm-tra--test)
10. [Cấu trúc dự án](#-cấu-trúc-dự-án)
11. [Biến môi trường chi tiết](#-biến-môi-trường-chi-tiết)
12. [Lỗi thường gặp](#-lỗi-thường-gặp)

---

## 🖥️ Yêu Cầu Hệ Thống

Trước khi bắt đầu, hãy đảm bảo máy tính của bạn đã có các phần mềm sau:

| Phần mềm | Phiên bản tối thiểu | Kiểm tra |
|----------|---------------------|----------|
| **Node.js** | v14.x trở lên | `node -v` |
| **npm** | v6.x trở lên | `npm -v` |
| **MySQL** | 5.7 hoặc 8.x | `mysql --version` |
| **Git** | Bất kỳ | `git --version` |

> 💡 **Khuyến nghị**: Dùng Node.js v16 hoặc v18 LTS để đảm bảo tương thích tốt nhất.

---

## 🔧 Bước 1 — Cài Đặt Môi Trường

### 1.1 Cài đặt Node.js

1. Truy cập [https://nodejs.org](https://nodejs.org) và tải phiên bản **LTS** (Long Term Support).
2. Chạy file cài đặt và làm theo hướng dẫn.
3. Mở **Terminal / Command Prompt** và xác nhận:

```bash
node -v
# Kết quả mong đợi: v16.x.x hoặc v18.x.x

npm -v
# Kết quả mong đợi: v8.x.x
```

### 1.2 Cài đặt MySQL

**Windows:**
1. Tải **MySQL Installer** tại [https://dev.mysql.com/downloads/installer/](https://dev.mysql.com/downloads/installer/)
2. Chọn gói **MySQL Community Server**
3. Trong quá trình cài đặt:
   - Đặt **root password** (ví dụ: `yourpassword`) — **ghi nhớ lại**
   - Port mặc định: `3306`
4. Kiểm tra MySQL đang chạy:

```bash
mysql --version
# Kết quả: mysql  Ver 8.x.x ...
```

**macOS (Homebrew):**
```bash
brew install mysql
brew services start mysql
mysql_secure_installation
```

**Ubuntu/Debian:**
```bash
sudo apt update
sudo apt install mysql-server
sudo systemctl start mysql
sudo mysql_secure_installation
```

### 1.3 Cài đặt Git

Tải tại [https://git-scm.com/downloads](https://git-scm.com/downloads) và làm theo hướng dẫn.

---

## 📥 Bước 2 — Clone Dự Án

Mở Terminal và chạy lệnh sau để tải mã nguồn về máy:

```bash
# Clone repository về thư mục hiện tại
git clone <URL_REPO_CỦA_BẠN> vsocial

# Di chuyển vào thư mục dự án
cd vsocial
```

> Nếu bạn đã có mã nguồn sẵn (ví dụ: tải zip), chỉ cần `cd` vào thư mục chứa dự án.

---

## 📦 Bước 3 — Cài Đặt Dependencies

Trong thư mục gốc của dự án, chạy lệnh sau để cài tất cả thư viện cần thiết:

```bash
npm install
```

Lệnh này sẽ đọc file `package.json` và tự động tải về tất cả packages (bao gồm Express, React, Redux, Socket.io, MySQL2, v.v.).

**Quá trình có thể mất 2–5 phút** tùy tốc độ mạng. Sau khi hoàn tất, thư mục `node_modules/` sẽ được tạo ra.

```bash
# Kiểm tra cài đặt thành công
ls node_modules/
# Bạn sẽ thấy hàng trăm thư mục packages
```

---

## ⚙️ Bước 4 — Cấu Hình Biến Môi Trường (`.env`)

Dự án sử dụng file `.env` để lưu trữ các thông tin cấu hình nhạy cảm.

### 4.1 Tạo file `.env`

File `.env` **có thể đã tồn tại** trong thư mục dự án. Nếu chưa có, tạo mới:

```bash
# Windows (Command Prompt)
copy .env.example .env

# Windows (PowerShell) hoặc macOS/Linux
cp .env.example .env
```

Nếu không có file `.env.example`, tạo file `.env` mới với nội dung sau:

```bash
# Windows PowerShell
New-Item -Name ".env" -ItemType "file"
```

### 4.2 Chỉnh sửa file `.env`

Mở file `.env` bằng trình soạn thảo (VS Code, Notepad++...) và cập nhật các giá trị:

```env
# ================================
# SERVER CONFIGURATION
# ================================
PORT=8000
SESSION_SECRET_LETTER="chuoi-bi-mat-bat-ky-cua-ban"

# ================================
# DATABASE CONFIGURATION
# ================================
MYSQL_HOST="localhost"
MYSQL_PORT="3306"
MYSQL_USER="root"
MYSQL_PASSWORD="password-mysql-cua-ban"
MYSQL_DATABASE="vsocial"

# ================================
# EMAIL CONFIGURATION (Nodemailer)
# ================================
# Dùng Gmail App Password (không phải mật khẩu Gmail thường)
MAIL="email-cua-ban@gmail.com"
MAIL_PASSWORD="mat-khau-ung-dung-gmail"

# ================================
# OPTIONAL KEYS
# ================================
GOOGLE_GEOLOCATION_KEY='google-geolocation-api-key'
ADMIN_PASSWORD='mat-khau-admin-cua-ban'
JWT_SECRET='chuoi-bi-mat-jwt-dai-va-phuc-tap'
```

> ⚠️ **Lưu ý quan trọng:**
> - `MYSQL_PASSWORD` phải khớp với mật khẩu root bạn đặt khi cài MySQL
> - `MAIL_PASSWORD` là **App Password** của Gmail, không phải mật khẩu đăng nhập
> - Không bao giờ commit file `.env` lên Git (đã có trong `.gitignore`)

### 4.3 Tạo Gmail App Password (cho tính năng email)

1. Đăng nhập vào Gmail → **Tài khoản Google** → **Bảo mật**
2. Bật **Xác minh 2 bước** (nếu chưa bật)
3. Tìm mục **Mật khẩu ứng dụng** → Tạo mật khẩu mới
4. Chọn **Ứng dụng khác** → Đặt tên (ví dụ: "Vsocial") → **Tạo**
5. Copy mật khẩu 16 ký tự và dán vào `MAIL_PASSWORD` trong file `.env`

---

## 🗄️ Bước 5 — Thiết Lập Cơ Sở Dữ Liệu MySQL

### 5.1 Đăng nhập MySQL

Mở Terminal và đăng nhập vào MySQL với tài khoản root:

```bash
mysql -u root -p
# Nhập mật khẩu root khi được hỏi
```

### 5.2 Chạy script thiết lập tự động

Dự án cung cấp script `setup-db.js` để tự động tạo database và chạy tất cả migrations. Thoát khỏi MySQL console và chạy:

```bash
# Thoát MySQL console (nếu đang ở trong)
exit

# Chạy script setup database
node setup-db.js
```

Script này sẽ tự động:
- ✅ Kết nối MySQL bằng thông tin trong `.env`
- ✅ Tạo database `vsocial` (nếu chưa có)
- ✅ Import toàn bộ schema từ `db.sql`
- ✅ Chạy các migration cần thiết (thêm cột, bảng mới...)
- ✅ Bỏ qua các bước đã thực hiện trước đó (idempotent)

**Kết quả thành công sẽ hiện:**
```
========================================
🔌 Connected to MySQL at localhost:3306
🏗️  Creating database: vsocial...
========================================

✅ Database created/exists. Switching to database vsocial...
📄 Reading db.sql...
⚡ Executing base db.sql...
✅ Base db.sql executed successfully.
Now running migrations...
✅ Executed: ALTER TABLE `users` ADD COLUMN `nickname` VARCHAR(255)...
✅ Executed: ALTER TABLE `posts` ADD COLUMN `isNSFW` TINYINT(1)...
...
🎉 Database setup & migration complete! X migrations executed, Y skipped/already applied.
```

### 5.3 Kiểm tra database (tuỳ chọn)

```bash
mysql -u root -p -e "USE vsocial; SHOW TABLES;"
```

Bạn sẽ thấy danh sách các bảng như: `users`, `posts`, `comments`, `notifications`, `friend_requests`, v.v.

---

## 🏗️ Bước 6 — Build Frontend (Webpack)

Dự án sử dụng **Webpack** để bundle React/JS frontend. Có 2 chế độ:

### Chế độ Development (có hot-reload, dùng khi phát triển):

```bash
npm run dev
```

Webpack sẽ theo dõi thay đổi file và tự động rebuild. Để chạy song song với server, mở **2 terminal riêng biệt**.

### Chế độ Production (tối ưu cho triển khai):

```bash
npm run prod
```

> ⏳ Lần build đầu tiên có thể mất 1–3 phút. Sau khi hoàn tất, thư mục `dist/` sẽ chứa các file bundle.

---

## 🚀 Bước 7 — Chạy Ứng Dụng

### 7.1 Mở 2 terminal song song

**Terminal 1 — Build frontend (watch mode):**

```bash
npm run dev
```

**Terminal 2 — Khởi động server Node.js:**

```bash
npm start
```

Server sử dụng **Nodemon** nên sẽ tự động restart khi bạn thay đổi file server.

### 7.2 Truy cập ứng dụng

Mở trình duyệt và vào địa chỉ:

```
http://localhost:8000
```

🎉 **Nếu thấy trang đăng ký/đăng nhập xuất hiện — bạn đã cài đặt thành công!**

### 7.3 Tạo tài khoản Admin

Đăng ký tài khoản người dùng bình thường trước, sau đó truy cập trang admin:

```
http://localhost:8000/admin
```

Nhập `ADMIN_PASSWORD` từ file `.env` để đăng nhập admin.

---

## 🧪 Bước 8 — Kiểm Tra & Test

### Chạy toàn bộ test suite:

```bash
npm test
```

### Chạy test ở chế độ watch (tự chạy lại khi có thay đổi):

```bash
npm run test:watch
```

### Kiểm tra code coverage:

```bash
npm run test:coverage
```

### Kiểm tra lỗi ESLint:

```bash
npm run eslint src/
```

---

## 📁 Cấu Trúc Dự Án

```
vsocial/
│
├── 📄 app.js                  # Entry point chính của server
├── 📄 app-routes.js           # Định nghĩa tất cả routes
├── 📄 setup-db.js             # Script thiết lập database
├── 📄 db.sql                  # Schema SQL gốc
├── 📄 package.json            # Dependencies và scripts
├── 📄 webpack.config.js       # Cấu hình Webpack
├── 📄 .env                    # Biến môi trường (KHÔNG commit)
├── 📄 .babelrc                # Cấu hình Babel
│
├── 📂 config/                 # Các module cấu hình
│   ├── Mysql.js               # Kết nối MySQL
│   ├── Socket.js              # Khởi tạo Socket.io
│   ├── Middlewares.js         # Express middlewares
│   ├── Mail.js                # Cấu hình Nodemailer
│   ├── JWT.js                 # JSON Web Token helpers
│   ├── User.js                # Logic nghiệp vụ người dùng
│   ├── Post.js                # Logic nghiệp vụ bài đăng
│   └── ...
│
├── 📂 routes/                 # Express route handlers
│
├── 📂 src/                    # Frontend React (source)
│   ├── main.js                # Entry point React
│   ├── 📂 components/         # React components
│   ├── 📂 actions/            # Redux actions
│   ├── 📂 store/              # Redux store
│   └── 📂 user-system/        # Hệ thống xác thực người dùng
│
├── 📂 views/                  # Handlebars templates (HBS)
├── 📂 styles/                 # CSS/SCSS styles
├── 📂 dist/                   # Output build (tự động tạo)
└── 📂 scripts/                # Utility scripts
```

---

## 🔑 Biến Môi Trường Chi Tiết

| Biến | Bắt buộc | Mô tả | Ví dụ |
|------|----------|-------|-------|
| `PORT` | ✅ | Cổng server lắng nghe | `8000` |
| `SESSION_SECRET_LETTER` | ✅ | Chuỗi bí mật cho session | `"my-super-secret-key"` |
| `MYSQL_HOST` | ✅ | Host MySQL server | `"localhost"` |
| `MYSQL_PORT` | ✅ | Port MySQL | `"3306"` |
| `MYSQL_USER` | ✅ | Tên người dùng MySQL | `"root"` |
| `MYSQL_PASSWORD` | ✅ | Mật khẩu MySQL | `"yourpassword"` |
| `MYSQL_DATABASE` | ✅ | Tên database | `"vsocial"` |
| `MAIL` | ⚠️ | Gmail dùng để gửi email | `"app@gmail.com"` |
| `MAIL_PASSWORD` | ⚠️ | Gmail App Password | `"xxxx xxxx xxxx xxxx"` |
| `GOOGLE_GEOLOCATION_KEY` | ❌ | Google Maps API key | `"AIza..."` |
| `ADMIN_PASSWORD` | ✅ | Mật khẩu trang admin | `"strongpassword"` |
| `JWT_SECRET` | ✅ | Chuỗi bí mật JWT | `"long-random-secret"` |

> **Chú thích:** ✅ = Bắt buộc | ⚠️ = Cần cho tính năng email | ❌ = Tuỳ chọn

---

## 🛠️ Scripts Có Sẵn

| Lệnh | Mô tả |
|------|-------|
| `npm start` | Khởi động server với Nodemon (auto-restart) |
| `npm run dev` | Webpack build development + watch mode |
| `npm run prod` | Webpack build production (minified) |
| `npm test` | Chạy Jest test suite |
| `npm run test:watch` | Jest ở chế độ watch |
| `npm run test:coverage` | Jest với báo cáo coverage |
| `npm run eslint` | Kiểm tra lỗi ESLint |
| `node setup-db.js` | Thiết lập database và chạy migrations |

---

## ❓ Lỗi Thường Gặp

### ❌ `Error: connect ECONNREFUSED 127.0.0.1:3306`

**Nguyên nhân:** MySQL chưa được khởi động.

**Giải pháp:**
```bash
# Windows (Services)
net start MySQL80

# macOS
brew services start mysql

# Linux
sudo systemctl start mysql
```

---

### ❌ `Access denied for user 'root'@'localhost'`

**Nguyên nhân:** Sai mật khẩu MySQL trong file `.env`.

**Giải pháp:** Kiểm tra lại `MYSQL_PASSWORD` trong `.env` phải khớp với mật khẩu root MySQL của bạn.

---

### ❌ `Cannot find module '...'`

**Nguyên nhân:** Chưa cài đặt dependencies.

**Giải pháp:**
```bash
# Xóa node_modules và cài lại
rm -rf node_modules
npm install
```

---

### ❌ `Port 8000 is already in use`

**Nguyên nhân:** Cổng 8000 đang được dùng bởi ứng dụng khác.

**Giải pháp:** Thay đổi `PORT` trong `.env`:
```env
PORT=3000
```
Hoặc tắt ứng dụng đang dùng cổng 8000:
```bash
# Windows
netstat -ano | findstr :8000
taskkill /PID <PID> /F

# macOS/Linux
lsof -ti:8000 | xargs kill
```

---

### ❌ Webpack build lỗi `SCSS/CSS`

**Nguyên nhân:** Thiếu sass compiler.

**Giải pháp:**
```bash
npm install sass --save-dev
```

---

### ❌ `SESSION_SECRET_LETTER is not set`

**Nguyên nhân:** File `.env` không được load đúng cách.

**Giải pháp:** Đảm bảo file `.env` nằm ở **thư mục gốc** của dự án (cùng cấp với `app.js`), không phải trong subfolder.

---

## 📄 License

Dự án được phát hành dưới [ISC License](./LICENSE).

---

## 🤝 Đóng Góp

1. Fork repository
2. Tạo branch mới: `git checkout -b feature/ten-tinh-nang`
3. Commit thay đổi: `git commit -m 'Add: mô tả thay đổi'`
4. Push lên branch: `git push origin feature/ten-tinh-nang`
5. Tạo Pull Request

---

<div align="center">
  <strong>Vsocial Team</strong> — Xây dựng với ❤️ bằng Node.js & React
</div>
