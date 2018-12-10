package com.mapboard.board.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("fileinfoDao")
public class FileinfoDaoImpl implements FileinfoDao{

	@Autowired
	protected SqlSessionTemplate sqlSession;
	
	
}
