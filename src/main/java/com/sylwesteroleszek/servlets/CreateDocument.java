package com.sylwesteroleszek.servlets;

import com.sylwesteroleszek.dao.DocumentDao;
import com.sylwesteroleszek.entity.Document;
import com.sylwesteroleszek.providers.DaoProvider;
import com.sylwesteroleszek.utils.DataOperations;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/CreateDocument")
@MultipartConfig
public class CreateDocument extends HttpServlet {
    DocumentDao documentDao = DaoProvider.getInstance().getDocumentDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String documentType = req.getParameter("doctype");
        String title = req.getParameter("title");
        String description = req.getParameter("description");
        String owner = (String)req.getSession().getAttribute("login");
        Part filePart = req.getPart("file");
        String path = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        InputStream fileContent = filePart.getInputStream();

        Document document = new Document.Builder()
                .revision(1)
                .type(documentType)
                .title(title)
                .description(description)
                .state("in work")
                .owner(owner)
                .creationDate(LocalDate.now())
                .lastModification(null)
                .link(path)
                .build();

        documentDao.SaveOrUpdate(document);

        List<Document> documents = documentDao.findAll();
        Document savedDocument = documents.get(documents.size() - 1);

        String fileName = savedDocument.getId().toString();

        DataOperations.saveData(documentType, fileContent, fileName);

        req.getSession().setAttribute("document", document);
        RequestDispatcher rd = req.getRequestDispatcher("document.jsp");
        rd.forward(req, resp);
    }
}
