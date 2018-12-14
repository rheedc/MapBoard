package com.mapboard.board.service;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import com.mapboard.board.vo.BoardVO;
import com.mapboard.board.vo.FileinfoVO;


public interface BoardService {

	// 예시입니다 이곳에다 Service 함수를 정의하고 각 클래스에 구현해주셔요
	// void 말고 String, VO클래스 등을 사용가능하고 
	// 매개변수
	//	Board
	public BoardVO boardSelectService(int oriNo) throws Exception;
	public void boardInsertService(BoardVO vo, HttpSession session, ArrayList list) throws Exception;
	public void boardUpdateService() throws Exception;
	public void boardDeleteService() throws Exception;
	public void updateHit(int oriNo, HttpSession session) throws Exception;
	
	//	Boardcomm
	public void boardcommSelectService() throws Exception;
	public void boardcommInsertService() throws Exception;
	public void boardcommUpdateService() throws Exception;
	public void boardcommDeleteService() throws Exception;
		
	//	Fileinfo
	public ArrayList fileinfoSelectService(int oriNo) throws Exception;
	public void fileinfoInsertService() throws Exception;
	public void fileinfoUpdateService() throws Exception;
	public void fileinfoDeleteService() throws Exception;
	public FileinfoVO getDownload(int fileNo) throws Exception;
		
}