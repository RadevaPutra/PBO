package Models;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class KoneksiDB {
    private static final String URL = "jdbc:mysql://127.0.0.1:3307/projek_uas_baru?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC&connectTimeout=3000&socketTimeout=2000";
    private static final String USER = "root";
    private static final String PASSWORD = ""; // GANTI JIKA PASSWORD ANDA TIDAK KOSONG!

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Gagal memuat driver JDBC.", e);
        }
    }

    // PERBAIKAN KRITIS: JANGAN HAPUS 'throws SQLException'
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}