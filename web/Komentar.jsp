<%@page import="controller.komentarcontroller"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="Models.Pesawat"%>
<%@page import="Models.komentar"%>
<%@page import="Models.User"%>
<%@page import="controller.komentarcontroller"%>

<% 
    User loggedInUser = (User) session.getAttribute("user");
    List<Pesawat> listPesawat = (List<Pesawat>) request.getAttribute("listPesawat");

    String activePage = (String) request.getAttribute("activePage");
    if (activePage == null || activePage.isEmpty()) {
        activePage = "home"; 
    }
    
    String currentKategori = request.getParameter("type");
    String currentSub = request.getParameter("sub"); 
    
    if (activePage.equals("kategori") && (currentKategori == null || currentKategori.isEmpty())) {
        currentKategori = "komersial"; 
    }
    
    // Penentuan Judul Tabel dan Topik Komentar
    String displaySub = (currentSub != null) ? currentSub.replace("_", " ") : "";
    String tableTitle = (currentKategori != null) ? currentKategori.toUpperCase() + (displaySub.isEmpty() ? "" : " - " + displaySub.toUpperCase()) : "";
    String topikAktif = (!displaySub.isEmpty()) ? displaySub : (currentKategori != null ? currentKategori : "Umum");
%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>WikiAir - Ensiklopedia Pesawat</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f0f2f5; margin: 0; }
        .header { background-color: #1a1a1a; color: white; padding: 15px 50px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 2px 10px rgba(0,0,0,0.3); }
        .header a { color: #ccc; text-decoration: none; margin-left: 25px; font-weight: 600; transition: 0.3s; }
        .header a:hover, .header a.active { color: #ffcc00; }
        .logo-text { font-size: 1.8em; font-weight: bold; color: white; }
        
        .main-content { display: flex; max-width: 1200px; margin: 30px auto; padding: 0 20px; gap: 30px; }
        .content-left { flex: 2.5; }
        .sidebar-right { flex: 1; }
        
        .content-box, .sidebar-box { background: white; padding: 25px; border-radius: 8px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); margin-bottom: 25px; }
        .large-image { width: 100%; height: 400px; object-fit: cover; border-radius: 8px; margin-bottom: 20px; }
        
        .sub-nav { margin-top: 20px; display: flex; gap: 10px; flex-wrap: wrap; align-items: center; }
        .btn-sub { padding: 8px 15px; background: #007bff; color: white; text-decoration: none; border-radius: 4px; font-size: 0.9em; transition: 0.3s; border: none; cursor: pointer; }
        .btn-sub:hover { background: #0056b3; }

        .category-menu { display: flex; flex-direction: column; gap: 10px; }
        .category-menu a { padding: 12px 15px; background: #f8f9fa; color: #333; text-decoration: none; border-radius: 5px; font-weight: 500; transition: 0.3s; border-left: 4px solid transparent; }
        .category-menu a:hover, .category-menu a.active-cat { background: #e9ecef; border-left-color: #ffcc00; color: #007bff; }

        .comment-container { max-width: 1200px; margin: 0 auto 50px; padding: 0 20px; }
        .comment-form { background: #fdfdfd; padding: 20px; border: 1px solid #eee; border-radius: 8px; margin-top: 15px; }
        .comment-input { width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 5px; margin-top: 10px; box-sizing: border-box; font-family: inherit; resize: vertical; }
        
        .comment-card { padding: 15px; border-bottom: 1px solid #eee; transition: 0.3s; }
        .comment-card:hover { background-color: #f8f9fa; }
    </style>
</head>
<body>

    <div class="header">
        <div class="logo-text">✈️ WikiAir</div>
        <nav>
            <% if (loggedInUser != null) { %>
                <a href="web?page=home" class="<%= activePage.equals("home") ? "active" : "" %>">HOME</a>
                <a href="web?page=kategori" class="<%= activePage.equals("kategori") ? "active" : "" %>">KATEGORI</a>
                <a href="web?page=data" class="<%= activePage.equals("data") ? "active" : "" %>">DATA</a>
                <a href="login?action=logout" style="color: #ff4444;">LOGOUT</a>
            <% } %>
        </nav>
    </div>

    <div class="main-content">
        <div class="content-left">
            <div class="content-box">
                <h3>TOP PHOTOS</h3>
                <img src="img/pesawat_main.jpg" alt="Main Photo" class="large-image">

                <% if (activePage.equals("home")) { %>
                    <div class="info-description">
                        <h3>Mengenal Dunia Penerbangan</h3>
                        <p>WikiAir menyediakan informasi teknis mendalam mengenai armada pesawat di seluruh dunia.</p>
                    </div>
                <% } %>

                <% if (activePage.equals("kategori")) { %>
                    <p>Pilih kategori di samping dan berikan komentar Anda pada unit spesifik.</p>
                    
                    <%-- Opsi Pesawat muncul saat klik Pesawat Komersial --%>
                    <% if ("komersial".equals(currentKategori)) { %>
                        <div class="sub-nav">
                            <strong>Opsi Pesawat:</strong>
                            <a href="web?page=kategori&type=komersial&sub=Airbus_A350" class="btn-sub">Airbus A350</a>
                            <a href="web?page=kategori&type=komersial&sub=Boeing_787" class="btn-sub">Boeing 787</a>
                            <a href="web?page=kategori&type=komersial&sub=Airbus_A220" class="btn-sub">Airbus A220</a>
                        </div>
                    <% } %>
                <% } %>
            </div>
        </div>

        <div class="sidebar-right">
            <% if (activePage.equals("kategori")) { %>
                <div class="sidebar-box">
                    <h3>KATEGORI UTAMA</h3>
                    <div class="category-menu">
                        <a href="web?page=kategori&type=komersial" class="<%= "komersial".equals(currentKategori) ? "active-cat" : "" %>">Pesawat Komersial</a>
                        <a href="web?page=kategori&type=tempur" class="<%= "tempur".equals(currentKategori) ? "active-cat" : "" %>">Pesawat Tempur</a>
                        <a href="web?page=kategori&type=kargo" class="<%= "kargo".equals(currentKategori) ? "active-cat" : "" %>">Pesawat Kargo</a>
                    </div>
                </div>
            <% } %>
        </div>
    </div>

    <%-- BAGIAN KOMENTAR DINAMIS --%>
    <% if (!activePage.equals("home")) { %>
        <div class="comment-container">
            <div class="content-box">
                <h3>Diskusi Pesawat: <%= tableTitle %></h3>
                
                <div class="comment-form">
                    <%-- Form diarahkan ke servlet komentar --%>
                    <form action="komentar" method="POST">
                        <input type="hidden" name="action" value="tambah">
                        <%-- Data topik dikirim ke kolom topik_pesawat --%>
                        <input type="hidden" name="topik_pesawat" value="<%= topikAktif %>">
                        
                        <label><strong>Berikan Komentar Anda:</strong></label>
                        <textarea name="isi_komentar" class="comment-input" rows="4" 
                                  placeholder="Apa pendapat Anda tentang <%= topikAktif %>?" required></textarea>
                        
                        <div style="margin-top: 15px; display: flex; justify-content: flex-end;">
                            <button type="submit" class="btn-sub">Kirim Komentar</button>
                        </div>
                    </form>
                </div>

                <div style="margin-top: 30px;">
                    <h4>Komentar Terkini</h4>
                    <hr color="#eee">
                    
                    <%
                        // Mengambil data real dari database
                        List<komentar> listKomentar = komentarcontroller.getKomentarByTopik(topikAktif);
                        if (listKomentar != null && !listKomentar.isEmpty()) {
                            for (komentar k : listKomentar) {
                    %>
                            <div class="comment-card">
                                <div style="display: flex; justify-content: space-between; align-items: center;">
                                    <span style="font-weight: bold; color: #007bff;">@<%= k.getUsername() %></span>
                                    <small style="color: #999;"><%= k.getTanggalPost() %></small>
                                </div>
                                <p style="margin: 8px 0 0; color: #333; line-height: 1.5;">"<%= k.getIsiKomentar() %>"</p>
                            </div>
                    <%
                            }
                        } else {
                    %>
                            <div style="padding: 20px 0; text-align: center;">
                                <p style="color: #666; font-style: italic;">Belum ada komentar untuk topik <%= topikAktif %>.</p>
                            </div>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
    <% } %>

</body>
</html>