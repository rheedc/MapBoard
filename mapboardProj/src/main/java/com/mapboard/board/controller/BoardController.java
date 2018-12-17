package com.mapboard.board.controller;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.mapboard.board.service.BoardService;
import com.mapboard.board.vo.BoardVO;
import com.mapboard.util.PageUtil;

@Controller
@RequestMapping("/board")
public class BoardController {
	@Autowired
	private BoardService service;
	
	
	
	//1-1. 글쓰기 폼보기 요청
	@RequestMapping("/writeForm")
	public void writeForm(@RequestParam(value="place_no",defaultValue="1")int place_no,
							HttpServletRequest req) throws Exception {
		//인터셉터를 이용하여 로그인 처리 했기 때문에 딱히 할일이 없다.
		System.out.println("controller의 writeForm 시작과 끝");
		
		//2) 서비스
		BoardVO vo = service.getSelectName(place_no);
		req.setAttribute("VO", vo);
		
		System.out.println("controller의 writeForm 시작과 끝");
	}									
	
	
	//1-2. 글쓰기
	@RequestMapping("/writeProc")
	public ModelAndView writeProc(BoardVO vo, HttpSession session) throws Exception {
		System.out.println("controller의 writeProc 시작");
		
		//1) 파라미터
		ArrayList list = new ArrayList();
		
		//2) 서비스
		service.insertBoard(vo, session, list); 
		
		//3) 모델
		//4) 뷰 호출
		ModelAndView mv = new ModelAndView();
		RedirectView view = new RedirectView("../board/boardList.yo");
		mv.setView(view);
		System.out.println("controller의 writeProc 끝");
		return mv;
	}
	
	//2. 목록보기
	@RequestMapping("/boardList")
	public void boardList(@RequestParam(value="nowPage", defaultValue="1") 
						int nowPage,HttpServletRequest req) throws Exception {
		System.out.println("controller의 boardList 시작");
		//1) 페이지 이동 기능
		PageUtil pInfo = service.getPageInfo(nowPage);
		
		//2) 게시물 꺼내오기
		ArrayList list = service.getBoardList(pInfo);
		System.out.println("게시물수 = "+list.size());
		
		//3) 모델 만들기
		req.setAttribute("PINFO", pInfo);
		req.setAttribute("LIST", list);
		System.out.println("controller의  boardList 끝");
	}
			
	
	 
	
	
	
	
	// 예시 함수 입니다-----------------------------------------------------------------------------------------------
		@RequestMapping("/board/example")
		public void example() {
			System.out.println("BoardController시작");
			
			try {
				//	service 함수 실행문
				//service.boardcommSelectService();
			} catch (Exception e) {
				System.out.println("BoardController 오류"+e);
			}
			
			System.out.println("BoardController끝");
			
		}
		
}
