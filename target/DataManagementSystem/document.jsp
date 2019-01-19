<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.sylwesteroleszek.entity.Document" %>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="style/documents-view.css" type="text/css">
    <title>Document</title>

    <script src="jsscripts/editform.js" type="text/javascript"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css"
          integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">

    <style>
        * {
            margin: 0px;
            padding: 0px;
            font-family: Helvetica, Arial, sans-serif;
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
                        if (!role.equals("viewer") && !document.getState().equals("frozen") && !document.getState().equals("released") || role.equals("admin")) {
                    %>
                    <a href="#">
                        <div class="icon">
                            <i class="fas fa-minus-square fa-2x"></i>
                            <i class="fas fa-minus-square fa-2x" title="Delete document"
                               onclick="document.getElementById('modal-wrapper-deletedocument').style.display='block'"></i>
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
        <%--<col width="220">--%>

        <form id="edit-form" action="UpdateDocument" method="post">

            <table class="document-table">
                <col width="220">

                <tr>
                    <td>Name</td>
                    <td><%=document.getName()%>
                    </td>
                </tr>
                <tr>
                    <td>Title</td>
                    <td><input type="text" class="edit-text" name="title" value="<%=document.getTitle()%>" readonly
                               required size="35">
                    </td>
                </tr>
                <tr>
                    <td>Type</td>
                    <td><%=document.getType()%>
                    </td>
                </tr>
                <tr>
                    <td>Revision</td>
                    <td><%=document.getRevision()%>
                    </td>
                </tr>
                <tr>
                    <td>State</td>
                    <td><%=document.getState()%>
                    </td>
                </tr>
                <tr>
                    <td>Owner</td>
                    <td><%=document.getOwner()%>
                    </td>
                </tr>
                <tr>
                    <td>Creation date</td>
                    <td><%=document.getCreationDate()%>
                    </td>
                </tr>
                <tr>
                    <td>Last modified</td>
                    <td><%=document.getLastModification()%>
                    </td>
                </tr>
                <tr>
                    <td>Attachement</td>
                    <td><%=document.getLink()%>
                    </td>
                </tr>
                <tr>
                    <td>Description</td>
                    <td><input type="text" class="edit-text" name="description" value="<%=document.getDescription()%>"
                               readonly required size="35">
                    </td>
                </tr>

                <input type="hidden" name="documentId" value="<%=document.getId()%>">

            </table>

            <%
                if (!role.equals("viewer") && !document.getState().equals("frozen") && !document.getState().equals("released") || role.equals("admin")) {
            %>

            <br><br>

            <button type="button" id="editButton" class="button-edit" style="visibility:visible" onclick="edit()">Edit
            </button>
            <button type="button" id="saveButton" class="button-edit" style="visibility:hidden" onclick="save()">Save
            </button>
            <button type="button" id="cancelButton" class="button-edit" style="visibility:hidden" onclick="cancel()">
                Cancel
            </button>

            <script src="jsscripts/editform.js"></script>

            <%
                }
            %>

        </form>


    </div>

    <div id="footer">
        Sylwester Oleszek 2018 &copy;
    </div>

    <div id="modal-wrapper-deletedocument" class="modal">

        <form class="modal-content animate" action="DeleteDocument" method="get">

            <div class="imgcontainer">
                <span onclick="document.getElementById('modal-wrapper-deletedocument').style.display='none'"
                      class="close"
                      title="Close PopUp">&times;</span>
                <img src="style/delete-document.jpeg" alt="Document" class="avatar">
                <h1 style="text-align:center">Delete document</h1>
            </div>

            <div class="container"><h3
                    style="text-align:left; margin-left: 24px; padding-top: 35px; padding-bottom: 15px">You are about to
                delete <%=document.getName()%>
            </h3>

                <input type="hidden" name="documentId" value="<%=document.getId()%>">

                <button type="submit">Complete</button>
            </div>
        </form>

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

</div>

</body>
</html>
