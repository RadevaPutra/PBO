package Models;

import java.util.ArrayList;
import java.util.List;

public class PesawatKomersial extends Pesawat {
    
    public PesawatKomersial() {
        super(); 
        this.kategori = "komersial"; 
    }
    
    // PERBAIKAN: Ubah float menjadi String pada parameter kecepatan_maks
    public PesawatKomersial(int ID_Pesawat, String kodePesawat, String jenisPesawat, String namaOperator, 
                            String tanggalPengiriman, String kategori, int ID_Mesin, String tipe_mesin, 
                            String pabrikan, String kecepatan_maks, int tahun_produksi, String negara_asal) {
        
        super(ID_Pesawat, kodePesawat, jenisPesawat, namaOperator, tanggalPengiriman, 
              kategori, ID_Mesin, tipe_mesin, pabrikan, kecepatan_maks, tahun_produksi, negara_asal);
    }

    @Override
    public String detail_mesin() {
        return "Mesin Pesawat Komersial: Menggunakan Turbofan efisiensi tinggi untuk rute jarak jauh.";
    }

    @Override
    public String detail_pesawat() {
        return "Fokus: Kapasitas penumpang, kenyamanan kabin, dan daya tahan operasional.";
    }
    
    @Override
    public List<String> TampilKategori() {
        List<String> categories = super.TampilKategori();
        categories.add("SIPIL");
        categories.add("KOMERSIAL");
        return categories;
    }
}