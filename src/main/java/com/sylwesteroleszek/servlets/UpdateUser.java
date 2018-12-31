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

@WebServlet("/UpdateUser")
public class UpdateUser extends HttpServlet {
    private UserDao userDao = DaoProvider.getInstance().getUserDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userIdString = req.getParameter("userId");
        String userName = req.getParameter("userName");
        String lastName = req.getParameter("lastName");
        String role = req.getParameter("role");
        String login = req.getParameter("login");
        String password = req.getParameter("password");

        Long userId = Long.parseLong(userIdString);
        User user = userDao.findBy(userId);

        user.setUserName(userName);
        user.setLastName(lastName);
        user.setRole(role);
        user.setLogin(login);
        user.setPassword(password);

        userDao.SaveOrUpdate(user);

        req.getSession().setAttribute("user", user);

        RequestDispatcher rd = req.getRequestDispatcher("user.jsp");
        rd.forward(req, resp);
    }
}
