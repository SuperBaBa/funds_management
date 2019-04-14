package com.jcq.service.user;


import com.jcq.model.User;

public interface UserOperUserService {
	public int saveUser(User user);

	public int checkLoginame(User user);

	public User isLogin(User user);

	public int updatePassword(User user, String newPassword);

	public int operation(User user, String operation);

}
