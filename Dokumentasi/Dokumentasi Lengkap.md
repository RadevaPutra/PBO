# Dokumentasi Lengkap Aplikasi WikiAir
Dokumen ini merupakan Panduan Utama yang menggabungkan seluruh aspek teknis dan operasional Aplikasi WikiAir, mulai dari cara instalasi, alur penggunaan website, arsitektur backend, hingga spesifikasi API.
# Daftar Isi
BAB 1: Cara Deployment 

BAB 2: Alur Website 

BAB 3: Backend Security

BAB 4: Dokumentasi API

# BAB 1:Cara Deployment
1. Persiapan Lingkungan (Prerequisites)
Sebelum memulai, pastikan perangkat lunak berikut sudah terpasang:

Java JDK 8: Versi Java yang digunakan dalam pengembangan aplikasi WikiAir.

MySQL Server: Sebagai penyimpanan database pesawat dan mesin.

IDE (IntelliJ IDEA / Eclipse / VS Code): Untuk menjalankan kode program.

Git: Untuk mengambil source code.

2. Langkah-Langkah Instalasi
A. Clone Repository Buka terminal atau Git Bash, lalu arahkan ke folder penyimpanan Anda dan jalankan perintah:

Bash

git clone https://github.com/RadevaPutra/PBO.git
cd PBO

B. Konfigurasi Database MySQL Aplikasi WikiAir memerlukan database untuk menyimpan data teknis pesawat (A350, F-35, dll).

Buka MySQL Workbench atau terminal MySQL.

Buat database baru:

SQL

CREATE DATABASE prject_uas_baru;
Buka file src/main/resources/application.properties di folder proyek, lalu sesuaikan username dan password MySQL Anda:

Properties

spring.datasource.url=jdbc:mysql://localhost:3306/wikiair_db
spring.datasource.username=username_anda
spring.datasource.password=password_anda
spring.jpa.hibernate.ddl-auto=update

C. Build dan Menjalankan Aplikasi Karena tidak menggunakan Docker, Anda dapat menggunakan Maven Wrapper yang tersedia di dalam folder proyek:

Melalui Terminal: Jalankan perintah berikut untuk mengunduh library dan menjalankan aplikasi:

Bash

./mvnw spring-boot:run
Melalui IDE (Rekomendasi):

Buka folder proyek di IntelliJ atau VS Code.

Tunggu hingga proses indexing dan download dependencies (Maven) selesai.

Cari file utama (biasanya WikiAirApplication.java).

Klik kanan dan pilih Run.

| Komponen | URL | Keterangan |
| --- | --- | --- |
| Dashboard Utama | http://localhost:8080/web | Halaman utama aplikasi |
| Halaman Login | http://localhost:8080/login | Akses masuk pengguna |
| Halaman Admin | http://localhost:8080/admin | Panel manajemen data |
| API Endpoint | http://localhost:8080 | Akses langsung ke Spring Boot (Opsional) |

3. Verifikasi Instalasi
Setelah terminal menampilkan tulisan "Started WikiAirApplication in ... seconds", aplikasi dapat diakses melalui browser:

Dashboard Utama: http://localhost:8080/web

Halaman Login: http://localhost:8080/login

Halaman Admin: http://localhost:8080/admin (Pastikan database sudah terisi data awal dari AdminController).

Struktur Komponen (Non-Docker)
Tanpa Docker, komponen aplikasi berjalan langsung sebagai proses di sistem operasi Anda:

Aplikasi Backend & Frontend: Berjalan sebagai proses Java (Spring Boot) di port 8080.

Database: Berjalan sebagai layanan sistem (MySQL Service) di port default 3306.

Interface Database: Anda dapat menggunakan MySQL Workbench atau DBeaver sebagai pengganti phpMyAdmin untuk memantau data tabel Pesawat dan Engine.

# BAB 2: Alur Website 
 Alur Guest (Pengguna Umum)
1. Halaman Utama (Landing Page)

