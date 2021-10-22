<%-- 
    Document   : tipoUsuarioFormulario
    Created on : 20/10/2021, 08:21:09 AM
    Author     : Manuel
--%>

<%@page import="Clases.TipoUsuario"%>
<%@page import="Clases.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    //validar
    HttpSession sesion= request.getSession();
    Usuario USUARIO=null;
    if(sesion.getAttribute("usuario")==null)response.sendRedirect("../index.jsp?Error=2");//acceso no valido
    else USUARIO=(Usuario) sesion.getAttribute("usuario");
    
    String titulo="Adicionar";
    TipoUsuario tipoUsuario=null;
    if(request.getParameter("id")!=null){
        titulo="Modificar";
        tipoUsuario=new TipoUsuario(request.getParameter("id"));
    }else tipoUsuario=new TipoUsuario();
        
 %>
 
 <h3><%=titulo.toUpperCase()%> TIPO DE USUARIO</h3>
 <form id="for" name="formulario" method="post" action="principal.jsp?CONTENIDO=configuracion/tipoUsuarioActualizar.jsp">
     <table border="1">
         <tr><th>Nombre(*)</th><td><input type="text" name="nombreTU" value="<%=tipoUsuario.getNombreTU()%>" size="50" maxlength="80" required></td></tr>
         <tr><th>Descripcion(*)</th><td><input type="text" name="descripcion" value="<%=tipoUsuario.getDescripcion()%>" size="50" maxlength="80" required></td></tr>
         
     </table><p>
         
         <input type="hidden" name="id" value="<%=tipoUsuario.getId()%>">
         <input type="submit" name="accion" value="<%=titulo%>">
     
 </form>
