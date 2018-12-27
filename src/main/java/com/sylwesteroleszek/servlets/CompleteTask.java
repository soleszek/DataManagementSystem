package com.sylwesteroleszek.servlets;

import com.sylwesteroleszek.dao.TaskDao;
import com.sylwesteroleszek.daoImpl.TaskDaoImpl;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/CompleteTask")
public class CompleteTask extends HttpServlet {
    TaskDao taskDao = new TaskDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


        RequestDispatcher rd = req.getRequestDispatcher("taskview.jsp");
        rd.forward(req, resp);
    }
}
