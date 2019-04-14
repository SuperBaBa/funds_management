package com.jcq.service.news.impl;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jcq.dao.IDaoSupport;
import com.jcq.mapper.NewsMapper;
import com.jcq.model.News;
import com.jcq.service.news.NewsService;
import com.jcq.util.DateFormat;
import com.jcq.util.TurnPage;
import com.jcq.util.UUIDUtil;

@Service
public class NewsServiceImpl implements NewsService {
	@Autowired
	private NewsMapper newsMapper;
	@Autowired
	private IDaoSupport daoNews;
	// 修改新闻
	// public Map<String, Object> update(){
	// return
	// }

	// 存储新闻
	public String saveNews(News news, String path) {
		String fileName = generationHTML(news.getTitle(), news.getContext(), path);
		news.setId(UUIDUtil.getUUID());
		news.setLastUpdateTime(new Date());
		news.setPicture("default.jpg");
		news.setContext(fileName);
		return (newsMapper.insert(news) != 0) ? fileName : null;
	}

	// 查询新闻
	public List<Object> queryAll(TurnPage turnPage) {
		Integer count = (Integer) daoNews.findOne("com.jcq.mapper.NewsMapper.count");
		turnPage.setTotal(count.longValue());
		return newsMapper.queryAll(turnPage);
	}

	// 批量删除新闻
	public int batchDelete(String[] newsId,String path) {
		int i = 0;
		for (String id : newsId) {
			i++;
			new File(path+newsMapper.selectByPrimaryKey(id).getContext()).delete();
			newsMapper.deleteByPrimaryKey(id);
		}
		return i;
	}

	// 根据新闻wangeditor生成响应标题的html
	public String generationHTML(String title, String context, String path) {
		FileWriter fw = null;
		String fileName = DateFormat.msecToDate(new Date()) + ".html";
		try {
			fw = new FileWriter(path + fileName);
			fw.write(context);
			fw.flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				fw.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return fileName;
	}

	public String getHTML(String url, String nId) {
		String html ="";
		String s=null;
		File file=new File(url);
		FileReader in = null;
		BufferedReader fr = null;
		try {
			in = new FileReader(file);
			fr = new BufferedReader(in);
			while ((s=fr.readLine())!=null) {
				html+=s;
			}
		} catch (FileNotFoundException e) {
			System.out.println("文件找不到");
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				in.close();
				fr.close();
				
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
//				file.delete();
			}
		}
		System.out.println(html);
		return html;
	}
}
