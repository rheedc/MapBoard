package com.mapboard.board.dao;

import java.util.ArrayList;

import com.mapboard.board.vo.FileinfoVO;

public interface FileinfoDao {

	//���⼭ �Լ��� �ۼ� �� FileinfoDaoImpl.java�� �������ּ���
	public void insertBoard()  throws Exception;
	public ArrayList getFileInfo() throws Exception;
	public FileinfoVO getDownload() throws Exception;
	
}
