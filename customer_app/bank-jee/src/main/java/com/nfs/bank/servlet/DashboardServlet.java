package com.nfs.bank.servlet;

import com.nfs.bank.dao.DaoFactory;
import com.nfs.bank.entity.*;
import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

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
            var user = (User) session.getAttribute("user");
            var customer = (Customer) session.getAttribute("customer");
            var accounts = DaoFactory.getAccountDao().getAll(customer.getId());
            var accounts_courrants = DaoFactory.getAccountDao().getAllCourants(customer.getId());
            var accounts_epargnes = DaoFactory.getAccountDao().getAllEpargnes(customer.getId());
            var transactions = DaoFactory.getTransactionDao().getAll(accounts.get(1).getId());
            SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
            List< List<Transaction> > transacs = new ArrayList( transactions.stream().collect(
                    Collectors.groupingBy( t -> fmt.format(t.getCreated_at()) ) ).values() );
            System.out.println(transacs);
            System.out.println(accounts_courrants);
            session.setAttribute("accounts", accounts);
            session.setAttribute("accounts_courrants", accounts_courrants);
            session.setAttribute("accounts_epargnes", accounts_epargnes);
            session.setAttribute("transacs", transacs);
            session.setAttribute("transactions", transactions);
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