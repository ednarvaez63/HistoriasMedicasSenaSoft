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
public class TipoUsuario {
    private String id;
    private String nombreTU;
    private String descripcion;

    public TipoUsuario() {
    }

    public TipoUsuario(String id, String nombreTU, String descripcion) {
        this.id = id;
        this.nombreTU = nombreTU;
        this.descripcion = descripcion;
    }

    public TipoUsuario(String id) {
        String cadenaSQL="select id, nombreTU, descripcion from tipoUsuario where id="+id;
        try {
            
            ResultSet resultado=ConectorBD.consultar(cadenaSQL);
            if(resultado.next()){
                this.id=id;
                this.nombreTU=resultado.getString("nombreTU");
                this.descripcion=resultado.getString("descripcion");
            }
        } catch (SQLException ex) {
           // Logger.getLogger(TipoUsuario.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("Error al consultar un tipo de usuario .SQL: "+cadenaSQL+"\n"+ex.getMessage());
        }
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNombreTU() {
        if(nombreTU==null) return "";
        else return nombreTU;
    }

    public void setNombreTU(String nombreTU) {
        this.nombreTU = nombreTU;
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
        return nombreTU;
    }
    
    public void guardar(){
        String cadenaSQL="insert into tipoUsuario (nombreTU ,descripcion) values('"+nombreTU+"','"+descripcion+"')";
        ConectorBD.ejecutarQuery(cadenaSQL);
    }
    public void modificar(){
        String cadenaSQL="update tipoUsuario set id='"+id+"', nombreTU='"+nombreTU+"', descripcion='"+descripcion+"' where id="+id;
        ConectorBD.ejecutarQuery(cadenaSQL);
    }
    public void eliminar(){
        String cadenaSQL="delete from tipoUsuario where id="+id;
        ConectorBD.ejecutarQuery(cadenaSQL);
    }
    public static ResultSet getLista(String filtro){
        if(filtro==null)filtro="";
        else filtro="order"+filtro;
        String cadenaSQL=" select id, nombreTU, descripcion from tipoUsuario "+filtro+"  by id";
        return ConectorBD.consultar(cadenaSQL);
    }
    
    public static ArrayList<TipoUsuario> getListaEnObjetos(String filtro){
        ArrayList<TipoUsuario> lista= new ArrayList<TipoUsuario>();
        ResultSet resultado= TipoUsuario.getLista(filtro);
        try {
            while(resultado.next()){
                TipoUsuario tipoUsuario=new TipoUsuario();
                tipoUsuario.setId(resultado.getString("id"));
                tipoUsuario.setNombreTU(resultado.getString("nombreTU"));
                tipoUsuario.setDescripcion(resultado.getString("descripcion"));
                lista.add(tipoUsuario);
            }
        } catch (SQLException ex) {
           // Logger.getLogger(TipoUsuario.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("No es posible obtener la lista gastos. Error: "+ex.getMessage());
        }
        return lista;
    }
    
    public static String getListaEnOptions(String predeterminado){
        String lista="";
        String filtro="";
        ArrayList<TipoUsuario> resultado=TipoUsuario.getListaEnObjetos(filtro);
        for (int i = 0; i < resultado.size(); i++) {
            TipoUsuario tipoUsuario = resultado.get(i);
            String auxiliar="";
            if(tipoUsuario.getId().equals(predeterminado))auxiliar="selected";
            lista+="<option value='"+tipoUsuario.getId()+"'"+auxiliar+">"+tipoUsuario.getNombreTU()+"</option>";
                
        }
        return lista;
    }
    
    public String getMenu(){
        String menu="<ul>";
        menu+="<a href='principal.jsp?CONTENIDO=configuracion/tipoUsuario.jsp'><td>  TIPO DE USUARIO   ||</td></a>";
        menu+="<a href='principal.jsp?CONTENIDO=configuracion/especialidad.jsp'><td>  ESPECIALIDADES   ||</td></a>";
        menu+="<a href='principal.jsp?CONTENIDO=usuario/usuario.jsp'><td>  USUARIOS   ||</td></a>";
        menu+="<a href='principal.jsp?CONTENIDO=historiaClinica/historiaClinica.jsp'><td>  HISTORIAS   ||</td></a>";
        menu+="<a href='../index.jsp'>   Salir</a>";
        menu+="</ul>";
        return menu;
    }
    
   
}
