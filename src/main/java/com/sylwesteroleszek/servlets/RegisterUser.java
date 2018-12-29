package com.sylwesteroleszek.servlets;

import com.sylwesteroleszek.dao.UserDao;
import com.sylwesteroleszek.entity.User;
import com.sylwesteroleszek.factory.NameFactory;
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
        String userName = req.getParameter("userName");
        String lastName = req.getParameter("lastName");
        String login = req.getParameter("login");
        String password = req.getParameter("password");
        String role = req.getParameter("role");

        List<User> userList =  userDao.findAll();
        boolean isUserExist = false;

        for(User u : userList){
            if(u.getLogin().equals(login)){
                isUserExist = true;

                RequestDispatcher rd = req.getRequestDispatcher("registration.jsp");
                resp.getWriter()
                        .println("<font color=red>User with this username already exists. Choose different username</font>");
                rd.include(req, resp);
            }
        }

        if(isUserExist == false){
            User user = new User.Builder()
                    .name(null)
                    .userName(userName)
                    .lastName(lastName)
                    .login(login)
                    .password(password)
                    .role(role)
                    .build();

            userDao.SaveOrUpdate(user);

            Long userId = userDao.findBy(user.getId()).getId();

            NameFactory nameFactory = new NameFactory();

            String name = nameFactory.createName(userId, "user");

            user.setName(name);

            userDao.SaveOrUpdate(user);

            req.getSession().setAttribute("user", user);

            RequestDispatcher rd = req.getRequestDispatcher("user.jsp");
            rd.forward(req, resp);
        }



    }
}
