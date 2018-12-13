package com.mapboard.board.dao;

import java.util.ArrayList;

import com.mapboard.board.vo.BoardVO;



public interface BoardDao {

	//���⼭ �Լ��� �ۼ� �� BoardDaoImpl.java�� �������ּ���
	public void insertBoard()  throws Exception;
	public int getTotalCount()  throws Exception;
	public ArrayList getBoardList() throws Exception;
	public BoardVO getBoardView() throws Exception;
	public void updateHit() throws Exception;
	
}
