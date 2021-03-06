package com.sylwesteroleszek.servlets;

import com.sylwesteroleszek.dao.DocumentDao;
import com.sylwesteroleszek.dao.TaskDao;
import com.sylwesteroleszek.daoImpl.DocumentDaoImpl;
import com.sylwesteroleszek.daoImpl.TaskDaoImpl;
import com.sylwesteroleszek.entity.Document;
import com.sylwesteroleszek.entity.Task;
import com.sylwesteroleszek.entity.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/AllUserTasks")
public class AllUserTasks extends HttpServlet {
    private TaskDao taskDao = new TaskDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String login = (String) req.getSession().getAttribute("login");

        List<Task> tasks = taskDao.findAll();

        List<Task> userTasks = tasks.stream()
                .filter(t -> t.getAssignedTo().equals(login))
                .collect(Collectors.toList());

        req.setAttribute("usertasks", userTasks);
        RequestDispatcher rd = req.getRequestDispatcher("tasks.jsp");
        rd.forward(req, resp);
    }
}
