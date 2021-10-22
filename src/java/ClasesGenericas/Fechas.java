/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ClasesGenericas;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

/**
 *
 * @author Manuel
 */
public class Fechas {
     public static SimpleDateFormat formatoFecha=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    
     public static int calcularDiferenciaFechas(String fecha1, String fecha2){
       
        int diferencia=0;
        if(!fecha2.equals("")){
            try {
            java.util.Date fechaInicial=formatoFecha.parse(fecha1);
            java.util.Date fechaFinal=formatoFecha.parse(fecha2);
            diferencia=(int)((fechaFinal.getTime()-fechaInicial.getTime())/1000);
            } catch (ParseException ex) {
            System.out.println("Error al convertir cadena fecha date. "+ex.getMessage());
            }
        }
        return diferencia;
    }
    public static String obtenerFechaActual(){
       java.util.Date fecha=new java.util.Date();
       return formatoFecha.format(fecha);//
    }
   
}
