package com.javaex.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.BoardDao;
import com.javaex.vo.BoardVo;

@Service
public class BoardService {

	@Autowired
	private BoardDao boardDao;
	
	
	//게시판 리스트 : 페이징 포함
	public Map<String, Object> getList3(int crtPage) {
		System.out.println("BoardService.getList3()");
		
		//현재 페이지 음수면 1페이지로 처리
		crtPage =(crtPage>=1) ? crtPage : (crtPage =1);
		
		//10	: (crtPage-1) * 10 + 1;
		//1-10, 11-20
		//rownum 번호 구하기
		//startRnum, endRnum
		
		//페이지 당 글 갯수
		int listCnt = 10;
		
		//시작 글 번호	1*5+1
		int startRnum = (crtPage-1) * listCnt + 1;
		
		//끝 글 번호
		int endRnum = (startRnum + listCnt)-1;
		
		List<BoardVo> boardList= boardDao.selectList3(startRnum, endRnum);
		
		//////////페이징  계산//////////
		//전체 글 개수
		int totalCount = boardDao.totalCount();
		System.out.println(totalCount);
		//페이지당 버튼 갯수
		int pageBtnCount = 5;
		
		//마지막 버튼 번호
		// 1 → 5
		// 3 → 5
		// 6 → 10
		// 14 → 15
		
		//마지막 버튼 갯수
		//						1 / 5 → (0.2→1)*올림 *5 => 5(마지막 버튼)5
		//						3 / 5 → (0.6→1)*올림 *5 => 5(마지막 버튼)5
		//						6 / 5 → (1.2→2)*올림 *5 => 10(마지막 버튼)10
		//						10 / 5 → (2→2)*올림 *5 => 10(마지막 버튼)10
		int endPageBtnNo = (int)Math.ceil(crtPage/(double)pageBtnCount) * pageBtnCount;
							//ceil 올림하는거 / double형이어서 int로 변환
		
		//시작 버튼 번호
		int startPageBtnNo = (endPageBtnNo-pageBtnCount)+1;
		
		//다음 화살표
		boolean next = false;
		if(endPageBtnNo * listCnt <totalCount) {	//10*10<123
			next = true;
		}else {
			next=false;
			//글 버튼 번호 endPageBtnNo 다시 계산 (맨뒤에 14,15에 list없으면 안나와야함)
			endPageBtnNo = (int)Math.ceil(totalCount/(double)listCnt);//double안넣으면 소수점 다 떨어져나가서
		}
		
		
		//이전 화살표
		boolean prev = false;
		if(startPageBtnNo !=1) {
			prev = true;
		}
		
		//맵으로 만들기
		Map<String, Object> pMap = new HashMap<String, Object>();//화면에서 그릴거 다 넘겨주기?
		pMap.put("prev", prev);
		pMap.put("startPageBtnNo", startPageBtnNo);
		pMap.put("endPageBtnNo", endPageBtnNo);
		pMap.put("next", next);
		pMap.put("boardList", boardList);//원래있는데 한번 더 포장한거?
		
		return pMap;
	}
	
	/* 게시판 리스트: 검색기능 포함 */
	public List<BoardVo> getList2(String keyword) {
		System.out.println("BoardService.getList2()");
		
		List<BoardVo> boardList = boardDao.selectList2(keyword);
		
		return boardList;
	}
	
	
	/* 게시판 리스트: 검색기능 X */
	public List<BoardVo> getList() {
		System.out.println("BoardService.getList()");
		
		List<BoardVo> boardList = boardDao.selectList();
		
		return boardList;
	}
	
	
	// 글쓰기
	public int addBoard(BoardVo boardVo) {
		System.out.println("BoardService.addBoard()");

		int count = boardDao.insertBoard(boardVo);
		return count;
	}
	
	
}