package com.jcq.mapper;

import com.jcq.model.Admin;

public interface AdminMapper {
	int deleteByPrimaryKey(String id);

	int insert(Admin record);

	int insertSelective(Admin record);

	Admin selectByPrimaryKey(String id);

	int updateByPrimaryKeySelective(Admin record);

	int updateByPrimaryKey(Admin record);

	Admin selectByLoginame(String loginame);
}