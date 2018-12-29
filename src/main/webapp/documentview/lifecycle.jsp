<%@ page import="com.sylwesteroleszek.entity.Document" %>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="style/style.css" type="text/css">
    <title>Lifecycle</title>
</head>
<body>

<div id="container">

    <%
        String userName = (String)request.getSession().getAttribute("userName");

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
        <div class="optionL"><a href="OpenDocument?documentId=<%=document.getId()%>">Properties</a></div>
        <div class="optionL"><a href="DocumentRevisions?documentId=<%=document.getId()%>">Revisions</a></div>
        <div class="optionL"><a href="DocumentRoutes?documentId=<%=document.getId()%>">Routes</a></div>
        <div class="optionL"><a href="Lifecycle?documentId=<%=document.getId()%>">Lifecycle</a></div>
        <%
            if(document.getType().equals("2D drawing")){
        %>
        <div class="optionL"><a href="viewer.jsp">Viewer</a></div>
        <% } %>
        <div style="clear: both"></div>
    </div>

    <div id="content">

        <ul class="lifecycle">

            <%
                if (document.getState().equals("in work")) {
            %>
            <li class="active">In work</li>
            <%
            } else {
            %>
            <li>In work</li>
            <% } %>

            <%
                if (document.getState().equals("frozen")){
            %>
            <li class="active">Frozen</li>
            <%
                } else {
            %>
            <li>Frozen</li>
            <% } %>

            <%
                if (document.getState().equals("released")){
            %>
            <li class="active">Released</li>
            <%
                } else {
            %>
            <li>Released</li>
            <% } %>

            <%
                if (document.getState().equals("canceled")){
            %>
            <li class="active">Canceled</li>
            <%
                } else {
            %>
            <li>Canceled</li>
            <% } %>
        </ul>

    </div>

    <div id="footer">
        Sylwester Oleszek 2018 &copy;
    </div>

</div>

</body>
</html>
