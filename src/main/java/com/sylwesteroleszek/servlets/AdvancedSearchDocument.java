package com.sylwesteroleszek.servlets;

import com.sylwesteroleszek.dao.DocumentDao;
import com.sylwesteroleszek.providers.DaoProvider;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/AdvancedSearchDocument")
public class AdvancedSearchDocument extends HttpServlet {
    private DocumentDao documentDao = DaoProvider.getInstance().getDocumentDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String title = req.getParameter("title");
        String docType = req.getParameter("doctype");
        String revision = req.getParameter("revision");
        String docState = req.getParameter("docstate");
        String owner = req.getParameter("owner");
        String creationDate = req.getParameter("creationDate");
        String lastModified = req.getParameter("lastModified");
        String description = req.getParameter("description");
    }
}
