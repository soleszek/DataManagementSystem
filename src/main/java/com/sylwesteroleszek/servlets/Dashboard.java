package com.sylwesteroleszek.servlets;

import com.sylwesteroleszek.Enums.RouteStates;
import com.sylwesteroleszek.Enums.TaskStates;
import com.sylwesteroleszek.dao.DocumentDao;
import com.sylwesteroleszek.dao.RouteDao;
import com.sylwesteroleszek.dao.TaskDao;
import com.sylwesteroleszek.dao.UserDao;
import com.sylwesteroleszek.entity.Route;
import com.sylwesteroleszek.entity.Task;
import com.sylwesteroleszek.providers.DaoProvider;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/Dashboard")
public class Dashboard extends HttpServlet {

    private UserDao userDao = DaoProvider.getInstance().getUserDao();
    private DocumentDao documentDao = DaoProvider.getInstance().getDocumentDao();
    private RouteDao routeDao = DaoProvider.getInstance().getRouteDao();
    private TaskDao taskDao = DaoProvider.getInstance().getTaskDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String login = (String)req.getSession().getAttribute("login");
        String userName = (String)req.getSession().getAttribute("userName");
        String role = (String)req.getSession().getAttribute("role");

        int allDocuments = documentDao.findAll().size();

        List<Route> allRoutes = routeDao.findAll();
        List<Route> activeRoutes = allRoutes.stream()
                .filter(a -> a.getState().equals(RouteStates.CHECKING.getState()) || a.getState().equals(RouteStates.APPROVING.getState()))
                .collect(Collectors.toList());

        List<Task> allTasks = taskDao.findAll();
        List<Task> assignedTasks = allTasks.stream()
                .filter(t -> t.getAssignedTo().equals(login) && t.getState().equals(TaskStates.ACTIVE.getState()))
                .collect(Collectors.toList());

        req.getSession().setAttribute("login", login);
        req.getSession().setAttribute("userName", userName);
        req.getSession().setAttribute("role", role);
        req.setAttribute("allDocuments", allDocuments);
        req.setAttribute("activeRoutes", activeRoutes);
        req.setAttribute("assignedTasks", assignedTasks);
        RequestDispatcher rd = req.getRequestDispatcher("dashboard.jsp");
        rd.forward(req, resp);

    }
}
