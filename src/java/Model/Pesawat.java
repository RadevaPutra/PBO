package Model;

import java.util.ArrayList;
import java.util.List;

public abstract class Pesawat {
    
    // Atribut Dasar sesuai Diagram
    public int ID_Pesawat;
    public int ID_Mesin;
    public String nama_pesawat;
    public String tipe_mesin;
    public String pabrikan;
    public float kecepatan_maks;
    public int tahun_produksi;
    public String negara_asal;
    
    // Constructor
    public Pesawat(int ID_Pesawat, int ID_Mesin, String nama_pesawat, String tipe_mesin, 
                   String pabrikan, float kecepatan_maks, int tahun_produksi, String negara_asal) {
        this.ID_Pesawat = ID_Pesawat;
        this.ID_Mesin = ID_Mesin;
        this.nama_pesawat = nama_pesawat;
        this.tipe_mesin = tipe_mesin;
        this.pabrikan = pabrikan;
        this.kecepatan_maks = kecepatan_maks;
        this.tahun_produksi = tahun_produksi;
        this.negara_asal = negara_asal;
    }
    
    // --- Metode Abstrak (Wajib di-override oleh subkelas) ---
    // Di Diagram, ini adalah void, tetapi dalam konteks MVC/View, lebih baik mengembalikan String.
    public abstract String detail_mesin();

    public abstract String detail_pesawat();
    
    // --- Metode Umum ---
    
    public void tampilkan_info() {
        System.out.println("Nama: " + nama_pesawat + ", Pabrikan: " + pabrikan);
    }
    
    public List<String> TampilKategori() {
        // Kategori dasar, subkelas dapat menambahkan kategori spesifik
        List<String> categories = new ArrayList<>();
        categories.add("UMUM");
        return categories;
    }
}