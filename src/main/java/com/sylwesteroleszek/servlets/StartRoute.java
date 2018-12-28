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

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/StartRoute")
public class StartRoute extends HttpServlet {
    private RouteDao routeDao = new RouteDaoImpl();
    private DocumentDao documentDao = new DocumentDaoImpl();
    private TaskDao taskDao = new TaskDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String routeIdString = req.getParameter("routeId");

        Long routeId = Long.parseLong(routeIdString);

        Route route = routeDao.findBy(routeId);

        RouteOperations proceedRoute = new RouteOperations(route);

        Route updatedRoute = proceedRoute.promoteRoute();

       /* route.setState("checking");

        routeDao.SaveOrUpdate(route);

        /*Task task = new Task.Builder()
                .owner(route.getOwner())
                .assignedTo(route.getResponsibleForChecking())
                .documentBeingApprovedId(route.getDocumentBeingApprovedId())
                .state("active")
                .dueDate(route.getCheckingDueDate())
                .completionDate(null)
                .comments("Please check")
                .parentId(String.valueOf(route.getId()))
                .build();

        taskDao.SaveOrUpdate(task);*/

        String documentBeingApprovedIdString = route.getDocumentBeingApprovedId();
        Long documentBeingApprovedId = Long.parseLong(documentBeingApprovedIdString);

        Document document = documentDao.findBy(documentBeingApprovedId);

        req.setAttribute("route", updatedRoute);
        req.setAttribute("document", document);
        RequestDispatcher rd = req.getRequestDispatcher("route.jsp");
        rd.forward(req, resp);
    }
}
