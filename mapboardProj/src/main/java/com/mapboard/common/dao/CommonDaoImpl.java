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
		System.out.println("CommonDao����");
		// sql ������ �κ�
		
		/*mybatis�� ���ǵ� ���� ����ؾ��Ѵ�.
		*	�Ѱ��� selectOne �������� selectList
		*	void�� �� �ִ� ���� insert��update, delete�Դϴ�. 
		*	sqlSession.update or insert, delete ������� ����մϴ� 
		*/
		
		// sqlSession.selectList("~~~.~~~~");
		
		System.out.println("CommonDao��");
		
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
