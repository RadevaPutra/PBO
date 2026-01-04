package Models;

/**
 * Model class for Admin users
 * Admin accounts are stored separately from regular users for security
 */
public class Admin {

    private int idAdmin;
    private String username;
    private String password;
    private String role;

    // Constructor for login (without password)
    public Admin(int idAdmin, String username) {
        this.idAdmin = idAdmin;
        this.username = username;
        this.role = "admin"; // Admin always has role "admin"
    }

    // Constructor with password (for authentication)
    public Admin(int idAdmin, String username, String password) {
        this.idAdmin = idAdmin;
        this.username = username;
        this.password = password;
        this.role = "admin";
    }

    // Empty constructor
    public Admin() {
        this.role = "admin";
    }

    // Getters and Setters
    public int getIdAdmin() {
        return idAdmin;
    }

    public void setIdAdmin(int idAdmin) {
        this.idAdmin = idAdmin;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
}
