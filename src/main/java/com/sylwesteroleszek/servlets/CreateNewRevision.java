package com.sylwesteroleszek.servlets;

import com.sylwesteroleszek.dao.DocumentDao;
import com.sylwesteroleszek.daoImpl.DocumentDaoImpl;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/CreateNewRevision")
public class CreateNewRevision extends HttpServlet {
    private DocumentDao documentDao = new DocumentDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        RequestDispatcher rd = req.getRequestDispatcher("revisions.jsp");
        rd.forward(req, resp);
    }
}
