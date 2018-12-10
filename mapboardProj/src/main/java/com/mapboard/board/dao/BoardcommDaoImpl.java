package com.mapboard.board.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("boardcommDao")
public class BoardcommDaoImpl implements BoardcommDao{

	@Autowired
	protected SqlSessionTemplate sqlSession;
	
	@Override
	public void example() throws Exception {
		// 예시
		System.out.println("example 시작");
		//sqlSession.selectOne(""); 
		System.out.println("example 끝");
	}

}
