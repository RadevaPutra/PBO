package controller;

import Models.KoneksiDB;
import Models.User;
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
import javax.servlet.http.HttpSession;

@WebServlet(name = "LoginController", urlPatterns = { "/login" })
public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        // LOGOUT
        if ("logout".equalsIgnoreCase(action)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect("index.jsp?status=logout");
        } else {
            response.sendRedirect("index.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        System.out.println("DEBUG LOGIN -> Username: " + username);

        try {
            User user = authenticate(username, password);

            if (user != null) {

                HttpSession session = request.getSession(true);
                session.setAttribute("user", user);
                session.setAttribute("role", user.getRole());

                System.out.println("DEBUG LOGIN -> Role: " + user.getRole());
                System.out.println("DEBUG SESSION ID -> " + session.getId());

                // REDIRECT BERDASARKAN ROLE
                if ("admin".equalsIgnoreCase(user.getRole())) {
                    response.sendRedirect("admin_dashboard.jsp");
                } else {
                    response.sendRedirect("web"); // halaman user
                }

            } else {
                request.setAttribute("error", "Username atau Password salah.");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Kesalahan sistem. Silakan coba lagi.");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }

    // AUTHENTICATE USER - Check both admin and regular user tables
    private User authenticate(String username, String password) throws SQLException {

        // FIRST: Check admin_user table
        String adminSql = "SELECT ID_admin, username FROM admin_user WHERE username=? AND password=?";

        try (Connection conn = KoneksiDB.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(adminSql)) {

            pstmt.setString(1, username);
            pstmt.setString(2, password);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    // Admin found
                    User user = new User();
                    user.setIdAkun(rs.getInt("ID_admin"));
                    user.setUsername(rs.getString("username"));
                    user.setRole("admin");
                    System.out.println("DEBUG: Admin login successful - " + username);
                    return user;
                }
            }
        }

        // SECOND: Check app_user table (regular users)
        String userSql = "SELECT ID_akun, username, role FROM app_user WHERE username=? AND password=?";

        try (Connection conn = KoneksiDB.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(userSql)) {

            pstmt.setString(1, username);
            pstmt.setString(2, password);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    // Regular user found
                    User user = new User();
                    user.setIdAkun(rs.getInt("ID_akun"));
                    user.setUsername(rs.getString("username"));
                    user.setRole(rs.getString("role"));
                    System.out
                            .println("DEBUG: User login successful - " + username + " (role: " + user.getRole() + ")");
                    return user;
                }
            }
        }

        return null;
    }
}
