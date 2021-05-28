package com.spz.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
//@WebFilter({"/jsp/admin/*","jsp/student/*","/jsp/manager/*"})
public class myFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("过滤器初始化完成");
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        Boolean flag=false;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        Object student = request.getSession().getAttribute("studentnum");
        Object student1 = request.getSession().getAttribute("username");
        if (student!=null||student1!=null){
            flag=true;
        }
        if (!flag){
            request.getSession().setAttribute("msg","你尚未登录，请返回登录");
            request.getSession().setAttribute("url","/jsp/login.jsp");
            response.sendRedirect("/jsp/error.jsp");
        }else {
            filterChain.doFilter(servletRequest,servletResponse);
        }
    }

    @Override
    public void destroy() {

    }
}
