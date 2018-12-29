<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Dashboard</title>
    <link rel="stylesheet" href="style/style.css" type="text/css">
    <title>2D drawing</title>
</head>
<body>

<div id="container">

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

    <div id="logo">
        Data Management System
    </div>

    <div id="search">

    </div>

    <div id="menu">
        <div class="optionSO">
            <form action="LogoutServlet" method="get">
                <input type="hidden" name="login" value="<%=login%>"/>
                <input type="submit" name="menu" value="Sign out">
            </form>
        </div>
        <div class="option">
            <form id = "usershow" action="UserShow" method="get">
                <a href="#" onclick="document.getElementById('usershow').submit()">Witaj <%=userName%></a>
            </form>
        </div>
        <div style="clear: both"></div>
    </div>

    <div id="sidebar">
        <div class="optionL"><a href="dashboard.jsp">Home</a></div>
        <div class="optionL"><a href="dashboard.jsp">Drw</a></div>
        <div class="optionL"><a href="documents.jsp">Files</a></div>
        <div class="optionL"><a href="tasks.jsp">Revisions</a></div>
        <div class="optionL"><a href="adminpanel.jsp">Routes</a></div>
        <div class="optionL"><a href="adminpanel.jsp">Lifecycle</a></div>
        <div class="optionL"><a href="adminpanel.jsp">Viewer</a></div>
        <div style="clear: both"></div>
    </div>

    <div id="content">

    </div>

    <div id="footer">
        Sylwester Oleszek 2018 &copy;
    </div>

</div>

</body>
</html>
