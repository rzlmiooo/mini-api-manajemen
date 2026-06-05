# Laporan UTS Praktikum Pemrograman Web Fullstack
## Mini API Manajemen Projek & Infrastruktur Server

**Oleh:** Rizal Maulana (2305101018 / 6B)  

---

## ERD Database & Relasi

Berdasarkan *Foreign Key* (FK) yang dirancang pada database, berikut adalah relasi antar tabelnya:

- **Project ke Task (One-to-Many)**
  Satu project dapat memiliki banyak task yang ditugaskan kepada developer. *Foreign key* `project_id` berada di tabel `tasks`.
- **Project ke Deployment (One-to-Many)**
  Satu project bisa di-deploy ke banyak server berbeda. *Foreign key* `project_id` berada di tabel `deployments`.
- **User ke Task (One-to-Many)**
  Satu user (developer) bisa ditugaskan ke banyak task dari berbagai project. *Foreign key* `user_id` berada di tabel `tasks`.
- **Server ke Deployment (One-to-Many)**
  Satu server bisa menjadi target deployment dari banyak project. *Foreign key* `server_id` berada di tabel `deployments`.

### Struktur Tabel

| Tabel | Kolom |
| :--- | :--- |
| `users` | id, name, email, password, role (enum: admin, manager, developer), timestamps |
| `projects` | id, name, description (text, nullable), status (enum: planning, ongoing, completed), timestamps |
| `tasks` | id, project_id (FK), user_id (FK), title, status (enum: todo, in_progress, done), timestamps |
| `servers` | id, name, ip_address, os, is_active (boolean), timestamps |
| `deployments` | id, project_id (FK), server_id (FK), deploy_date (datetime), status (enum: success, failed, pending), timestamps |

### Relasi Eloquent

```text
Project     → hasMany    → Tasks
Project     → hasMany    → Deployments
User        → hasMany    → Tasks (sebagai assignee)
Server      → hasMany    → Deployments
Task        → belongsTo  → Project
Task        → belongsTo  → User
Deployment  → belongsTo  → Project
Deployment  → belongsTo  → Server
```

---

## Daftar Endpoint API

| Modul | Method | Endpoint (Route) | Deskripsi & Akses |
| :--- | :---: | :--- | :--- |
| **Auth** | `POST` | `/api/register` | Mendaftarkan user baru (default role: developer) |
| | `POST` | `/api/login` | Login untuk mendapatkan Bearer Token |
| | `POST` | `/api/logout` | Logout dan menghapus Token aktif |
| **Projects** | `GET` | `/api/projects` | Menampilkan semua daftar project (Semua Role) |
| | `POST` | `/api/projects` | Membuat project baru (Manager / Admin) |
| | `PUT` | `/api/projects/{project}` | Update data project (Manager / Admin) |
| | `DELETE` | `/api/projects/{project}` | Hapus project — gagal jika memiliki task (Manager / Admin) |
| **Tasks** | `GET` | `/api/tasks` | List task (Admin/Manager: semua, Developer: milik sendiri) |
| | `POST` | `/api/tasks` | Membuat & assign task ke developer (Manager / Admin) |
| | `PUT` | `/api/tasks/{task}` | Update data task (Manager / Admin) |
| | `PUT` | `/api/tasks/{id}/status` | Update status task — todo/in_progress/done (Semua Role) |
| | `DELETE` | `/api/tasks/{task}` | Hapus task (Manager / Admin) |
| **Servers** | `GET` | `/api/servers` | List semua server infrastruktur (Admin Only) |
| | `POST` | `/api/servers` | Menambah server baru (Admin Only) |
| | `GET` | `/api/servers/{server}` | Detail satu server (Admin Only) |
| | `PUT` | `/api/servers/{server}` | Update data server (Admin Only) |
| | `DELETE` | `/api/servers/{server}` | Hapus server (Admin Only) |
| **Deployments** | `GET` | `/api/deployments` | List riwayat deployment (Admin Only) |
| | `POST` | `/api/deployments` | Mencatat deployment baru (Admin Only) |
| | `GET` | `/api/deployments/{deployment}` | Detail satu deployment (Admin Only) |
| | `PUT` | `/api/deployments/{deployment}` | Update data deployment (Admin Only) |
| | `DELETE` | `/api/deployments/{deployment}` | Hapus data deployment (Admin Only) |

