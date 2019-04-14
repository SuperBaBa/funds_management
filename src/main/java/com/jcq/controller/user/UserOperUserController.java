package com.jcq.controller.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.jcq.annotation.Token;
import com.jcq.model.User;
import com.jcq.service.records.RecordsService;
import com.jcq.service.user.UserOperUserService;
import com.jcq.util.TurnPage;

@Controller()
@RequestMapping("/user")
public class UserOperUserController {
	@Autowired
	private UserOperUserService userService;
	@Autowired 
	private RecordsService recordService;

	// 修改密码
	@RequestMapping("/passwordEdit")
	@ResponseBody
	public String passwordEdit(User user, HttpServletRequest request,
			@Param(value = "newPassword") String newPassword) {
		String userId = (String) request.getSession().getAttribute("userId");
		user.setId(userId);
		return JSON.toJSONString(userService.updatePassword(user, newPassword));
	}

	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:../manager/u_login";
	}

	// 存款、取款、转账
	@RequestMapping("/fundsOperation")
	@Token(remove=true)
	@ResponseBody
	public String fundsOperation(User user, HttpServletRequest request, @Param(value = "operation") String operation) {
		String userId = (String) request.getSession().getAttribute("userId");
		user.setId(userId);
		return JSON.toJSONString(userService.operation(user, operation));
	}

	// 查看交易记录
	@RequestMapping("/showDealRecord")
	@ResponseBody
	public String showDealRecord(User user, HttpServletRequest request, TurnPage turnpage) {
		Map<String, Object> map = new HashMap<>();
		map.put("row", turnpage.getRows());
		map.put("startNum", turnpage.getStartNum());
		map.put("id", request.getSession().getAttribute("userId"));
		map.put("rows", recordService.showRecords(map));
		map.put("total", recordService.recordsCount(map));
		return JSON.toJSONString(map);
	}
}
