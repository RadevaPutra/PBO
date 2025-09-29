/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.tp2modul;

import java.util.Scanner;

/**
 *
 * @author radev
 */
/*


*/

public class Matrix2 {
    public static void main(String[] args) {
  
    Scanner input = new Scanner (System.in);
    
    System.out.print("masukan ukuran matriks");
    int n = input.nextInt();
    
    int[][] matriks1 = new int[n][n];
    int[][] matriks2 = new int[n][n];
    int[][] hasil = new int[n][n];
    
    System.out.println("masukan elemen dalam matriks 1:");
    for (int i = 0;i < n;i++){
        for (int j = 0;j < n;j++){
            matriks1[i][j] = input.nextInt();
        }
    }
    
    System.out.println("masukan elemen dalam matriks 2:");
    for (int i = 0;i < n;i++){
        for(int j = 0;j < n;j++){
            matriks2[i][j] = input.nextInt();
        }
    }
    
    for (int i = 0;i < n;i++){
        for (int j = 0;j < n;j++){
            for (int k = 0;k < n;k++){
                hasil[i][j] += matriks1[i][k] * matriks2[k][j];
          
            }
        }
    }
    
    System.out.println("Hasil perkalian: ");
    for(int i = 0;i < n;i++){
        for(int j = 0;j < n;j++){
            System.out.print(hasil[i][j] + "  ");
            
        }
        
        System.out.println();
    }
}
}