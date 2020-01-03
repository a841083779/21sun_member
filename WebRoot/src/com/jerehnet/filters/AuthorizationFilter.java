package com.jerehnet.filters;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AuthorizationFilter implements Filter {

	private String errorURL;

	public void init(FilterConfig filterConfig) throws ServletException {
		errorURL = filterConfig.getInitParameter("nologin");
	}

	/**
	 * 认证过滤
	 */
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException 
		{
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		HttpSession session = req.getSession();
		boolean isLogon = false;
		HashMap memberInfo = (HashMap)session.getAttribute("memberInfo");
//		System.out.println("---:"+memberInfo);
		String goRUL = errorURL;
		if(!"".equals(req.getQueryString())){
			goRUL += "?"+req.getQueryString();
		}
		if (memberInfo != null) 
		{
			chain.doFilter(request, response);
		} else {
			res.sendRedirect(goRUL);
		}
	}

	public void destroy() {
	}
}
