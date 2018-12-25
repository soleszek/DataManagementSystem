package com.sylwesteroleszek.servlets;

import com.sylwesteroleszek.dao.DocumentDao;
import com.sylwesteroleszek.dao.RouteDao;
import com.sylwesteroleszek.dao.UserDao;
import com.sylwesteroleszek.daoImpl.DocumentDaoImpl;
import com.sylwesteroleszek.daoImpl.RouteDaoImpl;
import com.sylwesteroleszek.daoImpl.UserDaoImpl;
import com.sylwesteroleszek.entity.Document;
import com.sylwesteroleszek.entity.Route;
import com.sylwesteroleszek.entity.User;

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
    private UserDao userDao = new UserDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long id = Long.parseLong(req.getParameter("documentId"));

        Document document = documentDao.findBy(id);

        List<User> users = userDao.findAll();

        List<User> approvers = users.stream()
                .filter(a -> a.getRole().equals("manager") || a.getRole().equals("admin"))
                .collect(Collectors.toList());

        List<Route> routes = routeDao.findAll();

        List<Route> existingRoutes;

        existingRoutes = routes.stream()
                    .filter(r -> r.getDocumentBeingApprovedId().equals(String.valueOf(id)))
                    .collect(Collectors.toList());

        req.setAttribute("existingRoutes", existingRoutes);
        req.setAttribute("document", document);
        req.setAttribute("approvers", approvers);
        RequestDispatcher rd = req.getRequestDispatcher("documentview/routes.jsp");
        rd.forward(req, resp);
    }
}
