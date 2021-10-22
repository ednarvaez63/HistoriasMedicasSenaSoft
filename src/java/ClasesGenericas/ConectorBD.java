/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ClasesGenericas;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Manuel
 */
public class ConectorBD {
    private String servidor;
    private String puerto;
    private String usuario;
    private String clave;
    private String baseDatos;
    private Connection conexion;

    public ConectorBD() {
        Properties propiedades= new Properties();
        try {
            propiedades.load(this.getClass().getClassLoader().getResourceAsStream("configuracion.ini"));
            servidor=propiedades.getProperty("servidor");
            puerto=propiedades.getProperty("puerto");
            usuario=propiedades.getProperty("usuario");
            clave=propiedades.getProperty("clave");
            baseDatos=propiedades.getProperty("bd");
            System.out.println(baseDatos);
            
        } catch (IOException e) {
            System.out.println("No se encontro el archivo de configuracion del sistema /n"+e.getMessage());
        }
     
    }
    
    public boolean conectar(){
       boolean conectado=false;
        try {
            Class.forName("org.postgresql.Driver");//controlodar de conexxion a la BD
            conexion=(Connection)DriverManager.getConnection("jdbc:postgresql://"+servidor+":"+puerto+"/"+baseDatos,usuario,clave);
            conectado=true;
        } catch (ClassNotFoundException ex) {
            //Logger.getLogger(ConectorBD.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("No se puede conectar a la base de datos por el controlador/n"+ex.getMessage());
        } catch (SQLException ex) {
            //Logger.getLogger(ConectorBD.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("No se puede conectar a la base de datos /n"+ex.getMessage());
        }
        
       return conectado;
    }
   
    public void desconectar(){
        try {
            conexion.close();
        } catch (SQLException ex) {
            Logger.getLogger(ConectorBD.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static ResultSet consultar(String cadenaSQL){
        ConectorBD conector= new ConectorBD();
        if(!conector.conectar())System.out.println("Error al conectarse a la base de datos ");
        ResultSet resultado=null;
        try {
            
            PreparedStatement sentencia= conector.conexion.prepareStatement(cadenaSQL,ResultSet.TYPE_SCROLL_SENSITIVE,0);
            resultado=sentencia.executeQuery();
        } catch (SQLException ex) {
            //Logger.getLogger(ConectorBD.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("Error en la cadenaSQL:"+cadenaSQL+"\n"+ex.getMessage());
        }
        conector.desconectar();
        return resultado;
    }
    
    public static boolean ejecutarQuery(String cadenaSQL){
        ConectorBD conector=new ConectorBD();
        if(!conector.conectar())System.out.println("Error al conectarse  a la base de datos ");
        try {
            PreparedStatement sentencia=conector.conexion.prepareStatement(cadenaSQL);
            boolean resultado=sentencia.execute();
            return resultado;
        } catch (SQLException ex) {
           // Logger.getLogger(ConectorBD.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("Error al ejecutar la cadenaSQL: "+cadenaSQL+"\n"+ex.getMessage());
            return false;
        }
       
    }
    
}
