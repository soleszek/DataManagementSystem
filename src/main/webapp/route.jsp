<%@ page import="com.sylwesteroleszek.entity.Document" %>
<%@ page import="com.sylwesteroleszek.entity.Route" %>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="style/style.css" type="text/css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css"
          integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
    <title>Route</title>
</head>
<body>

<div id="container">

    <%
        String name = (String) request.getSession().getAttribute("name");

        String user = (String) request.getSession().getAttribute("username");
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals(user)) {
                    user = cookie.getName();
                }
            }
        }

        if (user == null) {
            response.sendRedirect("index.jsp");
        }
    %>

    <%
        Route route = (Route) request.getSession().getAttribute("route");
        Document document = (Document) request.getSession().getAttribute("document");
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
        </div>
        <div class="optionSO">
            <a href="dashboard.jsp" id="home"><i class="fas fa-play fa-lg" title="Home"></i></a>
        </div>
        <div style="clear: both"></div>
    </div>

    <div id="sidebar">
        <div class="optionL"><a href="OpenDocument?documentId=<%=document.getId()%>">Properties</a></div>
        <div class="optionL"><a href="DocumentRevisions?documentId=<%=document.getId()%>">Revisions</a></div>
        <div class="optionL"><a href="DocumentRoutes?documentId=<%=document.getId()%>">Routes</a></div>
        <div class="optionL"><a href="Lifecycle?documentId=<%=document.getId()%>">Lifecycle</a></div>
        <%
            if (document.getType().equals("2D drawing")) {
        %>
        <div class="optionL"><a href="viewer.jsp">Viewer</a></div>
        <% } %>
        <div style="clear: both"></div>
    </div>

    <div id="content">
        <%--<col width="220">--%>
        <div class="route-table">

            <table class="user-table">
                <col width="300">

                <tr>
                    <td>Promotion request id</td>
                    <td><%=route.getId()%>
                    </td>
                </tr>
                <tr>
                    <td>Owner</td>
                    <td><%=route.getOwner()%>
                    </td>
                </tr>
                <tr>
                    <td>Promoted document</td>
                    <td><span class="link"><a href="#"
                                              onclick="openPopup('OpenDocument?documentId=<%=document.getId()%>')"><%=document.getTitle()%></a></span>
                    </td>
                </tr>
                <tr>
                    <td>Check due date</td>
                    <td><%=route.getDeadline()%>
                    </td>
                </tr>
                <tr>
                    <td>Person assigned to check</td>
                    <td><%=route.getResponsibleForChecking()%>
                    </td>
                </tr>
                <tr>
                    <td>Approve due date</td>
                    <td><%=route.getDeadline()%>
                    </td>
                </tr>
                <tr>
                    <td>Person assign to approve</td>
                    <td><%=route.getResponsibleForApproving()%>
                    </td>
                </tr>
                <tr>
                    <td>Comments</td>
                    <td><%=route.getComments()%>
                    </td>
                </tr>
                <tr>
                    <td>Date of creation</td>
                    <td><%=route.getCreationDate()%>
                    </td>
                </tr>

            </table>
        </div>

        <div class="route-stages">
            adfadsfasdfa

            <ul class="progressbar">

                <li class="active"><i class="fas fa-flag fa-3x"></i></li>

                <li>Check</li>

                <li>Approve</li>

                <li><i class="fas fa-flag-checkered fa-3x"></i></li>

            </ul>
        </div>

    </div>

    <div id="footer">
        Sylwester Oleszek 2018 &copy;
    </div>

    <script src="jsscripts/popup.js"></script>

</div>

</body>
</html>
