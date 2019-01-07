package com.sylwesteroleszek.servlets;

import com.sylwesteroleszek.dao.RouteDao;
import com.sylwesteroleszek.providers.DaoProvider;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/AdvancedSearchRoute")
public class AdvancedSearchRoute extends HttpServlet {
    RouteDao routeDao = DaoProvider.getInstance().getRouteDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String owner = req.getParameter("owner");
        String promotedDocument = req.getParameter("promotedDocument");
        String routeState = req.getParameter("routestate");
        String checkDueDate = req.getParameter("checkDueDate");
        String assignedToCheck = req.getParameter("assignedToCheck");
        String approveDueDate = req.getParameter("approveDueDate");
        String assignedToApprove = req.getParameter("assignedToApprove");
        String comments = req.getParameter("comments");
        String dateOfCreation = req.getParameter("dateOfCreation");
        String finishDate = req.getParameter("finishDate");
    }
}
