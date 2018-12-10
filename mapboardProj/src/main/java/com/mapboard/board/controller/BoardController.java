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
		System.out.println("test ��Ʈ�ѷ��� replyModify");
	}
	
	@RequestMapping("board/modifyForm")
	public void replyForm() {
		System.out.println("test ��Ʈ�ѷ��� replyForm");
	}
	
	@RequestMapping("board/boardDetail")
	public void boardDetail() {
		System.out.println("test ��Ʈ�ѷ��� boardDetail");
	}
	
	@RequestMapping("board/boardList")
	public void boardList() {
		System.out.println("test ��Ʈ�ѷ��� boardList");
	}
	
	@RequestMapping("board/writeForm")
	public void writeForm() {
		System.out.println("test ��Ʈ�ѷ��� writeForm");
	}
	
	
	// ���� �Լ� �Դϴ�
		@RequestMapping("/board/example")
		public void example() {
			System.out.println("BoardController����");
			
			try {
				//	service �Լ� ���๮
				service.boardcommSelectService();
			} catch (Exception e) {
				System.out.println("BoardController ����"+e);
			}
			
			System.out.println("BoardController��");
			
		}
		
}
