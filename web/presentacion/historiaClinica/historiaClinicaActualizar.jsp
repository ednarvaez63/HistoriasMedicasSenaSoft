<%-- 
    Document   : historiaClinicaActualizar
    Created on : 20/10/2021, 11:45:19 PM
    Author     : Manuel
--%>

<%@page import="Clases.HistoriaClinica"%>
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
    File destino=new File(rutaActual+"/documentos/historias/");
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
                String nombreArchivo=variables.get("nombreCPaciente")+"_"+variables.get("id")+extension;//1_98000000.pdf
                if (elemento.getFieldName().equals("id")) destino=new File(rutaActual+"/documentos/fotos/");
                elemento.write(new File(destino,nombreArchivo));//graba el archivo en la carpeta indicada
                variables.put(elemento.getFieldName(), nombreArchivo);
            }
        }
    }
            
    HistoriaClinica historiaClinica=new HistoriaClinica();
    switch(variables.get("accion")){
        case "Adicionar":            
            historiaClinica.setFechaToma(variables.get("fechaToma"));
            historiaClinica.setNombreCPaciente(variables.get("nombreCPaciente"));
            historiaClinica.setHistoria(variables.get("historia"));
            historiaClinica.guardar();
            break;
        case "Modificar":
            historiaClinica.setId(variables.get("id"));
            historiaClinica.setFechaToma(variables.get("fechaToma"));
            historiaClinica.setNombreCPaciente(variables.get("nombreCPaciente"));
            historiaClinica.setHistoria(variables.get("historia"));
            historiaClinica.modificar();
            break;
        case "Eliminar":
            historiaClinica.setId(variables.get("id"));
            historiaClinica.eliminar();
            break;
    }
    response.sendRedirect("principal.jsp?CONTENIDO=historiaClinica/historiaClinica.jsp&id="+variables.get("id"));
%>
<script type="text/javascript">
window.location="principal.jsp?CONTENIDO=historiaClinica/historiaClinica.jsp&id=<%=variables.get("id")%>";    
</script>
<%
}
%> 
