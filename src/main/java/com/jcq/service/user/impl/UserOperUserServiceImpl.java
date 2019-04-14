package com.jcq.service.user.impl;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jcq.dao.IDaoSupport;
import com.jcq.mapper.UserMapper;
import com.jcq.model.Records;
import com.jcq.model.User;
import com.jcq.service.records.RecordsService;
import com.jcq.service.user.UserOperUserService;
import com.jcq.util.MD5Util;

@Service("userOperUserService")
public class UserOperUserServiceImpl implements UserOperUserService {
	@Autowired
	private UserMapper userMapper;
	@Autowired
	private IDaoSupport daoUser;
	@Autowired
	private RecordsService recordsService;

	@Override
	public int saveUser(User user) {
		return 0;
	}

	@Override
	public int checkLoginame(User user) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public User isLogin(User user) {
		/*
		 * 验证密码和状态 0 账号密码错误 2冻结状态 1可以登录
		 */
		User userFormDB = userMapper.isLogin(user);
		// 验证密码
		if (userFormDB != null && MD5Util.MD5(user.getPassword()).equals(userFormDB.getPassword())) {
			// 是否已启用
			if (userFormDB.getStatus() == 1) {
				return userFormDB;
			} else {
				return userFormDB;
			}
		}
		return null;
	}

	@Override
	public int updatePassword(User user, String newPassword) {
		if (isLogin(user) != null) {
			user.setPassword(MD5Util.MD5(newPassword));
			return userMapper.updateByPrimaryKeySelective(user);
		}
		;
		return 0;
	}

	/*
	 * 1存款2取款3转账 接收到的user除了id或者balance以外全是交易对象的信息,user只是负责传递数据 11存款成功
	 * 10存款失败（比如数据库链接断了） 21取款成功 20余额不足 31转账成功 30转账失败 301转账对象信息不匹配 302余额不足 303为完成事务
	 */
	@Override
	public int operation(User user, String operation) {
		User userFormDB = userMapper.selectByPrimaryKey(user.getId());
		int i = 0;

		int operCode = Integer.parseInt(operation);
		if (operCode == 1) {
			i = deposit(userFormDB, user);
		} else if (operCode == 2) {
			i = withdrawa(userFormDB, user);
		} else if (operCode == 3) {
			i = transfer(userFormDB, user);
		}
		return i;
	}

	// 存款
	private int deposit(User userFormDB, User userFormModel) {
		userFormDB.setBalance(userFormDB.getBalance() + userFormModel.getBalance());
		// 进行本次操作的记录
		return (userMapper.updateByPrimaryKeySelective(userFormDB) != 0
				&& doRecord(userFormDB.getId(), userFormDB.getAccountNumber(), "1", userFormModel.getBalance()) != 0)
						? 11
						: 10;
	}

	// 取款
	private int withdrawa(User userFormDB, User userFormModel) {
		int i = 20;
		if (userFormDB.getBalance() >= userFormModel.getBalance()) {
			// 进行本次操作的记录
			userFormDB.setBalance(userFormDB.getBalance() - userFormModel.getBalance());
			i = (userMapper.updateByPrimaryKeySelective(userFormDB) != 0 && doRecord(userFormDB.getId(),
					userFormDB.getAccountNumber(), "2", userFormModel.getBalance()) != 0) ? 21 : 20;
		}
		return i; 
	}

	// 转账
	private int transfer(User userFormDB, User userFormModel) {
		int i;
		userFormModel.setId(null);
		User userObject = userMapper.isLogin(userFormModel);
		if (userFormDB.getBalance() >= userFormModel.getBalance()) {
			if (userFormModel.getName() != null &&userObject!=null&&userObject.getName()!=null&& userFormModel.getName().equals(userObject.getName())) {
				userObject.setBalance(userObject.getBalance() + userFormModel.getBalance());
				userFormDB.setBalance(userFormDB.getBalance() - userFormModel.getBalance());
				i = (userMapper.updateByPrimaryKeySelective(userObject) != 0
						&& userMapper.updateByPrimaryKeySelective(userFormDB) != 0 && doRecord(userFormDB.getId(),
								userObject.getAccountNumber(), "3", userFormModel.getBalance()) != 0) ? 31 : 303;
			} else {
				i = 301;
			}
		} else {
			i = 302;
		}
		return i;
	}

	// time和id由record自行创建，该方法需要添加记录的
	private int doRecord(String userId, String trading_object, String transactionTypeId, Double transactionFunds) {
		Records record = new Records();
		record.setUserId(userId);
		record.setTradingObject(trading_object);
		record.setTransactionTypeId(transactionTypeId);
		record.setTransactionFunds(transactionFunds);
		return recordsService.addRecord(record);
	}


}
