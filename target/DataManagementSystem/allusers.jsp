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
        String name = (String) request.getSession().getAttribute("name");
        String role = (String) request.getSession().getAttribute("role");

        String user = (String) request.getSession().getAttribute("username");
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals(user)) {
                    user = cookie.getValue();
                }
            }
        }

        if (user == null) {
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
                <input type="hidden" name="username" value="<%=user%>"/>
                <input type="submit" name="menu" value="Sign out">
            </form>
        </div>
        <div class="option">
            <form id="usershow" action="UserShow" method="get">
                <a href="#" onclick="document.getElementById('usershow').submit()">Witaj <%=name%>
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
        <div class="optionL"><a href="tasks.jsp">Tasks</a></div>
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
            <col width="220">

            <%
                List<User> users = (List<User>) request.getAttribute("users");
            %>

            <tr>
                <th>User id</th>
                <th>Username</th>
                <th>Name</th>
                <th>Last name</th>
                <th>Role</th>
                <th>Password</th>
            </tr>
            <% for (User u : users) {
            %>
            <tr>
                <td><%=u.getId()%></td>
                <td><%=u.getUsername()%></td>
                <td><%=u.getName()%></td>
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

</div>

</body>
</html>
