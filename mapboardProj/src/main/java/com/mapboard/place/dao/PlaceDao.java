package com.mapboard.place.dao;

import java.util.ArrayList;

import com.mapboard.place.vo.PlaceVO;

public interface PlaceDao {

	public ArrayList<PlaceVO> getPlaceDao(PlaceVO vo);

	public int getTotalCount(PlaceVO vo,int situation);

	public ArrayList getPlaceList(PlaceVO vo, int situation); 
}
