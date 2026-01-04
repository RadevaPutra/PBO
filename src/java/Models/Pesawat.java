package Models;

import java.util.ArrayList;
import java.util.List;

// 1. Hapus kata 'abstract' agar kelas bisa diinstansiasi di Controller
public class Pesawat {
    
    protected int ID_Pesawat;
    protected String kodePesawat;
    protected String jenisPesawat;
    protected String namaOperator;
    protected String tanggalPengiriman; // Digunakan sebagai parameter sorting tanggal
    protected String kategori; 
    
    protected int ID_Mesin;
    protected String tipe_mesin;
    protected String pabrikan;
    protected String kecepatan_maks; 
    protected int tahun_produksi;
    protected String negara_asal;

    // 2. Konstruktor Kosong
    public Pesawat() {}
    
    // 3. Konstruktor Khusus untuk Admin (digunakan di createPesawatFromRequest)
    // Ini menyelesaikan error "no suitable constructor found"
    public Pesawat(String jenisPesawat, String kategori, String namaOperator, String tanggalPengiriman) {
        this.jenisPesawat = jenisPesawat;
        this.kategori = kategori;
        this.namaOperator = namaOperator;
        this.tanggalPengiriman = tanggalPengiriman;
    }

    // 4. Konstruktor Lengkap (untuk keperluan Database/DAO)
    public Pesawat(int ID_Pesawat, String kodePesawat, String jenisPesawat, String namaOperator, String tanggalPengiriman, 
                   String kategori, int ID_Mesin, String tipe_mesin, String pabrikan, String kecepatan_maks, 
                   int tahun_produksi, String negara_asal) {
        
        this.ID_Pesawat = ID_Pesawat;
        this.kodePesawat = kodePesawat;
        this.jenisPesawat = jenisPesawat;
        this.namaOperator = namaOperator;
        this.tanggalPengiriman = tanggalPengiriman;
        this.kategori = kategori;
        this.ID_Mesin = ID_Mesin;
        this.tipe_mesin = tipe_mesin;
        this.pabrikan = pabrikan;
        this.kecepatan_maks = kecepatan_maks;
        this.tahun_produksi = tahun_produksi;
        this.negara_asal = negara_asal;
    }

    // 5. Ubah method abstract menjadi method biasa agar tidak perlu override paksa
    public String detail_mesin() {
        return "Mesin: " + tipe_mesin + " oleh " + pabrikan;
    }

    public String detail_pesawat() {
        return "Pesawat: " + jenisPesawat + " (" + kodePesawat + ")";
    }
    
    public List<String> TampilKategori() {
        List<String> categories = new ArrayList<>();
        categories.add("UMUM");
        categories.add("KOMERSIAL");
        categories.add("TEMPUR");
        categories.add("KARGO");
        return categories;
    }

    // --- Getter & Setter ---
    public int getID_Pesawat() { return ID_Pesawat; }
    // Perbaikan method setId agar sinkron dengan Controller
    public void setID_Pesawat(int ID_Pesawat) { this.ID_Pesawat = ID_Pesawat; }
    public void setId(int id) { this.ID_Pesawat = id; } 

    public String getKodePesawat() { return kodePesawat; }
    public void setKodePesawat(String kodePesawat) { this.kodePesawat = kodePesawat; }

    public String getJenisPesawat() { return jenisPesawat; }
    public void setJenisPesawat(String jenisPesawat) { this.jenisPesawat = jenisPesawat; }

    public String getNamaOperator() { return namaOperator; }
    public void setNamaOperator(String namaOperator) { this.namaOperator = namaOperator; }

    public String getTanggalPengiriman() { return tanggalPengiriman; }
    public void setTanggalPengiriman(String tanggalPengiriman) { this.tanggalPengiriman = tanggalPengiriman; }

    public String getKategori() { return kategori; } 
    public void setKategori(String kategori) { this.kategori = kategori; }

    public int getID_Mesin() { return ID_Mesin; }
    public void setID_Mesin(int ID_Mesin) { this.ID_Mesin = ID_Mesin; }

    public String getTipe_mesin() { return tipe_mesin; }
    public void setTipe_mesin(String tipe_mesin) { this.tipe_mesin = tipe_mesin; }

    public String getPabrikan() { return pabrikan; }
    public void setPabrikan(String pabrikan) { this.pabrikan = pabrikan; }

    public String getKecepatan_maks() { return kecepatan_maks; }
    public void setKecepatan_maks(String kecepatan_maks) { this.kecepatan_maks = kecepatan_maks; }

    public int getTahun_produksi() { return tahun_produksi; }
    public void setTahun_produksi(int tahun_produksi) { this.tahun_produksi = tahun_produksi; }

    public String getNegara_asal() { return negara_asal; }
    public void setNegara_asal(String negara_asal) { this.negara_asal = negara_asal; }
}