package com.sylwesteroleszek.servlets;

import com.sylwesteroleszek.dao.DocumentDao;
import com.sylwesteroleszek.daoImpl.DocumentDaoImpl;
import com.sylwesteroleszek.entity.Document;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/CreateNewRevision")
public class CreateNewRevision extends HttpServlet {
    private DocumentDao documentDao = new DocumentDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String documentIdString = req.getParameter("documentId");
        String login = (String)req.getSession().getAttribute("login");
        Long documentId = Long.parseLong(documentIdString);
        Document document = documentDao.findBy(documentId);
        String name = document.getName();

        List<Document> documents = documentDao.findAll();

        List<Document> documentRevisions = documents.stream()
                .filter(dR -> dR.getName().equals(name))
                .collect(Collectors.toList());

        Long lastRevisionId = documentRevisions.get(documentRevisions.size() - 1).getId();
        int lastRevisionNumber = documentDao.findBy(lastRevisionId).getRevision();

        if(documentDao.findBy(lastRevisionId).getState().equals("released")) {

            Document newRevision = new Document.Builder()
                    .name(document.getName())
                    .revision(lastRevisionNumber + 1)
                    .type(document.getType())
                    .title(document.getTitle())
                    .description("")
                    .state("in work")
                    .owner(login)
                    .creationDate(LocalDate.now())
                    .lastModification(null)
                    .link("")
                    .build();

            documentDao.SaveOrUpdate(newRevision);

            String message = "";

            req.setAttribute("documentId", documentIdString);
            RequestDispatcher rd = req.getRequestDispatcher("DocumentRevisions");
            rd.forward(req, resp);
        } else {
            String message = "<font color=red>You can create new revision only from released documents</font>";
            req.getSession().setAttribute("message", message);
            RequestDispatcher rd = req.getRequestDispatcher("CantCreateRevision");
            /*resp.getWriter()
                    .println("<font color=red>You can create new revision only from released documents</font>");*/
            rd.forward(req, resp);
        }
    }
}
