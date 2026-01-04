<%-- 
    Document   : user_dasboard
    Created on : 21 Nov 2025, 20.58.41
    Author     : radev
--%>

<%@page import="Model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    User user = (User) session.getAttribute("user");
    // Guard: Pastikan user login dan bukan Admin (atau diarahkan ke sini)
    if (user == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>🌎 Dasbor Pengguna - Arsip Pesawat Global</title>
    <style>
        body { 
            font-family: sans-serif; 
            background-color: #f8f9fa; 
            margin: 0; 
        }
        .header { 
            background-color: #f0f0f0; 
            border-bottom: 3px solid #007bff; 
            padding: 15px 30px; display: flex; 
            justify-content: space-between; 
            align-items: center; 
        }
        .nav-links a { 
            margin-left: 20px; 
            text-decoration: none; 
            color: #007bff; 
            font-weight: bold; 
        }
        .content { 
            padding: 30px; 
            max-width: 1000px; 
            margin: auto; 
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Ensiklopedia Pesawat ✈️</h1>
        <div class="nav-links">
            <span>Halo, <%= user.getUsername() %> | Role: <%= user.getFirstRole().toUpperCase() %></span>
            <form action="auth" method="POST" style="display:inline;">
                <input type="hidden" name="action" value="logout">
                <button type="submit" style="background: none; border: none; color: red; cursor: pointer; font-weight: bold;">[Logout]</button>
            </form>
        </div>
    </div>

    <div class="content">
        <h2>Selamat Datang di Portal Pembaca</h2>
        <p>Anda dapat mengakses seluruh arsip pesawat, melihat detail spesifikasi, dan berinteraksi melalui kolom komentar.</p>
        
        <h3>Menu Akses Cepat</h3>
        <ul>
            <li><a href="pesawat?action=tampil">1. Jelajahi Semua Artikel Pesawat (Lihat Konten)</a></li>
            <li><a href="komentar.jsp">2. Beri Komentar & Tinjau Diskusi</a></li>
        </ul>
        
        <hr style="margin-top: 50px;">
        <p style="font-size: small; color: #666;">*Anda masuk sebagai pengguna biasa. Hak akses editing konten tidak tersedia.</p>
    </div>
</body>
</html>