<%@ page import="com.sylwesteroleszek.entity.Task" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Dashboard</title>
    <link rel="stylesheet" href="style/documents-view.css" type="text/css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css"
          integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
    <title>Tasks</title>
</head>
<body>

<div id="container">

    <%
        String name = (String)request.getSession().getAttribute("name");
        String role = (String) request.getSession().getAttribute("role");

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
            <form action="LogoutServlet" method="get">
                <input type="hidden" name="username" value="<%=user%>"/>
                <input type="submit" name="menu" value="Sign out">
            </form>
        </div>
        <div class="option">
            <form id = "usershow" action="UserShow" method="get">
                <a href="#" onclick="document.getElementById('usershow').submit()">Witaj <%=name%></a>
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

    <div id="navbar">
        <ul>
            <li>
                <a href="#">
                    <div class="icon">
                        <i class="fas fa-filter fa-2x"></i>
                        <i class="fas fa-filter fa-2x" title="Filter"></i>
                    </div>
                </a>
            </li>
    </div>

    <div id="content">

        <table class="task-table">
            <col width="60">

            <%
                List<Task> userTasks = (List<Task>) request.getAttribute("usertasks");
            %>

            <tr>
                <th>Task id</th>
                <th>Owner</th>
                <th>Submitted document</th>
                <th>State</th>
                <th>Due date</th>
                <th>Comments</th>
                <th>Completion date</th>
            </tr>
            <% for (Task t : userTasks) {
            %>
            <tr>
                <td><a href="OpenTask?taskId=<%=t.getId()%>" id="doc-link"><%=t.getId()%></a></td>
                <td><%=t.getOwner()%></td>
                <td><span class="doc-link" onclick="openPopup('OpenDocument?documentId=<%=t.getDocumentBeingApprovedId()%>')"><%=t.getDocumentBeingApprovedId()%></span></td>
                <td><%=t.getState()%></td>
                <td><%=t.getDueDate()%></td>
                <td><%=t.getComments()%></td>
                <td><%=t.getCompletionDate()%></td>
            </tr>
            <%
                }
            %>

        </table>

        <script src="jsscripts/popup.js"></script>

    </div>

    <div id="footer">
        Sylwester Oleszek 2018 &copy;
    </div>

</div>

</body>
</html>