---

## Akun Default (Seeder)

| Role | Nama | Email | Password |
| :--- | :--- | :--- | :--- |
| Admin | Admin User | admin@example.com | password |
| Manager | Manager User | manager@example.com | password |
| Developer | Developer 1 | dev1@example.com | password |
| Developer | Developer 2 | dev2@example.com | password |

---

## Testing & Dokumentasi API (Postman)

### 1. Auth
- `[POST]` `/api/register`

  [SCREENSHOT DI SINI]

- `[POST]` `/api/login` (Admin)

  [SCREENSHOT DI SINI]

- `[POST]` `/api/login` (Manager)

  [SCREENSHOT DI SINI]

- `[POST]` `/api/logout`

  [SCREENSHOT DI SINI]


### 2. Projects
- `[GET]` `/api/projects` (List Project)

  [SCREENSHOT DI SINI]

- `[POST]` `/api/projects` (Buat Project)

  [SCREENSHOT DI SINI]

- `[PUT]` `/api/projects/{project}` (Update Project)

  [SCREENSHOT DI SINI]

- `[DELETE]` `/api/projects/{project}` (Hapus Project)

  [SCREENSHOT DI SINI]


### 3. Tasks
- `[GET]` `/api/tasks` (List Task)

  [SCREENSHOT DI SINI]

- `[POST]` `/api/tasks` (Buat & Assign Task)

  [SCREENSHOT DI SINI]

- `[PUT]` `/api/tasks/{task}` (Update Task)

  [SCREENSHOT DI SINI]

- `[PUT]` `/api/tasks/{id}/status` (Update Status Task)

  [SCREENSHOT DI SINI]

- `[DELETE]` `/api/tasks/{task}` (Hapus Task)

  [SCREENSHOT DI SINI]


### 4. Servers
- `[GET]` `/api/servers` (List Server)

  [SCREENSHOT DI SINI]

- `[POST]` `/api/servers` (Tambah Server)

  [SCREENSHOT DI SINI]

- `[GET]` `/api/servers/{server}` (Detail Server)

  [SCREENSHOT DI SINI]

- `[PUT]` `/api/servers/{server}` (Update Server)

  [SCREENSHOT DI SINI]

- `[DELETE]` `/api/servers/{server}` (Hapus Server)

  [SCREENSHOT DI SINI]


### 5. Deployments
- `[GET]` `/api/deployments` (List Deployment)

  [SCREENSHOT DI SINI]

- `[POST]` `/api/deployments` (Catat Deployment)

  [SCREENSHOT DI SINI]

- `[GET]` `/api/deployments/{deployment}` (Detail Deployment)

  [SCREENSHOT DI SINI]

- `[PUT]` `/api/deployments/{deployment}` (Update Deployment)

  [SCREENSHOT DI SINI]

- `[DELETE]` `/api/deployments/{deployment}` (Hapus Deployment)

  [SCREENSHOT DI SINI]

---

## Format Response Standar

Semua response API mengikuti format JSON yang konsisten:

```json
// Sukses
{ "success": true, "message": "Berhasil mengambil data", "data": { ... } }

// Error validasi (422)
{ "success": false, "message": "Data tidak valid", "errors": { "field": ["pesan error"] } }

// Error akses / auth (401 / 403)
{ "success": false, "message": "Akses ditolak.", "errors": null }
```

---

## Header Wajib

```
Content-Type: application/json
Accept: application/json
Authorization: Bearer {token}   ← untuk route protected
```

---

## Middleware & Otorisasi

Sistem menggunakan dua middleware custom untuk mengontrol akses berdasarkan role:

