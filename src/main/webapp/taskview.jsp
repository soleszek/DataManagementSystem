<%@ page import="com.sylwesteroleszek.entity.Document" %>
<%@ page import="java.util.List" %>
<%@ page import="com.sylwesteroleszek.entity.Route" %>
<%@ page import="com.sylwesteroleszek.entity.Task" %>
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
    <title>Task view</title>

    <style>
        *{margin:0px; padding:0px; font-family:Helvetica, Arial, sans-serif;}

        /* Full-width input fields */
        input[type=text], input[type=password] {
            width: 90%;
            padding: 12px 20px;
            margin: 8px 26px;
            display: inline-block;
            border: 1px solid #ccc;
            box-sizing: border-box;
            font-size:16px;
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
            font-size:20px;
        }
        button:hover {
            opacity: 0.8;
        }

        .file{
            background-color: #46b7ce;
            color: white;
            padding: 14px 20px;
            margin-left: 24px;
            margin-right: 50px;
            border: none;
            cursor: pointer;
            font-size:15px;
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
            height:150px;
            border-radius: 50%;
        }

        /* The Modal (background) */
        .modal {
            display:none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4);
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
        .close:hover,.close:focus {
            color: red;
            cursor: pointer;
        }

        /* Add Zoom Animation */
        .animate {
            animation: zoom 0.6s
        }
        @keyframes zoom {
            from {transform: scale(0)}
            to {transform: scale(1)}
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
        .select-items div,.select-selected {
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
        String name = (String) request.getSession().getAttribute("name");
        String role = (String) request.getSession().getAttribute("role");

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
                        <i class="fas fa-check-square fa-2x"></i>
                        <i class="fas fa-check-square fa-2x" title="Complete" onclick="document.getElementById('modal-content-complete-task').style.display='block'"></i>
                    </div>
                </a>
            </li>
        </ul>

    </div>

    <div id="content">

        <table>
            <col width="300">

            <%
                Task task = (Task) request.getAttribute("task");
            %>

            <tr>
                <td>Task id</td>
                <td><%=task.getId()%>
                </td>
            </tr>
            <tr>
                <td>Owner</td>
                <td><%=task.getOwner()%>
                </td>
            </tr>
            <tr>
                <td>Promoted document</td>
                <td><span class="link"><a href="#"
                                          onclick="openPopup('OpenDocument?documentId=<%=task.getDocumentBeingApprovedId()%>')"><%=task.getDocumentBeingApprovedId()%></a></span>
                </td>
            </tr>
            <tr>
                <td>State</td>
                <td><%=task.getState()%>
                </td>
            </tr>
            <tr>
                <td>Due date</td>
                <td><%=task.getDueDate()%>
                </td>
            </tr>
            <tr>
                <td>Task comment</td>
                <td><%=task.getComments()%>
                </td>
            </tr>
            <tr>
                <td>Completion date</td>
                <td><%=task.getCompletionDate()%>
                </td>
            </tr>
            <tr>
                <td>Your comment</td>
                <td><input type="text" name="doer comment" value="" placeholder="Put your comments here">
                </td>
            </tr>

        </table>

    </div>

    <div id="footer">
        Sylwester Oleszek 2018 &copy;
    </div>

    <div id="modal-content-complete-task" class="modal">

        <form class="modal-content animate" action="CompleteTask" method="get">

            <div class="imgcontainer">
                <span onclick="document.getElementById('modal-content-complete-task').style.display='none'" class="close" title="Close PopUp">&times;</span>
                <img src="style/complete-task.png" alt="Document" class="avatar">
                <h1 style="text-align:center">Complete task</h1>
            </div>

            <div class="container"><h3 style="text-align:left; margin-left: 24px; padding-top: 35px; padding-bottom: 15px">You are completing task <%=task.getId()%>, <%=task.getComments()%></h3></div>

                <input type="hidden" name="taskId" value="<%=task.getId()%>">

                <button type="submit">Complete</button>
            </div>
        </form>

    </div>

    <script>
        // If user clicks anywhere outside of the modal, Modal will close

        var modal = document.getElementById('modal-content-complete-task');
        window.onclick = function(event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>

    <script src="jsscripts/popup.js"></script>

</div>

</body>
</html>
