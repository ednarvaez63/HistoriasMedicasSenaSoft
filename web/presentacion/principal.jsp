<%-- 
    Document   : principal
    Created on : 19/10/2021, 04:48:30 PM
    Author     : Manuel
--%>

<%@page import="Clases.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    HttpSession sesion= request.getSession();
    Usuario USUARIO=null;
    if(sesion.getAttribute("usuario")==null)response.sendRedirect("../index.jsp?Error=2");//acceso no valido
    else USUARIO=(Usuario) sesion.getAttribute("usuario");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/estilo.css" />
        <title>BIENVENIDO</title>
    </head>
     
    <body>
        
        <div id="banner"><h4 id="titulo">SOFTWARE DE HISTORIAS CLINICAS </h4><h5 id="usuario"> <%= USUARIO%></h5></div>
        <div id="menu"><%= USUARIO.getTipoUsuario().getMenu()%></div>
        <div id="contenido"><jsp:include page='<%= request.getParameter("CONTENIDO")%>' flush="true"/></div>
        
    </body>
</html>
