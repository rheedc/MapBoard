package com.mapboard.board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mapboard.board.service.BoardService;

@Controller
public class BoardController {

	@Autowired
	private BoardService service;
	
	@RequestMapping("board/replyModify")
	public void replyModify() {
		System.out.println("test 컨트롤러의 replyModify");
	}
	
	@RequestMapping("board/modifyForm")
	public void replyForm() {
		System.out.println("test 컨트롤러의 replyForm");
	}
	
	@RequestMapping("board/boardDetail")
	public void boardDetail() {
		System.out.println("test 컨트롤러의 boardDetail");
	}
	
	@RequestMapping("board/boardList")
	public void boardList() {
		System.out.println("test 컨트롤러의 boardList");
	}
	
	@RequestMapping("board/writeForm")
	public void writeForm() {
		System.out.println("test 컨트롤러의 writeForm");
	}
	
	
	// 예시 함수 입니다
		@RequestMapping("/board/example")
		public void example() {
			System.out.println("BoardController시작");
			
			try {
				//	service 함수 실행문
				service.boardcommSelectService();
			} catch (Exception e) {
				System.out.println("BoardController 오류"+e);
			}
			
			System.out.println("BoardController끝");
			
		}
		
}
