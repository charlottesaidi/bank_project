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
            List< List<Account> > accs = new ArrayList( accounts.stream().collect(
                    Collectors.groupingBy( a -> a.getAccount_type() ) ).values() );
            var transactions = DaoFactory.getTransactionDao().getAll(accounts.get(0).getId());
            SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
            List< List<Transaction> > transacs = new ArrayList( transactions.stream().collect(
                    Collectors.groupingBy( t -> fmt.format(t.getCreated_at()) ) ).values() );
            System.out.println(accounts.get(0).getAccount_type().getName());
            System.out.println(transacs);
            session.setAttribute("accounts", accounts);
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