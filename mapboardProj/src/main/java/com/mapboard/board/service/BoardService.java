package com.mapboard.board.service;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import com.mapboard.board.vo.BoardVO;
import com.mapboard.board.vo.FileinfoVO;
import com.mapboard.util.PageUtil;


public interface BoardService {

	// 예시입니다 이곳에다 Service 함수를 정의하고 각 클래스에 구현해주셔요
	// void 말고 String, VO클래스 등을 사용가능하고 
	// 매개변수
	//	Board
	public void insertBoard(BoardVO vo, HttpSession session, ArrayList list) throws Exception;

	public ArrayList getBoardList(PageUtil pInfo) throws Exception;
	
	public PageUtil getPageInfo(int nowPage) throws Exception;
		
}