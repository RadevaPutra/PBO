package Models;

import java.util.ArrayList;
import java.util.List;

public class PesawatTempur extends Pesawat {
    
    // Atribut unik untuk PesawatTempur
    public String jenis_senjata; 
    
    // ===================================================================================
    // KONSTRUKTOR 1: KOSONG (Wajib untuk DAO/Controller)
    // ===================================================================================
    public PesawatTempur() {
        super();
        this.kategori = "tempur"; 
    }

    // ===================================================================================
    // KONSTRUKTOR 2: LENGKAP 
    // Mengatasi error "float cannot be converted to String"
    // ===================================================================================
    public PesawatTempur(int ID_Pesawat, String kodePesawat, String jenisPesawat, String namaOperator, 
                         String tanggalPengiriman, String tipeMesin, String kecepatan_maks, 
                         int tahun_produksi, String negara_asal, String jenis_senjata) {
        
        // Memanggil constructor lengkap induk (Pesawat)
        // Kecepatan_maks di sini harus String agar tidak error
        super(ID_Pesawat, kodePesawat, jenisPesawat, namaOperator, tanggalPengiriman, 
              "tempur", 0, tipeMesin, namaOperator, kecepatan_maks, tahun_produksi, negara_asal);
        
        this.jenis_senjata = jenis_senjata;
    }

    @Override
    public String detail_mesin() {
        return "Mesin Pesawat Tempur: Menggunakan mesin Turbofan rasio by-pass rendah atau Turbojet dengan *afterburner*.";
    }

    @Override
    public String detail_pesawat() {
        return "Badan Pesawat Tempur: Dirancang untuk manuver tinggi (high G-force) dan dilengkapi senjata: " + 
               (this.jenis_senjata != null ? this.jenis_senjata : "Persenjataan Standar") + ".";
    }
    
    @Override
    public List<String> TampilKategori() {
        List<String> categories = new ArrayList<>();
        categories.add("TEMPUR");
        categories.add("MILITER");
        return categories;
    }
    
    // Getter & Setter
    public String getJenis_senjata() { return jenis_senjata; }
    public void setJenis_senjata(String jenis_senjata) { this.jenis_senjata = jenis_senjata; }
}