-- =========================================
-- SQL SCRIPT: PROJEK UAS - DATABASE SETUP
-- =========================================
-- Database: projek_uas_baru
-- Run this script di MySQL (port 3307)

-- 1. CREATE DATABASE (jika belum ada)
CREATE DATABASE IF NOT EXISTS projek_uas_baru;
USE projek_uas_baru;

-- 2. CREATE TABLE PESAWAT
CREATE TABLE IF NOT EXISTS pesawat (
    ID_Pesawat INT AUTO_INCREMENT PRIMARY KEY,
    kodePesawat VARCHAR(50),
    jenisPesawat VARCHAR(100) NOT NULL,
    namaOperator VARCHAR(100),
    tanggalPengiriman VARCHAR(50),
    kategori VARCHAR(50),
    tipe_mesin VARCHAR(100),
    pabrikan VARCHAR(100),
    kecepatan_maks VARCHAR(50),
    tahun_produksi INT,
    negara_asal VARCHAR(100)
);

-- 3. INSERT SAMPLE DATA

-- PESAWAT KOMERSIAL
INSERT INTO pesawat 
(kodePesawat, jenisPesawat, namaOperator, tanggalPengiriman, kategori, tipe_mesin, pabrikan, kecepatan_maks, tahun_produksi, negara_asal)
VALUES
('A350-941', 'Airbus A350 XWB', 'Qatar Airways', '2024-01-15', 'Komersial', 'Rolls-Royce Trent XWB', 'Airbus', '903 km/h', 2013, 'Perancis'),
('B787-9', 'Boeing 787 Dreamliner', 'ANA All Nippon Airways', '2024-02-20', 'Komersial', 'GE GEnx-1B', 'Boeing', '913 km/h', 2009, 'Amerika Serikat'),
('A380-861', 'Airbus A380', 'Emirates', '2023-12-10', 'Komersial', 'Engine Alliance GP7200', 'Airbus', '903 km/h', 2005, 'Perancis'),
('B777-300ER', 'Boeing 777-300ER', 'Singapore Airlines', '2024-03-05', 'Komersial', 'GE90-115B', 'Boeing', '905 km/h', 1994, 'Amerika Serikat'),
('A321neo', 'Airbus A321neo', 'Garuda Indonesia', '2024-01-28', 'Komersial', 'CFM LEAP-1A', 'Airbus', '871 km/h', 2016, 'Perancis');

-- PESAWAT TEMPUR
INSERT INTO pesawat 
(kodePesawat, jenisPesawat, namaOperator, tanggalPengiriman, kategori, tipe_mesin, pabrikan, kecepatan_maks, tahun_produksi, negara_asal)
VALUES
('F-35A', 'F-35 Lightning II', 'USAF', '2023-11-20', 'Tempur', 'Pratt & Whitney F135', 'Lockheed Martin', '1,975 km/h', 2006, 'Amerika Serikat'),
('Su-27SK', 'Sukhoi Su-27SK', 'Russian Air Force', '2023-10-15', 'Tempur', 'Saturn AL-31F', 'Sukhoi', '2,500 km/h', 1985, 'Rusia'),
('F-117A', 'Lockheed F-117A Nighthawk', 'USAF (Retired)', '2023-09-18', 'Tempur', 'General Electric F404', 'Lockheed', '1,040 km/h', 1981, 'Amerika Serikat'),
('F-22', 'Lockheed Martin F-22 Raptor', 'USAF', '2024-02-12', 'Tempur', 'Pratt & Whitney F119', 'Lockheed Martin', '2,410 km/h', 1997, 'Amerika Serikat'),
('Rafale-C', 'Dassault Rafale C', 'French Air Force', '2024-01-10', 'Tempur', 'Snecma M88-2', 'Dassault Aviation', '1,912 km/h', 2001, 'Perancis');

-- PESAWAT KARGO
INSERT INTO pesawat 
(kodePesawat, jenisPesawat, namaOperator, tanggalPengiriman, kategori, tipe_mesin, pabrikan, kecepatan_maks, tahun_produksi, negara_asal)
VALUES
('B737-800F', 'Boeing 737-800BCF', 'DHL Express', '2024-01-25', 'Kargo', 'CFM56-7B', 'Boeing', '850 km/h', 1998, 'Amerika Serikat'),
('A321P2F', 'Airbus A321P2F', 'FedEx Express', '2023-12-20', 'Kargo', 'CFM56-5B', 'Airbus', '840 km/h', 1988, 'Perancis'),
('AN-124', 'Antonov An-124 Ruslan', 'Antonov Airlines', '2023-11-30', 'Kargo', 'Progress D-18T', 'Antonov', '865 km/h', 1982, 'Ukraina'),
('B747-8F', 'Boeing 747-8F', 'UPS Airlines', '2024-02-08', 'Kargo', 'GEnx-2B67', 'Boeing', '920 km/h', 2011, 'Amerika Serikat'),
('C-130J', 'Lockheed C-130J Hercules', 'Royal Air Force', '2024-03-01', 'Kargo', 'Rolls-Royce AE 2100D3', 'Lockheed Martin', '671 km/h', 1996, 'Amerika Serikat');

-- 4. CREATE TABLE FOR ADMIN (SEPARATED FROM REGULAR USERS)
CREATE TABLE IF NOT EXISTS admin_user (
    ID_admin INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 5. CREATE TABLE FOR APP USERS (IF NOT EXISTS)
CREATE TABLE IF NOT EXISTS app_user (
    ID_akun INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('user', 'member') DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 6. INSERT DEFAULT ADMIN ACCOUNT
INSERT INTO admin_user (username, password) VALUES ('admin', 'admin123');

-- Optional: Add more admin accounts here
-- INSERT INTO admin_user (username, password) VALUES ('superadmin', 'super123');

-- 7. VERIFY DATA
SELECT 'Total Pesawat:', COUNT(*) FROM pesawat;
SELECT 'Pesawat Komersial:', COUNT(*) FROM pesawat WHERE kategori = 'Komersial';
SELECT 'Pesawat Tempur:', COUNT(*) FROM pesawat WHERE kategori = 'Tempur';
SELECT 'Pesawat Kargo:', COUNT(*) FROM pesawat WHERE kategori = 'Kargo';

-- 8. VERIFY ADMIN ACCOUNT
SELECT 'Admin Accounts:', COUNT(*) FROM admin_user;
SELECT * FROM admin_user;
