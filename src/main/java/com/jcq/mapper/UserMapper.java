package com.jcq.mapper;

import java.util.List;

import com.jcq.model.User;
import com.jcq.util.TurnPage;

public interface UserMapper {
	int deleteByPrimaryKey(String id);

	int insert(User record);

	int insertSelective(User record);

	User selectByPrimaryKey(String id);

	int updateByPrimaryKeySelective(User record);

	int updateByPrimaryKey(User record);

	List<Object> queryAll(TurnPage turnPage);

	List<Object> queryFreezed(TurnPage turnPage);

	List<Object> queryUsing(TurnPage turnPage);

	User isLogin(User user);

}