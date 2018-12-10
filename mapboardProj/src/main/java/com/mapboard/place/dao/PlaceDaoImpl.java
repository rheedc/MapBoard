package com.mapboard.place.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mapboard.place.vo.PlaceVO;

@Service("placeDao")
public class PlaceDaoImpl implements PlaceDao{
	
	//	Statement ������ ���� sqlSessionTemplate�� �ʿ�
	@Autowired
	protected SqlSessionTemplate sqlSession;

	
	//	������ �󰡵����� �ѷ��ֱ�
	@Override
	public ArrayList<PlaceVO> getPlaceDao(PlaceVO vo) {
		
		System.out.println("PlaceDao����");
		//	���Ǹ� ������ ������Ʈ��Ʈ ���ϱ�
		ArrayList<PlaceVO> arrayList	=	null;
		
		// ���� �޾� set���ش� �ؿ��� �ӽ÷� �־���
		vo.setSigungu_code(11680);
		vo.setCategory_no(4);
		//	���� ����
		arrayList	=	(ArrayList)sqlSession.selectList("placeSql.placeList", vo);
		System.out.println("PlaceDao��");
		
		//	����� ���񽺿��� ��ȯ
		return arrayList;
				
	}
	
	
}
