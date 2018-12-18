package com.mapboard.place.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mapboard.place.dao.PlaceDao;
import com.mapboard.place.vo.PlaceVO;
import com.mapboard.util.PageUtil;

@Service("placeService")
public class PlaceServiceImpl implements PlaceService{

	@Autowired
	private PlaceDao pdao;

	
	//		지도 좌표정보를 가져와주는 함수
	@Override
	public ArrayList<PlaceVO> getPlaceService(PlaceVO vo) {
		System.out.println("PlaceService시작");
		//	할일
		// 지도 좌표 구하기 dao에게 할일을 넘긴다
		ArrayList<PlaceVO> arrayList	=	null;
		arrayList	=	pdao.getPlaceDao(vo);
		
		System.out.println(arrayList.size());
		System.out.println("PlaceService끝");
		
		
		return arrayList;
	}
	// 신규장소 등록 서비스 dao를 통해 등록하자
	@Override
	public int insertNewPlace(PlaceVO vo) {
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		System.out.println("신규장소 서비스시작");
		int place_no= pdao.insertNewPlace(vo);
		// 신규장소 등록 후 place_no 값을 select로 찾아 넘겨주자
		System.out.println("신규장소 서비스끝");
		
		return place_no;
		
	}

	//myplace 수정 dao한테 일시키자
	@Override
	public void myPlaceUpdate(PlaceVO vo) {
		System.out.println("내 장소 update 서비스 시작");
		pdao.myPlaceUpdate(vo);
		System.out.println("내 장소 update 서비스 시작");
	}

	// selectPlaceNo 장소 no 구하는 놈
	@Override
	public int selectPlaceNo(PlaceVO vo) {
		//바로 넘기기 
		System.out.println("selectPlaceNo servicet시작");
		int place_no	=	pdao.selectPlaceNo(vo);
		System.out.println("selectPlaceNo service끝");
		return place_no;
	}
	
	/*-----------------------------------작성자 : 조은비-----------------------------------	 */
	
	//페이지 이동정보를 만들어주는 함수
	public PageUtil getPageInfo(PlaceVO vo,int nowPage,int situation,String searchType) {
		//할일
		int totalCount=0;
		//장소검색 결과보기시 총개수구하기
		if(searchType=="placeSearch") {
			totalCount=pdao.getPlaceListCnt(vo, situation);
		}
		//게시물검색 결과보기시 총개수구하기
		if(searchType=="boardSearch") {
			totalCount=pdao.getBoardListCnt(vo, situation);
		}
		//한 페이지당 10개의 게시물을 뿌리고, 5페이지씩 보여주자
		PageUtil pInfo=new PageUtil(nowPage, totalCount, 10, 5);
		System.out.println(pInfo.getTotalCount());
		System.out.println(pInfo.getStartPage());
		System.out.println(pInfo.getEndPage());
		return pInfo;
	}
	
	//장소검색결과 개수를 가져와주는 함수
	public int getPlaceListCnt(PlaceVO vo,int situation) {
		int placecnt_total=pdao.getPlaceListCnt(vo, situation);
		return placecnt_total;
	}
	//게시물검색결과 개수를 가져와주는 함수
	public int getBoardListCnt(PlaceVO vo,int situation) {
		int reviewcnt_total=pdao.getBoardListCnt(vo, situation);
		return reviewcnt_total;
	}
	
	//장소검색결과를 전부 가져와주는 함수
	public ArrayList getTotalPlaceList(PlaceVO vo, int situation) {
		ArrayList tlist=pdao.getTotalPlaceList(vo,situation);
		return tlist;
	}	
	
	//장소검색결과를 가져와주는 함수
	public ArrayList getPlaceList(PlaceVO vo,int situation,PageUtil pInfo) {
		System.out.println("장소검색결과뿌리기");
		
		//페이징처리 적용
		//시작=(현재페이지-1)*(한 페이지에 보여줄 게시물 수 )
		int start=(pInfo.getNowPage()-1)*pInfo.getListCount()+1;
		//끝=시작페이지+그 페이지에서 보여줄 게시물수-1
		int end=start+pInfo.getListCount()-1;
		vo.setStart(start);
		vo.setEnd(end);
		
		ArrayList plist=pdao.getPlaceList(vo,situation);
		return plist;
	}
	
	//게시물검색결과를 가져와주는 함수
	public ArrayList getBoardList(PlaceVO vo, int situation,PageUtil pInfo) {
		System.out.println("게시물검색결과뿌리기");
		
		//페이징처리 적용
		//시작=(현재페이지-1)*(한 페이지에 보여줄 게시물 수 )
		int start=(pInfo.getNowPage()-1)*pInfo.getListCount()+1;
		//끝=시작페이지+그 페이지에서 보여줄 게시물수-1
		int end=start+pInfo.getListCount()-1;
		vo.setStart(start);
		vo.setEnd(end);
		
		ArrayList blist=pdao.getBoardList(vo,situation);
		return blist;
	}


	//관리자페이지 장소관리요청시 사용할 페이지정보
	public PageUtil getPageInfo_Admin(int nowPage, String type) {
		//장소결과 목록의 총개수 구하기
		int totalCount=pdao.getAdminPlaceListCnt(type);
		//한 페이지당 10개의 게시물을 뿌리고, 5페이지씩 보여주자
		PageUtil pInfo=new PageUtil(nowPage, totalCount, 10, 5);
		return pInfo;
	}
	

