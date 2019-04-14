package com.jcq.interceptor;

import java.lang.reflect.Method;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.jcq.annotation.Token;
 
public class TokenInterceptor extends HandlerInterceptorAdapter {  
    @Override  
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {  
        if (handler instanceof HandlerMethod) {  
            HandlerMethod handlerMethod = (HandlerMethod) handler;  
            Method method = handlerMethod.getMethod();  
            Token annotation = method.getAnnotation(Token.class);  //判断对controller中的方法是否有标注，若存在标注的话则返回那个方法标注时的一个注解属性
            if (annotation != null) {  
                boolean needSaveSession = annotation.save();  
                if (needSaveSession) {  
                	//生成uuid随机token，反射到jsp
                    request.getSession(false).setAttribute("token", UUID.randomUUID().toString()); 
                }
                
                boolean needRemoveSession = annotation.remove();  //saveentity方法触发
                if (needRemoveSession) {
                	
                    if (isRepeatSubmit(request)) {  
                    	System.out.println("重发提交");
                        return false; 
                    }  
                    //防止下一次进入，去掉token，
                    request.getSession(false).removeAttribute("token");  
                }  
                
            }  
            return true;  
        } else {  
            return super.preHandle(request, response, handler);  
        }  
    }  


	/**
	 * 判断是否重复点击
	 * 
	 * @author 李品良 创建时间：2016年9月10日 下午2:26:05
	 * @param request
	 * @return
	 */
	private boolean isRepeatSubmit(HttpServletRequest request) {
		// 那么下一次，这个方法就失败了.
		String serverToken = (String) request.getSession(false).getAttribute("token");
		if (serverToken == null) {
			return true;
		}
		String clinetToken = request.getParameter("token");
		if (clinetToken == null) {
			return true;
		}
		if (!serverToken.equals(clinetToken)) {
			return true;
		}
		return false;
	}

}
