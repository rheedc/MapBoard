package com.mapboard.board.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mapboard.board.dao.BoardDao;
import com.mapboard.board.dao.BoardcommDao;
import com.mapboard.board.dao.FileinfoDao;

@Service("boardService")
public class BoardServiceImpl implements BoardService{

	@Autowired
	private BoardcommDao bcDao;
	@Autowired
	private BoardDao bDao;
	@Autowired
	private FileinfoDao fDao;
	
	// board-----------------------------------------------------����
	@Override
	public void boardSelectService() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void boardInsertService() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void boardUpdateService() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void boardDeleteService() throws Exception {
		// TODO Auto-generated method stub
		
	}
	// board-----------------------------------------------------��
	// boardcomm-----------------------------------------------------����
	@Override
	public void boardcommSelectService() throws Exception {
		System.out.println("boardcommSelectService����");
		
		bcDao.example();
		
		System.out.println("boardcommSelectService��");
		
	}

	@Override
	public void boardcommInsertService() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void boardcommUpdateService() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void boardcommDeleteService() throws Exception {
		// TODO Auto-generated method stub
		
	}
	// boardcomm-----------------------------------------------------��
	// filrinfo-----------------------------------------------------����
	@Override
	public void filrinfoSelectService() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void filrinfoInsertService() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void filrinfoUpdateService() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void filrinfoDeleteService() throws Exception {
		// TODO Auto-generated method stub
		
	}

	// filrinfo-----------------------------------------------------��	

	
	

}
