<%@ page import="com.sylwesteroleszek.entity.User" %>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Information about user</title>
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
            <form id = "usershow" action="UserShow" method="get">
                <a href="#" onclick="document.getElementById('usershow').submit()">Witaj <%=userName%></a>
            </form>
        </div>
        <div class="optionSO">
            <a href="dashboard.jsp" id="home"><i class="fas fa-play fa-lg" title="Home"></i></a>
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

        <form id="edit-form" action="UpdateUser" method="post">

        <table class="user-table">
            <col width="220">

            <%
                User userObject = (User)request.getSession().getAttribute("user");
            %>

            <tr>
                <td>Name</td>
                <td><%=userObject.getName()%></td>
            </tr>
            <tr>
                <td>First Name</td>
                <td><input type="text" class="edit-text" name="name" value="<%=userObject.getUserName()%>" readonly required></td>
            </tr>
            <tr>
                <td>Last Name</td>
                <td><input type="text" class="edit-text" name="lastname" value="<%=userObject.getLastName()%>" readonly required></td>
            </tr>
            <tr>
                <td>Role</td>
                <td><input type="text" class="edit-text" name="role" value="<%=userObject.getRole()%>" readonly required></td>
            </tr>
            <tr>
                <td>User Name</td>
                <td><input type="text" class="edit-text" name="login" value="<%=userObject.getLogin()%>" readonly required></td>
            </tr>
            <tr>
                <td>User Password</td>
                <td><input type="text" class="edit-text" name="password" value="<%=userObject.getPassword()%>" readonly required></td>
            </tr>

        </table>

            <br><br>

            <button type="button" id="editButton" class="button-edit" style="visibility:visible" onclick="edit()">Edit</button>
            <button type="button" id="saveButton" class="button-edit" style="visibility:hidden" onclick="save()">Save</button>
            <button type="button" id="cancelButton" class="button-edit" style="visibility:hidden" onclick="cancel()">Cancel</button>

            <script src="jsscripts/editform.js"></script>

        </form>

    </div>

    <div id="footer">
        Sylwester Oleszek 2018 &copy;
    </div>

</div>

</body>
</html>
