package com.mapboard.place.service;

import java.util.ArrayList;

import com.mapboard.place.vo.PlaceVO;
import com.mapboard.util.PageUtil;

public interface PlaceService {

	public ArrayList<PlaceVO> getPlaceService(PlaceVO vo);

	public PageUtil getPageInfo(PlaceVO vo,int nowPage,int situation,String searchType);
	
	public ArrayList getPlaceList(PlaceVO vo, int situation, PageUtil pInfo);
	public ArrayList getBoardList(PlaceVO vo, int situation,PageUtil pInfo);

	public int getPlaceListCnt(PlaceVO vo, int situation);
	
	public int getBoardListCnt(PlaceVO vo, int situation);
	
}