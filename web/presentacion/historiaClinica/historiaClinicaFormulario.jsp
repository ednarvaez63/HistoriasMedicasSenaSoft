<%-- 
    Document   : HistoriaClinicaFormulario
    Created on : 20/10/2021, 11:33:47 PM
    Author     : Manuel
--%>

<%@page import="ClasesGenericas.Fechas"%>
<%@page import="Clases.HistoriaClinica"%>
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
    HistoriaClinica historiaClinica=null;
    if(request.getParameter("id")!=null){
        titulo="Modificar";
        historiaClinica=new HistoriaClinica(request.getParameter("id"));
    }else historiaClinica=new HistoriaClinica();
        
 %>
 
 <h3><%=titulo.toUpperCase()%> HISTORIAS CLÍNICAS</h3>
 <form id="for" name="formulario" method="post" action="principal.jsp?CONTENIDO=historiaClinica/historiaClinicaActualizar.jsp" enctype="multipart/form-data">
     <table border="1">
         <tr><th>Fecha(*)</th><td><input type="text" name="fechaToma" value="<%=Fechas.obtenerFechaActual()%>" size="50" maxlength="80" required></td></tr>
         <tr><th>Nombre Paciente(*)</th><td><input type="text" name="nombreCPaciente" value="<%=historiaClinica.getNombreCPaciente()%>" size="50" maxlength="80" required></td></tr>
         <tr><th>Historia(*)</th><td><input type="file" name="historia" value="<%=historiaClinica.getHistoria()%>" size="50" maxlength="80" required></td></tr>
         
     </table><p>
         
         <input type="hidden" name="id" value="<%=historiaClinica.getId()%>">
         <input type="submit" name="accion" value="<%=titulo%>">
     
 </form>
