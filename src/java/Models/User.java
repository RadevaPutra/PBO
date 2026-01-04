package Models;

public class User {

    private int idAkun;
    private String username;
    private String password;
    private String role;        // ROLE STRING
    private boolean login_status;

    // -------------------------------------------------------------
    // KONSTRUKTOR UNTUK REGISTRASI
    // -------------------------------------------------------------
    public User(int idAkun, String username, String password, String role) {
        this.idAkun = idAkun;
        this.username = username;
        this.password = password;
        this.role = (role != null) ? role : "user";
        this.login_status = false;
    }

    // -------------------------------------------------------------
    // KONSTRUKTOR UNTUK LOGIN
    // -------------------------------------------------------------
    public User(int idAkun, String username, String role) {
        this.idAkun = idAkun;
        this.username = username;
        this.role = role;
        this.login_status = true;
    }

    // -------------------------------------------------------------
    // KONSTRUKTOR KOSONG (WAJIB ADA)
    // -------------------------------------------------------------
    public User() {
        this.role = "guest";
        this.login_status = false;
    }

    // ------------------- BUSINESS LOGIC -------------------------

    public boolean login(String inputPassword) {
        if (this.password != null && this.password.equals(inputPassword)) {
            this.login_status = true;
            return true;
        }
        return false;
    }

    public void logout() {
        this.login_status = false;
    }

    // ------------------- GETTER & SETTER ------------------------

    public int getIdAkun() {
        return idAkun;
    }

    public void setIdAkun(int idAkun) {
        this.idAkun = idAkun;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getRole() {          // 🔥 SEKARANG STRING
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public boolean isLogin_status() {
        return login_status;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Object getFirstRole() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