| Middleware | Alias | Akses Diizinkan |
| :--- | :--- | :--- |
| `EnsureUserIsAdmin` | `role.admin` | Hanya role `admin` |
| `EnsureUserIsManager` | `role.manager` | Role `admin` atau `manager` |

**Pengelompokan Route berdasarkan Role:**
- **Public:** `POST /register`, `POST /login`
- **Semua Role (Token):** `GET /projects`, `GET /tasks`, `PUT /tasks/{id}/status`, `POST /logout`
- **Manager & Admin:** `POST/PUT/DELETE /projects`, `POST/PUT/DELETE /tasks`
- **Admin Only:** CRUD `/servers`, CRUD `/deployments`

---

## Kendala dan Solusi

* **Kendala:** Saat testing endpoint `Login`, token tidak bisa digunakan di endpoint lain karena Sanctum mengembalikan error `Unauthenticated`.
* **Solusi:** Perlu menambahkan header `Accept: application/json` di setiap request Postman agar Laravel mengenali request sebagai API dan mengembalikan response JSON, bukan redirect ke halaman login HTML.

* **Kendala:** Project dengan task di dalamnya tidak boleh dihapus secara langsung.
* **Solusi:** Ditambahkan pengecekan di `ProjectController@destroy` — jika project masih memiliki task, API mengembalikan error 422 dengan pesan yang jelas. Meskipun database sudah menggunakan `cascadeOnDelete()`, pengecekan di level aplikasi memberikan feedback yang lebih baik ke user.

---

## Langkah Instalasi Lokal

Ikuti langkah-langkah di bawah ini untuk menjalankan proyek **Mini API Manajemen Projek & Infrastruktur Server** secara lokal di komputer Anda.

### Persyaratan Sistem
Pastikan sistem Anda sudah terinstal:
- **PHP** (Minimal versi 8.1)
- **Composer** (Untuk manajemen dependensi PHP)
- **MySQL** (Atau aplikasi bundle seperti XAMPP/Laragon)
- **Git**

### Cara Instalasi

**1. Clone Repositori**

Buka terminal/command prompt, lalu jalankan perintah berikut:
```bash
git clone <repository-url>
```

**2. Masuk ke Direktori Proyek**
```bash
cd mini-api-manajemen
```

**3. Install Dependensi PHP (Composer)**

Jalankan perintah ini untuk menginstal semua library dan dependensi Laravel:
```bash
composer install
```

**4. Konfigurasi Environment (File .env)**

Salin file konfigurasi bawaan menjadi file `.env` yang aktif:
```bash
cp .env.example .env
```

**5. Generate Application Key**

Buat key unik untuk keamanan aplikasi Laravel Anda:
```bash
php artisan key:generate
```

**6. Konfigurasi Database**

- Buka aplikasi database client Anda (misalnya phpMyAdmin, DBeaver, dll).
- Buat database baru dengan nama `mini_api_manajemen` (atau sesuai keinginan).
- Buka file `.env` di text editor, lalu sesuaikan konfigurasi koneksi database:
```env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=mini_api_manajemen   # Ubah sesuai nama database Anda
DB_USERNAME=root                  # Username default XAMPP/Laragon
DB_PASSWORD=                      # Kosongkan jika tidak ada password
```

**7. Jalankan Migrasi & Seeder**

Setelah database terhubung, buat struktur tabel beserta data dummy menggunakan perintah:
```bash
php artisan migrate:fresh --seed
```

**8. Jalankan Local Development Server**

Terakhir, nyalakan server bawaan Laravel:
```bash
php artisan serve
```

Server akan berjalan di `http://localhost:8000`. Semua endpoint API bisa diakses melalui prefix `/api/`.

---

## Postman Collection

File Postman Collection tersedia di root project:
```
mini_api_manajemen_postman_collection.json
```

Import file ini ke Postman untuk langsung menguji semua endpoint API yang tersedia.

---

## Tech Stack

| Teknologi | Versi |
| :--- | :--- |
| PHP | ^8.1 |
| Laravel | ^10.10 |
| Laravel Sanctum | ^3.3 |
| MySQL | 8.0+ |
