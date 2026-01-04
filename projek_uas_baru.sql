-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Dec 28, 2025 at 12:00 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `projek_uas_baru`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin_user`
--

CREATE TABLE `admin_user` (
  `ID_admin` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin_user`
--

INSERT INTO `admin_user` (`ID_admin`, `username`, `password`, `created_at`) VALUES
(1, 'admin', 'admin123', '2025-12-27 09:45:30');

-- --------------------------------------------------------

--
-- Table structure for table `app_user`
--

CREATE TABLE `app_user` (
  `ID_akun` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('user','member') DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `app_user`
--

INSERT INTO `app_user` (`ID_akun`, `username`, `password`, `role`) VALUES
(2, 'user', 'user123', 'user'),
(3, 'parhan', 'parhan123', 'user'),
(4, 'tester', 'tester', 'user'),
(5, 'testuser', 'password123', 'user'),
(8, 'test', 'test', 'user'),
(9, 'admin1', 'admin1', 'user'),
(10, 'admin2', 'admin2', 'user'),
(11, 'Deva', '12345', 'user'),
(12, 'Putra', '12345', 'user'),
(13, 'Va', '12345', 'user');

-- --------------------------------------------------------

--
-- Table structure for table `homepage_content`
--

CREATE TABLE `homepage_content` (
  `id` int(11) NOT NULL,
  `judul` varchar(100) DEFAULT NULL,
  `isi` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `komentar`
--

CREATE TABLE `komentar` (
  `idKomentar` int(11) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `topik_pesawat` varchar(100) DEFAULT NULL,
  `isi_komentar` text DEFAULT NULL,
  `tanggal_post` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `komentar`
--

INSERT INTO `komentar` (`idKomentar`, `username`, `topik_pesawat`, `isi_komentar`, `tanggal_post`) VALUES
(1, 'user', 'Boeing 737-800', 'Pesawat ini sangat legendaris!', '2025-12-24 07:44:11'),
(2, 'parhan', 'Airbus A350', 'haiii', '2025-12-24 09:00:03'),
(3, 'muamar', 'Umum', 'haii\r\n', '2025-12-26 05:47:17'),
(4, 'muamar', 'About - WikiAir', 'keren', '2025-12-26 09:10:21');

-- --------------------------------------------------------

--
-- Table structure for table `konten`
--

CREATE TABLE `konten` (
  `id` int(11) NOT NULL,
  `judul` varchar(100) DEFAULT NULL,
  `isi` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pesawat`
--

CREATE TABLE `pesawat` (
  `ID_Pesawat` int(11) NOT NULL,
  `kodePesawat` varchar(20) DEFAULT NULL,
  `jenisPesawat` varchar(50) DEFAULT NULL,
  `namaOperator` varchar(100) DEFAULT NULL,
  `tanggalPengiriman` date DEFAULT NULL,
  `kategori` varchar(50) DEFAULT NULL,
  `tipe_mesin` varchar(50) DEFAULT NULL,
  `pabrikan` varchar(50) DEFAULT NULL,
  `kecepatan_maks` varchar(20) DEFAULT NULL,
  `tahun_produksi` int(11) DEFAULT NULL,
  `negara_asal` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pesawat`
--

INSERT INTO `pesawat` (`ID_Pesawat`, `kodePesawat`, `jenisPesawat`, `namaOperator`, `tanggalPengiriman`, `kategori`, `tipe_mesin`, `pabrikan`, `kecepatan_maks`, `tahun_produksi`, `negara_asal`) VALUES
(1, 'GA-001', 'Boeing 737-800', 'Garuda Indonesia', '2015-05-20', 'Komersial', 'Twin Jet', 'Boeing', '876 km/h', 2015, 'USA'),
(2, 'SQ-350', 'Airbus A350-900', 'Singapore Airlines', '2018-08-15', 'Komersial', 'Twin Jet', 'Airbus', '903 km/h', 2018, 'France'),
(3, 'F-16C', 'F-16 Fighting Falcon', 'TNI AU', '2019-01-10', 'Militer', 'Single Jet', 'Lockheed Martin', '2120 km/h', 2019, 'USA'),
(4, 'A350-941', 'Airbus A350 XWB', 'Qatar Airways', '2024-01-15', 'Komersial', 'Rolls-Royce Trent XWB', 'Airbus', '903 km/h', 2013, 'Perancis'),
(5, 'B787-9', 'Boeing 787 Dreamliner', 'ANA All Nippon Airways', '2024-02-20', 'Komersial', 'GE GEnx-1B', 'Boeing', '913 km/h', 2009, 'Amerika Serikat'),
(6, 'A380-861', 'Airbus A380', 'Emirates', '2023-12-10', 'Komersial', 'Engine Alliance GP7200', 'Airbus', '903 km/h', 2005, 'Perancis'),
(8, 'A321neo', 'Airbus A321neo', 'Garuda Indonesia', '2024-01-28', 'Komersial', 'CFM LEAP-1A', 'Airbus', '871 km/h', 2016, 'Perancis'),
(9, 'F-35A', 'F-35 Lightning II', 'USAF', '2023-11-20', 'Tempur', 'Pratt & Whitney F135', 'Lockheed Martin', '1,975 km/h', 2006, 'Amerika Serikat'),
(10, 'Su-27SK', 'Sukhoi Su-27SK', 'Russian Air Force', '2023-10-15', 'Tempur', 'Saturn AL-31F', 'Sukhoi', '2,500 km/h', 1985, 'Rusia'),
(11, 'F-117A', 'Lockheed F-117A Nighthawk', 'USAF (Retired)', '2023-09-18', 'Tempur', 'General Electric F404', 'Lockheed', '1,040 km/h', 1981, 'Amerika Serikat'),
(12, 'F-22', 'Lockheed Martin F-22 Raptor', 'USAF', '2024-02-12', 'Tempur', 'Pratt & Whitney F119', 'Lockheed Martin', '2,410 km/h', 1997, 'Amerika Serikat'),
(13, 'Rafale-C', 'Dassault Rafale C', 'French Air Force', '2024-01-10', 'Tempur', 'Snecma M88-2', 'Dassault Aviation', '1,912 km/h', 2001, 'Perancis'),
(14, 'B737-800F', 'Boeing 737-800BCF', 'DHL Express', '2024-01-25', 'Kargo', 'CFM56-7B', 'Boeing', '850 km/h', 1998, 'Amerika Serikat'),
(15, 'A321P2F', 'Airbus A321P2F', 'FedEx Express', '2023-12-20', 'Kargo', 'CFM56-5B', 'Airbus', '840 km/h', 1988, 'Perancis'),
(16, 'AN-124', 'Antonov An-124 Ruslan', 'Antonov Airlines', '2023-11-30', 'Kargo', 'Progress D-18T', 'Antonov', '865 km/h', 1982, 'Ukraina'),
(17, 'B747-8F', 'Boeing 747-8F', 'UPS Airlines', '2024-02-08', 'Kargo', 'GEnx-2B67', 'Boeing', '920 km/h', 2011, 'Amerika Serikat'),
(18, 'C-130J', 'Lockheed C-130J Hercules', 'Royal Air Force', '2024-03-01', 'Kargo', 'Rolls-Royce AE 2100D3', 'Lockheed Martin', '671 km/h', 1996, 'Amerika Serikat'),
(19, 'A350-941', 'Airbus A350 XWB', 'Qatar Airways', '2024-01-15', 'Komersial', 'Rolls-Royce Trent XWB', 'Airbus', '903 km/h', 2013, 'Perancis'),
(20, 'B787-9', 'Boeing 787 Dreamliner', 'ANA All Nippon Airways', '2024-02-20', 'Komersial', 'GE GEnx-1B', 'Boeing', '913 km/h', 2009, 'Amerika Serikat'),
(21, 'A380-861', 'Airbus A380', 'Emirates', '2023-12-10', 'Komersial', 'Engine Alliance GP7200', 'Airbus', '903 km/h', 2005, 'Perancis'),
(22, 'B777-300ER', 'Boeing 777-300ER', 'Singapore Airlines', '2024-03-05', 'Komersial', 'GE90-115B', 'Boeing', '905 km/h', 1994, 'Amerika Serikat'),
(23, 'A321neo', 'Airbus A321neo', 'Garuda Indonesia', '2024-01-28', 'Komersial', 'CFM LEAP-1A', 'Airbus', '871 km/h', 2016, 'Perancis'),
(24, 'F-35A', 'F-35 Lightning II', 'USAF', '2023-11-20', 'Tempur', 'Pratt & Whitney F135', 'Lockheed Martin', '1,975 km/h', 2006, 'Amerika Serikat'),
(25, 'Su-27SK', 'Sukhoi Su-27SK', 'Russian Air Force', '2023-10-15', 'Tempur', 'Saturn AL-31F', 'Sukhoi', '2,500 km/h', 1985, 'Rusia'),
(26, 'F-117A', 'Lockheed F-117A Nighthawk', 'USAF (Retired)', '2023-09-18', 'Tempur', 'General Electric F404', 'Lockheed', '1,040 km/h', 1981, 'Amerika Serikat'),
(27, 'F-22', 'Lockheed Martin F-22 Raptor', 'USAF', '2024-02-12', 'Tempur', 'Pratt & Whitney F119', 'Lockheed Martin', '2,410 km/h', 1997, 'Amerika Serikat'),
(28, 'Rafale-C', 'Dassault Rafale C', 'French Air Force', '2024-01-10', 'Tempur', 'Snecma M88-2', 'Dassault Aviation', '1,912 km/h', 2001, 'Perancis'),
(29, 'B737-800F', 'Boeing 737-800BCF', 'DHL Express', '2024-01-25', 'Kargo', 'CFM56-7B', 'Boeing', '850 km/h', 1998, 'Amerika Serikat'),
(30, 'A321P2F', 'Airbus A321P2F', 'FedEx Express', '2023-12-20', 'Kargo', 'CFM56-5B', 'Airbus', '840 km/h', 1988, 'Perancis'),
(31, 'AN-124', 'Antonov An-124 Ruslan', 'Antonov Airlines', '2023-11-30', 'Kargo', 'Progress D-18T', 'Antonov', '865 km/h', 1982, 'Ukraina'),
(32, 'B747-8F', 'Boeing 747-8F', 'UPS Airlines', '2024-02-08', 'Kargo', 'GEnx-2B67', 'Boeing', '920 km/h', 2011, 'Amerika Serikat'),
(33, 'C-130J', 'Lockheed C-130J Hercules', 'Garuda Airlines', '2025-12-27', 'Komersial', 'GARUDABAGUS-001', 'Lockheed Martin', '786', 2000, 'Amerika Serikat'),
(37, 'GA-002', 'GarudaBangkit', 'Garuda Airlines', '2025-12-27', 'Tempur', 'GARUDABAGUS-013', 'FarhanCorporate', '786', 2024, 'INA'),
(39, 'GA-003', 'GarudaBangkit', 'Garuda Airlines', '2025-01-02', 'Tempur', 'GARUDABAGUS-011', 'FarhanCorporateAsoy', '786', 2024, 'INA');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin_user`
--
ALTER TABLE `admin_user`
  ADD PRIMARY KEY (`ID_admin`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `app_user`
--
ALTER TABLE `app_user`
  ADD PRIMARY KEY (`ID_akun`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `homepage_content`
--
ALTER TABLE `homepage_content`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `komentar`
--
ALTER TABLE `komentar`
  ADD PRIMARY KEY (`idKomentar`);

--
-- Indexes for table `konten`
--
ALTER TABLE `konten`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pesawat`
--
ALTER TABLE `pesawat`
  ADD PRIMARY KEY (`ID_Pesawat`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin_user`
--
ALTER TABLE `admin_user`
  MODIFY `ID_admin` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `app_user`
--
ALTER TABLE `app_user`
  MODIFY `ID_akun` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `homepage_content`
--
ALTER TABLE `homepage_content`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `komentar`
--
ALTER TABLE `komentar`
  MODIFY `idKomentar` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `konten`
--
ALTER TABLE `konten`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pesawat`
--
ALTER TABLE `pesawat`
  MODIFY `ID_Pesawat` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
