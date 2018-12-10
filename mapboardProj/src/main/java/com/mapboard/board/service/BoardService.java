package com.mapboard.board.service;

public interface BoardService {

	// 예시입니다 이곳에다 Service 함수를 정의하고 각 클래스에 구현해주셔요
	// void 말고 String, VO클래스 등을 사용가능하고 
	// 매개변수
	//	Board
	public void boardSelectService() throws Exception;
	public void boardInsertService() throws Exception;
	public void boardUpdateService() throws Exception;
	public void boardDeleteService() throws Exception;
		
	//	Boardcomm
	public void boardcommSelectService() throws Exception;
	public void boardcommInsertService() throws Exception;
	public void boardcommUpdateService() throws Exception;
	public void boardcommDeleteService() throws Exception;
		
	//	Fileinfo
	public void filrinfoSelectService() throws Exception;
	public void filrinfoInsertService() throws Exception;
	public void filrinfoUpdateService() throws Exception;
	public void filrinfoDeleteService() throws Exception;
		
		
}
