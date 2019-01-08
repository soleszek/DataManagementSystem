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
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/AdvancedSearchDocument")
public class AdvancedSearchDocument extends HttpServlet {
    private DocumentDao documentDao = DaoProvider.getInstance().getDocumentDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = (req.getParameter("name")).trim();
        String title = (req.getParameter("title")).trim();
        String docType = req.getParameter("doctypeinput");
        String revisionString = (req.getParameter("revision")).trim();
        String docState = req.getParameter("docstateinput");
        String owner = (req.getParameter("owner")).trim();
        String creationDateString = req.getParameter("creationDate");
        String lastModifiedString = req.getParameter("lastModified");
        String description = (req.getParameter("description")).trim();

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        List<Document> documents = documentDao.findAll();

        List<Document> matchingDocuments = documents.stream()
                .filter(!name.isEmpty() ? e -> e.getName().equals(name) : e -> true)
                .filter(!title.isEmpty() ? e -> e.getTitle().equals(title) : e -> true)
                .filter(!docType.isEmpty() ? e -> e.getType().equals(docType) : e -> true)
                .filter(!revisionString.isEmpty() ? e -> e.getRevision() == Integer.valueOf(revisionString) : e -> true)
                .filter(!docState.isEmpty() ? e -> e.getState().equals(docState) : e -> true)
                .filter(!owner.isEmpty() ? e -> e.getOwner().equals(owner) : e -> true)
                .filter(!creationDateString.isEmpty() ? e -> e.getCreationDate().equals(LocalDate.parse(creationDateString, formatter)) : e -> true)
                .filter(!lastModifiedString.isEmpty() ? e -> e.getLastModification().equals(LocalDate.parse(lastModifiedString, formatter)) : e -> true)
                .filter(!description.isEmpty() ? e -> e.getDescription().equals(description) : e -> true)
                .collect(Collectors.toList());

        req.setAttribute("matchingDocuments", matchingDocuments);
        RequestDispatcher rd = req.getRequestDispatcher("quicksearch.jsp");
        rd.forward(req, resp);
    }
}
