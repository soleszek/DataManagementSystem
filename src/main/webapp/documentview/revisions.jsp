<%@ page import="com.sylwesteroleszek.entity.Document" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="style/documents-view.css" type="text/css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css"
          integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
    <title>Revisions</title>
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
        String role = (String) request.getSession().getAttribute("role");
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
        <div class="optionL"><a href="OpenDocument?documentId=<%=document.getId()%>">Properties</a></div>
        <div class="optionL"><a href="DocumentRevisions?documentId=<%=document.getId()%>">Revisions</a></div>

        <% if (!role.equals("viewer")) { %>

        <div class="optionL"><a href="DocumentRoutes?documentId=<%=document.getId()%>">Routes</a></div>

        <% } %>

        <div class="optionL"><a href="Lifecycle?documentId=<%=document.getId()%>">Lifecycle</a></div>
        <%
            if(document.getType().equals("drawing")){
        %>
        <div class="optionL"><a href="viewer.jsp">Viewer</a></div>
        <% } %>
        <div style="clear: both"></div>
    </div>

    <div id="navbar">
        <ul>
            <li>
                <%
                    if(!role.equals("viewer")){
                %>
                <a href="#">
                    <div class="icon">
                        <i class="far fa-clone fa-2x"></i>
                        <i class="far fa-clone fa-2x" title="Create new revision" onclick="javascript:location.href='CreateNewRevision?documentId=<%=document.getId()%>'"></i>
                    </div>
                </a>
                <%
                } else {
                %>

                <a href="#">
                    <div class="icon-disabled">
                        <i class="far fa-clone fa-2x" title="You don't have privileges"></i>
                    </div>
                </a>
                <%
                    }
                %>
            </li>
            <li>
                <%
                    if(!role.equals("viewer")){
                %>
                <a href="#">
                    <div class="icon">
                        <i class="fas fa-minus-square fa-2x"></i>
                        <i class="fas fa-minus-square fa-2x" title="Delete"></i>
                    </div>
                </a>
                <%
                } else {
                %>
                <a href="#">
                    <div class="icon-disabled">
                        <i class="fas fa-minus-square fa-2x" title="You don't have privileges"></i>
                    </div>
                </a>
                <%
                    }
                %>

            </li>
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
                List<Document> documentRevisions = (List<Document>) request.getAttribute("documentRevisions");
            %>

            <tr>
                <th><input type="checkbox"></th>
                <th>Name</th>
                <th>Title</th>
                <th><i class="far fa-window-restore"></i></th>
                <th>Type</th>
                <th>State</th>
                <th>Revision</th>
                <th>Owner</th>
                <th>Creation date</th>
                <th>Last modified</th>
                <th>Attachement</th>
                <th>Description</th>
            </tr>
            <% for (Document dR : documentRevisions) {
            %>
            <tr>
                <td><input type="checkbox"></td>
                <td><a href="OpenDocument?documentId=<%=dR.getId()%>" id="doc-link"><%=dR.getName()%></a></td>
                <td><%=dR.getTitle()%></td>
                <td><div id="popup" onclick="openPopup('OpenDocument?documentId=<%=dR.getId()%>')"><i class="far fa-window-restore"></i></div></td>
                <td><%=dR.getType()%></td>
                <td><%=dR.getState()%></td>
                <td><%=dR.getRevision()%></td>
                <td><%=dR.getOwner()%></td>
                <td><%=dR.getCreationDate()%></td>
                <td><%=dR.getLastModification()%></td>
                <td><%=dR.getLink()%></td>
                <td><%=dR.getDescription()%></td>
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
