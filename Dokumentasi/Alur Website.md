# Alur website Aplikasi Wikiair

WikiAir adalah platform ensiklopedia berbasis web yang berfungsi seperti Wikipedia khusus untuk pesawat. Aplikasi ini menyajikan informasi teknis, gambar, dan data historis mengenai berbagai jenis pesawat (komersial, militer, kargo, dll) secara sistematis. Berikut adalah alur penggunaan aplikasi untuk User dan Admin.

A. Alur Guest (Pengguna Umum)
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
