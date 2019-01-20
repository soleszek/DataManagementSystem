<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.sylwesteroleszek.entity.Document" %>
<%@ page import="com.sylwesteroleszek.entity.Route" %>
<%@ page import="java.util.List" %>
<%@ page import="com.sylwesteroleszek.entity.User" %>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="style/documents-view.css" type="text/css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css"
          integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
    <title>Routes</title>

    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css">

    <script src="https://code.jquery.com/jquery-3.3.1.js" type="text/javascript"></script>
    <script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js" type="text/javascript"></script>

    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="/resources/demos/style.css">
    <script>
        $(function () {
            $(".datepicker").datepicker({
                dateFormat: "yy-mm-dd"
            });
        });
    </script>

    <style>
        * {
            margin: 0px;
            padding: 0px;
            font-family: Helvetica, Arial, sans-serif;
        }

        .modal-text, .datepicker {
            width: 90%;
            padding: 12px 20px;
            margin: 8px 26px;
            display: inline-block;
            border: 1px solid #ccc;
            box-sizing: border-box;
            font-size: 16px;
        }

        /* Set a style for all buttons */
        button {
            background-color: #46b7ce;
            color: white;
            padding: 14px 20px;
            margin: 8px 26px;
            border: none;
            cursor: pointer;
            width: 90%;
            font-size: 20px;
        }

        button:hover {
            opacity: 0.8;
        }

        .file {
            background-color: #46b7ce;
            color: white;
            padding: 14px 20px;
            margin-left: 24px;
            margin-right: 50px;
            border: none;
            cursor: pointer;
            font-size: 15px;
            width: 85%;
        }

        /* Center the image and position the close button */
        .imgcontainer {
            text-align: center;
            margin: 24px 0 12px 0;
            position: relative;
        }

        .avatar {
            width: 150px;
            height: 150px;
            border-radius: 50%;
        }

        /* The Modal (background) */
        .modal {
            display: none;
            position: fixed;
            z-index: 12;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.4);
        }

        /* Modal Content Box */
        .modal-content {
            background-color: #fefefe;
            margin: 4% auto 15% auto;
            border: 1px solid #888;
            width: 40%;
            padding-bottom: 30px;
        }

        /* The Close Button (x) */
        .close {
            position: absolute;
            right: 25px;
            top: 0;
            color: #000;
            font-size: 35px;
            font-weight: bold;
        }

        .close:hover, .close:focus {
            color: red;
            cursor: pointer;
        }

        /* Add Zoom Animation */
        .animate {
            animation: zoom 0.6s
        }

        @keyframes zoom {
            from {
                transform: scale(0)
            }
            to {
                transform: scale(1)
            }
        }

        .custom-select {
            position: relative;
        }

        .custom-select select {
            display: none; /*hide original SELECT element:*/
        }

        .select-selected {
            background-color: #46b7ce;
        }

        /*style the arrow inside the select element:*/
        .select-selected:after {
            position: absolute;
            content: "";
            top: 14px;
            right: 10px;
            width: 0;
            height: 0;
            border: 6px solid transparent;
            border-color: #fff transparent transparent transparent;
        }

        /*point the arrow upwards when the select box is open (active):*/
        .select-selected.select-arrow-active:after {
            border-color: transparent transparent #fff transparent;
            top: 7px;
        }

        /*style the items (options), including the selected item:*/
        .select-items div, .select-selected {
            color: #ffffff;
            padding: 14px 20px;
            margin-left: 24px;
            margin-right: 50px;
            border: 1px solid transparent;
            border-color: transparent transparent #46b7ce transparent;
            cursor: pointer;
            user-select: none;
        }

        /*style items (options):*/
        .select-items {
            padding: 14px 20px;
            margin-left: 24px;
            margin-right: 50px;
            position: absolute;
            background-color: #46b7ce;
            top: 100%;
            left: 0;
            right: 0;
            z-index: 99;
        }

        /*hide the items when the select box is closed:*/
        .select-hide {
            display: none;
        }

        .select-items div:hover, .same-as-selected {
            background-color: rgba(0, 0, 0, 0.1);
        }


    </style>

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
        Document document = (Document) request.getAttribute("document");
        List<User> checkers = (List<User>) request.getAttribute("checkers");
        List<User> approvers = (List<User>) request.getAttribute("approvers");
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
                    <input type="hidden" name="login" value="<c:out value="${sessionScope.login}"/>"/>
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
                <a href="Dashboard" id="home"><i class="fas fa-play fa-lg" title="Home"></i></a>
            </div>
            <div style="clear: both"></div>

        </div>
        <div style="clear:both;"></div>

    </div>
    <div style="clear:both"></div>

    <div id="sidebar">
        <div class="optionL"><a href="OpenDocument?documentId=<%=document.getId()%>">Properties</a></div>
        <div class="optionL"><a href="DocumentRevisions?documentId=<%=document.getId()%>">Revisions</a></div>

        <c:if test="${role ne 'viewer'}">
            <div class="optionL"><a href="DocumentRoutes?documentId=<%=document.getId()%>">Routes</a></div>
        </c:if>

        <div class="optionL"><a href="Lifecycle?documentId=<%=document.getId()%>">Lifecycle</a></div>
        <c:if test="${document.getType() eq 'drawing'}">
            <div class="optionL"><a href="viewer.jsp">Viewer</a></div>
        </c:if>

        <div style="clear: both"></div>
    </div>

    <div id="content">

        <div id="navbar">
            <ul>
                <li>
                    <a href="#">
                        <div class="icon">
                            <i class="fas fa-angle-double-right fa-2x"></i>
                            <i class="fas fa-angle-double-right fa-2x" title="Create new route"
                               onclick="document.getElementById('modal-wrapper-routes').style.display='block'"></i>
                        </div>
                    </a>
                </li>
            </ul>
            <input id="txtSearch" placeholder="Filter table" class="form-control"/>
        </div>

        <table id="example" class="display" style="width:100%">
            <col width="60">

            <%
                List<Route> existingRoutes = (List<Route>) request.getAttribute("existingRoutes");
            %>
            <thead>
            <tr>
                <th>Promotion request name</th>
                <th>Owner</th>
                <th><i class="far fa-window-restore"></i></th>
                <th>Promoted document</th>
                <th>State</th>
                <th>Check due date</th>
                <th>Person assigned to check</th>
                <th>Approve due date</th>
                <th>Responsible for approving</th>
                <th>Comments</th>
                <th>Creation date</th>
                <th>Finish date</th>
            </tr>
            </thead>
            <%
                if (existingRoutes != null) {
            %>
            <tbody>
            <%
                for (Route r : existingRoutes) {
            %>
            <tr>
                <td><a href="OpenRoute?routeId=<%=r.getId()%>" id="doc-link"><%=r.getName()%>
                </a>
                </td>
                <td><%=r.getOwner()%>
                </td>
                <td>
                    <div id="popup" onclick="openPopup('OpenRoute?routeId=<%=r.getId()%>')"><i
                            class="far fa-window-restore"></i></div>
                </td>
                <td><span class="doc-link"
                          onclick="openPopup('OpenDocument?documentId=<%=r.getDocumentBeingApprovedId()%>')"><%=document.getName()%></span>
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

    <div id="modal-wrapper-routes" class="modal">

        <form class="modal-content animate" action="CreateRoute" method="post">
            <div class="imgcontainer">
                <span onclick="document.getElementById('modal-wrapper-routes').style.display='none'" class="close"
                      title="Close PopUp">&times;</span>
                <img src="style/route.png" alt="Document" class="avatar">
                <h1 style="text-align:center">New promotion request</h1>
            </div>
            <div class="container">
                <input type="text" class="modal-text" disabled name="name" value="<%=document.getName()%>">
                <input type="hidden" readonly name="documentId" value="<%=document.getId()%>">
                <c:set var="now" value="<%=new java.util.Date()%>"/>
                <input type="text" class="modal-text" readonly name="creation date"
                       value="<fmt:formatDate type = "date" value = "${now}"/>">
                <input type="text" class="modal-text" disabled name="documentTitle" value="<%=document.getTitle()%>">
                <input type="text" class="modal-text" readonly name="owner" value="<%=login%>">

                <div><input type="text" placeholder="Must be checked before" class="datepicker"
                            name="checkingDueDate" required></div>

                <div class="custom-select">

                    <select name="responsibleForChecking">
                        <option value="soleszek">Sylwester Oleszek, admin</option>
                        <%
                            for (User c : checkers) {
                        %>
                        <option value="<%=c.getLogin()%>"><%=c.getUserName()%> <%=c.getLastName()%>, <%=c.getRole()%>
                        </option>
                        <%
                            }
                        %>
                    </select>

                </div>

                <br>
                <div><input type="text" placeholder="Must be approved before" class="datepicker"
                            name="deadline" required></div>

                <div class="custom-select">

                    <select name="responsibleForApproving">
                        <option value="soleszek">Sylwester Oleszek, admin</option>
                        <%
                            for (User u : approvers) {
                        %>
                        <option value="<%=u.getLogin()%>"><%=u.getUserName()%> <%=u.getLastName()%>, <%=u.getRole()%>
                        </option>
                        <%
                            }
                        %>
                    </select>

                </div>
                <input type="text" class="modal-text" placeholder="Enter comment" name="description" required>
                <button type="submit">Create</button>
            </div>
        </form>

    </div>

    <script>
        // If user clicks anywhere outside of the modal, Modal will close

        var modal = document.getElementById('modal-wrapper-routes');
        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>

    <script src="jsscripts/popup.js"></script>
    <script src="jsscripts/dropdownmenu.js"></script>

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
