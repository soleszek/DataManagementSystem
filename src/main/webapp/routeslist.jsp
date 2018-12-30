<%@ page import="com.sylwesteroleszek.entity.Document" %>
<%@ page import="java.util.List" %>
<%@ page import="com.sylwesteroleszek.entity.Route" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="style/documents-view.css" type="text/css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css"
          integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
    <title>All routes</title>

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

    <%
        Document document = (Document) request.getAttribute("document");
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
        </ul>

    </div>

    <div id="content">

        <table>
            <col width="60">

            <%
                List<Route> routes = (List<Route>) request.getAttribute("routes");
            %>

            <tr>
                <th><input type="checkbox"></th>
                <th>Promotion request name</th>
                <th>Owner</th>
                <th><i class="far fa-window-restore"></i></th>
                <th>Promoted document name</th>
                <th>State</th>
                <th>Check due date</th>
                <th>Person assigned to check</th>
                <th>Approve due date</th>
                <th>Responsible for approving</th>
                <th>Comments</th>
                <th>Creation date</th>
                <th>Finish date</th>
            </tr>
            <%
                if (routes != null) {
                    for (Route r : routes) {
            %>
            <tr>
                <td><input type="checkbox"></td>
                <td><a href="OpenRoute?routeId=<%=r.getId()%>"id="doc-link"><%=r.getName()%></a>
                </td>
                <td><%=r.getOwner()%>
                </td>
                <td>
                    <div id="popup" onclick="openPopup('OpenRoute?routeId=<%=r.getId()%>')"><i class="far fa-window-restore"></i></div>
                </td>
                <td><span class="doc-link" onclick="openPopup('OpenDocument?documentId=<%=r.getDocumentBeingApprovedId()%>')"><%=r.getDocumentBeingApprovedName()%></span>
                </td>
                <td><%=r.getState()%>
                </td>
                <td><%=r.getCheckingDueDate()%>
                </td>
                <td><%=r.getResponsibleForChecking()%>
                </td>
                <td><%=r.getDeadline()%>
                </td>
                <td><%=r.getResponsibleForApproving()%>
                </td>
                <td><%=r.getComments()%>
                </td>
                <td><%=r.getCreationDate()%>
                </td>
                <td><%=r.getFinishDate()%>
                </td>
            </tr>
            <%
                    }
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
