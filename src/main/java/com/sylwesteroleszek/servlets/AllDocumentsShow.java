package com.sylwesteroleszek.servlets;

import com.sylwesteroleszek.dao.DocumentDao;
import com.sylwesteroleszek.entity.Document;
import com.sylwesteroleszek.providers.DaoProvider;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/AllDocuments")
public class AllDocumentsShow extends HttpServlet {
    DocumentDao documentDao = DaoProvider.getInstance().getDocumentDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Document> documents = documentDao.findAll();

        req.setAttribute("documents", documents);
        RequestDispatcher rd = req.getRequestDispatcher("documents.jsp");
        rd.forward(req, resp);
    }
}
