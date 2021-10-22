<%-- 
    Document   : especialidad
    Created on : 20/10/2021, 08:23:29 AM
    Author     : Manuel
--%>

<%@page import="Clases.Especialidad"%>
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
    String filtro="identificacionAdministrador='"+USUARIO.getId()+"'";
    
    ArrayList<Especialidad> datos= Especialidad.getListaEnObjetos(lista);
    for(int i=0;i< datos.size();i++){
        Especialidad especialidad= datos.get(i);
        lista+="<tr>";
        lista+="<td>"+especialidad.getId()+"</td>";
        lista+="<td>"+especialidad.getNombreE()+"</td>";
        lista+="<td>"+especialidad.getDescripcion()+"</td>";
        lista+="<td>";
        lista+="<a href='principal.jsp?CONTENIDO=configuracion/especialidadFormulario.jsp&accion=Modificar&id="+especialidad.getId()+"' title='Modificar'><img src='imagenes/modificar.png'></a>";
        lista+="<label Onclick='eliminar("+especialidad.getId()+")'><img src='imagenes/eliminar.png'></label>";
        lista+="</td>";
        lista+="</tr>";
    }
    

%>

<h3> ESPECIALIDAD</h3>
<table border="1px">
    <tr><th>Id</th><th>Nombre</th><th>Descripcion</th><th><a href="principal.jsp?CONTENIDO=configuracion/especialidadFormulario.jsp"><img src="imagenes/guardar.png"></a></th></tr>
    <%=lista%>
</table>
<script type="text/javascript">
        function eliminar(id){
            var respuesta=confirm("¿Realmente desea eliminar este registro?");
            if(respuesta)location='principal.jsp?CONTENIDO=configuracion/especialidadActualizar.jsp&accion=Eliminar&id='+id;
            
            
        }
</script>
