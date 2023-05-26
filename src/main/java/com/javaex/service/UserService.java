package com.javaex.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.UserDao;
import com.javaex.vo.UserVo;

@Service
public class UserService {
	//필드
	@Autowired
	private UserDao userDao;
	//메서드 일반
	//회원등록
	public int join(UserVo userVo) {
		System.out.println("UserSevice.join()");
		int count = userDao.inertUser(userVo);
		return count;
	}
	//로그인
	public UserVo login(UserVo userVo) {
		System.out.println("UserService.login()");
		UserVo authUser = userDao.selectUser(userVo);
		return authUser;
	}
	//회원정보 수정 폼
	public UserVo modifyForm(int no) {//no값
		System.out.println("UserService.modifyForm()");
		UserVo userVo = userDao.selectUser(no);
		return userVo;
	}
}
