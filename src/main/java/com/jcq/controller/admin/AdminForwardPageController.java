package com.jcq.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jcq.annotation.Token;

@Controller
@RequestMapping("/admin")
public class AdminForwardPageController {
	/**
	 * 以下方法均为负责管理员页面跳转
	 * 
	 * @return
	 */
	// 跳转到管理员界面主页
	@RequestMapping("/index")
	public String index() {
		return "admin/index";
	}

	// 所有账户视图
	@RequestMapping("/accountOfAllList")
	public String accountOfAllList() {
		return "admin/accountOfAllList";
	}

	// 修改密码视图
	@RequestMapping("/updatePassword")
	public String updatePassword() {
		return "admin/updatePassword";
	}

	// 所有冻结账户视图
	@RequestMapping("/accountOfFrozenList")
	public String accountOfFrozenList() {
		return "admin/accountOfFrozenList";
	}

	// 所有已启用账户视图
	@RequestMapping("/accountOfOpenList")
	public String accountOfOpenList() {
		return "admin/accountOfOpenList";
	}

	// 添加用户视图
	@RequestMapping("/createAccount")
	public String createAccount() {
		return "admin/createAccount";
	}

	// 用户详情视图
	@RequestMapping("/accountOfInfo")
	public String accountOfInfo() {
		return "admin/accountOfInfo";
	}

	// 添加新闻视图
	@RequestMapping("/newsCreate")
	public String newsCreate() {
		return "admin/newsCreate";
	}

	// 添加新闻列表视图
	@RequestMapping("/newsList")
	public String newsList() {
		return "admin/newsList";
	}

}
