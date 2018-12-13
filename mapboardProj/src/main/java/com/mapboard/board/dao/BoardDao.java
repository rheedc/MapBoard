package com.mapboard.board.dao;

import java.util.ArrayList;

import com.mapboard.board.vo.BoardVO;



public interface BoardDao {

	//여기서 함수를 작성 후 BoardDaoImpl.java에 구현해주세요
	public void insertBoard()  throws Exception;
	public int getTotalCount()  throws Exception;
	public ArrayList getBoardList() throws Exception;
	public BoardVO getBoardView() throws Exception;
	public void updateHit() throws Exception;
	
}
