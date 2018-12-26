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

@WebServlet("/OpenRoute")
public class OpenRoute extends HttpServlet {
    private RouteDao routeDao = new RouteDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idRouteString = req.getParameter("routeId");

        Long idRoute = Long.parseLong(idRouteString);

        Route route = routeDao.findBy(idRoute);

        req.getSession().setAttribute("route", route);
        RequestDispatcher rd = req.getRequestDispatcher("route.jsp");
        rd.forward(req, resp);
    }
}
