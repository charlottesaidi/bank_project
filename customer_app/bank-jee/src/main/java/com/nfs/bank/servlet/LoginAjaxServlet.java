package com.nfs.bank.servlet;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
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

@WebServlet(name = "LoginAjaxServlet", urlPatterns = {"/loginAjaxServlet"})
public class LoginAjaxServlet extends HttpServlet {

    @Override
    public void init() throws ServletException {
        super.init();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect(request.getContextPath()+"/login.jsp");
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        var session = request.getSession();
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        String body = request.getReader().lines()
                .reduce("", (accumulator, actual) -> accumulator + actual);
        ObjectMapper objectMapper = new ObjectMapper();
        JsonNode jsonNode = objectMapper.readTree(body);
        String identifiant = jsonNode.get("identifiant").asText();
        String password = jsonNode.get("password").asText();
        var user = DaoFactory.getUserDao().checkUser(identifiant, "$2a$12$WUVW18N9N8kWpJ0JSVKjDelBU3F6OgEyNvuDnAcKBTUvrEW.LRK/.");
        if (!user.isEmpty()) {
            var customer = DaoFactory.getCustomerDao().findById(user.get(0).getId());
            session.setAttribute("user", user.get(0));
            session.setAttribute("customer", customer.get(0));
        }
        else {
            response.getWriter().write("Identifiant ou mot de passe incorrect");
        }
    }
}
