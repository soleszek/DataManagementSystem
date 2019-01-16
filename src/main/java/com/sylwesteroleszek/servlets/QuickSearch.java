package com.sylwesteroleszek.servlets;

import com.sylwesteroleszek.dao.DocumentDao;
import com.sylwesteroleszek.dao.RouteDao;
import com.sylwesteroleszek.dao.TaskDao;
import com.sylwesteroleszek.dao.UserDao;
import com.sylwesteroleszek.entity.Document;
import com.sylwesteroleszek.entity.Route;
import com.sylwesteroleszek.entity.Task;
import com.sylwesteroleszek.entity.User;
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

@WebServlet("/QuickSearch")
public class QuickSearch extends HttpServlet {
    private DocumentDao documentDao = DaoProvider.getInstance().getDocumentDao();
    private RouteDao routeDao = DaoProvider.getInstance().getRouteDao();
    private TaskDao taskDao = DaoProvider.getInstance().getTaskDao();
    private UserDao userDao = DaoProvider.getInstance().getUserDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String phrase = (String)req.getParameter("phrase");

        List<Document> documents = documentDao.findAll();
        List<Route> routes = routeDao.findAll();
        List<Task> tasks = taskDao.findAll();
        List<User> users = userDao.findAll();

        List<Document> matchingDocuments = documents.stream()
                .filter(d ->
                        d.getName().equals(phrase) ||
                        d.getType().equals(phrase) ||
                        d.getTitle().equals(phrase) ||
                        d.getDescription().equals(phrase) ||
                        d.getState().equals(phrase) ||
                        d.getOwner().equals(phrase))
                .collect(Collectors.toList());

        req.setAttribute("matchingDocuments", matchingDocuments);
        RequestDispatcher rd = req.getRequestDispatcher("quicksearch.jsp");
        rd.forward(req, resp);
    }
}
