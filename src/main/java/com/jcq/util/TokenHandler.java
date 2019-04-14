package com.jcq.util;
import java.math.BigInteger;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
 
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
 
import org.apache.log4j.Logger;

public class TokenHandler {
	private static Logger logger = Logger.getLogger(TokenHandler.class);
 
	static Map<String, String> springmvc_token = null;
 
	// 生成一个唯一值的token
	@SuppressWarnings("unchecked")
	public synchronized static String generateGUID(HttpSession session) {
		String token = "";
		try {
			Object obj = session.getAttribute("SPRINGMVC.TOKEN");
			if (obj != null) {
				//如果session中存在token则将其取出
				springmvc_token = (Map<String, String>) session.getAttribute("SPRINGMVC.TOKEN");
			}else {
				//如果session中不存在token则重新实例化一个map作为token
				springmvc_token = new HashMap<String, String>();
			}
			//随机生成一个Sring类型的token的值
			token = new BigInteger(165, new Random()).toString(36).toUpperCase();
			//将token值放入map，确保map的key唯一
			springmvc_token.put(Constants.DEFAULT_TOKEN_NAME + "." + token, token);
			//将token放入session
			session.setAttribute("SPRINGMVC.TOKEN", springmvc_token);
			//常量是不可改变的，这块是不是有问题============================================================打个标记
			Constants.TOKEN_VALUE = token;
			 System.out.println(session.getAttribute("SPRINGMVC.TOKEN"));
		} catch (IllegalStateException e) {
			logger.error("generateGUID() mothod find bug,by token session...");
		}
		return token;
	}
 
	// 验证表单token值和session中的token值是否一致
	@SuppressWarnings("unchecked")
	public static boolean validToken(HttpServletRequest request) {
		String inputToken = getInputToken(request);
		if (inputToken == null) {
			logger.warn("令牌是不是有效的。inputtoken是空的");
			return false;
		}
 
		HttpSession session = request.getSession();
		Map<String, String> tokenMap = (Map<String, String>) session.getAttribute("SPRINGMVC.TOKEN");
		
		if (tokenMap == null || tokenMap.size() < 1) {
			logger.warn("token is not valid!sessionToken is NULL");
			return false;
		}
		//从session中拿出此次请求会话中的令牌
		String sessionToken = tokenMap.get(Constants.DEFAULT_TOKEN_NAME + "." + inputToken);
		if (!inputToken.equals(sessionToken)) {
			logger.warn("token is not valid!inputToken='" + inputToken + "',sessionToken = '" + sessionToken + "'");
			return false;
		}
		tokenMap.remove(Constants.DEFAULT_TOKEN_NAME + "." + inputToken);
		session.setAttribute("SPRINGMVC.TOKEN", tokenMap);
 
		return true;
	}
 
	// 获取表单中token值
	@SuppressWarnings("unchecked")
	public static String getInputToken(HttpServletRequest request) {
		//提交请求中的请求参数和请求参数值的映射关系。这个返回值有个特别之处————只能读
		Map readOnlyMap  = request.getParameterMap();
		System.out.println(request.getSession().getAttribute("SPRINGMVC.TOKEN"));
		//判断表单提交的数据中是否存在一个令牌参数，containKey用于寻找map中是否存在key为springMVC的参数，也就是令牌参数
		if (!readOnlyMap .containsKey(Constants.DEFAULT_TOKEN_NAME)) {
			logger.warn("无法找到令牌名称参数。");
			return null;
		}
		//可能存在多个令牌参数，将其转化为String 数组
		String[] tokens = (String[])  readOnlyMap .get(Constants.DEFAULT_TOKEN_NAME);
		if ((tokens == null) || (tokens.length < 1)) {
			logger.warn("得到空或空的令牌名称。");
			return null;
		}
		String temp = tokens[0];
		String inputtoken = temp.substring(temp.indexOf("=") + 1, (temp.length()) - 1);
		return inputtoken;
	}
}