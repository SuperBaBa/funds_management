package com.jcq.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.jcq.model.User;
import com.jcq.service.admin.AdminOperUserService;
import com.jcq.util.TurnPage;

@Controller
@RequestMapping("/admin")
public class AdminOperUserController {
	@Autowired
	private AdminOperUserService service;

	/**
	 * 下列均为管理员页面业务操作方法
	 * 
	 * @param turnpage
	 * @return
	 */

	/*
	 * 返回rows、status和page数据，通过json回传数据，查询所有账户 0=冻结账户 1=启用账户 2=所有账户
	 */
	@RequestMapping(value="/queryAllList", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String queryAllList(TurnPage turnpage, @Param(value="search")String search,User user) {
		if(search==null) {
			Map<String, Object> map = new HashMap<String, Object>();
			List<Object> list = service.queryAll(turnpage);
			map.put("rows", list);
			map.put("page", turnpage);
			map.put("total", turnpage.getTotal());
			String param = JSON.toJSONString(map);
			return list.size() != 0 ? param : "<script type=\"text/javascript\">window.location.reload();</script>";
		}else {
			Map<String, Object> map = new HashMap<String, Object>();
			if (user.getName() != null) {
				map.put("name", user.getName());
			} else if(user.getPhoneNumber()!=null){
				map.put("phoneNumber", user.getPhoneNumber());
			}
			List<Object> list = service.search(map);
			map.put("rows", list);
			map.put("total", list.size());
			return  JSON.toJSONString(map) ;
		}
	}

	// 添加用户业务
	@RequestMapping(value = "/createNewAccount", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String createNewAccount(User user) {
		int i = (service.addUser(user) != 0) ? 1 : 0;
		return JSON.toJSONString(i);
	}

	// 通过ID进行批量删除，单个删除也是走这个
	@RequestMapping("/deleteById")
	@ResponseBody
	public String deleteById(@RequestParam(value = "idArray[]") String[] idArray) {
		service.batchDelete(idArray);
		return JSON.toJSONString("删完了");
	}

	// 通过ID进行批量删除，单个冻结也是走这个
	@RequestMapping("/freezeById")
	@ResponseBody
	public String freezeById(@RequestParam(value = "idArray[]") String[] idArray) {
		return JSON.toJSONString(service.batchFreeze(idArray));
	}

	// 通过ID进行批量删除，单个启用也是走这个
	@RequestMapping("/usingById")
	@ResponseBody
	public String usingById(@RequestParam(value = "idArray[]") String[] idArray) {
		return JSON.toJSONString(service.batchUing(idArray));
	}

	// 获取用户详情
	@RequestMapping("/getInfoById")
	@ResponseBody
	public String getInfoById(@RequestParam(value = "id") String id) {
		User u = service.checkDetailById(id);
		String msg = "{\"rows\":[{\"name\":\"姓名：\",\"value\":\"" + u.getName() + "\"},{\"name\":\"地址：\",\"value\":\""
				+ u.getAddress() + "\"},{\"name\":\"电话：\",\"value\":\"" + u.getPhoneNumber()
				+ "\"},{\"name\":\"Email\",\"value\":\"" + u.getEmail() + "\"}]}";
		return msg;
	}

	@RequestMapping(value="/search", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String search(User user) {
		return "";
	}
}
