package Model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class KoneksiDB {
    
    private static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String DB_URL = "jdbc:mysql://localhost:3306/db_ensiklopedia_pesawat";
    private static final String USER = "root"; 
    private static final String PASS = "";    
    
    // Gunakan Singleton pattern untuk koneksi
    public static Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName(JDBC_DRIVER);
            connection = DriverManager.getConnection(DB_URL, USER, PASS);
        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("Gagal terhubung ke database: " + e.getMessage());
            e.printStackTrace();
        }
        return connection;
    }
}