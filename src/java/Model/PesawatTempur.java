package Model;

import java.util.ArrayList;
import java.util.List;

public class PesawatTempur extends Pesawat {
    
    public String jenis_senjata; 

    public PesawatTempur(int ID_Pesawat, int ID_Mesin, String nama_pesawat, String tipe_mesin, 
                         String pabrikan, float kecepatan_maks, int tahun_produksi, String negara_asal, 
                         String jenis_senjata) {
        // Panggilan ke konstruktor kelas induk Pesawat
        super(ID_Pesawat, ID_Mesin, nama_pesawat, tipe_mesin, pabrikan, kecepatan_maks, 
              tahun_produksi, negara_asal);
        this.jenis_senjata = jenis_senjata;
    }

    @Override
    public String detail_mesin() {
        return "Mesin Pesawat Tempur: Menggunakan mesin Turbofan rasio by-pass rendah atau Turbojet dengan *afterburner*.";
    }

    @Override
    public String detail_pesawat() {
        return "Badan Pesawat Tempur: Dirancang untuk manuver tinggi (high G-force) dan dilengkapi senjata: " + this.jenis_senjata + ".";
    }
    
    @Override
    public List<String> TampilKategori() {
        List<String> categories = new ArrayList<>();
        categories.add("TEMPUR");
        categories.add("MILITER");
        return categories;
    }
}