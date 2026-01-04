-- ========================================
-- SQL SCRIPT: CREATE ADMIN TABLE & UPDATE APP_USER
-- ========================================
-- Jalankan script ini di MySQL untuk membuat tabel admin terpisah
-- Database: projek_uas_baru (port 3307)

USE projek_uas_baru;

-- 1. CREATE TABLE FOR ADMIN (SEPARATED FROM REGULAR USERS)
CREATE TABLE IF NOT EXISTS admin_user (
    ID_admin INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. UPDATE app_user table to only allow 'user' and 'member' roles
-- WARNING: This will drop existing role column and recreate it
-- Make sure to backup data first if needed!

-- Drop existing role column if it exists
ALTER TABLE app_user DROP COLUMN IF EXISTS role;

-- Add role column with ENUM constraint
ALTER TABLE app_user ADD COLUMN role ENUM('user', 'member') DEFAULT 'user' AFTER password;

-- 3. INSERT DEFAULT ADMIN ACCOUNT
-- Check if admin already exists before inserting
INSERT INTO admin_user (username, password) 
SELECT 'admin', 'admin123'
WHERE NOT EXISTS (SELECT 1 FROM admin_user WHERE username = 'admin');

-- Optional: Add more admin accounts here
-- INSERT INTO admin_user (username, password) VALUES ('superadmin', 'super123');

-- 4. CLEAN UP: Remove any users with role 'admin' from app_user
-- They should be in admin_user table instead
DELETE FROM app_user WHERE username IN ('admin', 'muamar', 'newuser123', 'hai');

-- 5. VERIFY ADMIN ACCOUNT
SELECT 'Admin Accounts:' AS Info, COUNT(*) AS Count FROM admin_user;
SELECT * FROM admin_user;

-- 6. VERIFY APP_USER
SELECT 'App Users:' AS Info, COUNT(*) AS Count FROM app_user;
SELECT ID_akun, username, role FROM app_user LIMIT 10;
