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
	
	//방명록삭제 폼(ajax도 같이 사용)
	public int deleteGuest(GuestbookVo guestbookVo) {
		System.out.println("GuestbookService.deleteGuest()");
		int count =guestbookDao.deleteGuest(guestbookVo);
        return count;
	}
	
	//방명록 리스트
	public List<GuestbookVo> getGuestList() {
		System.out.println("GuestbookService.getGuestList()");
		
		List<GuestbookVo> guestbookList = guestbookDao.selectGuestList();
		return guestbookList;
	}
	
	//방명록 등록
	public void addGuest(GuestbookVo guestbookVo) {
		System.out.println("GuestbookService.addGuest()");
		guestbookDao.insertGuest(guestbookVo);
		
	}
	
	//ajax방명록 등록때 사용
	public GuestbookVo addGuestList(GuestbookVo guestbookVo) {
		System.out.println("GuestbookService.addGuestResultVo()");
		
		//글등록 no확인
		guestbookDao.insertSelectKey(guestbookVo);
		int no = guestbookVo.getNo();
		
		//no 글가져오기
		GuestbookVo guestVo = guestbookDao.selectGuest(no);
		return guestVo;
	}
	

}