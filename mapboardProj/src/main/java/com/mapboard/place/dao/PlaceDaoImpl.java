package com.mapboard.place.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mapboard.place.vo.PlaceVO;

@Service("placeDao")
public class PlaceDaoImpl implements PlaceDao{
	
	//	Statement 역할을 해줄 sqlSessionTemplate를 필요
	@Autowired
	protected SqlSessionTemplate sqlSession;

	
	//	지도에 상가데이터 뿌려주기
	@Override
	public ArrayList<PlaceVO> getPlaceDao(PlaceVO vo) {
		
		System.out.println("PlaceDao시작");
		//	질의를 실행할 스테이트먼트 구하기
		ArrayList<PlaceVO> arrayList	=	null;
		
		// 값을 받아 set해준다 밑에건 임시로 넣었다
		vo.setSigungu_code(11680);
		vo.setCategory_no(4);
		//	질의 실행
		arrayList	=	(ArrayList)sqlSession.selectList("placeSql.placeList", vo);
		System.out.println("PlaceDao끝");
		
		//	결과를 서비스에게 반환
		return arrayList;
				
	}
	
	
}
