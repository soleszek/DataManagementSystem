package com.sylwesteroleszek.servlets;

import com.sylwesteroleszek.dao.TaskDao;
import com.sylwesteroleszek.entity.Document;
import com.sylwesteroleszek.entity.Task;
import com.sylwesteroleszek.providers.DaoProvider;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/AdvancedSearchTask")
public class AdvancedSearchTask extends HttpServlet {
    TaskDao taskDao = DaoProvider.getInstance().getTaskDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = (req.getParameter("name")).trim();
        String owner = (req.getParameter("owner")).trim();
        String promotedDocument = (req.getParameter("promotedDocument")).trim();
        String state = req.getParameter("state");
        String dueDate = req.getParameter("dueDate");
        String taskComment = (req.getParameter("comment")).trim();
        String completionDate = req.getParameter("completionDate");

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        List<Task> tasks = taskDao.findAll();

        List<Task> matchingTasks = tasks.stream()
                .filter(!name.isEmpty() ? e -> e.getName().equals(name) : e -> true)
                .filter(!promotedDocument.isEmpty() ? e -> e.getDocumentBeingApprovedId().equals(promotedDocument) : e -> true)
                .filter(!state.isEmpty() ? e -> e.getState().equals(state) : e -> true)
                .filter(!owner.isEmpty() ? e -> e.getOwner().equals(owner) : e -> true)
                .filter(!dueDate.isEmpty() ? e -> e.getDueDate().equals(LocalDate.parse(dueDate, formatter)) : e -> true)
                .filter(!completionDate.isEmpty() ? e -> e.getCompletionDate().equals(LocalDate.parse(completionDate, formatter)) : e -> true)
                .filter(!taskComment.isEmpty() ? e -> e.getComments().equals(taskComment) : e -> true)
                .collect(Collectors.toList());

        req.setAttribute("matchingTasks", matchingTasks);
        RequestDispatcher rd = req.getRequestDispatcher("searchresultstasks.jsp");
        rd.forward(req, resp);
    }
}
