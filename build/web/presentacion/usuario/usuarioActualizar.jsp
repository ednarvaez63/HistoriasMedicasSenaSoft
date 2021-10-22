<%-- 
    Document   : usuarioActualizar
    Created on : 20/10/2021, 09:40:46 AM
    Author     : Manuel
--%>

<%@page import="Clases.Usuario"%>
<%@page import="org.apache.tomcat.util.http.fileupload.FileItem"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext"%>
<%@page import="org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory"%>
<%@page import="java.io.File"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
HttpSession sesion=request.getSession();
if (sesion.getAttribute("usuario")==null) response.sendRedirect("index.jsp?mensaje=Acceso no autorizado");
else {   
    String rutaActual=getServletContext().getRealPath("/");
    File destino=new File(rutaActual+"/documentos/firmas/");
    DiskFileItemFactory factory=new DiskFileItemFactory(1024*1024, destino);
    ServletFileUpload upload=new ServletFileUpload(factory);
    File archivo=null;
    
    ServletRequestContext origen=new ServletRequestContext(request);
    Map<String,String> variables=new HashMap<String, String>();
    List elementosFormulario=upload.parseRequest(origen);
    Iterator iterador=elementosFormulario.iterator();
    while (iterador.hasNext()) {            
        FileItem elemento=(FileItem) iterador.next();
        //out.println(elemento.getFieldName()+": "+elemento.getString());
        if (elemento.isFormField()) variables.put(elemento.getFieldName(), elemento.getString());
        else {
            variables.put(elemento.getFieldName(), elemento.getName());
            if (!elemento.getName().equals("")){
                //extraer la extensión del archivo propuesta.pdf
                int ubicacionPunto=elemento.getName().lastIndexOf(".");
                String extension=elemento.getName().substring(ubicacionPunto);//.pdf
                String nombreArchivo=variables.get("nombre")+"_"+variables.get("documento")+extension;//1_98000000.pdf
                if (elemento.getFieldName().equals("id")) destino=new File(rutaActual+"/documentos/historias/");
                elemento.write(new File(destino,nombreArchivo));//graba el archivo en la carpeta indicada
                variables.put(elemento.getFieldName(), nombreArchivo);
            }
        }
    }
            
    Usuario usuario=new Usuario();
    switch(variables.get("accion")){
        case "Adicionar":            
            usuario.setDocumento(variables.get("documento"));
            usuario.setNombre(variables.get("nombre"));
            usuario.setApellido(variables.get("apellido"));
            usuario.setUsuario(variables.get("usuario"));
            usuario.setClave(variables.get("clave"));
            usuario.setFirma(variables.get("firma"));
            usuario.setIdTipoUsuario(variables.get("idTipoUsuario"));
            usuario.setCelular(variables.get("celular"));
            usuario.setDireccion(variables.get("direccion"));
            usuario.setIdEspecialidad(variables.get("idEspecialidad"));
            usuario.guardar();
            break;
        case "Modificar":
            usuario.setId(variables.get("id"));
            usuario.setDocumento(variables.get("documento"));
            usuario.setNombre(variables.get("nombre"));
            usuario.setApellido(variables.get("apellido"));
            usuario.setUsuario(variables.get("usuario"));
            usuario.setClave(variables.get("clave"));
            usuario.setFirma(variables.get("firma"));
            usuario.setIdTipoUsuario(variables.get("idTipoUsuario"));
            usuario.setCelular(variables.get("celular"));
            usuario.setDireccion(variables.get("direccion"));
            usuario.setIdEspecialidad(variables.get("idEspecialidad"));
            usuario.modificar();
            break;
        case "Eliminar":
            usuario.setId(variables.get("id"));
            usuario.eliminar();
            break;
    }
    response.sendRedirect("principal.jsp?CONTENIDO=usuario/usuario.jsp&id="+variables.get("id"));
%>
<script type="text/javascript">
window.location="principal.jsp?CONTENIDO=usuario/usuario.jsp&id=<%=variables.get("id")%>";    
</script>
<%
}
%>    
