<%-- 
    Document   : historiaClinica
    Created on : 20/10/2021, 11:26:41 PM
    Author     : Manuel
--%>

<%@page import="Clases.HistoriaClinica"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Clases.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    //validar
    HttpSession sesion= request.getSession();
    Usuario USUARIO=null;
    if(sesion.getAttribute("usuario")==null)response.sendRedirect("../index.jsp?Error=2");//acceso no valido
    else USUARIO=(Usuario) sesion.getAttribute("usuario");
    
    String lista="";
    //String filtro="identificacionAdministrador='"+USUARIO.getId()+"'";
    String filtro="";
    String nombre="";//definir la variable para recuperar el dato 
    String cnombre="";//para verififcar si marco el cecbox 
    if(request.getParameter("cnombre")!=null){
        nombre=request.getParameter("nombre");
        cnombre+="checked";
        filtro="nombreCpaciente='"+ nombre +"'";//abstraccion de los datoa 
    }
    
     String fechaInicial="";
     String  fechaFinal="";
    String cfecha="";
    if(request.getParameter("cfecha")!=null && !request.getParameter("fechaInicial").trim().equals("") && !request.getParameter("fechaFinal").trim().equals("")){
        fechaInicial=request.getParameter("fechaInicial");
        fechaFinal=request.getParameter("fechaFinal");
        cfecha="checked";
        if(!filtro.equals(""))filtro+=" and ";
        filtro+="fechatoma between '" +fechaInicial+ "' and '" +fechaFinal+ "'";
    }
    
    if(!filtro.equals(""))filtro+="";
        
    ArrayList<HistoriaClinica> datos= HistoriaClinica.getListaEnObjetos(filtro);
    for(int i=0;i< datos.size();i++){
        HistoriaClinica historiaClinica= datos.get(i);
        lista+="<tr>";
        lista+="<td>"+historiaClinica.getId()+"</td>";
        lista+="<td>"+historiaClinica.getFechaToma()+"</td>";
        lista+="<td>"+historiaClinica.getNombreCPaciente()+"</td>";
        lista+="<td>"+historiaClinica.getHistoria()+"</td>";
        lista+="<td>";
        lista+="<a href='principal.jsp?CONTENIDO=historiaClinica/historiaClinicaFormulario.jsp&accion=Modificar&id="+historiaClinica.getId()+"' title='Modificar'><img src='imagenes/modificar.png'></a>";
        lista+="<label Onclick='eliminar("+historiaClinica.getId()+")'><img src='imagenes/eliminar.png'></label>";
        lista+="</td>";
        lista+="</tr>";
    }
    

%>

<h3> HISTORIAS CLÍNICAS</h3>

<form id="forh" name="formulario" method="post" id="buscador">
    <table border="1px">
        <tr><th><input type="checkbox" name="cnombre" value="<%=cnombre%>"/>Nombre paciente</th><td><input type="text" name="nombre" value="<%=nombre%>"  size="50" maxlength="80"></td></tr>
        <tr><th><input type="checkbox" name="cfecha" value="<%=cfecha%>">Fecha</th><td>Desde<input type="dateTime" name="fechaInicial" value="<%=fechaInicial%>">Hasta<input type="dateTime" name="fechaFinal" value="<%=fechaFinal%>"></td></tr>    
    </table>
    <input type="submit" value="Buscar"/>
</form>

<table border="1px" id="lista">
    <tr><th>Id</th><th>Fecha</th><th>Nombre</th><th>Historia</th><th><a href="principal.jsp?CONTENIDO=historiaClinica/historiaClinicaFormulario.jsp"><img src="imagenes/guardarh.png"></a></th></tr>
    <%=lista%>
</table>
<script type="text/javascript">
        function eliminar(id){
            var respuesta=confirm("¿Realmente desea eliminar este registro?");
            if(respuesta)location='principal.jsp?CONTENIDO=historiaClinica/historiaClinicaActualizar.jsp&accion=Eliminar&id='+id;
            
            
        }
</script>
