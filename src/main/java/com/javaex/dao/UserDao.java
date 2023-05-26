package com.javaex.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.UserVo;

@Repository
public class UserDao {
	//필드
	@Autowired
	private SqlSession sqlSession;
	//생성자
	//메서드 gs
	//메서드 일반
	//회원등록
	public int inertUser(UserVo userVo) {
		System.out.println("UserDao.insertUser()");
		System.out.println(userVo);
		int count = sqlSession.insert("user.insert", userVo);
		return count;
	}
	//로그인 (세션 저장용)
	public UserVo selectUser(UserVo userVo) {
		System.out.println("UserDao.selectUser()");
		UserVo authUser = sqlSession.selectOne("user.selectUser", userVo);
		return authUser;
	}
	//회원정보 수정 폼 (회원정보 가져오기)
	public UserVo selectUser(int no) {
		System.out.println("UserDao.selectUser()");
		System.out.println(no);
		//sqlSession.selectOne("user.SelectUser",no); //xml의 이름은 겹치면 안됨
		UserVo userVo = sqlSession.selectOne("user.SelectUserByNo",no);//"안의 값이 쿼리id로 옴?" 쿼리값저장해서 리턴주기
		return userVo;
	}
	
}
