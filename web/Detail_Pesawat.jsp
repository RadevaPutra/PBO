<%-- 
    Document   : detail_pesawat
    Created on : 21 Nov 2025
    Author     : radev
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Model.User"%>
<%@page import="Model.Pesawat"%>
<%@page import="Model.Komentar"%>
<%@page import="Controller.komentarcontroler"%>
<%@page import="java.util.List"%>

<%
    // 1. Ambil data User dari sesi
    User user = (User) session.getAttribute("user");
    
    // 2. Ambil data Pesawat dari Request Attribute (diset oleh Pesawatcontroler.java)
    Pesawat detailPesawat = (Pesawat) request.getAttribute("detailPesawat");

    if (detailPesawat == null) {
        response.sendRedirect("konten.jsp?error=Pesawat_Tidak_Ditemukan");
        return;
    }
    
    int idPesawatSaatIni = detailPesawat.getID_Pesawat();
    
    // 3. Ambil daftar komentar terkait pesawat ini (Penting!)
    // Memanggil helper method statis dari KomentarController
    List<Komentar> daftarKomentar = komentarcontroler.getKomentarByPesawatId(idPesawatSaatIni);
    
    // Header Navigation Link
    String dashboardLink = (user != null && user.getFirstRole().equalsIgnoreCase("admin")) 
                           ? "admin_dashboard.jsp" : 
                           (user != null ? "user_dashboard.jsp" : "index.jsp");
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Detail: <%= detailPesawat.getNamaPesawat() %> | WikiAir</title>
    <style>
        body { font-family: Arial, sans-serif; 
               background-color: #f4f4f4; 
               margin: 0; 
               color: #333; 
        }
        .header { 
            background-color: #333; 
            color: white; 
            padding: 10px 20px; 
            display: flex; 
            justify-content: space-between;
            align-items: center; 
        }
        .header a { 
            color: white; 
            text-decoration: none; 
            margin-left: 20px; 
            font-weight: bold; 
        }
        .container { 
            max-width: 900px; 
            margin: 20px auto; 
            padding: 0 20px; 
        }
        .article-box { 
            background-color: white; 
            padding: 30px; 
            border-radius: 8px; 
            box-shadow: 0 2px 10px rgba(0,0,0,0.1); 
        }
        .pesawat-header { 
            border-bottom: 2px solid #ccc; 
            padding-bottom: 10px; 
            margin-bottom: 20px; 
        }
        .pesawat-header h1 { 
            margin: 0;
            color: #007bff; 
        }
        .pesawat-header p { 
            font-style: italic; 
            color: #666; 
        }
        
        .specs table {
            width: 100%; 
            margin-top: 15px; 
            border-collapse: collapse; 
        }
        .specs th, .specs td { 
            padding: 10px; 
            border: 1px solid #eee; 
            text-align: left; 
            font-size: 0.95em; 
        }
        .specs th { 
            background-color: #f8f8f8; 
            width: 30%; 
        }
        
        /* Gaya Komentar */
        .comment-section { 
            margin-top: 40px; 
            border-top: 1px solid #ccc; 
            padding-top: 20px; 
        }
        .comment-box { 
            background-color: #f9f9f9; 
            padding: 15px; 
            margin-bottom: 15px; 
            border-radius: 5px; 
            border-left: 5px solid #007bff; 
        }
        .comment-meta { 
            font-size: 0.8em; 
            color: #888; 
            margin-top: 5px; 
        }
        .comment-author { 
            font-weight: bold; 
            color: #333; 
        }
        
        .comment-form textarea {
            width: 100%; 
            padding: 10px; 
            margin-bottom: 10px; 
            box-sizing: border-box; 
            border: 1px solid #ccc; 
            border-radius: 4px; 
        }
        .comment-form button { 
            padding: 10px 20px; 
            background-color: #28a745; 
            color: white; border: none; 
            border-radius: 4px; 
            cursor: pointer; 
            font-weight: bold; 
        }
        
        .logout-btn { 
            background-color: #dc3545; 
            border: none; 
            color: white; 
            padding: 5px 10px; 
            border-radius: 3px; 
            cursor: pointer; 
            font-weight: bold; 
            text-decoration: none; 
            margin-left: 10px; 
        }
        .alert-message { 
            padding: 10px; 
            margin-bottom: 15px; 
            border-radius: 4px; 
            font-weight: bold; 
        }
        .alert-success { 
            background-color: #d4edda; 
            color: #155724; 
            border: 1px solid #c3e6cb; 
        }
        .alert-error { 
            background-color: #f8d7da; 
            color: #721c24; 
            border: 1px solid #f5c6cb; 
        }
    </style>
</head>
<body>

    <div class="header">
        <div class="logo-text">✈️ WikiAir | Artikel Detail</div>
        <nav>
            <a href="pesawat?action=tampil">KEMBALI KE DAFTAR</a>
            <a href="<%= dashboardLink %>">DASHBOARD</a>
            <% if (user != null) { %>
                <a href="login?action=logout" class="logout-btn">LOGOUT</a>
            <% } else { %>
                 <a href="index.jsp" class="logout-btn" style="background-color: #28a745;">LOGIN</a>
            <% } %>
        </nav>
    </div>

    <div class="container">
        
        <%
            // Tampilkan pesan sukses atau error setelah submit komentar
            String msg = request.getParameter("msg");
            if ("Komentar_Sukses".equals(msg)) {
                out.println("<div class='alert-message alert-success'>Komentar berhasil diposting!</div>");
            } else if ("Error_Post_Komentar".equals(msg)) {
                out.println("<div class='alert-message alert-error'>Gagal memposting komentar. Silakan coba");