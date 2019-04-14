package com.jcq.service.admin;

import java.util.List;
import java.util.Map;

import com.jcq.model.User;
import com.jcq.util.TurnPage;

public interface AdminOperUserService {
	int addUser(User user);

	int batchUpdate(String[] userid);

	int batchDelete(String[] userid);

	public int batchUing(String[] userid);

	public int batchFreeze(String[] userid);

	// map中放入turnPage和user两个model进行参数传递
	List<Object> queryAll(TurnPage turnPage);

	List<Object> search(Map<String, Object> map);

	User checkDetailById(String userid);

}
