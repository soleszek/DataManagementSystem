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
        <div id="navbar">
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
        </div>

        <select id="select" onChange="handleSelection(value)">
            <option selected>Select type of object</option>
            <option value="div1">Document</option>
            <option value="div2">Route</option>
            <option value="div3">Task</option>
            <option value="div4">User</option>
        </select>
        <div class="hide" id="div1">
            <form>
                <label>Name</label><input type="text"></input><br/>
                <input type="checkbox"/><br/>
                <input type="text"></input><br/>
            </form>
        </div>
        <div class="hide" id="div2">
            <form>
                <input type="checkbox"/><br/>
                <input type="text"></input><br/>
                <input type="checkbox"/><br/>
                <input type="text"></input><br/>
                <textarea></textarea>
            </form>
        </div>
        <div class="hide" id="div3">
            <form>
                <input type="checkbox"/><br/>
                <input type="text"></input><br/>
                <input type="checkbox"/><br/>
                <input type="text"></input><br/>
                <textarea></textarea>
            </form>
        </div>
        <div class="hide" id="div4">
            <form>
                <input type="checkbox"/><br/>
                <input type="text"></input><br/>
                <input type="checkbox"/><br/>
                <input type="text"></input><br/>
                <textarea></textarea>
            </form>
        </div>

    </div>

    <div id="footer">
        Sylwester Oleszek 2018 &copy;
    </div>

    <script type="text/javascript">

        function handleSelection(choice) {
//document.getElementById('select').disabled=true;
            if (choice == 'div1') {
                document.getElementById(choice).style.display = "block";
                document.getElementById('div2').style.display = "none";
            }
            else if (choice == "div2") {
                document.getElementById(choice).style.display = "block";
                document.getElementById('div1').style.display = "none";
            }
            else if (choice == "div3") {
                document.getElementById(choice).style.display = "block";
                document.getElementById('div1').style.display = "none";
            }
            else if (choice == "div4") {
                document.getElementById(choice).style.display = "block";
                document.getElementById('div1').style.display = "none";
            }
        }
    </script>

</div>

</body>

</html>
