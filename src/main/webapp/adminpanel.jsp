<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Dashboard</title>
    <link rel="stylesheet" href="style/style.css" type="text/css">
    <title>Admin panel</title>
</head>
<body>

<div id="container">

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

    <div id="logo">
        Data Management System
    </div>

    <div id="search">

    </div>

    <div id="menu">
        <div class="optionSO">
            <form id="signout" action="LogoutServlet" method="get">
                <input type="hidden" name="username" value="<%=user%>"/>
                <input type="submit" name="menu" value="Sign out">
            </form>
        </div>
        <div class="option">
            <form id = "usershow" action="UserShow" method="get">
                <a href="#" onclick="document.getElementById('usershow').submit()">Witaj <%=name%></a>
            </form>
        </div>
        <div style="clear: both"></div>
    </div>

    <div id="sidebar">
        <div class="optionL"><a href="dashboard.jsp">Home</a></div>
        <div class="optionL"><a href="workspaces.jsp">Workspaces</a></div>
        <div class="optionL"><a href="tasks.jsp">Tasks</a></div>
        <div class="optionL"><a href="adminpanel.jsp">Admin Panel</a></div>
        <div style="clear: both"></div>
    </div>

    <div id="content">
        <div class="square">
            <div class="tile1"><H1><a href="registration.jsp" class="tilelink">Create new user</a> </H1></div>
            <div class="tile1"><H1><a href="registration.jsp" class="tilelink">Delete user</a> </H1><</div>
            <div style="clear: both"></div>

            <div class="tile2"><H1><a href="registration.jsp" class="tilelink">Create workspace</a> </H1></div>
            <div class="tile3">3</div>
            <div style="clear: both"></div>

            <div class="tile4">4</div>

        </div>
        <div class="square">
            <div class="tile5">5</div>

            <div class="tile6">6</div>
            <div class="tile7">7</div>
            <div class="tile8">8</div>
            <div class="tile9">9</div>
            <div style="clear: both"></div>
        </div>
        <div style="clear: both"></div>
    </div>

    <div id="footer">
        Sylwester Oleszek 2018 &copy;
    </div>

</div>

</body>
</html>
