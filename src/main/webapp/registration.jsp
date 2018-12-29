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
    String userName = (String)request.getSession().getAttribute("userName");

    String login = (String) request.getSession().getAttribute("login");
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals(login)) {
                userName = cookie.getValue();
            }
        }
    }

    if (login == null) {
        response.sendRedirect("index.jsp");
    }
%>

<form action="RegisterUser" method="post">
    <div class="login-box">
        <h1>Fill in user data</h1>
        <div class="textbox">
            <input type="text" placeholder="Name" name="userName" value="" required>
        </div>

        <div class="textbox">
            <input type="text" placeholder="Last name" name="lastName" value="" required>
        </div>

        <div class="textbox">
            <input type="text" placeholder="Login" name="login" value="" required>
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
