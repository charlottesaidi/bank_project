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
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "DashboardAjaxServlet", urlPatterns = {"/dashboardAjaxServlet"})
public class DashboardAjaxServlet extends HttpServlet {

    @Override
    public void init() throws ServletException {
        super.init();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect(request.getContextPath()+"/dashboard.jsp");
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
        String account = jsonNode.get("account").asText();
        int newAccount = Integer.parseInt(account);
        var transactions = DaoFactory.getTransactionDao().getAll(newAccount);
        SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
        List< List<Transaction> > transacs = new ArrayList( transactions.stream().collect(
                Collectors.groupingBy(t -> fmt.format(t.getCreated_at()) ) ).values() );
        String formatTransactions = objectMapper.writeValueAsString(transacs);
        response.getWriter().write(formatTransactions);
    }
}
