<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="Models.User" %>
<%@page import="Models.Pesawat" %>
<%@page import="java.util.List" %>

<%
    // --- 1. SESSION SECURITY ---
    User user = (User) session.getAttribute("user");
    if (user == null || !user.getRole().equalsIgnoreCase("admin")) {
        response.sendRedirect("index.jsp?error=unauthorized");
        return;
    }

    // --- 2. DATA CHECK ---
    List<Pesawat> listPesawat = (List<Pesawat>) request.getAttribute("listPesawat");
    if (listPesawat == null) {
        response.sendRedirect("pesawat?action=admin_view");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>🛡️ Panel Admin - WikiAir</title>
    <style>
        /* --- GLOBAL STYLES --- */
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f4f7f6; margin: 0; color: #333; }

        /* --- SIDEBAR --- */
        .sidebar { width: 240px; background: #2c3e50; color: white; height: 100vh; position: fixed; left: 0; top: 0; padding-top: 20px; }
        .sidebar h3 { text-align: center; color: #ecf0f1; margin-bottom: 20px; font-size: 1.5em; border-bottom: 1px solid #34495e; padding-bottom: 15px; }
        .sidebar a { padding: 15px 25px; text-decoration: none; font-size: 16px; color: #bdc3c7; display: block; border-bottom: 1px solid #34495e; transition: 0.3s; }
        .sidebar a:hover { background-color: #34495e; color: #fff; padding-left: 30px; }

        /* --- HEADER --- */
        .header { margin-left: 240px; background-color: #fff; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 2px 5px rgba(0,0,0,0.05); position: sticky; top: 0; z-index: 100; }
        .logout-btn { background: none; border: 1px solid #e74c3c; color: #e74c3c; padding: 5px 15px; border-radius: 4px; cursor: pointer; font-weight: bold; transition: 0.3s; }
        .logout-btn:hover { background: #e74c3c; color: white; }

        /* --- MAIN CONTENT --- */
        .main-content { margin-left: 240px; padding: 30px; }
        .card { background: white; padding: 25px; border-radius: 8px; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05); margin-bottom: 20px; }

        /* --- TABLE --- */
        table { width: 100%; border-collapse: separate; border-spacing: 0; margin-top: 15px; }
        table th, table td { padding: 12px 15px; border-bottom: 1px solid #eee; text-align: left; vertical-align: middle; }
        table th { background: linear-gradient(135deg, #3498db 0%, #2980b9 100%); color: white; font-weight: 600; text-transform: uppercase; font-size: 0.85em; }
        table tr:hover { background-color: #f8f9fa; }

        /* --- ELEMENTS --- */
        .badge-date { background: #e8f6f3; color: #1abc9c; padding: 4px 8px; border-radius: 4px; font-size: 12px; font-weight: bold; }
        .btn-add-new { background-color: #27ae60; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; font-weight: bold; display: inline-block; transition: 0.3s; }
        .btn-add-new:hover { transform: translateY(-2px); box-shadow: 0 2px 5px rgba(0,0,0,0.1); }

        .action-links { display: flex; gap: 8px; justify-content: center; }
        .action-btn { padding: 6px 12px; border-radius: 6px; text-decoration: none; color: white; font-size: 13px; font-weight: 600; display: inline-flex; align-items: center; min-width: 70px; justify-content: center; }
        .btn-edit { background-color: #ff9f1c; }
        .btn-delete { background-color: #e74c3c; }
        
        input[type="text"], select { width: 100%; padding: 10px 15px; border: 2px solid #e0e0e0; border-radius: 6px; box-sizing: border-box; }

        /* --- MODAL NOTIFICATION --- */
        .modal-overlay { position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); display: flex; justify-content: center; align-items: center; z-index: 9999; animation: fadeIn 0.3s ease-out; }
        .modal-notification { background: white; padding: 30px 40px; border-radius: 12px; box-shadow: 0 10px 40px rgba(0,0,0,0.3); text-align: center; min-width: 400px; animation: slideDown 0.3s ease-out; }
        .modal-notification .icon { font-size: 48px; margin-bottom: 15px; }
        .modal-notification .title { font-size: 20px; font-weight: bold; margin-bottom: 10px; color: #333; }
        .modal-notification .message { font-size: 16px; color: #666; margin-bottom: 20px; }
        .modal-notification .btn-close { background: #3498db; color: white; border: none; padding: 10px 30px; border-radius: 6px; cursor: pointer; font-weight: bold; }
        .modal-notification .btn-close:hover { background: #2980b9; }
        
        .success-icon { color: #27ae60; }
        .error-icon { color: #e74c3c; }

        @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }
        @keyframes slideDown { from { transform: translateY(-20px); opacity: 0; } to { transform: translateY(0); opacity: 1; } }
    </style>
</head>
<body>

    <div class="sidebar">
        <h3>WikiAir Admin</h3>
        <a href="pesawat?action=admin_view" style="background-color: #34495e; color: white;">📋 Kelola Pesawat</a>
        <a href="Form_Pesawat.jsp?mode=tambah">➕ Tambah Data Baru</a>
    </div>

    <div class="header">
        <div>Dashboard Admin: <strong><%= user.getUsername() %></strong></div>
        <form action="login" method="POST" style="margin:0;">
            <input type="hidden" name="action" value="logout">
            <button type="submit" class="logout-btn">Logout ➔</button>
        </form>
    </div>

    <div class="main-content">
        
        <% 
            // --- NOTIFICATION LOGIC ---
            String msg = request.getParameter("msg");
            
            if (msg != null && !msg.isEmpty()) {
                String actionType = "NOTIFIKASI";
                String icon = "ℹ️";
                String iconClass = "success-icon";
                String message = msg.replace("_", " ");

                if ("success_insert".equals(msg) || "Insert_Sukses".equals(msg)) {
                    actionType = "TAMBAH DATA";
                    icon = "✅";
                    message = "Data pesawat berhasil ditambahkan ke sistem.";
                } else if ("success_update".equals(msg) || "Update_Sukses".equals(msg)) {
                    actionType = "EDIT DATA";
                    icon = "✏️";
                    message = "Data pesawat berhasil diperbarui.";
                } else if ("success_delete".equals(msg) || "Delete_Sukses".equals(msg)) {
                    actionType = "HAPUS DATA";
                    icon = "🗑️";
                    message = "Data pesawat berhasil dihapus dari sistem.";
                } else if ("Duplicate_Kode".equals(msg)) {
                    actionType = "ERROR";
                    icon = "⚠️";
                    iconClass = "error-icon";
                    message = "Kode pesawat sudah terdaftar! Gunakan kode lain.";
                }
        %>
            <div class="modal-overlay" id="notificationModal" onclick="closeNotification()">
                <div class="modal-notification" onclick="event.stopPropagation()">
                    <div class="icon <%= iconClass %>"><%= icon %></div>
                    <div class="title"><%= actionType %></div>
                    <div class="message"><%= message %></div>
                    <button class="btn-close" onclick="closeNotification()">OK</button>
                </div>
            </div>
        <% } %>

        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
            <h2>Daftar Inventaris Pesawat</h2>
            <a href="Form_Pesawat.jsp?mode=tambah" class="btn-add-new">+ Tambah Pesawat</a>
        </div>

        <div class="card" style="padding: 20px;">
            <div style="display: grid; grid-template-columns: 2fr 1fr; gap: 20px;">
                <input type="text" id="searchInput" placeholder="Ketik nama atau kode pesawat..." onkeyup="filterTable()">
                <select id="filterCategory" onchange="filterTable()">
                    <option value="">Semua Kategori</option>
                    <option value="komersial">Pesawat Komersial</option>
                    <option value="tempur">Pesawat Tempur</option>
                    <option value="kargo">Pesawat Kargo</option>
                </select>
            </div>
        </div>

        <div class="card" style="padding: 0; overflow: hidden;">
            <table id="aircraftTable">
                <thead>
                    <tr>
                        <th>ID</th> <th>Kode</th> <th>Jenis Pesawat</th> <th>Kategori</th> 
                        <th>Operator</th> <th>Mesin</th> <th>Pabrikan</th> <th>Tahun</th> <th>Negara</th> 
                        <th style="text-align: center;">Aksi</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (listPesawat != null && !listPesawat.isEmpty()) { 
                        for (Pesawat p : listPesawat) { %>
                    <tr>
                        <td><%= p.getID_Pesawat() %></td>
                        <td><strong><%= (p.getKodePesawat() != null) ? p.getKodePesawat() : "-" %></strong></td>
                        <td><%= p.getJenisPesawat() %></td>
                        <td><%= p.getKategori() %></td>
                        <td><%= (p.getNamaOperator() != null) ? p.getNamaOperator() : "-" %></td>
                        <td><%= (p.getTipe_mesin() != null) ? p.getTipe_mesin() : "-" %></td>
                        <td><%= p.getPabrikan() %></td>
                        <td><span class="badge-date"><%= p.getTahun_produksi() %></span></td>
                        <td><%= (p.getNegara_asal() != null) ? p.getNegara_asal() : "-" %></td>
                        <td>
                            <div class="action-links">
                                <a href="Form_Pesawat.jsp?mode=edit&id=<%= p.getID_Pesawat() %>&kode=<%= (p.getKodePesawat()!=null)?p.getKodePesawat():"" %>&nama=<%= p.getJenisPesawat() %>&kategori=<%= p.getKategori() %>&operator=<%= (p.getNamaOperator()!=null)?p.getNamaOperator():"" %>&tipemesin=<%= (p.getTipe_mesin()!=null)?p.getTipe_mesin():"" %>&pabrikan=<%= p.getPabrikan() %>&kecepatan=<%= (p.getKecepatan_maks()!=null)?p.getKecepatan_maks():"" %>&tahun=<%= p.getTahun_produksi() %>&negara=<%= (p.getNegara_asal()!=null)?p.getNegara_asal():"" %>" 
                                   class="action-btn btn-edit">
                                    ✏️ Edit
                                </a>
                                
                                <a href="pesawat?action=delete&id=<%= p.getID_Pesawat() %>" 
                                   class="action-btn btn-delete"
                                   onclick="return confirm('Yakin ingin menghapus data <%= p.getJenisPesawat() %>?');">
                                   🗑️ Hapus
                                </a>
                            </div>
                        </td>
                    </tr>
                    <% } } else { %>
                    <tr>
                        <td colspan="10" style="text-align:center;">Tidak ada data.</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        function filterTable() {
            const input = document.getElementById("searchInput").value.toUpperCase();
            const filter = document.getElementById("filterCategory").value.toUpperCase();
            const table = document.getElementById("aircraftTable");
            const tr = table.getElementsByTagName("tr");
            for (let i = 1; i < tr.length; i++) {
                // Index 2 = Jenis Pesawat, Index 3 = Kategori (sesuaikan jika kolom berubah)
                let tdName = tr[i].getElementsByTagName("td")[2];
                let tdCat = tr[i].getElementsByTagName("td")[3];
                if (tdName && tdCat) {
                    let txtValue = tdName.textContent || tdName.innerText;
                    let catValue = tdCat.textContent || tdCat.innerText;
                    if (txtValue.toUpperCase().indexOf(input) > -1 && (filter === "" || catValue.toUpperCase().indexOf(filter) > -1)) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        }

        // Close notification modal
        function closeNotification() {
            const modal = document.getElementById('notificationModal');
            if (modal) {
                // Animation reverse logic (optional) or just remove
                modal.style.opacity = '0';
                setTimeout(() => modal.remove(), 300);
            }
        }

        // Auto-close after 3 seconds
        window.addEventListener('load', function () {
            const modal = document.getElementById('notificationModal');
            if (modal) {
                setTimeout(() => closeNotification(), 3000);
            }
        });
    </script>

</body>
</html>