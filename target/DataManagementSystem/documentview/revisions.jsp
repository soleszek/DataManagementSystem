<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css">

    <script src="https://code.jquery.com/jquery-3.3.1.js" type="text/javascript"></script>
    <script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js" type="text/javascript"></script>

    <title>Revisions</title>
</head>
<body>

<div id="container">

    <%
        String userName = (String) request.getSession().getAttribute("userName");

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
        <span style="color:#c34f4f">Data</span> Management System
    </div>

    <div class="menu">

        <div class="topmenu">
            <label>Name</label>
        </div>
        <div id="search">
            <ul class="sliding-icons">
                <li>
                    <a href="advancedsearch.jsp">
                        <div class="icon">
                            <i class="fas fa-search fa-2x"></i>
                            <i class="fas fa-search fa-2x" title="Advanced search"></i>
                        </div>
                    </a>
                </li>
            </ul>
            <form class="thing" action="QuickSearch" method="get">
                <label for="ddd" class="thing-label">
                    Type to search...
                </label>
                <input type="text" name="phrase" id="ddd" class="thing-text">
                <input type="submit" value="search" class="thing-btn">
            </form>
            <div style="clear: both"></div>
        </div>

        <div class="topmenu">
            <div class="optionSO">
                <form action="LogoutServlet" method="get">
                    <input type="hidden" name="login" value="<%=login%>"/>
                    <input type="submit" name="menu" value="Sign out">
                </form>
            </div>
            <div class="option">
                <form id="usershow" action="UserShow" method="get">
                    <a href="#" onclick="document.getElementById('usershow').submit()">Witaj <c:out value="${sessionScope.userName}"/>
                    </a>
                </form>
            </div>
            <div class="optionSO">
                <a href="dashboard.jsp" id="home"><i class="fas fa-play fa-lg" title="Home"></i></a>
            </div>
            <div style="clear: both"></div>

        </div>
        <div style="clear:both;"></div>

    </div>
    <div style="clear:both"></div>

    <div id="sidebar">
        <div class="optionL"><a href="OpenDocument?documentId=<%=document.getId()%>">Properties</a></div>
        <div class="optionL"><a href="DocumentRevisions?documentId=<%=document.getId()%>">Revisions</a></div>

        <% if (!role.equals("viewer")) { %>

        <div class="optionL"><a href="DocumentRoutes?documentId=<%=document.getId()%>">Routes</a></div>

        <% } %>

        <div class="optionL"><a href="Lifecycle?documentId=<%=document.getId()%>">Lifecycle</a></div>
        <%
            if (document.getType().equals("drawing")) {
        %>
        <div class="optionL"><a href="viewer.jsp">Viewer</a></div>
        <% } %>
        <div style="clear: both"></div>
    </div>

    <div id="content">

        <div id="navbar">
            <ul>
                <li>
                    <%
                        if (!role.equals("viewer") && !document.getState().equals("in work") && !document.getState().equals("frozen")) {
                    %>
                    <a href="#">
                        <div class="icon">
                            <i class="far fa-clone fa-2x"></i>
                            <i class="far fa-clone fa-2x" title="Create new revision"
                               onclick="javascript:location.href='CreateNewRevision?documentId=<%=document.getId()%>'"></i>
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
            </ul>

            <input id="txtSearch" placeholder="Filter table" class="form-control"/>

        </div>


        <table id="example" class="display" style="width:100%">
            <col width="60">

            <%
                List<Document> documentRevisions = (List<Document>) request.getAttribute("documentRevisions");
            %>
            <thead>
            <tr>
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
            </thead>
            <tbody>
            <% for (Document dR : documentRevisions) {
            %>
            <tr>
                <td><a href="OpenDocument?documentId=<%=dR.getId()%>" id="doc-link"><%=dR.getName()%>
                </a></td>
                <td><%=dR.getTitle()%>
                </td>
                <td>
                    <div id="popup" onclick="openPopup('OpenDocument?documentId=<%=dR.getId()%>')"><i
                            class="far fa-window-restore"></i></div>
                </td>
                <td><%=dR.getType()%>
                </td>
                <td><%=dR.getState()%>
                </td>
                <td><%=dR.getRevision()%>
                </td>
                <td><%=dR.getOwner()%>
                </td>
                <td><%=dR.getCreationDate()%>
                </td>
                <td><%=dR.getLastModification()%>
                </td>
                <td><%=dR.getLink()%>
                </td>
                <td><%=dR.getDescription()%>
                </td>
            </tr>
            <%
                }
            %>
            </tbody>

        </table>

    </div>

    <div id="footer">
        Sylwester Oleszek 2018 &copy;
    </div>

    <script src="jsscripts/popup.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {

            // Setup - add a text input to each footer cell
            $('#example tfoot th').each(function () {
                var title = $(this).text();
                $(this).html('<input type="text" placeholder="Search ' + title + '" />');
            });

            // DataTable
            var table = $('#example').DataTable({
                "lengthMenu": [[10, 20], [10, 20]]
            });

            /*// Apply the search
            table.columns().every(function () {
                var that = this;

                $('input', this.footer()).on('keyup change', function () {
                    if (that.search() !== this.value) {
                        that
                            .search(this.value)
                            .draw();
                    }
                });
            });*/
        });
    </script>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#example').DataTable();

            $('#example_filter').hide(); // Hide default search datatables where example is the ID of table

            $('#txtSearch').on('keyup', function () {
                $('#example')
                    .DataTable()
                    .search($('#txtSearch').val(), false, true)
                    .draw();
            });
        });
    </script>

</div>

</body>
</html>
