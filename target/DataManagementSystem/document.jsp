<%@ page import="com.sylwesteroleszek.entity.Document" %>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="style/style.css" type="text/css">
    <title>Document</title>
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

    <%
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
        <div class="optionL"><a href="OpenDocument?documentId=<%=document.getId()%>">Properties</a></div>
        <div class="optionL"><a href="DocumentRevisions?documentId=<%=document.getId()%>">Revisions</a></div>
        <div class="optionL"><a href="DocumentRoutes?documentId=<%=document.getId()%>">Routes</a></div>
        <div class="optionL"><a href="Lifecycle?documentId=<%=document.getId()%>">Lifecycle</a></div>
        <%
            if(document.getType().equals("2D drawing")){
        %>
        <div class="optionL"><a href="DocumentViewer?documentId=<%=document.getId()%>">Viewer</a></div>
        <% } %>
        <div style="clear: both"></div>
    </div>

    <div id="content">
        <col width="220">

        <table class="user-table">
            <col width="220">

            <tr>
                <td>Document id</td>
                <td><%=document.getId()%></td>
            </tr>
            <tr>
                <td>Title</td>
                <td><%=document.getTitle()%></td>
            </tr>
            <tr>
                <td>Type</td>
                <td><%=document.getType()%></td>
            </tr>
            <tr>
                <td>Revision</td>
                <td><%=document.getRevision()%></td>
            </tr>
            <tr>
                <td>State</td>
                <td><%=document.getState()%></td>
            </tr>
            <tr>
                <td>Owner</td>
                <td><%=document.getOwner()%></td>
            </tr>
            <tr>
                <td>Creation date</td>
                <td><%=document.getCreationDate()%></td>
            </tr>
            <tr>
                <td>Last modified</td>
                <td><%=document.getLastModification()%></td>
            </tr>
            <tr>
                <td>Attachement</td>
                <td><%=document.getLink()%></td>
            </tr>
            <tr>
                <td>Description</td>
                <td><%=document.getDescription()%></td>
            </tr>

        </table>

    </div>

    <div id="footer">
        Sylwester Oleszek 2018 &copy;
    </div>

</div>

</body>
</html>
