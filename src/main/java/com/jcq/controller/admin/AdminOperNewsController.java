package com.jcq.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.jcq.model.News;
import com.jcq.service.admin.AdminOperNewsService;
import com.jcq.util.JsonToObject;
import com.jcq.util.TurnPage;

@Controller
@RequestMapping("admin/news")
public class AdminOperNewsController {
	@Autowired
	private AdminOperNewsService service;

	/**
	 * 下列均为管理员页面业务操作方法
	 * 
	 * @param turnpage
	 * @return
	 */

	// 返回rows和page数据，通过json回传数据，查询所有账户
	@RequestMapping("/queryAllList")
	@ResponseBody
	public String queryAllList(TurnPage turnpage) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Object> list = service.queryAll(turnpage);
		map.put("rows", list);
		map.put("total", turnpage.getTotal());
		String param = JSON.toJSONString(map);
		return list.size() != 0 ? JsonToObject.jsonGetProperty(param, "lastUpdateTime", "rows") : "";
	}

	// 添加新闻业务
	@RequestMapping(value="/newsCreate",produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String createNewAccount(News news, HttpServletRequest request) {
		String path = request.getSession().getServletContext().getRealPath("/html/");
		System.out.println(path);
		request.setAttribute("url", service.saveNews(news, path));
		return JSON.toJSONString("添加完成");
	}

	// 通过ID进行批量删除，单个删除也是走这个
	@RequestMapping("/deleteById")
	@ResponseBody
	public String deleteById(@RequestParam(value = "idArray[]") String[] idArray,HttpServletRequest request) {
		String path=request.getSession().getServletContext().getRealPath("/html/");
		return JSON.toJSONString(service.batchDelete(idArray,path));
	}
	@RequestMapping(value="/upateNews")
	@ResponseBody
	public String updateNewsById(News news, HttpServletRequest request,HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("html", service.update(news, request.getSession().getServletContext().getRealPath("/html/")+news.getContext()));
		map.put("title", news.getTitle());
		map.put("newsAbstract", news.getNewsAbstract());
		session.setAttribute("newsMap", map);
		return JSON.toJSONString(map);
	}

}
