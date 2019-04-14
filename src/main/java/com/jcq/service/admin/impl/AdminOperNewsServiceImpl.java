package com.jcq.service.admin.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jcq.model.News;
import com.jcq.service.admin.AdminOperNewsService;
import com.jcq.service.news.NewsService;
import com.jcq.util.TurnPage;

@Service("adminOperNewsService")
public class AdminOperNewsServiceImpl implements AdminOperNewsService {
	@Autowired
	private NewsService newsService;

	@Override
	public String  saveNews(News news ,String path) {
		return newsService.saveNews(news,path);
	}

	@Override
	public List<Object> queryAll(TurnPage turnPage) {
		return newsService.queryAll(turnPage);
	}

	@Override
	public int batchDelete(String[] newsId,String path) {
		return newsService.batchDelete(newsId,path);
	}
/**
 * @param news对象,用来获取context和id
 * @param path,用来获取html的路径,将html用IO流读取到内存当中,传到前台用于富文本编辑器的添加
 * 在前台更改数据之后需要重新添加一个新闻，调用删除方法将该新闻和新闻文档进行删除
 * 1、操作数据库；2、删除文件
 */
	@Override
	public String update(News news, String path) {
		return newsService.getHTML(path, news.getId());
	}
}
