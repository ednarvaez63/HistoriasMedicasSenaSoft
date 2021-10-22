<%-- 
    Document   : especialidadFormulario
    Created on : 20/10/2021, 08:37:50 AM
    Author     : Manuel
--%>

<%@page import="Clases.Especialidad"%>
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
    Especialidad especialidad=null;
    if(request.getParameter("id")!=null){
        titulo="Modificar";
        especialidad=new Especialidad(request.getParameter("id"));
    }else especialidad=new Especialidad();
        
 %>
 
 <h3><%=titulo.toUpperCase()%> TIPO DE ESPECIALIDAD</h3>
 <form id="for" name="formulario" method="post" action="principal.jsp?CONTENIDO=configuracion/especialidadActualizar.jsp">
     <table border="1">
         <tr><th>Nombre(*)</th><td><input type="text" name="nombreE" value="<%=especialidad.getNombreE()%>" size="50" maxlength="80" required></td></tr>
         <tr><th>Descripcion(*)</th><td><input type="text" name="descripcion" value="<%=especialidad.getDescripcion()%>" size="50" maxlength="80" required></td></tr>
         
     </table><p>
         
         <input type="hidden" name="id" value="<%=especialidad.getId()%>">
         <input type="submit" name="accion" value="<%=titulo%>">
     
 </form>
