<%-- 
    Document   : tipoUsuarioActualizar
    Created on : 20/10/2021, 08:18:50 AM
    Author     : Manuel
--%>

<%@page import="Clases.TipoUsuario"%>
<%@page import="Clases.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    HttpSession sesion= request.getSession();
    Usuario USUARIO=null;
    if(sesion.getAttribute("usuario")==null)response.sendRedirect("../index.jsp?Error=2");//acceso no valido
    else USUARIO=(Usuario) sesion.getAttribute("usuario");

    TipoUsuario tipoUsuario=new TipoUsuario();
    switch(request.getParameter("accion")){
        case "Adicionar":
            tipoUsuario.setNombreTU(request.getParameter("nombreTU"));
            tipoUsuario.setDescripcion(request.getParameter("descripcion"));
            tipoUsuario.guardar();
            break;
        case "Modificar":
            tipoUsuario.setId(request.getParameter("id"));
            tipoUsuario.setNombreTU(request.getParameter("nombreTU"));
            tipoUsuario.setDescripcion(request.getParameter("descripcion"));
            tipoUsuario.modificar();
            break;
        case "Eliminar":
            tipoUsuario.setId(request.getParameter("id"));
            tipoUsuario.eliminar();
            break;
    }
    //response.sendRedirect("principal.jsp?CONTENIDO=configuracion/tipoUsuario.jsp");
%>
<script type="text/javascript"> 
    location="principal.jsp?CONTENIDO=configuracion/tipoUsuario.jsp"
</script>
