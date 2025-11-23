/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package MOD11Control;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// Mapping harus sesuai dengan 'action' di register.jsp
@WebServlet("/RegisterControl") 
public class RegisterControl extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");
        
        String message;
        boolean isRegisterSuccess;
        
       
        if (password.equals(confirmPassword) && !email.isEmpty()) {
          
            message = "Registrasi Berhasil untuk " + email + ". Silakan Login.";
            isRegisterSuccess = true;
        } else {
            message = "Registrasi Gagal! Pastikan semua field terisi dan password cocok.";
            isRegisterSuccess = false;
        }
        
        request.setAttribute("message", message);
        request.setAttribute("isRegisterSuccess", isRegisterSuccess);

        
        String nextPage = isRegisterSuccess ? "login" : "register";
        request.getRequestDispatcher("index.jsp?page=" + nextPage).forward(request, response);
    }
}
