package com.mapboard.place.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mapboard.place.vo.PlaceVO;
import com.mapboard.util.PageUtil;

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
		vo.setCategory_no(3);
		//	질의 실행
		arrayList	=	(ArrayList)sqlSession.selectList("placeSql.placeList", vo);
		System.out.println("PlaceDao끝");
		
		//	결과를 서비스에게 반환
		return arrayList;
				
	}
	
	/*
	 * 작성자 : 조은비 
	 * 작성일 : 2018-12-12
	 */
	//게시물 총개수 구하기 질의실행 함수
	public int getPlaceListCnt(PlaceVO vo, int situation) {
		//질의를 실행할 스테이트먼트 구하기
		/*int result=sqlSession.selectOne("fileBoardName.totalCount");*/
		int placecnt_total=0;
		if(situation==2) {
			placecnt_total=sqlSession.selectOne("placeSql.cnt_placeList_ct",vo);
		}
		if(situation==3) {
			placecnt_total=sqlSession.selectOne("placeSql.cnt_placeList_cd",vo);
		}
		if(situation==4||situation==5) {
			placecnt_total=sqlSession.selectOne("placeSql.cnt_placeList_p_ct",vo);
		}
		if(situation==6) {
			placecnt_total=sqlSession.selectOne("placeSql.cnt_placeList_p_cd",vo);
		}
		//결과를 반환
		return placecnt_total;
	}
	//장소검색결과 목록 불러오는 함수
	public ArrayList getTotalPlaceList(PlaceVO vo, int situation) {
		ArrayList tlist=new ArrayList();
		if(situation==2) {
			tlist=(ArrayList) sqlSession.selectList("placeSql.all_placeList_ct", vo);
		}
		if(situation==3) {
			tlist=(ArrayList) sqlSession.selectList("placeSql.all_placeList_cd", vo);
		}
		if(situation==4||situation==5) {
			tlist=(ArrayList) sqlSession.selectList("placeSql.all_placeList_p_ct", vo);
		}
		if(situation==6) {
			tlist=(ArrayList) sqlSession.selectList("placeSql.all_placeList_p_cd", vo);
		}
		return tlist;
	}
	//장소검색결과 목록 불러오는 함수
	public ArrayList getPlaceList(PlaceVO vo,int situation) {
		ArrayList plist=new ArrayList();
		if(situation==2) {
			plist=(ArrayList) sqlSession.selectList("placeSql.placeList_ct", vo);
		}
		if(situation==3) {
			plist=(ArrayList) sqlSession.selectList("placeSql.placeList_cd", vo);
		}
		if(situation==4||situation==5) {
			plist=(ArrayList) sqlSession.selectList("placeSql.placeList_p_ct", vo);
		}
		if(situation==6) {
			plist=(ArrayList) sqlSession.selectList("placeSql.placeList_p_cd", vo);
		}
		return plist;
	}

	public int getBoardListCnt(PlaceVO vo, int situation) {
		// TODO Auto-generated method stub
		return 0;
	}

	
}
