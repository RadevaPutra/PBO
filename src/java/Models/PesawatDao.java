package Models;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PesawatDao {

    // =================================================
    // ================= READ METHODS ==================
    // =================================================

    public List<Pesawat> getAllPesawat() throws SQLException {
        List<Pesawat> list = new ArrayList<>();
        String sql = "SELECT * FROM pesawat ORDER BY ID_Pesawat DESC";

        try (Connection conn = KoneksiDB.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                list.add(mapResultSetToPesawat(rs));
            }
        }
        return list;
    }

    public List<Pesawat> getPesawatByKategori(String kategori) throws SQLException {
        List<Pesawat> list = new ArrayList<>();
        String sql = "SELECT * FROM pesawat WHERE kategori = ? ORDER BY ID_Pesawat DESC";

        try (Connection conn = KoneksiDB.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, kategori);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToPesawat(rs));
                }
            }
        }
        return list;
    }

    public List<Pesawat> getPesawatByJenis(String jenis) throws SQLException {
        List<Pesawat> list = new ArrayList<>();
        String sql = "SELECT * FROM pesawat WHERE jenisPesawat LIKE ? ORDER BY ID_Pesawat DESC";

        try (Connection conn = KoneksiDB.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, "%" + jenis + "%");
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToPesawat(rs));
                }
            }
        }
        return list;
    }

    public Pesawat getPesawatById(int id) throws SQLException {
        String sql = "SELECT * FROM pesawat WHERE ID_Pesawat = ?";

        try (Connection conn = KoneksiDB.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToPesawat(rs);
                }
            }
        }
        return null; // Return null if not found
    }

    // Method to check if kodePesawat already exists (for duplicate prevention)
    public boolean isKodePesawatExists(String kodePesawat) throws SQLException {
        String sql = "SELECT COUNT(*) FROM pesawat WHERE kodePesawat = ?";

        System.out.println("[DEBUG] Checking duplicate for kode: '" + kodePesawat + "'");

        try (Connection conn = KoneksiDB.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, kodePesawat);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt(1);
                    System.out.println("[DEBUG] Query result - Count: " + count);
                    return count > 0; // True if count > 0 (duplicate exists)
                }
            }
        }
        return false;
    }

    // Check if kodePesawat exists EXCLUDING a specific ID (for edit validation)
    public boolean isKodePesawatExistsExcludingId(String kodePesawat, int excludeId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM pesawat WHERE kodePesawat = ? AND ID_Pesawat != ?";

        System.out.println(
                "[DEBUG] Checking duplicate for kode: '" + kodePesawat + "' (excluding ID: " + excludeId + ")");

        try (Connection conn = KoneksiDB.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, kodePesawat);
            pstmt.setInt(2, excludeId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt(1);
                    System.out.println("[DEBUG] Query result - Count: " + count);
                    return count > 0;
                }
            }
        }
        return false;
    }

    // =================================================
    // ================= WRITE METHODS =================
    // =================================================

    public boolean insertPesawat(Pesawat p) throws SQLException {
        String sql = "INSERT INTO pesawat " +
                "(kodePesawat, jenisPesawat, namaOperator, tanggalPengiriman, kategori, " +
                "tipe_mesin, pabrikan, kecepatan_maks, tahun_produksi, negara_asal) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = KoneksiDB.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, p.getKodePesawat());
            pstmt.setString(2, p.getJenisPesawat());
            pstmt.setString(3, p.getNamaOperator());
            pstmt.setString(4, p.getTanggalPengiriman()); // Pastikan format tanggal sesuai
            pstmt.setString(5, p.getKategori());
            pstmt.setString(6, p.getTipe_mesin());
            pstmt.setString(7, p.getPabrikan());
            pstmt.setString(8, p.getKecepatan_maks());
            pstmt.setInt(9, p.getTahun_produksi());
            pstmt.setString(10, p.getNegara_asal());

            int rowsInserted = pstmt.executeUpdate();
            return rowsInserted > 0;
        }
    }

    /**
     * INSERT HANYA 5 FIELD DARI FORM (jenisPesawat, kategori, pabrikan, tahun,
     * negara)
     * Field lain diberi nilai default
     */
    public boolean insertPesawatSimple(Pesawat p) throws SQLException {
        String sql = "INSERT INTO pesawat " +
                "(jenisPesawat, kategori, pabrikan, tahun_produksi, negara_asal, " +
                "kodePesawat, namaOperator, tanggalPengiriman, tipe_mesin, kecepatan_maks) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, NOW(), ?, ?)";

        try (Connection conn = KoneksiDB.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, p.getJenisPesawat());
            pstmt.setString(2, p.getKategori());
            pstmt.setString(3, p.getPabrikan());
            pstmt.setInt(4, p.getTahun_produksi());
            pstmt.setString(5, p.getNegara_asal());

            // Default values untuk field yang tidak ada di form
            pstmt.setString(6, "AUTO-" + System.currentTimeMillis()); // kodePesawat auto-generated
            pstmt.setString(7, "-"); // namaOperator
            // tanggalPengiriman menggunakan NOW()
            pstmt.setString(8, "-"); // tipe_mesin
            pstmt.setString(9, "-"); // kecepatan_maks

            int rowsInserted = pstmt.executeUpdate();
            return rowsInserted > 0;
        }
    }

    public boolean updatePesawat(Pesawat p) throws SQLException {
        String sql = "UPDATE pesawat SET " +
                "kodePesawat=?, jenisPesawat=?, namaOperator=?, tanggalPengiriman=?, " +
                "kategori=?, tipe_mesin=?, pabrikan=?, kecepatan_maks=?, " +
                "tahun_produksi=?, negara_asal=? " +
                "WHERE ID_Pesawat=?";

        try (Connection conn = KoneksiDB.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, p.getKodePesawat());
            pstmt.setString(2, p.getJenisPesawat());
            pstmt.setString(3, p.getNamaOperator());
            pstmt.setString(4, p.getTanggalPengiriman()); // Pastikan format tanggal sesuai
            pstmt.setString(5, p.getKategori());
            pstmt.setString(6, p.getTipe_mesin());
            pstmt.setString(7, p.getPabrikan());
            pstmt.setString(8, p.getKecepatan_maks());
            pstmt.setInt(9, p.getTahun_produksi());
            pstmt.setString(10, p.getNegara_asal());
            pstmt.setInt(11, p.getID_Pesawat());

            int rowsUpdated = pstmt.executeUpdate();
            return rowsUpdated > 0;
        }
    }

    /**
     * UPDATE HANYA 5 FIELD DARI FORM (jenisPesawat, kategori, pabrikan, tahun,
     * negara)
     * Sisanya dibiarkan tidak berubah di database
     */
    public boolean updatePesawatSimple(Pesawat p) throws SQLException {
        String sql = "UPDATE pesawat SET " +
                "jenisPesawat=?, kategori=?, pabrikan=?, tahun_produksi=?, negara_asal=? " +
                "WHERE ID_Pesawat=?";

        try (Connection conn = KoneksiDB.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, p.getJenisPesawat());
            pstmt.setString(2, p.getKategori());
            pstmt.setString(3, p.getPabrikan());
            pstmt.setInt(4, p.getTahun_produksi());
            pstmt.setString(5, p.getNegara_asal());
            pstmt.setInt(6, p.getID_Pesawat());

            int rowsUpdated = pstmt.executeUpdate();
            return rowsUpdated > 0;
        }
    }

    public boolean deletePesawat(int id) throws SQLException {
        String sql = "DELETE FROM pesawat WHERE ID_Pesawat=?";

        try (Connection conn = KoneksiDB.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            int rowsDeleted = pstmt.executeUpdate();
            return rowsDeleted > 0;
        }
    }

    // ... (Metode mapResultSetToPesawat tetap sama) ...

    // =================================================
    // ================= HELPER METHOD ================
    // =================================================

    private Pesawat mapResultSetToPesawat(ResultSet rs) throws SQLException {
        Pesawat p = new Pesawat();

        p.setID_Pesawat(rs.getInt("ID_Pesawat"));
        p.setKodePesawat(rs.getString("kodePesawat"));
        p.setJenisPesawat(rs.getString("jenisPesawat"));
        p.setNamaOperator(rs.getString("namaOperator"));
        p.setTanggalPengiriman(rs.getString("tanggalPengiriman"));
        p.setKategori(rs.getString("kategori"));
        p.setTipe_mesin(rs.getString("tipe_mesin"));
        p.setPabrikan(rs.getString("pabrikan"));
        p.setKecepatan_maks(rs.getString("kecepatan_maks"));
        p.setTahun_produksi(rs.getInt("tahun_produksi"));
        p.setNegara_asal(rs.getString("negara_asal"));

        return p;
    }
}
