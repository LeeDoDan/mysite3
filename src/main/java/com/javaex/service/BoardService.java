package com.javaex.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.BoardDao;
import com.javaex.vo.BoardVo;

@Service
public class BoardService {
	@Autowired
	private BoardDao boardDao;

	//게시판 리스트
	public List<BoardVo> getList(String keyword) {
		System.out.println("BoardService.getList()");
		//Dao selectList()호출
		List<BoardVo>boardList = boardDao.selectList(keyword);
		return boardList;
	}
//	//게시판 키워드 하나 넘기기
//	public List<BoardVo> getList2(String keyword) {
//		System.out.println("BoardService.getList2()");
//		List<BoardVo> boardList = boardDao.selectList2(keyword);
//		return boardList;
//	}
	
}
