<%-- 
    Document   : especialidadActualizar
    Created on : 20/10/2021, 08:28:20 AM
    Author     : Manuel
--%>

<%@page import="Clases.Especialidad"%>
<%@page import="Clases.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    HttpSession sesion= request.getSession();
    Usuario USUARIO=null;
    if(sesion.getAttribute("usuario")==null)response.sendRedirect("../index.jsp?Error=2");//acceso no valido
    else USUARIO=(Usuario) sesion.getAttribute("usuario");

    Especialidad especialidad=new Especialidad();
    //TipoEspecialidad tipoEspecialidad=new TipoEspecialidad(null);
    switch(request.getParameter("accion")){
        case "Adicionar":
            especialidad.setNombreE(request.getParameter("nombreE"));
            especialidad.setDescripcion(request.getParameter("descripcion"));
            especialidad.guardar();
            break;
        case "Modificar":
            especialidad.setId(request.getParameter("id"));
            especialidad.setNombreE(request.getParameter("nombreE"));
            especialidad.setDescripcion(request.getParameter("descripcion"));
            especialidad.modificar();
            break;
        case "Eliminar":
            especialidad.setId(request.getParameter("id"));
            especialidad.eliminar();
            break;
    }
    //response.sendRedirect("principal.jsp?CONTENIDO=configuracion/especialidads.jsp");
%>
<script type="text/javascript"> 
    location="principal.jsp?CONTENIDO=configuracion/especialidad.jsp"
</script>
