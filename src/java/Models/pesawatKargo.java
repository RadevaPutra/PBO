package Models;

import java.util.ArrayList;
import java.util.List;

public class pesawatKargo extends Pesawat { 
    
    // Konstruktor Kosong (Wajib untuk DAO)
    public pesawatKargo() {
        super();
        this.kategori = "kargo"; 
    }
    
    // PERBAIKAN: Parameter kecepatan_maks diubah menjadi String
    public pesawatKargo(int ID_Pesawat, String kodePesawat, String jenisPesawat, 
                        String pabrikan, String tanggalPengiriman, 
                        String tipe_mesin, String kecepatan_maks, int tahun_produksi, String negara_asal) {
        
        // Memanggil konstruktor induk (Pesawat) dengan 12 argumen
        // Sekarang kecepatan_maks adalah String, sehingga error 'incompatible types' akan hilang
        super(ID_Pesawat, kodePesawat, jenisPesawat, 
              pabrikan, tanggalPengiriman, 
              "kargo", 0, tipe_mesin, pabrikan, kecepatan_maks, 
              tahun_produksi, negara_asal);
    }

    @Override
    public String detail_mesin() {
        return "Mesin Pesawat Kargo: Dirancang untuk daya angkut berat dan torsi maksimal.";
    }

    @Override
    public String detail_pesawat() {
        return "Badan Pesawat Kargo: Memiliki badan yang diperkuat dan pintu kargo besar.";
    }
    
    @Override
    public List<String> TampilKategori() {
        List<String> categories = super.TampilKategori();
        categories.add("KARGO");
        return categories;
    }
}