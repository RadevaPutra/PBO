/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Model;

import java.time.LocalDateTime;


public class Komentar {
    public int ID_Komentar;
    public int ID_user;
    public int ID_pesawat;
    public String isi_komentar;
    public LocalDateTime tanggal_post; // Menggunakan LocalDateTime untuk tanggal

    public Komentar(int ID_Komentar, int ID_user, int ID_pesawat, String isi_komentar) {
        this.ID_Komentar = ID_Komentar;
        this.ID_user = ID_user;
        this.ID_pesawat = ID_pesawat;
        this.isi_komentar = isi_komentar;
        this.tanggal_post = LocalDateTime.now();
    }
    
    
    public void TampilKonten() {
        System.out.println("Komentar dari User " + ID_user + " pada " + tanggal_post.toString());
    }

    
    public String getIsiKomentar() { return isi_komentar; }
    public String getTanggalPost() { return tanggal_post.toString(); }
}
