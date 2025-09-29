/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 */

package com.mycompany.tptiga;

/**
 *
 * @author radev
 */

class Prodi {
    private String nama;
    
    public void setNama(String nama){
        this.nama = nama;
    }
    
    String getNama(){
        return this.nama;
    }
    
}

class mahasiswa{
    private String nama;
    private String prodi;
    
    public void setNama(String nama){
        this.nama = nama;
    }
    public void setProdi(String prodi){
        this.prodi = prodi;
    }
    public String setNama(){
        return this.nama;
    }
    public String getProdi(){
        return this.prodi;
    }
    public void displayMahasiswa(){
        System.out.println("Nama mahasiswa:"  + this.nama);
        System.out.println("Nama Prodi:" + this.prodi);
        System.out.println("-----------------------");
    }
}
public class TpTiga {

    public static void main(String[] args) {
        Prodi pr1 = new Prodi();
        Prodi pr2 = new Prodi();
        
        pr1.setNama("informatika");
        pr2.setNama(" Data Science");
        
        mahasiswa mh1 = new mahasiswa();
        mahasiswa mh2 = new mahasiswa();
        
        mh1.setNama("Bruce Wayne");
        mh1.setProdi("informatika");
        
        mh2.setNama("Tony Stark");
        mh2.setProdi("data Science");
        
        mh1.displayMahasiswa();
        mh2.displayMahasiswa();
    }
}
