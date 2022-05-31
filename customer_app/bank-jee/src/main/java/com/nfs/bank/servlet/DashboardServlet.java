package com.nfs.bank.servlet;

import com.nfs.bank.dao.DaoFactory;
import com.nfs.bank.entity.*;
import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "DashboardServlet", urlPatterns = {"/dashboard"})
public class DashboardServlet extends HttpServlet {

    @Override
    public void init() throws ServletException {
        super.init();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession().getAttribute("user") != null) {
            var session = request.getSession();
            var user = session.getAttribute("user");
            var accounts = DaoFactory.getAccountDao().getAll(4);
            var transactions = DaoFactory.getTransactionDao().getAll(1);
            session.setAttribute("accounts", accounts);
            session.setAttribute("transactions", transactions);
            System.out.println(accounts);
            response.sendRedirect(request.getContextPath()+"/dashboard.jsp");
        }
        else {
            response.sendRedirect(request.getContextPath()+"/login.jsp");
        }

    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect(request.getContextPath()+"/dashboard.jsp");
    }
}