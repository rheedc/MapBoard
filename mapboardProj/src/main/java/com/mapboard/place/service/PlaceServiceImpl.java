package com.mapboard.place.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mapboard.place.dao.PlaceDao;
import com.mapboard.place.vo.PlaceVO;

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
		
		
	
	
}
