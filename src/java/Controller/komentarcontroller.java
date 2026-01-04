package controller;

import Models.KoneksiDB;
import Models.komentar;
import Models.User;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/komentar") // DIPERBAIKI: Menggunakan huruf kecil 'k'
public class komentarcontroller extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null || "tambah".equals(action)) {
            tambahKomentar(request, response);
        }
    }

    private void tambahKomentar(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect("login.jsp?error=Harus_Login");
            return;
        }

        String topik = request.getParameter("topik_pesawat"); 
        String isi = request.getParameter("isi_komentar");
        // Ambil tipe kategori agar redirect tidak selalu ke 'komersial'
        String type = request.getParameter("type_pesawat"); 
        if (type == null) type = "komersial";

        String sql = "INSERT INTO komentar (username, topik_pesawat, isi_komentar) VALUES (?, ?, ?)";

        try (Connection conn = KoneksiDB.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, topik);
            pstmt.setString(3, isi);
            pstmt.executeUpdate();
            
            // DIPERBAIKI: Redirect menggunakan parameter type yang dinamis
            response.sendRedirect("web?page=kategori&type=" + type + "&sub=" + topik.replace(" ", "_"));
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("web?page=kategori&error=SQL_Error");
        }
    }

    public static List<komentar> getKomentarByTopik(String topik) {
        List<komentar> listKomentar = new ArrayList<>();
        String sql = "SELECT * FROM komentar WHERE topik_pesawat = ? ORDER BY tanggal_post DESC";

        try (Connection conn = KoneksiDB.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, topik);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    komentar k = new komentar();
                    k.setUsername(rs.getString("username"));
                    k.setTopikPesawat(rs.getString("topik_pesawat"));
                    k.setIsiKomentar(rs.getString("isi_komentar"));
                    k.setTanggalPost(rs.getTimestamp("tanggal_post"));
                    listKomentar.add(k);
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return listKomentar;
    }

    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException { processRequest(req, resp); }
    @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException { processRequest(req, resp); }
}