/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Clases;

import ClasesGenericas.ConectorBD;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Font.FontFamily;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;
import java.awt.image.BufferedImage;
import java.awt.image.DataBuffer;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import javax.imageio.ImageIO;

/**
 *
 * @author Manuel
 */
public class HistoriaClinica {
    private String id;
    private String fechaToma;
    private String nombreCPaciente;
    private String historia;

    public HistoriaClinica() {
    }

    public HistoriaClinica(String id, String fechaToma, String nombreCPaciente, String historia) {
        this.id = id;
        this.fechaToma = fechaToma;
        this.nombreCPaciente = nombreCPaciente;
        this.historia = historia;
    }

    public HistoriaClinica(String id) {
        String cadenaSQL="select id, fechaToma, nombreCPaciente, historia from historiaClinica where id="+id;
        try {
            
            ResultSet resultado=ConectorBD.consultar(cadenaSQL);
            if(resultado.next()){
                this.id=id;
                this.fechaToma=resultado.getString("fechaToma");
                this.nombreCPaciente=resultado.getString("nombreCPaciente");
                this.historia=resultado.getString("historia");
            }
        } catch (SQLException ex) {
           // Logger.getLogger(HistoriaClinica.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("Error al consultar un tipo de historia Clinica .SQL: "+cadenaSQL+"\n"+ex.getMessage());
        }
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getFechaToma() {
        return fechaToma;
    }

    public void setFechaToma(String fechaToma) {
        this.fechaToma = fechaToma;
    }

    public String getNombreCPaciente() {
        if(nombreCPaciente==null) return "";
        else return nombreCPaciente;
    }

    public void setNombreCPaciente(String nombreCPaciente) {
        this.nombreCPaciente = nombreCPaciente;
    }

    public String getHistoria() {
        return historia;
    }

    public void setHistoria(String historia) {
        this.historia = historia;
    }

    @Override
    public String toString() {
        return nombreCPaciente;
    }
    
    public void guardar(){
        String cadenaSQL="insert into historiaClinica (fechaToma, nombreCPaciente, historia) values('"+fechaToma+"','"+nombreCPaciente+"','"+historia+"')";
        ConectorBD.ejecutarQuery(cadenaSQL);
    }
    public void modificar(){
        String cadenaSQL="update historiaClinica set id='"+id+"', fechaToma='"+fechaToma+"', nombreCPaciente='"+nombreCPaciente+"', historia='"+historia+"' where id="+id;
        ConectorBD.ejecutarQuery(cadenaSQL);
    }
    public void eliminar(){
        String cadenaSQL="delete from historiaClinica where id="+id;
        ConectorBD.ejecutarQuery(cadenaSQL);
    }
    public static ResultSet getLista(String filtro){
        if(filtro=="")filtro="";
        else filtro="where "+filtro;
        String cadenaSQL=" select id, fechaToma, nombreCPaciente, historia from historiaClinica "+filtro+" order by id";
        return ConectorBD.consultar(cadenaSQL);
    }
    
    public static ArrayList<HistoriaClinica> getListaEnObjetos(String filtro){
        ArrayList<HistoriaClinica> lista= new ArrayList<HistoriaClinica>();
        ResultSet resultado= HistoriaClinica.getLista(filtro);
        try {
            while(resultado.next()){
                HistoriaClinica historiaClinica=new HistoriaClinica();
                historiaClinica.setId(resultado.getString("id"));
                historiaClinica.setFechaToma(resultado.getString("fechaToma"));
                historiaClinica.setNombreCPaciente(resultado.getString("nombreCPaciente"));
                historiaClinica.setHistoria(resultado.getString("historia"));
                lista.add(historiaClinica);
            }
        } catch (SQLException ex) {
           // Logger.getLogger(HistoriaClinica.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("No es posible obtener la lista historias clinicas. Error: "+ex.getMessage());
        }
        return lista;
    }
    
    
    //comparacion de tamaño imagenes
    public float compareImage(File imagen1, File imagen2) {

    float porcentage = 0;
        try {
            // carga imagenes
            BufferedImage biA = ImageIO.read(imagen1);
            DataBuffer dbA = biA.getData().getDataBuffer();
            int tamaño1 = dbA.getSize();
            BufferedImage biB = ImageIO.read(imagen2);
            DataBuffer dbB = biB.getData().getDataBuffer();
            int tamaño2 = dbB.getSize();
            int count = 0;
            // compara las imagenes
            if (tamaño1 == tamaño2) {

                for (int i = 0; i < tamaño1; i++) {

                    if (dbA.getElem(i) == dbB.getElem(i)) {
                        count = count + 1;
                    }

                }
                porcentage = (count * 100) / tamaño1;
            } else {
                System.out.println("Las imagenes no tienen el mismo tamaño");
            }

        } catch (Exception e) {
            System.out.println("No se pudo comparar las imagenes ...");
        }
        return porcentage;
    }
    // Inicio del metodo para pdf 
       public class App 
{
 
    public void main(String[] args)
    {
        writePDF();
    }
    
    private  void writePDF() {
 
        Document document = new Document();
 
        try {
                String path = new File(".").getCanonicalPath();
                String FILE_NAME = path + "/itext-test-file.pdf";
            PdfWriter.getInstance(document, new FileOutputStream(new File(FILE_NAME)));
 
            document.open();
 
            Paragraph paragraphHello = new Paragraph();
            paragraphHello.add("Hello iText paragraph!");
            paragraphHello.setAlignment(Element.ALIGN_JUSTIFIED);
 
            document.add(paragraphHello);
 
            Paragraph paragraphLorem = new Paragraph();
            paragraphLorem.add("Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                + "Maecenas finibus fringilla turpis, vitae fringilla justo."
                + "Sed imperdiet purus quis tellus molestie, et finibus risus placerat."
                + "Donec convallis eget felis vitae interdum. Praesent varius risus et dictum hendrerit."
                + "Aenean eu semper nunc. Aenean posuere viverra orci in hendrerit. Aenean dui purus, eleifend nec tellus vitae,"
                + " pretium dignissim ex. Aliquam erat volutpat. ");
            
            java.util.List<Element> paragraphList = new ArrayList<>();
            
            paragraphList = paragraphLorem.breakUp();
 
            Font f = new Font();
            f.setFamily(FontFamily.COURIER.name());
            f.setStyle(Font.BOLDITALIC);
            f.setSize(8);
            
            Paragraph p3 = new Paragraph();
            p3.setFont(f);
            p3.addAll(paragraphList);
            p3.add("TEST LOREM IPSUM DOLOR SIT AMET CONSECTETUR ADIPISCING ELIT!");
 
            document.add(paragraphLorem);
            document.add(p3);
            document.close();
 
        } catch (FileNotFoundException | DocumentException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
 
    }
}
    // fin del metodo para pdf 
    
}
