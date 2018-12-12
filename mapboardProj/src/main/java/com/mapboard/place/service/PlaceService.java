package com.mapboard.place.service;

import java.util.ArrayList;

import com.mapboard.place.vo.PlaceVO;

public interface PlaceService {

	public ArrayList<PlaceVO> getPlaceService(PlaceVO vo);

	public ArrayList getPlaceList(PlaceVO vo, int situation);
	
}
