package com.mapboard.board.dao;

import java.util.ArrayList;

import com.mapboard.board.vo.FileinfoVO;

public interface FileinfoDao {

	//여기서 함수를 작성 후 FileinfoDaoImpl.java에 구현해주세요
	public void insertFileBoard(FileinfoVO vo)  throws Exception;
	public ArrayList getFileInfo(int oriNo) throws Exception;
	public FileinfoVO getDownload(int fileNo) throws Exception;
	
}
