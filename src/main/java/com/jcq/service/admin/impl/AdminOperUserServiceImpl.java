package com.jcq.service.admin.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jcq.dao.IDaoSupport;
import com.jcq.mapper.UserMapper;
import com.jcq.model.User;
import com.jcq.service.admin.AdminOperUserService;
import com.jcq.util.GenerateAccountNumber;
import com.jcq.util.MD5Util;
import com.jcq.util.TurnPage;
import com.jcq.util.UUIDUtil;

@Service("adminOperUserService")
public class AdminOperUserServiceImpl implements AdminOperUserService {
	/**
	 * 该方法采用通用dao进行业务逻辑中增删改查的使用 通用dao实际上是使用SqlSessionTemplet模板进行增删改查
	 */
	@Autowired
	private IDaoSupport daoUser;
	@Autowired
	private UserMapper userMapper;

	/*
	 * 开户业务，传入前台所输入的user信息，并将前台不能输入的进行随机生成，且进行验证，保证 账户 、身份证号、电话号在数据库中唯一
	 */
	public int addUser(User user) {
		if (user.getId() == null && user.getAccountNumber() == null) {
			// 随机生成accoun_number、ID ，初始化status 、头像路径
			user.setAccountNumber(GenerateAccountNumber.getAccountNumber());
			user.setId(UUIDUtil.getUUID());
			user.setStatus(0);
			user.setHeadProtrait("defaul.jpg");
			user.setPassword(MD5Util.MD5(user.getPassword()));
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("user", user);
			if (daoUser.findList("com.jcq.mapper.UserMapper.verify", param).size() == 0) {
				return daoUser.save("com.jcq.mapper.UserMapper.insert", user);
			} else {
				System.out.println("错误！！ 数据库存在改用户信息，请保证 账户 、身份证号、电话号唯一");
				return 0;
			}
			// 在数据库中查询 账号、手机号、身份证号 是否唯一，若不唯一则返回0
		} else {
			System.out.println("错误！！ 无法初始化用户信息，请检查数据库");
			return 0;
		}

	}

	public List<Object> search(Map<String, Object> keywords) {
		return daoUser.findList("com.jcq.mapper.UserMapper.search", keywords);
		
	}

	public User checkDetailById(String userid) {
		return userMapper.selectByPrimaryKey(userid);
	}

	public int batchUpdate(String[] userid) {
		return 0;
	}

	public int batchDelete(String[] userid) {
		int i = 0;
		for (String id : userid) {
			i++;
			userMapper.deleteByPrimaryKey(id);
		}
		return i;
	}

	public List<Object> queryAll(TurnPage turnPage) {
		List<Object> param = new ArrayList<Object>();
		if (turnPage.getStatus() == 1) {
			Integer count = (Integer) daoUser.findOne("com.jcq.mapper.UserMapper.countUsing");
			turnPage.setTotal(count.longValue());
			List<Object> list = userMapper.queryUsing(turnPage);
			param = list;
		} else if (turnPage.getStatus() == 0) {
			Integer count = (Integer) daoUser.findOne("com.jcq.mapper.UserMapper.countFreezed");
			turnPage.setTotal(count.longValue());
			List<Object> list = userMapper.queryFreezed(turnPage);
			param = list;
		} else if (turnPage.getStatus() == 2) {
			Integer count = (Integer) daoUser.findOne("com.jcq.mapper.UserMapper.count");
			turnPage.setTotal(count.longValue());
			List<Object> list = userMapper.queryAll(turnPage);
			param = list;
		}
		return param;
	}

	public int batchFreeze(String[] userid) {
		int i = 0;
		for (String id : userid) {
			i++;
			User userFreeze = new User();
			userFreeze.setStatus(0);
			userFreeze.setId(id);
			userMapper.updateByPrimaryKeySelective(userFreeze);
			System.out.println("删了" + id + "这个用户");
		}
		return i;

	}

	public int batchUing(String[] userid) {
		int i = 0;
		for (String id : userid) {
			i++;
			User userFreeze = new User();
			userFreeze.setStatus(1);
			userFreeze.setId(id);
			userMapper.updateByPrimaryKeySelective(userFreeze);
			System.out.println("删了" + id + "这个用户");
		}
		return i;

	}

}
