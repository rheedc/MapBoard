package com.mapboard.board.dao;

import java.util.ArrayList;

import com.mapboard.board.vo.BoardVO;
import com.mapboard.board.vo.FileinfoVO;



public interface BoardDao {

	//여기서 함수를 작성 후 BoardDaoImpl.java에 구현해주세요
	public BoardVO getSelectName(int place_no)throws Exception;
	
	public void insertBoard(BoardVO vo, String kind) throws Exception;
	
	public BoardVO getBoardDetail(int bidx) throws Exception;
	
	public void updateBoard(BoardVO bvo) throws Exception;

	//조회수 증가처리명령
	public void updateHit(int bidx);
	
	
	
}