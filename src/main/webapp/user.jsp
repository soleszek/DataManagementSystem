<%@ page import="com.sylwesteroleszek.entity.User" %>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Information about user</title>
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
        <div class="option">
            <form action="LogoutServlet" method="get">
                <input type="hidden" name="username" value="<%=user%>"/>
                <input type="submit" name="menu" value="Sign out">
            </form>
        </div>
        <div class="option">Witaj <%=name%></div>
        <%--<div class="option">Tasks</div>
        <div class="option">Admin Panel</div>--%>
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

        <table class="user-table" cellpadding="2" cellspacing="2" border="1" align="center" width="100%">

            <%
                User userObject = (User)request.getSession().getAttribute("user");
            %>

            <tr>
                <td>User id</td>
                <td><%=userObject.getId()%></td>
            </tr>
            <tr>
                <td>First Name</td>
                <td><%=userObject.getName()%></td>
            </tr>
            <tr>
                <td>Last Nme</td>
                <td><%=userObject.getLastName()%></td>
            </tr>
            <tr>
                <td>Role</td>
                <td><%=userObject.getRole()%></td>
            </tr>
            <tr>
                <td>User Name</td>
                <td><%=userObject.getUsername()%></td>
            </tr>
            <tr>
                <td>User Password</td>
                <td><%=userObject.getPassword()%></td>
            </tr>

        </table>

    </div>

    <div id="footer">
        Sylwester Oleszek 2018 &copy;
    </div>

</div>

</body>
</html>
