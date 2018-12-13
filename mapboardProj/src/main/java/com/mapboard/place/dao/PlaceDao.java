package com.mapboard.place.dao;

import java.util.ArrayList;

import com.mapboard.place.vo.PlaceVO;

public interface PlaceDao {

	public ArrayList<PlaceVO> getPlaceDao(PlaceVO vo);

	public ArrayList getPlaceList(PlaceVO vo, int situation); 
	
	public int getPlaceListCnt(PlaceVO vo, int situation);
	
	public int getBoardListCnt(PlaceVO vo, int situation);
}
