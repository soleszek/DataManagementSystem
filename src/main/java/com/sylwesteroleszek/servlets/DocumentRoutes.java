package com.sylwesteroleszek.servlets;

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
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@WebServlet("/DocumentRoutes")
public class DocumentRoutes extends HttpServlet {

    private RouteDao routeDao = new RouteDaoImpl();
    private DocumentDao documentDao = new DocumentDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long id = Long.parseLong(req.getParameter("documentId"));

        Document document = documentDao.findBy(id);

        List<Route> routes = routeDao.findAll();

        List<Route> existingRoutes = new ArrayList<>();

        existingRoutes = routes.stream()
                    .filter(r -> r.getDocumentBeingApprovedId().equals(String.valueOf(id)))
                    .collect(Collectors.toList());

        req.getSession().setAttribute("existingRoutes", existingRoutes);
        RequestDispatcher rd = req.getRequestDispatcher("documentview/routes.jsp");
        rd.forward(req, resp);
    }
}
