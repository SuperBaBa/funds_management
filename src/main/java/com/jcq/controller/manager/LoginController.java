package com.jcq.controller.manager;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.jcq.model.Admin;
import com.jcq.model.User;
import com.jcq.service.admin.AdminOperAdminService;
import com.jcq.service.user.UserOperUserService;

@Controller
@RequestMapping("manager")
public class LoginController {
	@Autowired
	private AdminOperAdminService adminService;
	@Autowired
	private UserOperUserService userService;

	@RequestMapping(value = "/u_login")
	public String toUserLogin() {
		return "manager/userLogin";
	}

	@RequestMapping(value = "/a_login")
	public String toAdminLogin() {
		return "manager/adminLogin";
	}

	@RequestMapping(value = "/alogin", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String adminLogin(Admin admin, HttpSession session){
		System.out.println(admin.getLoginame() + "这里是控制器");
		int i=adminService.isLogin(admin);
		// 由于重点在SpringMVC,此处模拟从数据库取出数据进行表单验证
		if (i==1) {
			session.setAttribute("admin", admin.getLoginame());
			// 进入登录主页
			return JSON.toJSONString(1);
		} else if(i==2){
			//首次登陆修改密码
			session.setAttribute("admin", admin.getLoginame());
			return JSON.toJSONString(2);
		}else {
			// 返回到登录页面
			return JSON.toJSONString("用户名密码错误，请重新输入");
		}
	}

	@RequestMapping(value = "/ulogin")
	@ResponseBody
	public String userLogin(User user, HttpSession session) {
		System.out.println(user.getPhoneNumber()+ "这里是控制器");
		User u=userService.isLogin(user);
		int i=0;
		if (u!=null) {
			session.setAttribute("user", u.getName());
			session.setAttribute("userId", u.getId());
			//判断冻结状态 1进入主页 2冻结状态
			i=(u.getStatus()==1)?1:2;
		}
		// 返回到登录错误状态码
		return JSON.toJSONString(i);
	}
}
