/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Model;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
/**
 *
 * @author radev
 */
@WebServlet(name = "User", urlPatterns = {"/User"})
public class User {
    private int ID_akun;
    private String username;
    private String password; // Seharusnya di-hash
    private List<String> Role;
    private boolean login_status;
    public int ID_Akun;

    // Constructor
    public User(int ID_akun, String username, String password, List<String> Role) {
        this.ID_akun = ID_akun;
        this.username = username;
        this.password = password;
        this.Role = Role;
        this.login_status = false;
    }

    // Metode Statis untuk Registrasi (Daftar)
    public static User Daftar(int ID_akun, String username, String password, List<String> role) {
        System.out.println("User " + username + " berhasil didaftarkan.");
        return new User(ID_akun, username, password, role);
    }
    
    // Metode Bisnis Sesuai Diagram
    public boolean login(String inputPassword) {
        if (this.password.equals(inputPassword)) {
            this.login_status = true;
            return true;
        }
        return false;
    }

    public void logout() {
        this.login_status = false;
    }
    
    public String getPosition() { 
        return "Posisi user ditentukan oleh role"; 
    }
    
    public void editJenisPesawat() { 
        // Logika hanya diimplementasikan jika user adalah Admin 
        if (this.Role.contains("admin")) {
            System.out.println("Admin " + username + " sedang mengedit jenis pesawat.");
        } else {
            System.out.println("Akses ditolak. Hanya Admin yang bisa mengedit jenis pesawat.");
        }
    }

    public void TampilKonten() {
        System.out.println(username + " sedang menampilkan konten.");
    }
    
    // Getter & Helper Methods
    public int getID_akun() { return ID_akun; }
    public String getUsername() { return username; }
    public List<String> getRole() { return Role; }
    public boolean isLogin_status() { return login_status; }
    
    public String getFirstRole() {
        return (Role != null && !Role.isEmpty()) ? Role.get(0).toLowerCase() : "guest";
    }
}
