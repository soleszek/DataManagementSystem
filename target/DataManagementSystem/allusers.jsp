<%@ page import="com.sylwesteroleszek.entity.User" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <meta charset="utf-8">
    <title>Search results of all users</title>
    <link rel="stylesheet" href="style/style.css" type="text/css">

</head>
<body>

<div id="container">

    <%
        String userName = (String)request.getSession().getAttribute("userName");
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
            <form id="usershow" action="UserShow" method="get">
                <a href="#" onclick="document.getElementById('usershow').submit()">Witaj <%=userName%>
                </a>
            </form>
            <div class="optionSO">
                <a href="dashboard.jsp" id="home"><i class="fas fa-play fa-lg" title="Home"></i></a>
            </div>
        </div>
        <div style="clear: both"></div>
    </div>

    <div id="sidebar">
        <div class="optionL"><a href="AllDocuments">Documents</a></div>
        <div class="optionL"><a href="ShowAllRoutes">Routes</a></div>
        <div class="optionL"><a href="AllUserTasks">Tasks</a></div>
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

        <table>
            <col width="60">

            <%
                List<User> users = (List<User>) request.getAttribute("users");
            %>

            <tr>
                <th>User name</th>
                <th>Login</th>
                <th>Name</th>
                <th>Last name</th>
                <th>Role</th>
                <th>Password</th>
            </tr>
            <% for (User u : users) {
            %>
            <tr>
                <td><a href="AnyUserShow?userId=<%=u.getId()%>" id="doc-link"><%=u.getName()%></a></td>
                <td><span class="doc-link" onclick="openPopup('AnyUserShow?userId=<%=u.getId()%>')"><%=u.getLogin()%></span></td>
                <td><%=u.getUserName()%></td>
                <td><%=u.getLastName()%></td>
                <td><%=u.getRole()%></td>
                <td><%=u.getPassword()%></td>
            </tr>
            <%
                }
            %>

        </table>

    </div>

    <div id="footer">
        Sylwester Oleszek 2018 &copy;
    </div>

    <script src="jsscripts/popup.js"></script>

</div>

</body>
</html>
