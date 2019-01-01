package com.sylwesteroleszek.servlets;

import com.sylwesteroleszek.dao.RouteDao;
import com.sylwesteroleszek.entity.Route;
import com.sylwesteroleszek.providers.DaoProvider;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/DeleteRoute")
public class DeleteRoute extends HttpServlet {
    private RouteDao routeDao = DaoProvider.getInstance().getRouteDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String routeIdString = req.getParameter("routeId");

        Long routeId = Long.parseLong(routeIdString);

        Route route = routeDao.findBy(routeId);

        String documentIdString = route.getDocumentBeingApprovedId();
        Long documentId = Long.parseLong(documentIdString);

        routeDao.delete(routeId);

        req.setAttribute("documentId", documentId);
        RequestDispatcher rd = req.getRequestDispatcher("DocumentRoutes?documentId=" + documentId);
        rd.forward(req, resp);
    }
}
