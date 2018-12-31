package com.sylwesteroleszek.servlets;

import com.sylwesteroleszek.dao.DocumentDao;
import com.sylwesteroleszek.dao.RouteDao;
import com.sylwesteroleszek.entity.Document;
import com.sylwesteroleszek.entity.Route;
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

@WebServlet("/UpdateRoute")
public class UpdateRoute extends HttpServlet {
    private RouteDao routeDao = DaoProvider.getInstance().getRouteDao();
    private DocumentDao documentDao = DaoProvider.getInstance().getDocumentDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String routeIdString = req.getParameter("routeId");
        String checkingDueDateString = req.getParameter("checkingDueDate");
        String responsibleForChecking = req.getParameter("responsibleForChecking");
        String deadlineString = req.getParameter("deadline");
        String responsibleForApproving = req.getParameter("responsibleForApproving");
        String comments = req.getParameter("comments");
        String documentIdString = req.getParameter("documentId");

        Long routeId = Long.parseLong(routeIdString);
        Route route = routeDao.findBy(routeId);

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate checkingDueDate = LocalDate.parse(checkingDueDateString, formatter);
        LocalDate deadline = LocalDate.parse(deadlineString, formatter);

        route.setCheckingDueDate(checkingDueDate);
        route.setResponsibleForChecking(responsibleForChecking);
        route.setDeadline(deadline);
        route.setResponsibleForApproving(responsibleForApproving);
        route.setComments(comments);

        routeDao.SaveOrUpdate(route);

        Long id = Long.parseLong(documentIdString);
        Document document = documentDao.findBy(id);

        req.setAttribute("route", route);
        req.setAttribute("document", document);
        RequestDispatcher rd = req.getRequestDispatcher("route.jsp");
        rd.forward(req, resp);
    }
}
