<%-- 
    Document   : usuario
    Created on : 20/10/2021, 09:34:35 AM
    Author     : Manuel
--%>

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
    
    ArrayList<Usuario> datos= Usuario.getListaEnObjetos(lista);
    for(int i=0;i< datos.size();i++){
        Usuario tipoUsuario= datos.get(i);
        lista+="<tr>";
        lista+="<td>"+tipoUsuario.getId()+"</td>";
        lista+="<td>"+tipoUsuario.getDocumento()+"</td>";
        lista+="<td>"+tipoUsuario.getNombre()+"</td>";
        lista+="<td>"+tipoUsuario.getApellido()+"</td>";
        lista+="<td>"+tipoUsuario.getUsuario()+"</td>";
        lista+="<td>"+tipoUsuario.getFirma()+"</td>";
        lista+="<td>"+tipoUsuario.getTipoUsuario()+"</td>";
        lista+="<td>"+tipoUsuario.getCelular()+"</td>";
        lista+="<td>"+tipoUsuario.getDireccion()+"</td>";
        lista+="<td>"+tipoUsuario.getTipoEspecialidad()+"</td>";
        lista+="<td>";
        lista+="<a href='principal.jsp?CONTENIDO=usuario/usuarioFormulario.jsp&accion=Modificar&id="+tipoUsuario.getId()+"' title='Modificar'><img src='imagenes/modificar.png'></a>";
        lista+="<label Onclick='eliminar("+tipoUsuario.getId()+")'><img src='imagenes/eliminar.png'></label>";
        lista+="</td>";
        lista+="</tr>";
    }
    

%>

<h3> USUARIO</h3>
<table border="1px">
    <tr><th>Id</th><th>Documento</th><th>Nombre</th><th>Apellido</th><th>Usuario</th><th>Firma</th><th>Tipo Usuario</th><th>Celular</th><th>Dirección</th><th>Especilidad</th><th><a href="principal.jsp?CONTENIDO=usuario/usuarioFormulario.jsp"><img src="imagenes/guardaru.png"></a></th></tr>
    <%=lista%>
</table>
<script type="text/javascript">
        function eliminar(id){
            var respuesta=confirm("¿Realmente desea eliminar este registro?");
            if(respuesta)location='principal.jsp?CONTENIDO=usuario/usuarioActualizar.jsp&accion=Eliminar&id='+id;
            
            
        }
</script>