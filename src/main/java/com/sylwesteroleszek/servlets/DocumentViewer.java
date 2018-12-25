package com.sylwesteroleszek.servlets;

import com.sylwesteroleszek.dao.DocumentDao;
import com.sylwesteroleszek.daoImpl.DocumentDaoImpl;
import com.sylwesteroleszek.entity.Document;
import com.sylwesteroleszek.utils.DataOperations;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.*;
import java.nio.file.Files;

@WebServlet("/DocumentViewer")
public class DocumentViewer extends HttpServlet {

    private DocumentDao documentDao = new DocumentDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idString = req.getParameter("documentId");

        Long id = Long.parseLong(idString);

        Document document = documentDao.findBy(id);

        int idInt = Math.toIntExact(document.getId());

        String fileName = DataOperations.drawingsPath + String.valueOf(idInt);

        File file = new File(fileName);
        resp.setContentType("application/pdf");
        resp.setHeader("Content-Length", String.valueOf(fileName));
        resp.setHeader("Content-Disposition", "inline; filename=\"" + fileName + "\"");
        Files.copy(file.toPath(), resp.getOutputStream());

    }
}
