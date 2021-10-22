<%-- 
    Document   : tipoUsuario
    Created on : 19/10/2021, 04:47:12 PM
    Author     : Manuel
--%>

<%@page import="Clases.TipoUsuario"%>
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
    
    ArrayList<TipoUsuario> datos= TipoUsuario.getListaEnObjetos(lista);
    for(int i=0;i< datos.size();i++){
        TipoUsuario tipoUsuario= datos.get(i);
        lista+="<tr>";
        lista+="<td>"+tipoUsuario.getId()+"</td>";
        lista+="<td>"+tipoUsuario.getNombreTU()+"</td>";
        lista+="<td>"+tipoUsuario.getDescripcion()+"</td>";
        lista+="<td>";
        lista+="<a href='principal.jsp?CONTENIDO=configuracion/tipoUsuarioFormulario.jsp&accion=Modificar&id="+tipoUsuario.getId()+"' title='Modificar'><img src='imagenes/modificar.png'></a>";
        lista+="<label Onclick='eliminar("+tipoUsuario.getId()+")'><img src='imagenes/eliminar.png'></label>";
        lista+="</td>";
        lista+="</tr>";
    }
    

%>

<h3> TIPO DE USUARIO</h3>
<table border="1px">
    <tr><th>Id</th><th>Nombre</th><th>Descripcion</th><th><a href="principal.jsp?CONTENIDO=configuracion/tipoUsuarioFormulario.jsp"><img src="imagenes/guardaru.png"></a></th></tr>
    <%=lista%>
</table>
<script type="text/javascript">
        function eliminar(id){
            var respuesta=confirm("¿Realmente desea eliminar este registro?");
            if(respuesta)location='principal.jsp?CONTENIDO=configuracion/tipoUsuarioActualizar.jsp&accion=Eliminar&id='+id;
            
            
        }
</script>
