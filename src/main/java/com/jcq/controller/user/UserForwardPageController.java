package com.jcq.controller.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jcq.annotation.Token;

@Controller
@RequestMapping("/user")
public class UserForwardPageController {
	/**
	 * 以下方法均为负责管理员页面跳转
	 * 
	 * @return
	 */
	// 跳转到管理员界面主页
	@RequestMapping("/index")
	public String index() {
		return "user/index";
	}

	// 查看交易记录视图
	@RequestMapping("/lookDealRecord")
	public String lookDealRecord() {
		return "user/lookDealRecord";
	}

	// 修改密码视图
	@RequestMapping("/updatePassword")
	public String updatePassword() {
		return "user/updatePassword";
	}

	// 存款视图
	@RequestMapping("/deposit")
	@Token(save=true)
	public String deposit() {
		return "user/deposit";
	}

	// 取款视图
	@RequestMapping("/withdrawa")
	@Token(save=true)
	public String withdrawa() {
		return "user/withdrawa";
	}
	// 转账视图
	@RequestMapping("/transfer")
	@Token(save=true)
	public String transfer() {
		return "user/transfer";
	}

	// 查看个人信息视图
	@RequestMapping("/lookInfo")
	public String lookInfo() {
		return "user/lookInfo";
	}

	// 修改个人信息视图
	@RequestMapping("/updateInfo")
	public String updateInfo() {
		return "user/updateInfo";
	}
	// 跳转到管理员界面主页
	@RequestMapping("/userNewsList")
		public String userNewsList() {
			return "user/userNewsList";
	}
}
