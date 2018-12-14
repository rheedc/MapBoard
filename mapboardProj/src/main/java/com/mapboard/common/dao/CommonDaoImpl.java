package com.mapboard.common.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("commonDao")
public class CommonDaoImpl implements CommonDao{

	@Autowired
	protected SqlSessionTemplate sqlSession;
	
	@Override
	public void excuteDao() throws Exception {
		System.out.println("CommonDao시작");
		// sql 들어가야할 부분
		
		/*mybatis에 정의된 것을 사용해야한다.
		*	한개면 selectOne 여러개면 selectList
		*	void일 수 있는 것은 insert와update, delete입니다. 
		*	sqlSession.update or insert, delete 방식으로 사용합니다 
		*/
		
		// sqlSession.selectList("~~~.~~~~");
		
		System.out.println("CommonDao끝");
		
	}

	@Override
	public void selectDao() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void insertDao() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteDao() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateDao() throws Exception {
		// TODO Auto-generated method stub
		
	}

	

	
	

}