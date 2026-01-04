package controller;

import Models.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "AdminController", urlPatterns = {"/admin"})
public class admincontroller extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        // Proteksi: Harus login & role admin
        if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect("index.jsp?error=Akses_ditolak");
            return;
        }

        String page = request.getParameter("page");

        // Routing halaman admin
        if (page == null || page.equals("dashboard")) {
            request.getRequestDispatcher("admin/dashboard.jsp").forward(request, response);
        } 
        else if (page.equals("pesawat")) {
            // Redirect ke controller pesawat (admin view)
            response.sendRedirect("pesawat?action=admin_view");
        } 
        else if (page.equals("logout")) {
            logout(request, response);
        } 
        else {
            response.sendRedirect("admin?page=dashboard");
        }
    }

    private void logout(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect("index.jsp?msg=Logout_Berhasil");
    }
}
