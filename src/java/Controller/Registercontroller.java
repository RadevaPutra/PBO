package controller;

import Models.KoneksiDB;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// PERBAIKAN 1: Pastikan URL mapping adalah /register agar cocok dengan action di form
@WebServlet(name = "Registercontroller", urlPatterns = { "/register" })
public class Registercontroller extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // PERBAIKAN 2: Ubah registrasi.jsp menjadi register.jsp
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        String errorMsg = null;

        // No need to check role anymore - always "user"
        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            errorMsg = "Username dan Password wajib diisi.";
        }

        if (errorMsg != null) {
            request.setAttribute("error", errorMsg);
            // PERBAIKAN 3: Ubah registrasi.jsp menjadi register.jsp
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        try {
            if (isUsernameExists(username)) {
                errorMsg = "Username '" + username + "' sudah terdaftar.";
            } else if (registerNewUser(username, password, "user")) { // Always register as "user"
                // Berhasil: Lempar ke index.jsp dengan parameter status
                response.sendRedirect("index.jsp?status=success");
                return;
            } else {
                errorMsg = "Gagal mendaftar. Silakan coba lagi.";
            }
        } catch (SQLException e) {
            e.printStackTrace();
            errorMsg = "Database Error: " + e.getMessage();
        }

        request.setAttribute("error", errorMsg);
        // PERBAIKAN 4: Ubah registrasi.jsp menjadi register.jsp
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    private boolean isUsernameExists(String username) throws SQLException {
        String sql = "SELECT ID_akun FROM app_user WHERE username = ?";
        try (Connection conn = KoneksiDB.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, username);
            try (ResultSet rs = pstmt.executeQuery()) {
                return rs.next();
            }
        }
    }

    private boolean registerNewUser(String username, String password, String role) throws SQLException {
        // Pastikan nama tabel (app_user) dan kolom (username, password, role)
        // sudah sesuai dengan database MySQL Anda
        String sql = "INSERT INTO app_user (username, password, role) VALUES (?, ?, ?)";
        try (Connection conn = KoneksiDB.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            pstmt.setString(3, role);
            return pstmt.executeUpdate() > 0;
        }
    }
}