package com.jcq.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class SessionInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();

		System.out.println(request.getRequestURI());
		System.out.println(session.getAttribute("admin") + "这是拦截器" + session.getAttribute("user"));
		if (session.getAttribute("admin") != null || session.getAttribute("user") != null) {
			return true;
		} else {
			session.invalidate();
			String path = (request.getRequestURI().indexOf("user") == -1) ? "a_login" : "u_login";
			// 没登录过又不登录login页面,重定向到登录页面
			request.setAttribute("msg", "我是拦截器，你不登录，我拦死你！！");
			request.getRequestDispatcher("/manager/" + path).forward(request, response);
			return false;
		}
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub

	}

}
