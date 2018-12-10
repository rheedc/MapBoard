package com.mapboard.board.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("boardDao")
public class BoardDaoImpl implements BoardDao{

	@Autowired
	protected SqlSessionTemplate sqlSession;
	
	
}
