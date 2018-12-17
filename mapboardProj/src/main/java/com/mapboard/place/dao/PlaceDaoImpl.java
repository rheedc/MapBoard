package com.mapboard.place.dao;

import java.util.ArrayList;
import java.util.concurrent.SynchronousQueue;

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
		
		//	질의 실행
		arrayList	=	(ArrayList)sqlSession.selectList("placeSql.placeList", vo);
		System.out.println("PlaceDao끝");
		
		//	결과를 서비스에게 반환
		return arrayList;
				
	}
	// 신규장소 등록 함수 sql에 등록해서 insert하자
	@Override
	public int insertNewPlace(PlaceVO vo) {
		System.out.println("신규장소 dao시작");
		// 신규장소 등록 구문 실행
		sqlSession.insert("placeSql.insertNewPlace", vo);
		// 신규장소 등록 후 place_no 값을 select로 찾아 넘겨주자
		int place_no= sqlSession.selectOne("placeSql.selectPlace_no");
		System.out.println("신규장소 dao끝");
		return place_no;
	}

	//myplace 수정 하자!
	@Override
	public void myPlaceUpdate(PlaceVO vo) {
		System.out.println("내 장소 update dao 시작");
		sqlSession.update("placeSql.myPlaceUpdate", vo);
		System.out.println("내 장소 update dao 시작");
	}

	// selectPlaceNo 장소 no 구하는 놈
	@Override
	public int selectPlaceNo(PlaceVO vo) {
		System.out.println("selectPlaceNo dao시작");
		int place_no= sqlSession.selectOne("placeSql.selectPlace_no2", vo);
		System.out.println("selectPlaceNo dao끝");
		return place_no;
	}

	
	/*
	 * 작성자 : 조은비 
	 * 작성일 : 2018-12-12
	 */
	//장소검색결과 총개수 구하기 질의실행 함수
	public int getPlaceListCnt(PlaceVO vo, int situation) {
		//질의를 실행할 스테이트먼트 구하기
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
	//전체장소정보용
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
	//페이징용
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

	//게시물검색결과 총개수 구하기 질의실행 함수
	public int getBoardListCnt(PlaceVO vo, int situation) {
		//질의를 실행할 스테이트먼트 구하기
		int reviewcnt_total=0;
		if(situation==2) {
			reviewcnt_total=sqlSession.selectOne("placeSql.cnt_boardList_ct",vo);
		}
		if(situation==3) {
			reviewcnt_total=sqlSession.selectOne("placeSql.cnt_boardList_cd",vo);
		}
		if(situation==4||situation==5) {
			reviewcnt_total=sqlSession.selectOne("placeSql.cnt_boardList_p_ct",vo);
		}
		if(situation==6) {
			reviewcnt_total=sqlSession.selectOne("placeSql.cnt_boardList_p_cd",vo);
		}
		//결과를 반환
		return reviewcnt_total;
	}

	//게시물검색결과 목록 불러오는 함수
	//페이징용
	public ArrayList getBoardList(PlaceVO vo, int situation) {
		ArrayList blist=new ArrayList();
		if(situation==2) {
			blist=(ArrayList) sqlSession.selectList("placeSql.boardList_ct", vo);
		}
		if(situation==3) {
			blist=(ArrayList) sqlSession.selectList("placeSql.boardList_cd", vo);
		}
		if(situation==4||situation==5) {
			blist=(ArrayList) sqlSession.selectList("placeSql.boardList_p_ct", vo);
		}
		if(situation==6) {
			blist=(ArrayList) sqlSession.selectList("placeSql.boardList_p_cd", vo);
		}
		return blist;	
	}
	//관리자용 장소 목록 불러오는 함수
	public ArrayList getAdminPlaceList(PlaceVO vo, String type) {
		ArrayList placeList=new ArrayList();
		if(type.equals("all")) {
			placeList=(ArrayList) sqlSession.selectList("placeSql.placeList_all", vo);
		}
		if(type.equals("old")) {
			placeList=(ArrayList) sqlSession.selectList("placeSql.placeList_old", vo);
		}
		if(type.equals("new")) {
			placeList=(ArrayList) sqlSession.selectList("placeSql.placeList_new", vo);
		}
		return placeList;
	}

	//관리자용 장소 목록 개수 얻어내는 함수
	public int getAdminPlaceListCnt(String type) {
		int totalCount=0;
		if(type.equals("all")) {
			totalCount=sqlSession.selectOne("placeSql.cnt_adminPlaceList_all");			
		}
		if(type.equals("old")) {
			totalCount=sqlSession.selectOne("placeSql.cnt_adminPlaceList_old");
		}
		if(type.equals("new")) {
			totalCount=sqlSession.selectOne("placeSql.cnt_adminPlaceList_new");
		}
		return totalCount;
	}

	//장소 노출/미노출 상태변경해주는 함수
	public void changeStatus(PlaceVO vo) {
		sqlSession.update("placeSql.changeStatus",vo);
	}
	
	//회원의 기준지 위치구하기
	public PlaceVO getLocation(PlaceVO vo) {
		return sqlSession.selectOne("placeSql.member_location",vo);
	}
	//총이동거리구하기
	public float getTotalMove(PlaceVO vo) {
		float move_total=sqlSession.selectOne("placeSql.total_move",vo);
		return move_total;
	}
	//총방문건수구하기
	public int getTotalMoveCnt(PlaceVO vo) {
		int movecnt_total=sqlSession.selectOne("placeSql.cnt_total_move",vo);
		return movecnt_total;
	}
	//월별이동거리구하기
	public float getMonthMove(PlaceVO vo, int i) {
		vo.setCreateMonth(i+"월");
		float move_month=sqlSession.selectOne("placeSql.month_move",vo);
		return move_month;
	}
	
	//월별방문건수구하기
	public int getMonthMoveCnt(PlaceVO vo, int i) {
		vo.setCreateMonth(i+"월");
		int movecnt_month=sqlSession.selectOne("placeSql.cnt_month_move",vo);
		return movecnt_month;
	}
	
}
