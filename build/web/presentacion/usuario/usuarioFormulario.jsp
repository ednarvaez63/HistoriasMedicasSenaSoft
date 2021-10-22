<%-- 
    Document   : usuarioFormulario
    Created on : 20/10/2021, 10:32:20 AM
    Author     : Manuel
--%>

<%@page import="Clases.TipoUsuario"%>
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
    Usuario usuario=null;
    if(request.getParameter("id")!=null){
        titulo="Modificar";
        usuario=new Usuario(request.getParameter("id"));
    }else usuario=new Usuario();
        
 %>
 
 <h3><%=titulo.toUpperCase()%> USUARIO</h3>
 <form id="for1" name="formulario" method="post" action="principal.jsp?CONTENIDO=usuario/usuarioActualizar.jsp" enctype="multipart/form-data">
     <table id="tablau" border>
         <tr><th>Documento(*)</th><td><input type="text" name="documento" value="<%=usuario.getDocumento()%>" size="50" maxlength="80" required></td></tr>
         <tr><th>Nombre(*)</th><td><input type="text" name="nombre" value="<%=usuario.getNombre()%>" size="50" maxlength="80" required></td></tr>
         <tr><th>Apellido(*)</th><td><input type="text" name="apellido" value="<%=usuario.getApellido()%>" size="50" maxlength="80" required></td></tr>
         <tr><th>Usuario(*)</th><td><input type="text" name="usuario" value="<%=usuario.getUsuario()%>" size="50" maxlength="80" required></td></tr>
         <tr><th>Clave(*)</th><td><input type="password" name="clave" value="<%=usuario.getClave()%>" size="50" maxlength="80" required></td></tr>
         <tr><th>Firma(*)</th><td><input type="file" name="firma" value="<%=usuario.getFirma()%>" size="50" maxlength="80" required></td></tr>
         <tr><th>Tipo Usuario(*)</th><td><select name="idTipoUsuario"><%=TipoUsuario.getListaEnOptions("")%></select></td></tr>
         <tr><th>Celular(*)</th><td><input type="text" name="celular" value="<%=usuario.getCelular()%>" size="50" maxlength="80" required></td></tr>
         <tr><th>Dirección(*)</th><td><input type="text" name="direccion" value="<%=usuario.getDireccion()%>" size="50" maxlength="80" required></td></tr>
         <tr><th>Especialidad(*)</th><td><select name="idEspecialidad"><%=Especialidad.getListaEnOptions("")%></select></td></tr>
         <input type="hidden" name="id" value="<%=usuario.getId()%>">
         <tr><td><input type="submit" name="accion" value="<%=titulo%>"><td></tr>
     </table><p>
         
         
     
 </form>