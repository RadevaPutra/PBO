package Controller;

import Model.KoneksiDB;
import Model.Komentar; 
import Model.User; 
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/komentar")
public class komentarcontroler extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) { action = "tampil"; }

        switch (action) {
            case "tambah":
                handleTambahKomentar(request, response);
                break;
            case "tampil":
            default:
                // Biasanya, tampil komentar dilakukan di detail_pesawat.jsp, 
                // tetapi bisa dipisah jika ada AJAX load.
                response.sendRedirect("pesawat?action=detail&id=" + request.getParameter("id_pesawat"));
                break;
        }
    }

    private void handleTambahKomentar(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        
        // Cek apakah user sudah login
        if (user == null) {
            response.sendRedirect("index.jsp?error=Login_Dibutuhkan");
            return;
        }

        int idPesawat = Integer.parseInt(request.getParameter("id_pesawat"));
        String isiKomentar = request.getParameter("isi_komentar");
        
        // Query Post Komentar: INSERT INTO komentar (id_user, id_pesawat, isi_komentar) VALUES (?, ?, ?)
        String sql = "INSERT INTO komentar (id_user, id_pesawat, isi_komentar) VALUES (?, ?, ?)";

        try (Connection conn = KoneksiDB.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, user.ID_Akun);
            pstmt.setInt(2, idPesawat);
            pstmt.setString(3, isiKomentar);
            
            pstmt.executeUpdate();
            
            // Redirect kembali ke halaman detail pesawat
            response.sendRedirect("pesawat?action=detail&id=" + idPesawat + "&msg=Komentar_Sukses");
            
        } catch (SQLException e) {
            System.err.println("SQL Error saat menambahkan komentar: " + e.getMessage());
            response.sendRedirect("pesawat?action=detail&id=" + idPesawat + "&error=Error_Post_Komentar");
        }
    }
    
    // Metode helper untuk menampilkan komentar (dapat dipanggil dari detail_pesawat.jsp)
    public static List<Komentar> getKomentarByPesawatId(int idPesawat) {
        List<Komentar> listKomentar = new ArrayList<>();
        // Query Tampil Komentar: SELECT k.isi_komentar, k.tanggal_post, u.username FROM komentar k JOIN user u ON k.id_user = u.id_akun WHERE k.id_pesawat = ? ORDER BY k.tanggal_post DESC
        String sql = "SELECT k.isi_komentar, k.tanggal_post, u.username "
                   + "FROM komentar k JOIN user u ON k.id_user = u.id_akun "
                   + "WHERE k.id_pesawat = ? ORDER BY k.tanggal_post DESC";
        
        try (Connection conn = KoneksiDB.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, idPesawat);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    // Asumsi konstruktor Komentar: new Komentar(isi, user, tanggal)
                    // Anda mungkin perlu menyesuaikan konstruktor Komentar di Model
                    // listKomentar.add(new Komentar(rs.getString("isi_komentar"), rs.getString("username"), rs.getTimestamp("tanggal_post")));
                }
            }
        } catch (SQLException e) {
            System.err.println("SQL Error saat mengambil komentar: " + e.getMessage());
        }
        return listKomentar;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }
}