package com.nfs.bank.servlet.filter;

import javax.servlet.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebFilter(filterName = "CountFilter", urlPatterns = {"/dashboard.jsp"})
public class LoginFilter implements Filter {
    public void init(FilterConfig config) throws ServletException {
    }

    public void destroy() {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
        var user = ((HttpServletRequest) request).getSession().getAttribute("user");
        if (user == null) {
            System.out.println("no user");
            ((HttpServletResponse) response).sendRedirect(((HttpServletRequest) request).getContextPath()+"/login.jsp");
        }
        System.out.println("je filtre");
        chain.doFilter(request, response);
    }
}
