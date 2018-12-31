package com.sylwesteroleszek.servlets;

import com.sylwesteroleszek.dao.DocumentDao;
import com.sylwesteroleszek.daoImpl.DocumentDaoImpl;
import com.sylwesteroleszek.entity.Document;
import com.sylwesteroleszek.providers.DaoProvider;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/UpdateDocument")
public class UpdateDocument extends HttpServlet {
    private DocumentDao documentDao = DaoProvider.getInstance().getDocumentDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String documentIdString = req.getParameter("documentId");
        String title = req.getParameter("title");
        String description = req.getParameter("description");

        Long documentId = Long.parseLong(documentIdString);
        Document document = documentDao.findBy(documentId);
        document.setTitle(title);
        document.setDescription(description);

        documentDao.SaveOrUpdate(document);

        req.getSession().setAttribute("document", document);
        RequestDispatcher rd = req.getRequestDispatcher("document.jsp");
        rd.forward(req, resp);
    }
}