Akses: http://localhost:8080/ProjekUAS/web
Aplikasi WikiAir menyajikan informasi ensiklopedia melalui dasbor utama yang dikelola oleh WebController untuk menampilkan statistik armada, menyediakan fitur pencarian dan filter kategori pesawat (Komersial, Militer, Kargo, Eksperimental), serta menyajikan halaman detail spesifikasi teknis dan mesin beserta fitur diskusi komunitas bagi pengguna.

2. Sistem Registrasi (Daftar Akun)

Akses: http://localhost/register

Pengguna baru yang ingin berkontribusi dalam diskusi atau mendapatkan akses khusus dapat mendaftar melalui RegisterController.

Proses: Pengguna mengisi formulir pendaftaran (Nama, Email, dan Password) yang kemudian diproses oleh fungsi Daftar() untuk disimpan ke dalam database.

3. Sistem Masuk (Login)

Akses: http://localhost/login

Pengguna atau Admin masuk ke sistem melalui LoginController.

Proses: Sistem akan memvalidasi kredensial pengguna. Jika login berhasil:

User/Guest: Kembali ke halaman utama dengan hak akses memberikan komentar pada fitur "Diskusi Komunitas".

Admin: Diarahkan ke Dashboard Admin untuk mengelola data inventaris pesawat.
4. Halaman Kategori Pesawat

Akses: http://localhost/kategori

Deskripsi: Melalui WebController, aplikasi menampilkan daftar kategori pesawat yang tersedia, seperti Komersial, Militer, Eksperimental, dan Kargo, di mana pengguna dapat melihat klasifikasi unit secara terorganisir serta dengan semua jenis pesawat nya.

Filter & Pencarian: Pengguna dapat mempersempit daftar pesawat yang ditampilkan menggunakan fitur filter pada fungsi tampilkanKategori() dan melakukan pencarian unit spesifik di dalam kategori tersebut melalui SearchEngine.

Interaksi: Setiap kartu pesawat dalam halaman kategori ini dapat diklik untuk mengarahkan pengguna ke halaman detail teknis yang mencakup spesifikasi mesin dan sejarah unit.

5. Detail Pesawat: Airbus A350

Akses: http://localhost/detail/airbus-a350

Data Spesifikasi Teknis (Berdasarkan Class Diagram):

Nama Pesawat: Airbus A350-900 / A350-1000.

Pabrikan: Airbus (Prancis/Uni Eropa).

Data Mesin (Class Engine): Menggunakan mesin Rolls-Royce Trent XWB.

Kapasitas: 300 - 410 Penumpang.

Jangkauan: ±15.000 km (Long Range).

Dimensi: Menampilkan panjang badan dan rentang sayap pesawat.

6. Halaman Kategori Pesawat Tempur (Militer)

Akses: http://localhost/kategori/militer

Deskripsi: Menampilkan daftar jet tempur dan pesawat pertahanan udara. Data diolah melalui WebController dan menampilkan visualisasi kartu pesawat hasil rancangan Fachri Muthawwa.

Contoh Unit: F-35 Lightning II

Data Teknis: Kecepatan maksimum (Mach 1.6+), radius tempur, dan fitur Stealth.

Data Mesin: Pratt & Whitney F135 (diambil dari class Engine).

URL Detail: http://localhost/detail/f35-lightning

7. Halaman Kategori Pesawat Kargo

Akses: http://localhost/kategori/kargo

Deskripsi: Menampilkan pesawat khusus pengangkut logistik dan barang berat. Halaman ini menggunakan fungsi tampilkanKategori() untuk memisahkan pesawat logistik dari pesawat penumpang.

Contoh Unit: Antonov An-124 Ruslan

Data Teknis: Kapasitas muatan (Payload) hingga 150 ton dan volume kargo.

Data Mesin: Progress D-18T (relasi Composition dengan database mesin).

URL Detail: http://localhost/detail/antonov-an124

8. Halaman About (Tentang WikiAir)
Akses: http://localhost/about

Deskripsi: Halaman ini menyajikan visi dan misi aplikasi WikiAir sebagai platform ensiklopedia dirgantara yang komprehensif. Pengguna dapat melihat informasi mengenai tujuan aplikasi, yaitu memberikan edukasi mendalam mengenai spesifikasi teknis pesawat dan teknologi mesin penerbangan.

