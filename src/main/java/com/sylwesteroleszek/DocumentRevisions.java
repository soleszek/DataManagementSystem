package com.sylwesteroleszek;

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
import java.util.stream.Collectors;

@WebServlet("/DocumentRevisions")
public class DocumentRevisions extends HttpServlet {

    private DocumentDao documentDao = DaoProvider.getInstance().getDocumentDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String documentIdString = req.getParameter("documentId");

        Long documentId = Long.parseLong(documentIdString);
        Document document = documentDao.findBy(documentId);
        String name = document.getName();

        List<Document> documents = documentDao.findAll();



        List<Document> documentRevisions = documents.stream()
                .filter(dR -> dR.getName().equals(name))
                .collect(Collectors.toList());

        req.setAttribute("documentRevisions", documentRevisions);
        RequestDispatcher rd = req.getRequestDispatcher("documentview/revisions.jsp");
        rd.forward(req, resp);
    }
}
