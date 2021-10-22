<%-- 
    Document   : index
    Created on : 19/10/2021, 02:04:06 PM
    Author     : Manuel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="presentacion/css/login.css" />
        <title>Bienvenido</title>
    </head>
    <body>
        <div class="login-box">
            <img class="avatar" src="presentacion/css/logo5.png" alt="logo">
            <h1 id="loguin">Inicio de sesión</h1>
                <form method="post" name="formulario" action="control/validar.jsp">
                    <table>
                        <tr><th>Usuario</th><th><input type="text" name="usuario" required></th></tr>
                        <tr><th>clave</th><th><input type="password" name="clave" required></th></tr>
                        <tr><th><input type="submit" value="Ingresar"></th><th><input type="submit" value="Cancelar"></th></tr>
                    </table> 

                </form>
        </div>
    </body>
</html>
