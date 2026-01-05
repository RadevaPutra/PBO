# Dokumentasi Teknis Backend - Wikiair
Arsitektur Backend & Logika Bisnis (WikiAir)
1. Fitur Utama Berfungsi dengan Baik Backend WikiAir telah berhasil mengimplementasikan alur manajemen informasi ensiklopedia penerbangan:

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