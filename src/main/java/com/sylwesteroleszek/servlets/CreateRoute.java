package com.sylwesteroleszek.servlets;

import com.sylwesteroleszek.dao.DocumentDao;
import com.sylwesteroleszek.dao.RouteDao;
import com.sylwesteroleszek.daoImpl.DocumentDaoImpl;
import com.sylwesteroleszek.daoImpl.RouteDaoImpl;
import com.sylwesteroleszek.entity.Document;
import com.sylwesteroleszek.entity.Route;
import com.sylwesteroleszek.entity.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.text.DateFormatter;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet("/CreateRoute")
public class CreateRoute extends HttpServlet {
    RouteDao routeDao = new RouteDaoImpl();
    DocumentDao documentDao = new DocumentDaoImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idString = req.getParameter("documentId");
        String login = req.getParameter("owner");
        String checkingDueDateString = req.getParameter("checkingDueDate");
        String checker = req.getParameter("responsibleForChecking");
        String approver = req.getParameter("responsibleForApproving");
        String deadlineString = req.getParameter("deadline");
        String comments = req.getParameter("description");

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate checkingDueDate = LocalDate.parse(checkingDueDateString, formatter);
        LocalDate deadline = LocalDate.parse(deadlineString, formatter);

        Route route = new Route.Builder()
                .owner(login)
                .state("not started")
                .creationDate(LocalDate.now())
                .finishDate(null)
                .deadline(deadline)
                .documentBeingApprovedId(idString)
                .checkingDueDate(checkingDueDate)
                .responsibleForChecking(checker)
                .responsibleForApproving(approver)
                .comments(comments)
                .build();

        routeDao.SaveOrUpdate(route);

        Long id = Long.parseLong(idString);

        Document document = documentDao.findBy(id);

        req.setAttribute("route", route);
        req.setAttribute("document", document);
        RequestDispatcher rd = req.getRequestDispatcher("route.jsp");
        rd.forward(req, resp);

    }
}
