package com.sylwesteroleszek.servlets;

import com.sylwesteroleszek.dao.DocumentDao;
import com.sylwesteroleszek.providers.DaoProvider;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/DeleteDocument")
public class DeleteDocument extends HttpServlet {
    private DocumentDao documentDao = DaoProvider.getInstance().getDocumentDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String documentIdString = req.getParameter("documentId");

        Long documentId = Long.parseLong(documentIdString);

        documentDao.delete(documentId);

        RequestDispatcher rd = req.getRequestDispatcher("AllDocuments");
        rd.forward(req, resp);
    }
}
