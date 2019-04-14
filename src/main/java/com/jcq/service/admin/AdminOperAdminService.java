package com.jcq.service.admin;

import com.jcq.model.Admin;

public interface AdminOperAdminService {
	public int saveAdmin(Admin admin);

	public int checkLoginame(Admin admin);

	public int isLogin(Admin admin);
	
	public int updatePassword(Admin admin,String newPassword);
}
