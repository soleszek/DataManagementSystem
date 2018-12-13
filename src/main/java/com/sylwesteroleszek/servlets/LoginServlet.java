package com.sylwesteroleszek.servlets;

import com.sylwesteroleszek.dao.UserDao;
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

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String user = req.getParameter("username");
        String password = req.getParameter("password");

        Cookie loginCookie = null;

        UserDao userDao = DaoProvider.getInstance().getUserDao();
        User userLoggedIn;
        userLoggedIn = userDao.findBy(user);

        if(user != null && user.equals(userLoggedIn.getUsername()) && password != null && password.equals(userLoggedIn.getPassword())){
            loginCookie = new Cookie(userLoggedIn.getUsername(), userLoggedIn.getName());
            loginCookie.setMaxAge(30*60);

            resp.addCookie(loginCookie);

            req.getSession().setAttribute("username", userLoggedIn.getUsername());
            req.getSession().setAttribute("name", userLoggedIn.getName());
            RequestDispatcher rd = req.getRequestDispatcher("dashboard.jsp");
            rd.forward(req, resp);
        }




        if(loginCookie == null) {
            RequestDispatcher rd = req.getRequestDispatcher("index.jsp");
            resp.getWriter()
                    .println("<font color=red>Incorrect or missing login details</font>");
            rd.include(req, resp);
        }
    }
}
