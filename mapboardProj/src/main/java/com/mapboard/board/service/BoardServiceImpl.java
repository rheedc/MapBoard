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
	
	// board-----------------------------------------------------시작
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
	// board-----------------------------------------------------끝
	// boardcomm-----------------------------------------------------시작
	@Override
	public void boardcommSelectService() throws Exception {
		System.out.println("boardcommSelectService시작");
		
		bcDao.example();
		
		System.out.println("boardcommSelectService끝");
		
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
	// boardcomm-----------------------------------------------------끝
	// filrinfo-----------------------------------------------------시작
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

	// filrinfo-----------------------------------------------------끝	

	
	

}
