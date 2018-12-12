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
	
	/*
	 * 작성자 : 조은비 
	 * 작성일 : 2018-12-12
	 */
	//페이지 이동정보를 만들어주는 함수
	public PageUtil getPageInfo(PlaceVO vo,int nowPage,int situation) {
		//할일
		//게시물 총개수 구하기
		int totalCount=pdao.getTotalCount(vo,situation);
		//한 페이지당 10개의 게시물을 뿌리고, 5페이지씩 보여주자
		PageUtil pInfo=new PageUtil(nowPage, totalCount, 10, 5);
		return pInfo;
		}
	
	//장소검색결과를 가져와주는 함수
	public ArrayList getPlaceList(PlaceVO vo,int situation) {
		System.out.println("장소검색결과뿌리기");
		ArrayList plist=pdao.getPlaceList(vo,situation);
		return plist;
	}
	
	//게시물검색결과를 가져와주는 함수
		
	
	
}
