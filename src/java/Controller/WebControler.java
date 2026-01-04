package Controller;

import Model.KoneksiDB;
import Model.User;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet({"/login", "/register", "/logout"})
public class WebControler extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String path = request.getServletPath();

        switch (path) {
            case "/login":
                handleLogin(request, response);
                break;
            case "/register":
                handleRegister(request, response);
                break;
            case "/logout":
                handleLogout(request, response);
                break;
            default:
                response.sendRedirect("index.jsp");
                break;
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        User user = null;
        
        // Query Login: SELECT id_akun, role, username FROM user WHERE username = ? AND password = ?
        String sql = "SELECT id_akun, role, username FROM user WHERE username = ? AND password = ?";
        
        try (Connection conn = KoneksiDB.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, username);
            pstmt.setString(2, password); // Hati-hati: Password harus di-hash di produksi
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    // Berhasil login, buat objek User
                    int id = rs.getInt("id_akun");
                    String roleDb = rs.getString("role");
                    List<String> roles = Arrays.asList(roleDb.split(","));
                    user = new User(id, username, password, roles);
                }
            }
        } catch (SQLException e) {
            System.err.println("SQL Error saat login: " + e.getMessage());
        }

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            
            // Redirect sesuai role
            if (user.getFirstRole().equals("admin")) {
                response.sendRedirect("admin_dasboard.jsp");
            } else {
                response.sendRedirect("user_dasboard.jsp");
            }
        } else {
            response.sendRedirect("index.jsp?error=Login_Gagal");
        }
    }

    private void handleRegister(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        
        if (username == null || password == null || username.trim().isEmpty() || password.trim().isEmpty()) {
            response.sendRedirect("registrasi.jsp?error=Data_Tidak_Lengkap");
            return;
        }
        
        // Query Registrasi: INSERT INTO user (username, password, role) VALUES (?, ?, 'user')
        // Query Registrasi: INSERT INTO user (username, password, role) VALUES (?, ?, ?)
        String sql = "INSERT INTO user (username, password, role) VALUES (?, ?, ?)";
        
        try (Connection conn = KoneksiDB.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, username);
            pstmt.setString(2, password); // Hati-hati: Password harus di-hash di produksi
            pstmt.setString(3, role != null ? role : "user"); // Default ke 'user' jika null
            int rowsAffected = pstmt.executeUpdate();
            
            if (rowsAffected > 0) {
                // Notifikasi "Akun Berhasil Dibuat"
                response.sendRedirect("index.jsp?msg=Registrasi_Sukses");
            } else {
                response.sendRedirect("registrasi.jsp?error=Gagal_Menyimpan_Data");
            }
            
        } catch (SQLException e) {
             // Cek jika error karena username sudah ada (Data Tidak Valid/Lengkap)
            if (e.getErrorCode() == 1062) { // 1062 adalah error code MySQL untuk Duplicate entry for key 'PRIMARY' atau 'UNIQUE'
                 response.sendRedirect("registrasi.jsp?error=Username_Sudah_Ada");
            } else {
                 System.err.println("SQL Error saat registrasi: " + e.getMessage());
                 response.sendRedirect("registrasi.jsp?error=Error_Sistem");
            }
        }
    }
    
    private void handleLogout(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect("index.jsp");
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