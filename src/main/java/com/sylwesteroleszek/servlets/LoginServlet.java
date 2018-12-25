package com.sylwesteroleszek.servlets;

import com.sylwesteroleszek.dao.UserDao;
import com.sylwesteroleszek.daoImpl.UserDaoImpl;
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

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private UserDao userDao = new UserDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String user = req.getParameter("username");
        String password = req.getParameter("password");

        Cookie loginCookie = null;

        List<User> users = userDao.findAll();
        Optional<User> userLoggedIn = users.stream()
                .filter(u -> u.getUsername().equals(user)
                && u.getPassword().equals(password))
                .findFirst();

        if(userLoggedIn.isPresent()){
            loginCookie = new Cookie(userLoggedIn.get().getUsername(), userLoggedIn.get().getName());
            loginCookie.setMaxAge(30*60);

            resp.addCookie(loginCookie);

            req.getSession().setAttribute("username", userLoggedIn.get().getUsername());
            req.getSession().setAttribute("name", userLoggedIn.get().getName());
            req.getSession().setAttribute("role", userLoggedIn.get().getRole());
            RequestDispatcher rd = req.getRequestDispatcher("dashboard.jsp");
            rd.forward(req, resp);
        } else {
            RequestDispatcher rd = req.getRequestDispatcher("index.jsp");
            resp.getWriter()
                    .println("<font color=red>Incorrect or missing login details</font>");
            rd.include(req, resp);
        }
    }
}
