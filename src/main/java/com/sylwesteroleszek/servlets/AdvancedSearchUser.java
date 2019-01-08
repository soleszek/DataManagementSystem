package com.sylwesteroleszek.servlets;

import com.sylwesteroleszek.dao.UserDao;
import com.sylwesteroleszek.entity.Document;
import com.sylwesteroleszek.entity.User;
import com.sylwesteroleszek.providers.DaoProvider;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/AdvancedSearchUser")
public class AdvancedSearchUser extends HttpServlet {
    UserDao userDao = DaoProvider.getInstance().getUserDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = (req.getParameter("name")).trim();
        String firstName = (req.getParameter("firstName")).trim();
        String lastName = (req.getParameter("lastName")).trim();
        String role = req.getParameter("role");
        String login = (req.getParameter("login")).trim();

        List<User> users = userDao.findAll();

        List<User> matchingUsers = users.stream()
                .filter(!name.isEmpty() ? e -> e.getName().equals(name) : e -> true)
                .filter(!firstName.isEmpty() ? e -> e.getUserName().equals(firstName) : e -> true)
                .filter(!lastName.isEmpty() ? e -> e.getLastName().equals(lastName) : e -> true)
                .filter(!role.isEmpty() ? e -> e.getRole().equals(role) : e -> true)
                .filter(!login.isEmpty() ? e -> e.getLogin().equals(login) : e -> true)
                .collect(Collectors.toList());

        req.setAttribute("matchingUsers", matchingUsers);
        RequestDispatcher rd = req.getRequestDispatcher("searchresultsusers.jsp");
        rd.forward(req, resp);
    }
}
