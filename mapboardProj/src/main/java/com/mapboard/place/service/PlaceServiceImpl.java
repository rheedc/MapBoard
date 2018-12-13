package com.mapboard.place.service;

import java.util.ArrayList;

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
		
		return null;
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
}
