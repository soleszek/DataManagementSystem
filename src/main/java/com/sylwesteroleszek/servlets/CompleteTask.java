package com.sylwesteroleszek.servlets;

import com.sylwesteroleszek.Classes.RouteOperations;
import com.sylwesteroleszek.dao.DocumentDao;
import com.sylwesteroleszek.dao.RouteDao;
import com.sylwesteroleszek.dao.TaskDao;
import com.sylwesteroleszek.daoImpl.DocumentDaoImpl;
import com.sylwesteroleszek.daoImpl.RouteDaoImpl;
import com.sylwesteroleszek.daoImpl.TaskDaoImpl;
import com.sylwesteroleszek.entity.Document;
import com.sylwesteroleszek.entity.Route;
import com.sylwesteroleszek.entity.Task;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/CompleteTask")
public class CompleteTask extends HttpServlet {
    private TaskDao taskDao = new TaskDaoImpl();
    private DocumentDao documentDao = new DocumentDaoImpl();
    private RouteDao routeDao = new RouteDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String taskIdString = req.getParameter("taskId");

        Long taskId = Long.parseLong(taskIdString);

        Task task = taskDao.findBy(taskId);

        String routeIdString = task.getParentId();
        Long routeId = Long.parseLong(routeIdString);
        Route route = routeDao.findBy(routeId);

        RouteOperations routeOperations = new RouteOperations(route);

        routeOperations.promoteRoute();

        task.setState("completed");
        taskDao.SaveOrUpdate(task);

        req.setAttribute("task", task);
        RequestDispatcher rd = req.getRequestDispatcher("taskview.jsp");
        rd.forward(req, resp);
    }
}
