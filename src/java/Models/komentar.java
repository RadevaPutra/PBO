package Models;

import java.sql.Timestamp;

public class komentar {
    private int idKomentar;
    private String isiKomentar;
    private String username; 
    private Timestamp tanggalPost;
    private String topikPesawat;

    public komentar() {}

    public int getIdKomentar() { return idKomentar; }
    public void setIdKomentar(int idKomentar) { this.idKomentar = idKomentar; }

    public String getIsiKomentar() { return isiKomentar; }
    public void setIsiKomentar(String isiKomentar) { this.isiKomentar = isiKomentar; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public Timestamp getTanggalPost() { return tanggalPost; }
    public void setTanggalPost(Timestamp tanggalPost) { this.tanggalPost = tanggalPost; }

    public String getTopikPesawat() { return topikPesawat; }
    public void setTopikPesawat(String topikPesawat) { this.topikPesawat = topikPesawat; }
}