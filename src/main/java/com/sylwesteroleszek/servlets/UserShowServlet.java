package com.sylwesteroleszek.servlets;

import com.sylwesteroleszek.dao.UserDao;
import com.sylwesteroleszek.entity.User;
import com.sylwesteroleszek.providers.DaoProvider;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/UserShow")
public class UserShowServlet extends HttpServlet {
    UserDao userDao = DaoProvider.getInstance().getUserDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = (String)req.getSession().getAttribute("username");

        User user = userDao.findBy(username);

        req.getSession().setAttribute("user", user);
        RequestDispatcher rd = req.getRequestDispatcher("user.jsp");
        rd.forward(req, resp);
    }
}
