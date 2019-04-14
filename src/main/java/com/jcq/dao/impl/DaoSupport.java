package com.jcq.dao.impl;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jcq.dao.IDaoSupport;

@Repository
public class DaoSupport implements IDaoSupport {
	/*
	 * 通用dao实际上是使用SqlSessionTemplet模板进行增删改查
	 */
	@Autowired
	private SqlSessionTemplate sqlSession;



	public int save(String str, Object t) {
		return sqlSession.insert(str, t);

	}

	public int delete(String str, Object t) {
		return sqlSession.delete(str, t);
	}

	public int update(String str, Object t) {
		return sqlSession.update(str, t);
	}

	public Map<String, Object> findOne(String str, Object t) {
		return sqlSession.selectOne(str, t);
	}

	public List<Object> findList(String str, Map<String, Object> map) {
		return sqlSession.selectList(str, map);
	}

	public  Object findOne(String str) {
		return sqlSession.selectOne(str);
	}

}