Informasi Tim Pengembang: Halaman ini menampilkan profil para pengembang dari Kelompok 04 yang terdiri dari:

Gde Radeva Putra Suniantara: Pengembang Utama (Database, Dashboard, & UI).

Muhammad Riandafa Yusaufa: Pengembang sistem Admin.

Fachri Muthawwa: Perancang UI/UX (Figma).

Daniel Dante & Frizanka Aryaguna: Penyusun konten artikel dan teknis.

Al-Fath Ilyasa: Kurator data visual dan foto unit pesawat.

Tampilan Visual: Mengacu pada gambar di laporan (Lampiran "About"), halaman ini memiliki desain yang bersih dengan narasi tentang sejarah singkat pembuatan WikiAir sebagai tugas besar mata kuliah Pemrograman Berorientasi Objek (PBO).

B. Alur Pengelola (Admin Approval)
Login

1. Login Admin

Akses: http://localhost/login

Deskripsi: Admin masuk menggunakan kredensial khusus yang divalidasi oleh LoginController. Jika berhasil, sistem akan memberikan hak akses untuk memanipulasi data yang tidak dimiliki oleh Guest.

2. Dashboard Admin (Tampilan Inventaris)

Akses: http://localhost/admin/dashboard

Tampilan: Admin melihat tabel daftar seluruh pesawat yang ada di database. Tabel ini mencakup kolom ID, Kode Pesawat, Jenis, Kategori, dan Pabrikan (sesuai dengan [Image 25] pada laporan Anda).

3. Tambah Data Pesawat Baru

Akses: http://localhost/admin/tambah

Deskripsi: Admin dapat menambahkan unit pesawat baru ke dalam ensiklopedia melalui form input.

Proses: Admin mengisi detail seperti nama pesawat, kategori (Komersial/Militer/Kargo/Eksperimental), tahun produksi, dan memilih data mesin dari Engine Database. Data disimpan melalui fungsi tambahData().

4. Edit & Update Data

Akses: http://localhost/admin/edit/{id}

Deskripsi: Jika terdapat informasi teknis yang perlu diperbarui (misalnya perubahan spesifikasi mesin atau sejarah), admin menggunakan fitur Edit ([Image 26]).

Proses: Mengubah atribut pada objek pesawat dan menyimpannya kembali ke database untuk segera tampil di halaman publik.

5. Hapus Data (Delete)

Akses: http://localhost/admin/hapus/{id}

Deskripsi: Admin memiliki wewenang untuk menghapus data pesawat yang sudah tidak relevan atau salah input ([Image 27]).

Keamanan: Sistem biasanya akan memunculkan konfirmasi sebelum data benar-benar dihapus dari database.

# BAB 3: Backend Security

Fitur Utama Berfungsi dengan Baik Backend WikiAir telah berhasil mengimplementasikan alur manajemen informasi ensiklopedia penerbangan:

Akses Publik (Guest): Pengguna dapat melakukan pencarian unit melalui SearchEngine, memfilter kategori (Komersial/Militer/Kargo), dan berpartisipasi dalam diskusi melalui KomentarController.

Manajemen Data (Admin): Melalui AdminController, pengelola dapat melakukan operasi CRUD (Create, Read, Update, Delete) pada data pesawat dan mesin secara real-time.

Database Engine: Sistem mengelola relasi kompleks antara data spesifik pesawat dengan spesifikasi mesin (Powerplant) menggunakan prinsip Composition.

2. Kode Modular & Clean Code (OOP) Aplikasi WikiAir dibangun dengan menerapkan prinsip Object-Oriented Programming (OOP) yang ketat sesuai dengan Class Diagram pada laporan:

Model (Entity):

Pesawat (Abstract Class): Mendefinisikan atribut umum seperti kode, nama, dan pabrikan.

PesawatKomersial, PesawatTempur (Subclasses): Implementasi Inheritance dan Polymorphism untuk atribut spesifik (misal: jumlah penumpang vs sistem persenjataan).

Engine: Entity mandiri yang terhubung dengan Pesawat.

Controller Layer:

WebController: Menangani routing halaman publik (/web, /kategori, /about).

