package com.mapboard.board.dao;

import java.util.ArrayList;

import com.mapboard.board.vo.BoardVO;



public interface BoardDao {

	//여기서 함수를 작성 후 BoardDaoImpl.java에 구현해주세요
	public BoardVO getSelectName(int place_no)throws Exception;
	
	public void insertBoard(BoardVO vo)  throws Exception;
	
	public ArrayList getBoardList(BoardVO vo)throws Exception;
	
	public int getTotalCount()throws Exception;
	
}