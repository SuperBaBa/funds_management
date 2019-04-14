package com.jcq.service.admin;

import java.util.List;


import com.jcq.model.News;
import com.jcq.util.TurnPage;

public interface AdminOperNewsService {
	public int batchDelete(String[] newsId,String path);

	public String saveNews(News news, String path);

	public List<Object> queryAll(TurnPage turnPage);

	public String update(News news, String path);
}
