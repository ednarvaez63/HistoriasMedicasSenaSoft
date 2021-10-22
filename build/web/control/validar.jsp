<%-- 
    Document   : validar
    Created on : 19/10/2021, 02:08:22 PM
    Author     : Manuel
--%>

<%@page import="Clases.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
        String usuario=request.getParameter("usuario");
        String clave=request.getParameter("clave");
        Usuario usuario1= Usuario.validar(usuario,clave);
        if (usuario1==null) response.sendRedirect("../index.jsp?error=1");
        else {
            HttpSession sesion=request.getSession();
            sesion.setAttribute("usuario", usuario1);
            response.sendRedirect("../presentacion/principal.jsp?CONTENIDO=inicio.jsp");
        }
        
%>