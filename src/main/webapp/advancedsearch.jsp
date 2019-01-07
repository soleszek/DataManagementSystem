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

    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="/resources/demos/style.css">

    <title>Advanced search</title>

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
                    <a href="#">
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
        <%--<div id="navbar">
            <ul class="sliding-icons">
                <li>
                    <%
                        if (!role.equals("viewer")) {
                    %>
                    <a href="#">
                        <div class="icon">
                            <i class="fas fa-plus-square fa-2x"></i>
                            <i class="fas fa-plus-square fa-2x" title="Create new document"
                               onclick="document.getElementById('modal-wrapper').style.display='block'"></i>
                        </div>
                    </a>
                    <%
                    } else {
                    %>

                    <a href="#">
                        <div class="icon-disabled">
                            <i class="fas fa-plus-square fa-2x" title="You don't have privileges"></i>
                        </div>
                    </a>
                    <%
                        }
                    %>

                </li>
            </ul>
        </div>--%>

        <select id="object">
            <option selected>Select type of object</option>
            <option value="div1">Documents</option>
            <option value="div2">Routes</option>
            <option value="div3">Tasks</option>
            <option value="div4">Users</option>
        </select>
        <div class="form-div1" id="div1">
            <form class="edit-form" action="AdvancedSearchDocument" method="post">

                <table id="example1" class="display" style="width:100%">
                    <col width="220">

                    <tr>
                        <td>Name</td>
                        <td><input type="text" name="name" value=""><td>
                        </td>
                    </tr>
                    <tr>
                        <td>Title</td>
                        <td><input type="text" name="title" value="">
                        </td>
                    </tr>
                    <tr>
                        <td>Type</td>
                        <td><input type="text" id=doctype name="doctype" value="" readonly>
                            <select name="docstate" id="select-doctype" onchange="replaceValueDocType(event)">
                                <option value="drawing">drawing</option>
                                <option value="document">document</option>
                                <option value="image">image</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Revision</td>
                        <td><input type="text" name="revision" value="">
                        </td>
                    </tr>
                    <tr>
                        <td>State</td>
                        <td><input type="text" id="docstate" name="docstate" value="" readonly>
                            <select name="docstate" id="select-docstate" onchange="replaceValueDocState(event)">
                                <option value="inwork">in work</option>
                                <option value="frozen">frozen</option>
                                <option value="released">released</option>
                                <option value="canceled">canceled</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Owner</td>
                        <td><input type="text" name="owner" value="">
                        </td>
                    </tr>
                    <tr>
                        <td>Creation date</td>
                        <td><input type="text" name="creationDate" value="" class="datepicker">
                        </td>
                    </tr>
                    <tr>
                        <td>Last modified</td>
                        <td><input type="text" name="lastModified" value="" class="datepicker">
                        </td>
                    </tr>
                    <tr>
                        <td>Description</td>
                        <td><input type="text" name="description" value="">
                        </td>
                    </tr>

                </table>

                <input type="submit" name="" value="search">

            </form>
        </div>
        <div class="form-div2" id="div2">
            <form id="edit-form" action="AdvancedSearchRoute" method="post">

                <table id="example2" class="display" style="width:100%">
                    <col width="300">

                    <tr>
                        <td>Promotion request name</td>
                        <td><input type="text" name="name" value="">
                        </td>
                    </tr>
                    <tr>
                        <td>Owner</td>
                        <td><input type="text" name="owner" value="">
                        </td>
                    </tr>
                    <tr>
                        <td>Promoted document</td>
                        <td><input type="text" name="promotedDocument" value="">
                        </td>
                    </tr>
                    <tr>
                        <td>State</td>
                        <td><input type="text" id="routestate" name="routestate" value="" readonly>
                            <select name="routestate" id="select-routestate" onchange="replaceValueRouteState(event)">
                                <option value="not started">not started</option>
                                <option value="checking">checking</option>
                                <option value="approving">approving</option>
                                <option value="completed">completed</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Check due date</td>
                        <td><input type="text" name="checkDueDate" value="" class="datepicker">
                        </td>
                    </tr>
                    <tr>
                        <td>Person assigned to check</td>
                        <td><input type="text" name="assignedToCheck" value="">
                        </td>
                    </tr>
                    <tr>
                        <td>Approve due date</td>
                        <td><input type="text" name="approveDueDate" value="" class="datepicker">
                        </td>
                    </tr>
                    <tr>
                        <td>Person assigned to approve</td>
                        <td><input type="text" name="assignedToApprove" value="">
                        </td>
                    </tr>
                    <tr>
                        <td>Comments</td>
                        <td><input type="text" name="comments" value="">
                        </td>
                    </tr>
                    <tr>
                        <td>Date of creation</td>
                        <td><input type="text" name="dateOfCreation" value="" class="datepicker">
                        </td>
                    </tr>
                    <tr>
                        <td>Finish date</td>
                        <td><input type="text" name="finishDate" value="" class="datepicker">
                        </td>
                    </tr>

                </table>

                <input type="submit" name="" value="search">

            </form>
        </div>
        <div class="form-div3" id="div3">
            <form class="edit-form" action="AdvancedSearchTask" method="post">
                <table id="example3" class="display" style="width:100%">
                    <col width="300">

                    <tr>
                        <td>Task name</td>
                        <td><input type="text" name="name" value="">
                        </td>
                    </tr>
                    <tr>
                        <td>Owner</td>
                        <td><input type="text" name="owner" value="">
                        </td>
                    </tr>
                    <tr>
                        <td>Promoted document</td>
                        <td><input type="text" name="promotedDocument" value="">
                        </td>
                    </tr>
                    <tr>
                        <td>State</td>
                        <td><input type="text" id="state" name="state" value="" readonly>
                            <select name="state" id="select-state" onchange="replaceValueState(event)">
                                <option value="active">Active</option>
                                <option value="complete">Complete</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Due date</td>
                        <td><input type="text" name="dueDate" value="" class="datepicker">
                        </td>
                    </tr>
                    <tr>
                        <td>Task comment</td>
                        <td><input type="text" name="comment" value="">
                        </td>
                    </tr>
                    <tr>
                        <td>Completion date</td>
                        <td><input type="text" name="completionDate" value="" class="datepicker">
                        </td>
                    </tr>
                    <tr>
                        <td>Your comment</td>
                        <td><input type="text" name="yourComment" value="">
                        </td>
                    </tr>

                </table>

                <input type="submit" name="" value="search">

            </form>
        </div>
        <div class="form-div4" id="div4">
            <form <%--id="edit-form"--%> action="AdvancedSearchUser" method="post">

                <table id="example4" class="display" style="width:100%">
                    <col width="220">

                    <tr>
                        <td>Name</td>
                        <td><input type="text" name="name" value="">
                        </td>
                    </tr>
                    <tr>
                        <td>First Name</td>
                        <td><input type="text" name="firstName" value=""></td>
                    </tr>
                    <tr>
                        <td>Last Name</td>
                        <td><input type="text" name="lastName" value=""></td>
                    </tr>
                    <tr>
                        <td>Role</td>
                        <td><input type="text" id="role" name="role" value="" readonly>
                            <select name="role" id="select-role" onchange="replaceValue(event)">
                                <option value="viewer">Viewer</option>
                                <option value="contributor">Contributor</option>
                                <option value="manager">Manager</option>
                                <option value="admin">Admin</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Login</td>
                        <td><input type="text" name="login" value="">
                        </td>
                    </tr>

                </table>

                <input type="submit" name="" value="search">

            </form>
        </div>

    </div>

    <div id="footer">
        Sylwester Oleszek 2018 &copy;
    </div>

    <script type="text/javascript">
        $(document).ready(function () {

            // Setup - add a text input to each footer cell
            $('#example1 tfoot th').each(function () {
                var title = $(this).text();
                $(this).html('<input type="text" placeholder="Search ' + title + '" />');
            });

            // DataTable
            var table = $('#example1').DataTable({
                "lengthMenu": [[10, 20], [10, 20]]
            });

        });
    </script>

    <script type="text/javascript">
        $(document).ready(function () {

            // Setup - add a text input to each footer cell
            $('#example2 tfoot th').each(function () {
                var title = $(this).text();
                $(this).html('<input type="text" placeholder="Search ' + title + '" />');
            });

            // DataTable
            var table = $('#example2').DataTable({
                "lengthMenu": [[10, 20], [10, 20]]
            });

        });
    </script>

    <script type="text/javascript">
        $(document).ready(function () {

            // Setup - add a text input to each footer cell
            $('#example3 tfoot th').each(function () {
                var title = $(this).text();
                $(this).html('<input type="text" placeholder="Search ' + title + '" />');
            });

            // DataTable
            var table = $('#example3').DataTable({
                "lengthMenu": [[10, 20], [10, 20]]
            });

        });
    </script>

    <script type="text/javascript">
        $(document).ready(function () {

            // Setup - add a text input to each footer cell
            $('#example4 tfoot th').each(function () {
                var title = $(this).text();
                $(this).html('<input type="text" placeholder="Search ' + title + '" />');
            });

            // DataTable
            var table = $('#example4').DataTable({
                "lengthMenu": [[10, 20], [10, 20]]
            });

        });
    </script>

    <script>
        $(function () {
            $(".datepicker").datepicker({
                dateFormat: "yy-mm-dd"
            });
        });
    </script>

    <script src="jsscripts/advancedsearch.js"></script>
    <script src="jsscripts/dropdownToInput.js"></script>
    <script src="jsscripts/dropdownToInputState.js"></script>
    <script src="jsscripts/dropdownToInputRouteState.js"></script>
    <script src="jsscripts/dropdownToInputDocState.js"></script>
    <script src="jsscripts/dropdownToInputDocType.js"></script>



</div>

</body>

</html>
