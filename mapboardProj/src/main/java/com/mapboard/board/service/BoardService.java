package com.mapboard.board.service;

public interface BoardService {

	// �����Դϴ� �̰����� Service �Լ��� �����ϰ� �� Ŭ������ �������ּſ�
	// void ���� String, VOŬ���� ���� ��밡���ϰ� 
	// �Ű�����
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
