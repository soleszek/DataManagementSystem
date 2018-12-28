package com.sylwesteroleszek.servlets;

import com.sylwesteroleszek.dao.UserDao;
import com.sylwesteroleszek.entity.User;
import com.sylwesteroleszek.factory.TaskFactory;
import com.sylwesteroleszek.providers.DaoProvider;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/RegisterUser")
public class RegisterUser extends HttpServlet {

TaskFactory dmsObject = new TaskFactory();
UserDao userDao = DaoProvider.getInstance().getUserDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String lastName = req.getParameter("lastname");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String role = req.getParameter("role");

        List<User> userList =  userDao.findAll();
        boolean isUserExist = false;

        for(User u : userList){
            if(u.getUsername().equals(username)){
                isUserExist = true;

                RequestDispatcher rd = req.getRequestDispatcher("registration.jsp");
                resp.getWriter()
                        .println("<font color=red>User with this username already exists. Choose different username</font>");
                rd.include(req, resp);
            }
        }

        if(isUserExist == false){
            User user = new User.Builder()
                    .name(name)
                    .lastName(lastName)
                    .username(username)
                    .password(password)
                    .role(role)
                    .build();

            userDao.SaveOrUpdate(user);

            req.getSession().setAttribute("user", user);

            RequestDispatcher rd = req.getRequestDispatcher("user.jsp");
            rd.forward(req, resp);
        }



    }
}
