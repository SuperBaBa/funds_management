package com.jcq.service.admin.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jcq.mapper.AdminMapper;
import com.jcq.model.Admin;
import com.jcq.service.admin.AdminOperAdminService;
import com.jcq.util.MD5Util;
import com.jcq.util.UUIDUtil;

@Service("adminnOperAdminService")
public class AdminnOperAdminServiceImpl implements AdminOperAdminService {
	@Autowired
	private AdminMapper adminMapper;

	@Override
	public int saveAdmin(Admin admin) {
		admin.setId(UUIDUtil.getUUID());
		admin.setPassword(MD5Util.MD5(admin.getPassword()));
		return (checkLoginame(admin) == 0) ? adminMapper.insertSelective(admin) : 0;
	}

	@Override
	public int checkLoginame(Admin admin) {
		// 确保用户名也唯一，进行验证
		return (adminMapper.selectByLoginame(admin.getLoginame()) != null) ? 1 : 0;
	}

	@Override
	public int isLogin(Admin admin) {
		/*
		 * 验证密码、登录次数和状态 0 账号密码错误 2初次登录 1可以登录
		 */
		Admin adminFromData=adminMapper.selectByLoginame(admin.getLoginame());
		int param = 0;
		// 验证密码
		if (adminFromData != null && MD5Util.MD5(admin.getPassword()).equals(adminFromData.getPassword())) {
			int i = adminFromData.getTimes();
			param = 2;
			// 验证登录次数，并修改登录次数
			if (adminFromData.getTimes() != 0) {
				adminFromData.setTimes(++i);
				adminMapper.updateByPrimaryKeySelective(adminFromData);
				param = 1;
			}else {
				adminFromData.setTimes(++i);
				adminMapper.updateByPrimaryKeySelective(adminFromData);
			}
			
		}
		return param;
	}

	@Override
	public int updatePassword(Admin admin,String newPassword) {
		if(isLogin(admin)!=0) {
			admin.setId(adminMapper.selectByLoginame(admin.getLoginame()).getId());
			admin.setPassword(MD5Util.MD5(newPassword));
			return adminMapper.updateByPrimaryKeySelective(admin);
		};
		return 0;
	}

}
