<%@ page import="com.sylwesteroleszek.entity.Document" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
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

    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css">

    <script src="https://code.jquery.com/jquery-3.3.1.js" type="text/javascript"></script>
    <script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js" type="text/javascript"></script>

    <title>Quick search results</title>

</head>
<body>

<div id="container">

    <%
        String userName = (String) request.getSession().getAttribute("userName");
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
                    <a href="#" onclick="document.getElementById('usershow').submit()">Witaj <%=userName%>
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
        <div class="optionL"><a href="AllDocuments">Documents</a></div>

        <% if (!role.equals("viewer")) { %>

        <div class="optionL"><a href="ShowAllRoutes">Routes</a></div>
        <div class="optionL"><a href="AllUserTasks">Tasks</a></div>

        <% } %>

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
        <div id="navbar">
            <input id="txtSearch" placeholder="Filter table" class="form-control"/>
        </div>

        <table id="example" class="display" style="width:100%">
            <col width="60">

            <%
                List<Document> matchingDocuments = (List<Document>) request.getAttribute("matchingDocuments");
                List<Document> approvedDocuments = new ArrayList<>();

                for (Document d : matchingDocuments) {
                    if (d.getState().equals("released")) {
                        approvedDocuments.add(d);
                    }
                }

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
            <%
                if (role.equals("viewer")) {
            %>
            <tbody>
            <%
                for (Document d : approvedDocuments) {
            %>
            <tr>
                <td><a href="OpenDocument?documentId=<%=d.getId()%>" id="doc-link"><%=d.getName()%>
                </a></td>
                <td><%=d.getTitle()%>
                </td>
                <td>
                    <div id="popup" onclick="openPopup('OpenDocument?documentId=<%=d.getId()%>')"><i
                            class="far fa-window-restore"></i></div>
                </td>
                <td><%=d.getType()%>
                </td>
                <td><%=d.getState()%>
                </td>
                <td><%=d.getRevision()%>
                </td>
                <td><%=d.getOwner()%>
                </td>
                <td><%=d.getCreationDate()%>
                </td>
                <td><%=d.getLastModification()%>
                </td>
                <td><%=d.getLink()%>
                </td>
                <td><%=d.getDescription()%>
                </td>
            </tr>
            <%
                }
            %>
            </tbody>

            <%
            } else {
            %>

            <tbody>
            <%
                for (Document d : matchingDocuments) {
            %>

            <tr>
                <td><a href="OpenDocument?documentId=<%=d.getId()%>" id="doc-link"><%=d.getName()%>
                </a></td>
                <td><%=d.getTitle()%>
                </td>
                <td>
                    <div id="popup" onclick="openPopup('OpenDocument?documentId=<%=d.getId()%>')"><i
                            class="far fa-window-restore"></i></div>
                </td>
                <td><%=d.getType()%>
                </td>
                <td><%=d.getState()%>
                </td>
                <td><%=d.getRevision()%>
                </td>
                <td><%=d.getOwner()%>
                </td>
                <td><%=d.getCreationDate()%>
                </td>
                <td><%=d.getLastModification()%>
                </td>
                <td><%=d.getLink()%>
                </td>
                <td><%=d.getDescription()%>
                </td>
            </tr>

            <%
                }
            %>
            </tbody>

            <%
                }
            %>

        </table>

    </div>

    <div id="footer">
        Sylwester Oleszek 2018 &copy;
    </div>

    <script>
        // If user clicks anywhere outside of the modal, Modal will close

        var modal = document.getElementById('modal-wrapper');
        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>

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
