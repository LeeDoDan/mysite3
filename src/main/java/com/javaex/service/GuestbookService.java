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
	
}
