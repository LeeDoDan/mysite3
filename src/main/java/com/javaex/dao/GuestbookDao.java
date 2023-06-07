package com.javaex.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.GuestbookVo;

@Repository
public class GuestbookDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	//방명록 삭제
	public int deleteGuest(GuestbookVo guestbookVo) {
		System.out.println("GuestbookDao.deleteGuest()");
		
		int count = sqlSession.delete("guestbook.delete",guestbookVo);
		System.out.println(count);
		return count;
		
	}
	
	//방명록 리스트
	public List<GuestbookVo> selectGuestList() {
		System.out.println("GuestbookDao.selectGuestList()");
		List<GuestbookVo> guestbookList = sqlSession.selectList("guestbook.selectList");
		return guestbookList;
	}
	
	//방명록 등록
	public int insertGuest(GuestbookVo guestbookVo) {
		System.out.println("GuestbookDao.insertGuest()");

		
		int count = sqlSession.insert("guestbook.insertGuest",guestbookVo);
        return count;
	}
	
	//ajax방명록 등록
	public int insertSelectKey(GuestbookVo guestbookVo) {
		System.out.println("GuestbookDao.insertSelectKey()");
		
		System.out.println(guestbookVo); //no가 없음
		sqlSession.insert("guestbook.insertSelectKey", guestbookVo);
		System.out.println(guestbookVo); //no가 있음
		
		return guestbookVo.getNo();
	}
	
	//ajax방명록 등록 후 no로 글 가져오기
	public GuestbookVo selectGuest(int no) {
		System.out.println("GuestbookDao.selectGuest()");
		System.out.println(no);
		
		GuestbookVo guestbookVo = sqlSession.selectOne("guestbook.selectGuest", no);
		return guestbookVo;		
		
	}
	

}