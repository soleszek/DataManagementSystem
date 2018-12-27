package com.sylwesteroleszek;

import com.sylwesteroleszek.dao.DocumentDao;
import com.sylwesteroleszek.dao.RouteDao;
import com.sylwesteroleszek.daoImpl.DocumentDaoImpl;
import com.sylwesteroleszek.daoImpl.RouteDaoImpl;
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

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String routeIdString = req.getParameter("routeId");

        Long routeId = Long.parseLong(routeIdString);

        Route route = routeDao.findBy(routeId);

        route.setState("checking");

        routeDao.SaveOrUpdate(route);

        String documentBeingApprovedIdString = route.getDocumentBeingApprovedId();
        Long documentBeingApprovedId = Long.parseLong(documentBeingApprovedIdString);

        Document document = documentDao.findBy(documentBeingApprovedId);

        req.setAttribute("route", route);
        req.setAttribute("document", document);
        RequestDispatcher rd = req.getRequestDispatcher("route.jsp");
        rd.forward(req, resp);
    }
}