AdminController: Menangani request HTTP untuk manajemen data (/admin/tambah, /admin/edit).

LoginController & RegisterController: Menangani autentikasi dan registrasi user.

3. Integrasi dengan Database & Keamanan

Operasi CRUD & Transaksi: Operasi database ditangani melalui layer Repository yang diabstraksi. Method seperti tambahData() dan updateData() memastikan integritas data pesawat tetap terjaga saat terjadi relasi antar tabel.

Keamanan Data:

Authentication: Menggunakan sistem login untuk membedakan hak akses antara User umum dan Admin (Role-Based Access Control).

Encapsulation: Semua atribut pada class Model diatur sebagai private, akses data dilakukan melalui method getter dan setter untuk menjaga keamanan state objek.

SQL Injection Protection: Input dari fitur pencarian (SearchEngine) divalidasi dan dibersihkan sebelum diproses ke dalam query database untuk mencegah serangan injeksi.

4. Penanganan Error (Exception Handling)Sistem menyertakan validasi input dasar, seperti memastikan tahun produksi pesawat berupa angka dan kolom wajib (seperti nama pesawat) tidak boleh kosong sebelum disimpan ke database.Penerapan Try-Catch pada proses koneksi database untuk memastikan aplikasi tidak crash jika terjadi kegagalan server.D. 

Daftar Akses Backend (Endpoints)Fungsi BackendURL Akses (HTTP/HTTPS)Controller Terkait
Public Dashboardhttp://localhost/web
WebControllerAuth 
Loginhttp://localhost/login
LoginControllerAuth 
Registerhttp://localhost/register
RegisterController

Admin CRUDhttp://localhost/admin/**
AdminController
Search APIhttp://localhost/search
SearchEngineComment 
Enginehttp://localhost/comment
KomentarController

# BAB 4: Dokumentasi API 
Dokumentasi ini menjelaskan titik akses (endpoints) yang digunakan oleh aplikasi untuk berinteraksi antara bagian Frontend (Thymeleaf/UI) dengan Backend (Spring Boot).

📦 Informasi Publik (Guest)
1. Pencarian Pesawat (Real-time)

Endpoint: GET /api/search

Query Params: keyword (String), category (String)

Fungsi: Mengambil data pesawat dari SearchEngine berdasarkan nama atau kategori.

Response: JSON List<Pesawat> (Berisi Nama, Pabrikan, dan Gambar).

2. Filter Kategori

Endpoint: GET /api/kategori/{type}

Path Variable: type (komersial, militer, kargo, eksperimental)

Fungsi: Menjalankan fungsi tampilkanKategori() untuk menyaring unit berdasarkan subclass.

Response: JSON List objek pesawat sesuai kategori.

💬 Interaksi & Komentar (User Terautentikasi)
1. Kirim Komentar/Diskusi

Endpoint: POST /api/comments/submit

Body (JSON): ```json { "pesawatId": 101, "userId": 5, "content": "Pesawat ini memiliki efisiensi bahan bakar yang luar biasa." }

Fungsi: Diproses oleh KomentarController untuk menampilkan ulasan pengguna di halaman detail.

🔐 Manajemen Data (Admin Only)
1. Tambah Unit Pesawat Baru

Endpoint: POST /admin/api/pesawat (Multipart)

Params: nama, pabrikan, kategori, engineId, deskripsi, file (Image).

Fungsi: Menjalankan tambahData() untuk menyimpan unit baru ke database.

2. Update Informasi Teknis

Endpoint: PUT /admin/api/pesawat/update/{id}

Path Variable: id (ID Pesawat)

Body: Objek Pesawat yang telah diperbarui.

Fungsi: Memperbarui spesifikasi teknis atau data mesin pada database.

3. Hapus Data

Endpoint: DELETE /admin/api/pesawat/delete/{id}

Fungsi: Menghapus entitas pesawat secara permanen dari sistem.

⚙️ Database Mesin (Engine Database)
1. Ambil Data Mesin

Endpoint: GET /api/engines

Response: Daftar seluruh spesifikasi mesin (Powerplant) yang tersedia untuk dihubungkan dengan data pesawat (Prinsip Composition).
