/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Clases;

import ClasesGenericas.ConectorBD;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Manuel
 */
public class Especialidad {
    private String id;
    private String nombreE;
    private String descripcion;

    public Especialidad() {
    }

    public Especialidad(String id, String nombreE, String descripcion) {
        this.id = id;
        this.nombreE = nombreE;
        this.descripcion = descripcion;
    }

    public Especialidad(String id) {
        String cadenaSQL="select id, nombreE, descripcion from especialidad where id="+id;
        try {
            
            ResultSet resultado=ConectorBD.consultar(cadenaSQL);
            if(resultado.next()){
                this.id=id;
                this.nombreE=resultado.getString("nombreE");
                this.descripcion=resultado.getString("descripcion");
            }
        } catch (SQLException ex) {
           // Logger.getLogger(Especialidad.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("Error al consultar un tipo de especialidad .SQL: "+cadenaSQL+"\n"+ex.getMessage());
        }
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNombreE() {
        if(nombreE==null) return "";
        else return nombreE;
    }

    public void setNombreE(String nombreE) {
        this.nombreE = nombreE;
    }

    public String getDescripcion() {
        if(descripcion==null) return "";
        else return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    @Override
    public String toString() {
        return nombreE;
    }
    
    public void guardar(){
        String cadenaSQL="insert into especialidad (nombreE, descripcion) values('"+nombreE+"','"+descripcion+"')";
        ConectorBD.ejecutarQuery(cadenaSQL);
    }
    public void modificar(){
        String cadenaSQL="update especialidad set id='"+id+"', nombreE='"+nombreE+"', descripcion='"+descripcion+"' where id="+id;
        ConectorBD.ejecutarQuery(cadenaSQL);
    }
    public void eliminar(){
        String cadenaSQL="delete from especialidad where id="+id;
        ConectorBD.ejecutarQuery(cadenaSQL);
    }
    public static ResultSet getLista(String filtro){
        if(filtro==null)filtro="";
        else filtro="order"+filtro;
        String cadenaSQL=" select id, nombreE, descripcion from especialidad "+filtro+"  by id";
        return ConectorBD.consultar(cadenaSQL);
    }
    
    public static ArrayList<Especialidad> getListaEnObjetos(String filtro){
        ArrayList<Especialidad> lista= new ArrayList<Especialidad>();
        ResultSet resultado= Especialidad.getLista(filtro);
        try {
            while(resultado.next()){
                Especialidad especialidad=new Especialidad();
                especialidad.setId(resultado.getString("id"));
                especialidad.setNombreE(resultado.getString("nombreE"));
                especialidad.setDescripcion(resultado.getString("descripcion"));
                lista.add(especialidad);
            }
        } catch (SQLException ex) {
           // Logger.getLogger(Especialidad.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("No es posible obtener la lista gastos. Error: "+ex.getMessage());
        }
        return lista;
    }
    
    public static String getListaEnOptions(String predeterminado){
        String lista="";
        String filtro="";
        ArrayList<Especialidad> resultado=Especialidad.getListaEnObjetos(filtro);
        for (int i = 0; i < resultado.size(); i++) {
            Especialidad especialidad = resultado.get(i);
            String auxiliar="";
            if(especialidad.getId().equals(predeterminado))auxiliar="selected";
            lista+="<option value='"+especialidad.getId()+"'"+auxiliar+">"+especialidad.getNombreE()+"</option>";
                
        }
        return lista;
    }
    
}
