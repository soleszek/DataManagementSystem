package com.sylwesteroleszek.servlets;

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
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/AdvancedSearchRoute")
public class AdvancedSearchRoute extends HttpServlet {
    RouteDao routeDao = DaoProvider.getInstance().getRouteDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = (req.getParameter("name")).trim();
        String owner = (req.getParameter("owner")).trim();
        String promotedDocument = (req.getParameter("promotedDocument")).trim();
        String routeState = req.getParameter("routestate");
        String checkDueDate = req.getParameter("checkDueDate");
        String assignedToCheck = (req.getParameter("assignedToCheck")).trim();
        String approveDueDate = req.getParameter("approveDueDate");
        String assignedToApprove = (req.getParameter("assignedToApprove")).trim();
        String comments = (req.getParameter("comments")).trim();
        String dateOfCreation = req.getParameter("dateOfCreation");
        String finishDate = req.getParameter("finishDate");

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        List<Route> routes = routeDao.findAll();

        List<Route> matchingRoutes = routes.stream()
                .filter(!name.isEmpty() ? e -> e.getName().equals(name) : e -> true)
                .filter(!owner.isEmpty() ? e -> e.getOwner().equals(owner) : e -> true)
                .filter(!promotedDocument.isEmpty() ? e -> e.getDocumentBeingApprovedId().equals(promotedDocument) : e -> true)
                .filter(!routeState.isEmpty() ? e -> e.getState().equals(routeState) : e -> true)
                .filter(!checkDueDate.isEmpty() ? e -> e.getCheckingDueDate().equals(LocalDate.parse(checkDueDate, formatter)) : e -> true)
                .filter(!assignedToCheck.isEmpty() ? e -> e.getResponsibleForChecking().equals(assignedToCheck) : e -> true)
                .filter(!approveDueDate.isEmpty() ? e -> e.getDeadline().equals(LocalDate.parse(approveDueDate, formatter)) : e -> true)
                .filter(!assignedToApprove.isEmpty() ? e -> e.getResponsibleForApproving().equals(assignedToApprove) : e -> true)
                .filter(!comments.isEmpty() ? e -> e.getComments().equals(comments) : e -> true)
                .filter(!dateOfCreation.isEmpty() ? e -> e.getCreationDate().equals(LocalDate.parse(dateOfCreation, formatter)) : e -> true)
                .filter(!finishDate.isEmpty() ? e -> e.getFinishDate().equals(LocalDate.parse(finishDate, formatter)) : e -> true)
                .collect(Collectors.toList());

        req.setAttribute("matchingRoutes", matchingRoutes);
        RequestDispatcher rd = req.getRequestDispatcher("searchresultsroutes.jsp");
        rd.forward(req, resp);
    }
}
