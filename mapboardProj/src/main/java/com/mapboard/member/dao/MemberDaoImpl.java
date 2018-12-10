package com.mapboard.member.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("memberDao")
public class MemberDaoImpl implements MemberDao{

	@Autowired
	protected SqlSessionTemplate sqlSession;
}
