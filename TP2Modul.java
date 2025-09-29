/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 */

package com.mycompany.tp2modul;

import java.util.Scanner;
/**
 *
 * @author radev
 */
public class TP2Modul {

    public static void main(String[] args) {
        Scanner input = new Scanner(System.in);
        
        System.out.print("masukan n:");
        int n = input.nextInt();
        
        int a = 1, b = 1;
        if(n >= 1) System.out.print(a + " ");
        if(n >= 2) System.out.print(b + " ");
        
        for (int i = 3; i <= n; i++){
            int c = a + b;
            System.out.print(c+" ");
            a = b;
            b = c; 
        }
        System.out.println();
    }
}
