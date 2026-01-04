/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Model;

import java.util.List;


public class PesawatKomersial extends Pesawat {
    
    public PesawatKomersial(int ID_Pesawat, int ID_Mesin, String nama_pesawat, String tipe_mesin, 
                            String pabrikan, float kecepatan_maks, int tahun_produksi, String negara_asal) {
        super(ID_Pesawat, ID_Mesin, nama_pesawat, tipe_mesin, pabrikan, kecepatan_maks, 
              tahun_produksi, negara_asal);
    }

    @Override
    public String detail_mesin() {
        return "Mesin Pesawat Komersial: Umumnya menggunakan mesin Turbofan rasio by-pass tinggi, yang dirancang untuk efisiensi bahan bakar maksimal dan kebisingan rendah selama penerbangan jarak jauh.";
    }

    public String detail_pesawat() {
        return "Badan Pesawat Komersial: Berfokus pada kapasitas angkut penumpang, kenyamanan kabin, dan daya tahan struktural untuk siklus lepas landas/pendaratan yang berulang (fatigue life).";
    }
    
    @Override
    public List<String> TampilKategori() {
        List<String> categories = super.TampilKategori();
        categories.add("SIPIL");
        categories.add("KOMERSIAL");
        return categories;
    }
}
