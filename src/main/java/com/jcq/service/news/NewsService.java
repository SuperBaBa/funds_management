package com.jcq.service.news;

import java.util.List;

import com.jcq.model.News;
import com.jcq.util.TurnPage;

public interface NewsService {
	public int batchDelete(String[] newsId,String path);

	public String saveNews(News news, String path);

	public List<Object> queryAll(TurnPage turnPage);

	public String generationHTML(String title, String context, String path);

	public String getHTML(String url,String nId);
}
