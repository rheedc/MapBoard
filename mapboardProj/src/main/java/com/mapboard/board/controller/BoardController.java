package com.mapboard.board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mapboard.board.service.BoardService;

@Controller
public class BoardController {

	@Autowired
	private BoardService service;
	
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
