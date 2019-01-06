<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.sylwesteroleszek.entity.Document" %>
<%@ page import="com.sylwesteroleszek.entity.Route" %>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="style/style-route.css" type="text/css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css"
          integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
    <title>Route</title>

    <style>
        * {
            margin: 0px;
            padding: 0px;
            font-family: Helvetica, Arial, sans-serif;
        }

        /*!* Full-width input fields *!
        input[type=text], input[type=password] {
            width: 90%;
            padding: 12px 20px;
            margin: 8px 26px;
            display: inline-block;
            border: 1px solid #ccc;
            box-sizing: border-box;
            font-size: 16px;
        }*/

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

        .button-edit {
            -webkit-border-radius: 3px;
            -moz-border-radius: 3px;
            border-radius: 3px;
            background-image: -webkit-gradient(linear, left bottom, left top, color-stop(0.16, rgb(207, 207, 207)), color-stop(0.79, rgb(252, 252, 252)));
            background-image: linear-gradient(to top, rgb(207, 207, 207) 16%, rgb(252, 252, 252) 79%);
            padding: 4px;
            border: 1px solid #777777;
            color: black;
            text-decoration: none;
            width: 75px;
            height: 25px;
            font-size: 15px;
            margin: 2px 2px;
            margin-top: 10px;
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
            z-index: 1;
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
        Route route = (Route) request.getAttribute("route");
        Document document = (Document) request.getAttribute("document");
        String role = (String)request.getSession().getAttribute("role");
    %>

    <div id="logo">
        <span style="color:#c34f4f">Data</span> Management System
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
            if (document.getType().equals("drawing")) {
        %>
        <div class="optionL"><a href="viewer.jsp">Viewer</a></div>
        <% } %>
        <div style="clear: both"></div>
    </div>

    <div id="navbar">
        <ul>
            <li>
                <%
                    if (route.getState().equals("not started")) {
                %>
                <a href="#">
                    <div class="icon">
                        <i class="fas fa-forward fa-2x"></i>
                        <i class="fas fa-forward fa-2x" title="Start route"
                           onclick="document.getElementById('modal-content-start-route').style.display='block'"></i>
                    </div>
                </a>
                <%
                } else {
                %>

                <a href="#">
                    <div class="icon-disabled">
                        <i class="fas fa-forward fa-2x" title="You don't have privileges"></i>
                    </div>
                </a>

                <%
                    }
                %>


            </li>

            <li>
                <%
                    if (route.getState().equals("not started")) {
                %>
                <a href="#">
                    <div class="icon">
                        <i class="fas fa-minus-square fa-2x"></i>
                        <i class="fas fa-minus-square fa-2x" title="Delete" onclick="document.getElementById('modal-wrapper-deleteroute').style.display='block'"></i>
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
        </ul>
    </div>

    <div id="content">

        <div class="route-table">

            <form id="edit-form" action="UpdateRoute" method="post">

                <table class="user-table">
                    <col width="300">

                    <tr>
                        <td>Promotion request name</td>
                        <td><%=route.getName()%>
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
                                                  onclick="openPopup('OpenDocument?documentId=<%=document.getId()%>')"><%=document.getName()%></a></span>
                        </td>
                    </tr>
                    <tr>
                        <td>State</td>
                        <td><%=route.getState()%>
                        </td>
                    </tr>
                    <tr>
                        <td>Check due date</td>
                        <td><input type="text" class="edit-text" name="checkingDueDate"
                                   value="<%=route.getCheckingDueDate()%>" readonly required>
                        </td>
                    </tr>
                    <tr>
                        <td>Person assigned to check</td>
                        <td><input type="text" class="edit-text" name="responsibleForChecking"
                                   value="<%=route.getResponsibleForChecking()%>" readonly required>
                        </td>
                    </tr>
                    <tr>
                        <td>Approve due date</td>
                        <td><input type="text" class="edit-text" name="deadline" value="<%=route.getDeadline()%>"
                                   readonly
                                   required>
                        </td>
                    </tr>
                    <tr>
                        <td>Person assign to approve</td>
                        <td><input type="text" class="edit-text" name="responsibleForApproving"
                                   value="<%=route.getResponsibleForApproving()%>" readonly required>
                        </td>
                    </tr>
                    <tr>
                        <td>Comments</td>
                        <td><input type="text" class="edit-text" name="comments" value="<%=route.getComments()%>"
                                   readonly required>
                        </td>
                    </tr>
                    <tr>
                        <td>Date of creation</td>
                        <td><%=route.getCreationDate()%>
                        </td>
                    </tr>
                    <tr>
                        <td>Finish date</td>
                        <td><%=route.getFinishDate()%>
                        </td>
                    </tr>

                    <input type="hidden" name="routeId" value="<%=route.getId()%>">
                    <input type="hidden" name="documentId" value="<%=document.getId()%>">

                    <script src="jsscripts/editform.js"></script>

                </table>

                <%
                    if(!route.getState().equals("checking") && !route.getState().equals("approving") && !route.getState().equals("completed") || role.equals("admin")) {
                %>

                <button type="button" id="editButton" class="button-edit" style="visibility:visible" onclick="edit()">
                    Edit
                </button>
                <button type="submit" id="saveButton" class="button-edit" style="visibility:hidden" onclick="save()">
                    Save
                </button>
                <button type="button" id="cancelButton" class="button-edit" style="visibility:hidden"
                        onclick="cancel()">Cancel
                </button>
                <br>

                <%
                    }
                %>

            </form>

        </div>

        <div class="route-stages">

            <div class="pg-container">

                <ul class="progressbar">

                    <%
                        if (route.getState().equals("not started")) {
                    %>

                    <li><i class="fas fa-flag fa-3x"></i></li>
                    <li>Checking</li>
                    <li>Approving</li>
                    <li><i class="fas fa-flag-checkered fa-3x"></i></li>

                    <%
                    } else if (route.getState().equals("checking")) {
                    %>

                    <li class="active"><i class="fas fa-flag fa-3x"></i></li>
                    <li>Checking</li>
                    <li>Approving</li>
                    <li><i class="fas fa-flag-checkered fa-3x"></i></li>
                    <%
                    } else if (route.getState().equals("approving")) {
                    %>

                    <li class="active"><i class="fas fa-flag fa-3x"></i></li>
                    <li class="active">Checking</li>
                    <li>Approving</li>
                    <li><i class="fas fa-flag-checkered fa-3x"></i></li>

                    <%
                    } else if (route.getState().equals("completed")) {
                    %>

                    <li class="active"><i class="fas fa-flag fa-3x"></i></li>
                    <li class="active">Checking</li>
                    <li class="active">Approving</li>
                    <li class="active"><i class="fas fa-flag-checkered fa-3x"></i></li>

                    <%
                        }
                    %>

                </ul>

            </div>

        </div>

    </div>

    <div id="footer">
        Sylwester Oleszek 2018 &copy;
    </div>

    <div id="modal-content-start-route" class="modal">

        <form class="modal-content animate" action="StartRoute" method="get">

            <div class="imgcontainer">
                <span onclick="document.getElementById('modal-content-start-route').style.display='none'" class="close"
                      title="Close PopUp">&times;</span>
                <img src="style/start-route.png" alt="Document" class="avatar">
                <h1 style="text-align:center">Starting promotion request</h1>
            </div>

            <div class="container"><h3
                    style="text-align:left; margin-left: 24px; padding-top: 35px; padding-bottom: 15px">Choose state to
                promote:</h3></div>

            <div class="container">
                <div class="custom-select">
                    <select name="state">
                        <option value="release">Release</option>
                        <option value="release">Release</option>
                        <option value="cancel">Cancel</option>
                    </select>
                </div>

                <input type="hidden" name="routeId" value="<%=route.getId()%>">

                <div class="container"><h2
                        style="text-align:center; margin-left: 24px; padding-top: 35px; padding-bottom: 20px">New task
                    will be sent to <%=route.getResponsibleForChecking()%>
                </h2></div>

                <button type="submit">Submit</button>
            </div>
        </form>

    </div>

    <div id="modal-wrapper-deleteroute" class="modal">

        <form class="modal-content animate" action="DeleteRoute" method="get">

            <div class="imgcontainer">
                <span onclick="document.getElementById('modal-wrapper-deleteroute').style.display='none'" class="close"
                      title="Close PopUp">&times;</span>
                <img src="style/delete-route.jpeg" alt="Document" class="avatar">
                <h1 style="text-align:center">Delete route</h1>
            </div>

            <div class="container"><h3 style="text-align:left; margin-left: 24px; padding-top: 35px; padding-bottom: 15px">You are about to delete route nr <%=route.getName()%></h3>

                <input type="hidden" name="routeId" value="<%=route.getId()%>">

                <button type="submit">Complete</button>
            </div>
        </form>

    </div>

    <script>
        // If user clicks anywhere outside of the modal, Modal will close

        var modal = document.getElementById('modal-content-start-route');
        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>

    <script>
        // If user clicks anywhere outside of the modal, Modal will close

        var modal = document.getElementById('modal-wrapper-deleteroute');
        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>

    <script src="jsscripts/popup.js"></script>
    <script src="jsscripts/dropdownmenu.js"></script>

</div>

</body>
</html>
