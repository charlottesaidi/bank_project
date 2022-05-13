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
        request.getSession().setAttribute("test","test");
        request.getSession().setAttribute("array",DaoFactory.getCustomerDao().getAll());
        request.getSession().setAttribute("user",DaoFactory.getCustomerDao().get(4));
        System.out.println(DaoFactory.getCustomerDao().get(4));
//        System.out.println("test");
        response.sendRedirect(request.getContextPath()+"/dashboard.jsp");
    }
}