	//관리자페이지 장소관리요청시 사용할 장소목록정보
	public ArrayList getPlaceList_Admin(PlaceVO vo,String type, PageUtil pInfo) {
		int start=(pInfo.getNowPage()-1)*pInfo.getListCount()+1;
		int end=start+pInfo.getListCount()-1;
		vo.setStart(start);
		vo.setEnd(end);
		ArrayList list=pdao.getAdminPlaceList(vo,type);
		return list;
	}

	//노출,미노출 상태전환하는 서비스
	public void changeStatus(PlaceVO vo) {
		pdao.changeStatus(vo);
	}
	
	//회원의 기준위치구하기
	public PlaceVO getLocation(PlaceVO vo) {
		return pdao.getLocation(vo);
	}
	//총이동거리구하기
	public float getTotalMove(PlaceVO vo) {
		float move_total=pdao.getTotalMove(vo);
		return move_total;
	}
	//총이동건수구하기
	public int getTotalMoveCnt(PlaceVO vo) {
		int movecnt_total=pdao.getTotalMoveCnt(vo);
		return movecnt_total;
	}
	//월별이동거리구하기
	public HashMap getMonthMove(PlaceVO vo) {
		HashMap map=new HashMap();
		for(int i=1;i<13;i++) {
			float move_month=0;
			if(pdao.getMonthMove(vo,i)!=0.0f) {
				move_month=pdao.getMonthMove(vo,i);
			}
			map.put(i+"월",move_month);
		}
		return map;
	}
	//월별이동건수구하기
	public HashMap getMonthMoveCnt(PlaceVO vo) {
		HashMap map=new HashMap();
		for(int i=1;i<13;i++) {
			int cnt_month_move=0;
			if(pdao.getMonthMoveCnt(vo,i)!=0) {
				cnt_month_move=pdao.getMonthMoveCnt(vo,i);
			}
			map.put(i+"월",cnt_month_move);
		}
		return map;
	}
	//마이페이지에서 내글보기 페이징처리를 위한 함수
	public PageUtil getPageInfo_Member(PlaceVO vo, int nowPage) {
		//할일
		int totalCount=0;
		
		//총게시물의 개수구하기
		totalCount=pdao.getMemberBoardCnt(vo);
		//한 페이지당 10개의 게시물을 뿌리고, 5페이지씩 보여주자
		PageUtil pInfo=new PageUtil(nowPage, totalCount, 10, 5);
		System.out.println(pInfo.getTotalCount());
		System.out.println(pInfo.getStartPage());
		System.out.println(pInfo.getEndPage());
		return pInfo;
	}
	//내글보기 목록불러오는 함수
	public ArrayList getMemberBoardList(PlaceVO vo, PageUtil pInfo) {
		int start=(pInfo.getNowPage()-1)*pInfo.getListCount()+1;
		int end=start+pInfo.getListCount()-1;
		vo.setStart(start);
		vo.setEnd(end);
		ArrayList list=pdao.getMemberBoardList(vo);
		return list;
	}


	//게시판 목록보기를 위한 함수들
	
	//특정상가에 대한 페이지유틸
	public PageUtil getPageInfo_board(PlaceVO vo, int nowPage) {
		//목록의 총개수 구하기
		int totalCount=pdao.getBoardListCnt(vo);
		//한 페이지당 5개의 게시물을 뿌리고, 5페이지씩 보여주자
		PageUtil pInfo_board=new PageUtil(nowPage, totalCount, 5, 5);
		return pInfo_board;
	}
	//특정상가에 대한 목록보기
	public ArrayList getBoardList(PlaceVO vo, PageUtil pInfo_board) {
		//페이징처리 적용
		//시작=(현재페이지-1)*(한 페이지에 보여줄 게시물 수 )
		int start=(pInfo_board.getNowPage()-1)*pInfo_board.getListCount()+1;
		//끝=시작페이지+그 페이지에서 보여줄 게시물수-1
		int end=start+pInfo_board.getListCount()-1;
		vo.setStart(start);
		vo.setEnd(end);
		
		ArrayList list=pdao.getBoardList(vo);
		return list;
	}
	
	//검색에 대한 페이지유틸
	public PageUtil getPageInfo_boardSearch(PlaceVO vo, int nowPage, int situation) {
			int totalCount=0;
			//목록의 총개수구하기
			totalCount=pdao.getBoardSearchListCnt(vo, situation);
			//한 페이지당 5개의 게시물을 뿌리고, 5페이지씩 보여주자
			PageUtil pInfo_boardSearch=new PageUtil(nowPage, totalCount, 5, 5);
			return pInfo_boardSearch;
		}
	//검색에 대한 목록보기
	public ArrayList getBoardSearchList(PlaceVO vo, int situation, PageUtil pInfo_boardSearch) {
		//페이징처리 적용
		//시작=(현재페이지-1)*(한 페이지에 보여줄 게시물 수 )
		int start=(pInfo_boardSearch.getNowPage()-1)*pInfo_boardSearch.getListCount()+1;
		//끝=시작페이지+그 페이지에서 보여줄 게시물수-1
		int end=start+pInfo_boardSearch.getListCount()-1;
		vo.setStart(start);
		vo.setEnd(end);
		
		ArrayList searchlist=pdao.getBoardSearchList(vo,situation);
		return searchlist;
	}
	//리뷰모아보기
	public String getReview(PlaceVO vo) {
		String review="";
		ArrayList list=pdao.getReview(vo);
		for(int i=0;i<list.size();i++) {
			vo=(PlaceVO) list.get(i);
			review+=" "+vo.getComm();
		}
		return review;
	}
}
