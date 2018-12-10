package com.mapboard.common.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mapboard.common.dao.CommonDao;

@Service("commonService")
public class CommonServiceImpl implements CommonService{

	@Autowired
	private CommonDao dao;
	//	구현 예시입니다

	@Override
	public void excuteService() throws Exception {
		System.out.println("CommonService시작");
		dao.excuteDao();
		
		System.out.println("CommonService끝");
	}

	@Override
	public void selectService() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void insertService() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteService() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateService() throws Exception {
		// TODO Auto-generated method stub
		
	}

	
	

	
}
