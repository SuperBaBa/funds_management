package com.jcq.controller.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.jcq.annotation.Token;
import com.jcq.model.Admin;
import com.jcq.service.admin.AdminOperAdminService;

@Controller()
@RequestMapping("/admin")
public class AdminOperAdminController {
	@Autowired
	private AdminOperAdminService service;

	@RequestMapping("addAdmin")
	@ResponseBody
	public String addAdmin(Admin admin) {
		return JSON.toJSONString(service.saveAdmin(admin));
	}

	@RequestMapping("/passwordEdit")
	@ResponseBody
	public String passwordEdit(Admin admin, HttpServletRequest request,@Param(value = "newPassword") String newPassword) {
		String loginame= (String) request.getSession().getAttribute("admin");
		admin.setLoginame(loginame);
		return JSON.toJSONString(service.updatePassword(admin,newPassword));
	}
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:../manager/a_login";
	}
}
