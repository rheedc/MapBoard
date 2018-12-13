package com.mapboard.board.service;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import com.mapboard.board.vo.BoardVO;
import com.mapboard.board.vo.FileinfoVO;


public interface BoardService {

	// �����Դϴ� �̰����� Service �Լ��� �����ϰ� �� Ŭ������ �������ּſ�
	// void ���� String, VOŬ���� ���� ��밡���ϰ� 
	// �Ű�����
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
