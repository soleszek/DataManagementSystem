package com.sylwesteroleszek.servlets;

import com.sylwesteroleszek.Enums.RouteStates;
import com.sylwesteroleszek.Enums.TaskStates;
import com.sylwesteroleszek.dao.DocumentDao;
import com.sylwesteroleszek.dao.RouteDao;
import com.sylwesteroleszek.dao.TaskDao;
import com.sylwesteroleszek.dao.UserDao;
import com.sylwesteroleszek.daoImpl.UserDaoImpl;
import com.sylwesteroleszek.entity.Route;
import com.sylwesteroleszek.entity.Task;
import com.sylwesteroleszek.entity.User;
import com.sylwesteroleszek.providers.DaoProvider;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private UserDao userDao = DaoProvider.getInstance().getUserDao();
    private DocumentDao documentDao = DaoProvider.getInstance().getDocumentDao();
    private RouteDao routeDao = DaoProvider.getInstance().getRouteDao();
    private TaskDao taskDao = DaoProvider.getInstance().getTaskDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String login = req.getParameter("login");
        String password = req.getParameter("password");

        Cookie loginCookie = null;

        List<User> users = userDao.findAll();
        Optional<User> userLoggedIn = users.stream()
                .filter(u -> u.getLogin().equals(login)
                && u.getPassword().equals(password))
                .findFirst();

        if(userLoggedIn.isPresent()){
            loginCookie = new Cookie(userLoggedIn.get().getLogin(), userLoggedIn.get().getUserName());
            loginCookie.setMaxAge(30*60);

            resp.addCookie(loginCookie);

            req.getSession().setAttribute("login", userLoggedIn.get().getLogin());
            req.getSession().setAttribute("userName", userLoggedIn.get().getUserName());
            req.getSession().setAttribute("role", userLoggedIn.get().getRole());
            RequestDispatcher rd = req.getRequestDispatcher("Dashboard");
            rd.forward(req, resp);

        } else {
            RequestDispatcher rd = req.getRequestDispatcher("index.jsp");
            resp.getWriter()
                    .println("<font color=red>Incorrect or missing login details</font>");
            rd.include(req, resp);
        }
    }
}
