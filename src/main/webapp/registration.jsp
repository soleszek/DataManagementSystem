<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>User registration</title>
    <link rel="stylesheet" href="style/style.css" type="text/css">

</head>
<body>

<%
    String name = (String)request.getSession().getAttribute("name");

    String user = (String)request.getSession().getAttribute("username");
    Cookie[] cookies = request.getCookies();
    if(cookies != null) {
        for (Cookie cookie : cookies){
            if(cookie.getName().equals(user)){
                user = cookie.getValue();
            }
        }
    }

    if(user == null) {
        response.sendRedirect("index.jsp");
    }
%>

<form action="RegisterUser" method="post">
    <div class="login-box">
        <h1>Fill in user data</h1>
        <div class="textbox">
            <input type="text" placeholder="Name" name="name" value="" required>
        </div>

        <div class="textbox">
            <input type="text" placeholder="Last name" name="lastname" value="" required>
        </div>

        <div class="textbox">
            <input type="text" placeholder="Username" name="username" value="" required>
        </div>

        <div class="textbox">
            <input type="password" placeholder="Password" name="password" value="" required>
        </div>

        <div class="custom-select" style="width:280px;">
            <select name="role">
                <option value="viewer">Viewer</option>
                <option value="viewer">Viewer</option>
                <option value="contributor">Contributor</option>
                <option value="manager">Manager</option>
                <option value="admin">Admin</option>
            </select>
        </div>

        <input class="btn" type="submit" name="" value="Create">

    </div>
</form>

<script src="jsscripts/dropdownmenu.js"></script>

</body>
</html>
