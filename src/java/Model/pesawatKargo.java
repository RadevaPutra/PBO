/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Model;

import java.util.List;


public class pesawatKargo extends Pesawat {
   

    public pesawatKargo(int ID_Pesawat, int ID_Mesin, String nama_pesawat, String tipe_mesin, 
                        String pabrikan, float kecepatan_maks, int tahun_produksi, String negara_asal) {
        super(ID_Pesawat, ID_Mesin, nama_pesawat, tipe_mesin, pabrikan, kecepatan_maks, 
              tahun_produksi, negara_asal);
    }

    @Override
    public String detail_mesin() {
        return "Mesin Pesawat Kargo: Seringkali menggunakan mesin yang sama dengan komersial, namun daya tahan dan torsi lebih diprioritaskan untuk membawa beban yang sangat berat.";
    }

    @Override
    public String detail_pesawat() {
        return "Badan Pesawat Kargo: Ditandai dengan pintu kargo besar, lantai kabin yang diperkuat, dan biasanya memiliki lambung yang lebih tinggi dan lebar untuk memuat kontainer standar.";
    }
    
    @Override
    public List<String> TampilKategori() {
        List<String> categories = super.TampilKategori();
        categories.add("LOGISTIK");
        categories.add("KARGO");
        return categories;
    }
}
