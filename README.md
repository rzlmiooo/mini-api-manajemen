# Laporan UTS Praktikum Pemrograman Web Fullstack
## Mini API Manajemen Projek & Infrastruktur Server

**Oleh:** Rizal Maulana (2305101018 / 6B)  

---

## ERD Database & Relasi
<img width="3428" height="2298" alt="erd" src="https://github.com/user-attachments/assets/16c92aaf-7bbb-4ad2-aa1e-e727a9eed927" />
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

  <img width="1334" height="941" alt="image" src="https://github.com/user-attachments/assets/fab7c869-dc35-4538-9882-11c0fc20f051" />


- `[POST]` `/api/login` (Admin)

  <img width="1330" height="993" alt="image" src="https://github.com/user-attachments/assets/96ccd133-a21b-473a-969c-5c83c2ea7bb1" />


- `[POST]` `/api/login` (Manager)

  <img width="1338" height="1002" alt="image" src="https://github.com/user-attachments/assets/fa68a12b-d14a-4bb4-bfba-6aece88a0c9a" />


- `[POST]` `/api/logout`

  <img width="1332" height="744" alt="image" src="https://github.com/user-attachments/assets/1d952ba2-36e4-4443-8afa-40fae5e5a209" />



### 2. Projects
- `[GET]` `/api/projects` (List Project)

  <img width="1335" height="965" alt="image" src="https://github.com/user-attachments/assets/a244300b-41a3-4c1d-8c8a-280b7e183f2f" />


- `[POST]` `/api/projects` (Buat Project)

  <img width="1327" height="936" alt="image" src="https://github.com/user-attachments/assets/01004834-3a37-468d-9bc7-d593534bdc65" />


- `[PUT]` `/api/projects/{project}` (Update Project)

  <img width="1326" height="941" alt="image" src="https://github.com/user-attachments/assets/abba551a-bc6b-45d2-8020-e893441b6ea4" />


- `[DELETE]` `/api/projects/{project}` (Hapus Project)

  <img width="1325" height="688" alt="image" src="https://github.com/user-attachments/assets/1a5c4075-b223-4256-afad-81cd5051a55c" />



### 3. Tasks
- `[GET]` `/api/tasks` (List Task)

  <img width="1330" height="658" alt="image" src="https://github.com/user-attachments/assets/b280df76-635e-4069-a1ab-f5f2f8c316ac" />


- `[POST]` `/api/tasks` (Buat & Assign Task)

  <img width="1337" height="1024" alt="image" src="https://github.com/user-attachments/assets/842fbde6-4ef9-41d4-b221-5198787c38c2" />


- `[PUT]` `/api/tasks/{task}` (Update Task)

  <img width="1338" height="932" alt="image" src="https://github.com/user-attachments/assets/f961eeff-178a-40e2-bac8-e7354d253dba" />


- `[PUT]` `/api/tasks/{id}/status` (Update Status Task)

  <img width="1333" height="932" alt="image" src="https://github.com/user-attachments/assets/eb91a0c2-183a-4d28-bf8f-a551d4ee3481" />


- `[DELETE]` `/api/tasks/{task}` (Hapus Task)

  <img width="1326" height="693" alt="image" src="https://github.com/user-attachments/assets/e5e58b3d-419b-44b6-bb36-5a2bcce398fa" />



### 4. Servers
- `[GET]` `/api/servers` (List Server)

  <img width="1331" height="935" alt="image" src="https://github.com/user-attachments/assets/1f6bae3f-5dfd-4167-b2f3-953e849c7a38" />

- `[GET]` `/api/servers/{id}` (Detail Server)

  <img width="1329" height="911" alt="image" src="https://github.com/user-attachments/assets/f0a49dcd-6ea7-4333-b924-d80e7d30bc5e" />

- `[POST]` `/api/servers` (Tambah Server)

  <img width="1332" height="1020" alt="image" src="https://github.com/user-attachments/assets/247ab3a1-9ebe-431d-aba2-d81a2a31ec47" />

- `[PUT]` `/api/servers/{server}` (Update Server)

  <img width="1324" height="900" alt="image" src="https://github.com/user-attachments/assets/88642f9e-6355-49fd-96ea-ffa2295c5f9c" />


- `[DELETE]` `/api/servers/{server}` (Hapus Server)

  <img width="1338" height="475" alt="image" src="https://github.com/user-attachments/assets/947739f1-6374-419c-90d5-e122fcea4bdf" />



### 5. Deployments
- `[GET]` `/api/deployments` (List Deployment)

  <img width="1340" height="477" alt="image" src="https://github.com/user-attachments/assets/22b9e58b-2b79-483f-abad-52657b6135d0" />


- `[POST]` `/api/deployments` (Buat Deployment)

  <img width="1338" height="1004" alt="image" src="https://github.com/user-attachments/assets/f9ea92ab-2612-4be2-9d39-d619a217aaae" />


- `[GET]` `/api/deployments/{deployment}` (Detail Deployment)

  <img width="1337" height="1024" alt="image" src="https://github.com/user-attachments/assets/135f6ef5-1b10-49d1-9d8e-7fa014dbd0d1" />


- `[PUT]` `/api/deployments/{deployment}` (Update Deployment)

  <img width="1339" height="902" alt="image" src="https://github.com/user-attachments/assets/00df011d-4844-4a9a-aca0-44e170bbcc9b" />


- `[DELETE]` `/api/deployments/{deployment}` (Hapus Deployment)

  <img width="1337" height="470" alt="image" src="https://github.com/user-attachments/assets/a0f78154-b88f-4aea-b5f4-d0b676ad2641" />


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
git clone https://github.com/rzlmiooo/mini-api-manajemen.git
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
