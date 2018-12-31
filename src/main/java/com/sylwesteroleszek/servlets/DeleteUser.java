package com.sylwesteroleszek.servlets;

import com.sylwesteroleszek.dao.UserDao;
import com.sylwesteroleszek.providers.DaoProvider;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/DeleteUser")
public class DeleteUser extends HttpServlet {
    private UserDao userDao = DaoProvider.getInstance().getUserDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userIdString = req.getParameter("markedUser");

        Long userId = Long.parseLong(userIdString);

        userDao.delete(userId);

        RequestDispatcher rd = req.getRequestDispatcher("AllUsersShow");
        rd.forward(req, resp);
    }
}
