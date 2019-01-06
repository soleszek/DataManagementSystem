<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Dashboard</title>
    <link rel="stylesheet" href="style/style.css" type="text/css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css"
          integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
</head>
<body>
<div id="container">

    <%
        String userName = (String) request.getSession().getAttribute("userName");
        String role = (String) request.getSession().getAttribute("role");

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
        <span style="color:#c34f4f">Data</span> Management System
    </div>

    <div class="menu">

        <div class="topmenu">
            <label>Name</label>
        </div>
        <div id="search">
            <ul class="sliding-icons">
                <li>
                    <a href="#">
                        <div class="icon">
                            <i class="fas fa-search fa-2x"></i>
                            <i class="fas fa-search fa-2x" title="Advanced search"></i>
                        </div>
                    </a>
                </li>
            </ul>
            <form action="" class="thing">
                <label for="ddd" class="thing-label">
                    Type to search...
                </label>
                <input type="text" name="ddd" id="ddd" class="thing-text">
                <input type="submit" value="search" class="thing-btn">
            </form>
            <div style="clear: both"></div>
        </div>

        <div class="topmenu">
            <div class="optionSO">
                <form action="LogoutServlet" method="get">
                    <input type="hidden" name="login" value="<%=login%>"/>
                    <input type="submit" name="menu" value="Sign out">
                </form>
            </div>
            <div class="option">
                <form id="usershow" action="UserShow" method="get">
                    <a href="#" onclick="document.getElementById('usershow').submit()">Witaj <%=userName%>
                    </a>
                </form>
            </div>
            <div class="optionSO">
                <a href="dashboard.jsp" id="home"><i class="fas fa-play fa-lg" title="Home"></i></a>
            </div>
            <div style="clear: both"></div>

        </div>
        <div style="clear:both;"></div>

    </div>
    <div style="clear:both"></div>

    <div id="sidebar">
        <div class="optionL"><a href="AllDocuments">Documents</a></div>

        <% if (!role.equals("viewer")) { %>

        <div class="optionL"><a href="ShowAllRoutes">Routes</a></div>
        <div class="optionL"><a href="AllUserTasks">Tasks</a></div>

        <% } %>

        <%
            if (role.equals("admin")) {
        %>
        <div class="optionL"><a href="adminpanel.jsp">Admin Panel</a></div>
        <%
            }
        %>
        <div style="clear: both"></div>
    </div>

    <div id="content">
        <div class="square">
            <div class="tile1"><H1><a href="#" class="tilelink">Your new tasks</a></H1></div>
            <div class="tile1"><H1><a href="AllUsers" class="tilelink">New routes</a></H1><</div>
            <div style="clear: both"></div>

            <div class="tile2"><H1><a href="registration.jsp" class="tilelink">New documents</a></H1></div>
            <div class="tile3"><H1><a href="registration.jsp" class="tilelink">Clock</a></H1></div>
            <div style="clear: both"></div>

            <div class="tile4">4</div>

        </div>
        <div class="square">
            <div class="tile5">Sentense</div>

            <div class="tile6">You spend ... in the systeme</div>
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
