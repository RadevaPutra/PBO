/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package MOD11Control;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author radev
 */
@WebServlet("/LoginControl") 
public class LoginControl extends HttpServlet {

   @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        String message;
        boolean isLoginSuccess;
        
       
        if (email != null && !email.trim().isEmpty() && password.equals("12345")) {
            message = "Login Berhasil! Selamat datang, " + email + ".";
            isLoginSuccess = true;
        } else {
            message = "Login Gagal. Email atau Password salah.";
            isLoginSuccess = false;
        }
        
        // Set data yang akan dikirim kembali ke JSP
        request.setAttribute("message", message);
        request.setAttribute("isLoginSuccess", isLoginSuccess);
        
        // Forward kembali ke index.jsp dengan parameter page=login
        request.getRequestDispatcher("index.jsp?page=login").forward(request, response);
    }
}
