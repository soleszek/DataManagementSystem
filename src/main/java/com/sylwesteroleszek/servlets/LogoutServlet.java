package com.sylwesteroleszek.servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String login = (String)req.getSession().getAttribute("login");
        Cookie[] cookies = req.getCookies();

        if(cookies != null){
            for(Cookie cookie : cookies){
                if(cookie.getName().equals(login)){
                    Cookie loginCookie = cookie;
                    loginCookie.setMaxAge(0);
                    req.getSession().invalidate();

                    resp.addCookie(loginCookie);
                    resp.sendRedirect("index.jsp");
                }
            }
        }

        if(login == null || cookies == null) {
            resp.sendRedirect("index.jsp");
        }

    }

}
