package com.nfs.bank.servlet;

import com.nfs.bank.dao.DaoFactory;
import com.nfs.bank.entity.*;
import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.http.HttpSession;
import javax.servlet.annotation.*;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    @Override
    public void init() throws ServletException {
        super.init();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.removeAttribute("errors");
        response.sendRedirect(request.getContextPath()+"/login.jsp");
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String identifiant = request.getParameter("identifiant");
        String password = request.getParameter("password");
        String[] errors = new String[2];
        if (password.length() == 0 || identifiant.length() == 0)
        {
            if (password.length() == 0) {
                errors[0] = "Veuillez renseigner votre identifiant";
            }
            if (identifiant.length() == 0) {
                errors[1] = "Veuillez renseigner votre mot de passe";
            }
            session.setAttribute("errors", errors);
            response.sendRedirect(request.getContextPath()+"/login.jsp");
        }
        else {
            var user = DaoFactory.getUserDao().checkUser(identifiant, "$2a$12$AIDy2OmHJ6uuSr/lNUn8Re7jGoCDQMNU0PVeRnXqM47siDpwhw/I.");
            if (user.isEmpty())
            {
                errors[0] = "Identifiant ou mot de passe incorrect";
                errors[1] = "Identifiant ou mot de passe incorrect";
                session.setAttribute("errors", errors);
                response.sendRedirect(request.getContextPath()+"/login.jsp");
            }
            else {
                session.setAttribute("user", user);
                response.sendRedirect(request.getContextPath()+"/dashboard");
            }
        }
    }
}