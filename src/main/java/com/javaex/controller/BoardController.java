package com.javaex.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.javaex.service.BoardService;
import com.javaex.vo.BoardVo;

@Controller
public class BoardController {
	@Autowired
	private BoardService boardService;
	
	//게시판 리스트
	@RequestMapping(value="/board/list", method = {RequestMethod.GET, RequestMethod.POST})
	public String list(@RequestParam(value="keyword",required = false, defaultValue = " ") String keyword, 
			Model model) {//파라미터에 없는데 파라미터에 받은거처럼의 효과? 넘긴거있음 그거나오고 안넘기면 디폴트값나오고
		System.out.println("BoardController.list()");
		System.out.println(keyword);
		List<BoardVo> boardList = boardService.getList(keyword);
		model.addAttribute("boardList",boardList);
		return "board/list";
	}
	
//	//게시판 키워드 하나 넘기기
//	@RequestMapping(value="/board/list2", method = {RequestMethod.GET, RequestMethod.POST})
//	public String list2(@RequestParam(value="keyword",required = false, defaultValue = " ") String keyword,
//			Model model) {//키워드 하나 받아야해
//		System.out.println("BoardController.list2()");
//		List<BoardVo> boardList = boardService.getList2(keyword);
//		System.out.println(boardList);
//		model.addAttribute("boardList", boardList);
//		return "board/list";
//	}
}
