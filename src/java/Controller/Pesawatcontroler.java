package Controller; 

import Model.Pesawat;
import Model.User;
import Model.KoneksiDB; 
import Model.PesawatKomersial;
import Model.PesawatTempur; 
import Model.pesawatKargo; 
import Model.pesawatKargo;
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

@WebServlet("/pesawat") 
public class Pesawatcontroler extends HttpServlet {

   
    private Pesawat createPesawatFromResultSet(ResultSet rs) throws SQLException {
        
        int id = rs.getInt("id_pesawat");
        String nama = rs.getString("nama_pesawat");
        String pabrikan = rs.getString("pabrikan");
        String kategori = rs.getString("kategori");
        float kecepatan = rs.getFloat("kecepatan_maks");
        int tahun = rs.getInt("tahun_produksi");
        String detailMesin = rs.getString("detail_mesin"); // Digunakan untuk tipe_mesin
        String detailPesawat = rs.getString("detail_pesawat"); // Digunakan untuk detail spesifik (senjata/muatan)
        
       
        String negaraAsalPlaceholder = "Unknown"; 
        
       
        if (kategori.equalsIgnoreCase("komersial")) {
           
            return new PesawatKomersial(id, 0, nama, detailMesin, pabrikan, kecepatan, tahun, negaraAsalPlaceholder);
        } else if (kategori.equalsIgnoreCase("tempur")) {
            return new PesawatTempur(id, 0, nama, detailMesin, pabrikan, kecepatan, tahun, negaraAsalPlaceholder, detailPesawat);
        } else if (kategori.equalsIgnoreCase("Kargo")){
            return new pesawatKargo(id, 0, nama, detailMesin, pabrikan, kecepatan, tahun, negaraAsalPlaceholder);
        }
        return null;
    }

    // --- LOGIKA UTAMA ---
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Mengganti karakter illegal '\u00a0' (non-breaking space) jika ada,
        // meskipun sebaiknya diperbaiki di sumber kode.
        String action = request.getParameter("action");
        if (action == null) { action = "tampil"; }

        switch (action) {
            case "tambah":
            case "edit":
            case "hapus":
                if (!checkAdminRole(request, response)) return;
                handleCrudAction(request, response, action);
                break;
            case "tampil": 
                tampilDaftarKonten(request, response);
                break;
            case "detail": 
                tampilDetailArtikel(request, response);
                break;
            default:
                response.sendRedirect("pesawat?action=tampil");
                break;
        }
    }

    private void tampilDaftarKonten(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Pesawat> listPesawat = new ArrayList<>();
        // Query: SELECT * FROM pesawat
        String sql = "SELECT * FROM pesawat ORDER BY nama_pesawat ASC"; 
        
        try (Connection conn = KoneksiDB.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                Pesawat p = createPesawatFromResultSet(rs);
                if (p != null) {
                    listPesawat.add(p); 
                }
            }
        } catch (SQLException e) {
            System.err.println("SQL Error saat menampilkan daftar pesawat: " + e.getMessage());
        }
        
        request.setAttribute("listPesawat", listPesawat);
        request.getRequestDispatcher("konten.jsp").forward(request, response);
    }
    
    private void tampilDetailArtikel(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        Pesawat detail = null;
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String sql = "SELECT * FROM pesawat WHERE id_pesawat = ?";
            
            try (Connection conn = KoneksiDB.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                
                pstmt.setInt(1, id);
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        detail = createPesawatFromResultSet(rs);
                    }
                }
            }
        } catch (NumberFormatException | SQLException e) {
            System.err.println("Error saat menampilkan detail pesawat: " + e.getMessage());
        }
        
        request.setAttribute("detailPesawat", detail);
        request.getRequestDispatcher("detail_pesawat.jsp").forward(request, response);
    }

    private boolean checkAdminRole(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        // Asumsi kelas Model.User sudah diimport dan memiliki method getFirstRole()
        User user = (session != null) ? (User) session.getAttribute("user") : null; 
        if (user == null || !user.getFirstRole().equals("admin")) {
            response.sendRedirect("index.jsp?error=Akses_Editor_Dibutuhkan");
            return false;
        }
        return true;
    }
    
    private void handleCrudAction(HttpServletRequest request, HttpServletResponse response, String mode) 
            throws ServletException, IOException {
        
        if (request.getMethod().equalsIgnoreCase("POST")) {
             // Logic INSERT/UPDATE/DELETE
             response.sendRedirect("pesawat?action=tampil&msg=" + mode + "_sukses");
        } else {
             // Logic GET
             if (mode.equals("tambah") || mode.equals("edit")) {
                 request.getRequestDispatcher("form_pesawat.jsp?mode=" + mode).forward(request, response);
             } else if (mode.equals("hapus")) {
                 // Logic DELETE
                 response.sendRedirect("pesawat?action=tampil&msg=hapus_sukses");
             }
        }
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