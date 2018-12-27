package com.sylwesteroleszek.servlets;

import com.sylwesteroleszek.dao.RouteDao;
import com.sylwesteroleszek.daoImpl.RouteDaoImpl;
import com.sylwesteroleszek.entity.Route;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/ShowAllRoutes")
public class ShowAllRoutes extends HttpServlet {
    private RouteDao routeDao = new RouteDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Route> routes = routeDao.findAll();

        req.setAttribute("routes", routes);
        RequestDispatcher rd = req.getRequestDispatcher("routeslist.jsp");
        rd.forward(req, resp);
    }
}
