package com.javaex.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.GuestbookDao;
import com.javaex.vo.GuestbookVo;

@Service
public class GuestbookService {
	
	@Autowired
	private GuestbookDao guestbookDao;
	
	//방명록 리스트
	public List<GuestbookVo> getGuestList(){
		System.out.println("GuestbookService.getGuestList()");
		List<GuestbookVo> guestbookList = guestbookDao.selectGuestList();
		return guestbookList;
	}
	
	//방명록 글 등록
	public void addGuest(GuestbookVo guestbookVo) {
		System.out.println("GuestbookService.addGuest()");
		guestbookDao.insertGuest(guestbookVo);
	}
	
	//방명록 삭제
	public void deleteGuest(GuestbookVo guestbookVo) {
		System.out.println("GuestbookService.addGuest()");
		guestbookDao.deleteGuest(guestbookVo);
	}
	//ajax 방명록 등록(insert) 떄 사용
	public GuestbookVo addGuset(GuestbookVo guestbookVo) {
		System.out.println("GuestbookService.addGuest()");
		//글 등록 no 확인
		System.out.println(guestbookVo);
		int count = guestbookDao.insertSelectKey(guestbookVo);
		int no = guestbookVo.getNo();
		//no 글 가져오기
		GuestbookVo guestVo =  guestbookDao.selectGuest(no);
		return guestVo;
	}
	
	
}
