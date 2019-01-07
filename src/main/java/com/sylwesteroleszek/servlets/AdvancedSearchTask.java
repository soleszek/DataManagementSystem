package com.sylwesteroleszek.servlets;

import com.sylwesteroleszek.dao.TaskDao;
import com.sylwesteroleszek.providers.DaoProvider;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/AdvancedSearchTask")
public class AdvancedSearchTask extends HttpServlet {
    TaskDao taskDao = DaoProvider.getInstance().getTaskDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String owner = req.getParameter("owner");
        String promotedDocument = req.getParameter("promotedDocument");
        String state = req.getParameter("state");
        String dueDate = req.getParameter("dueDate");
        String taskComment = req.getParameter("comment");
        String completionDate = req.getParameter("completionDate");
        String yourComment = req.getParameter("yourComment");
    }
}
