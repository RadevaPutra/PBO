/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Models;


public class Mesin {
    public int ID_Mesin;
    public String nama_mesin;
    public String jenis_mesin;
    public float tenaga_dorong;
    public String pabrikan;
    
    
    public Mesin(int ID_Mesin, String nama_mesin, String jenis_mesin, float tenaga_dorong, String pabrikan) {
        this.ID_Mesin = ID_Mesin;
        this.nama_mesin = nama_mesin;
        this.jenis_mesin = jenis_mesin;
        this.tenaga_dorong = tenaga_dorong;
        this.pabrikan = pabrikan;
    }

   
    public float get_tenaga_dorong() { 
        return tenaga_dorong;
    }

    public void detail_mesin() { 
        // detail_mesin(): void (Biasanya digunakan untuk mencetak/log, 
        // tetapi di MVC lebih baik mengembalikan String untuk View)
        System.out.println("Detail Mesin: " + nama_mesin + ", Jenis: " + jenis_mesin);
    }
    
    public String getDetail_mesin() { // Tambahan: Getter yang berguna untuk JSP
        return "Mesin " + nama_mesin + " (" + jenis_mesin + "), Pabrikan: " + pabrikan + ", Tenaga Dorong: " + tenaga_dorong + " kN.";
    }

    // Getter & Setter (Opsional, tapi praktik baik)
    public int getID_Mesin() { return ID_Mesin; }
    public String getNama_mesin() { return nama_mesin; }
    public String getJenis_mesin() { return jenis_mesin; }
    public String getPabrikan() { return pabrikan; }
}