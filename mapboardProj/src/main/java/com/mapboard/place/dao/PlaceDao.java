package com.mapboard.place.dao;

import java.util.ArrayList;

import com.mapboard.place.vo.PlaceVO;

public interface PlaceDao {

	public ArrayList<PlaceVO> getPlaceDao(PlaceVO vo);

	public ArrayList getTotalPlaceList(PlaceVO vo, int situation);

	public ArrayList getPlaceList(PlaceVO vo, int situation); 
	
	public ArrayList getBoardList(PlaceVO vo, int situation);
	
	public int getPlaceListCnt(PlaceVO vo, int situation);
	
	public int getBoardListCnt(PlaceVO vo, int situation);
	
	public int insertNewPlace(PlaceVO vo);
	
	public void myPlaceUpdate(PlaceVO vo);
	
	public int selectPlaceNo(PlaceVO vo);
	

	//관리자용
	public ArrayList getAdminPlaceList(PlaceVO vo,String type);

	public int getAdminPlaceListCnt(String type);

	public void changeStatus(PlaceVO vo);

	
	//my통계를 위한 자료
	public float getTotalMove(PlaceVO vo);

	public int getTotalMoveCnt(PlaceVO vo);

	public float getMonthMove(PlaceVO vo, int i);

	public int getMonthMoveCnt(PlaceVO vo, int i);

	public PlaceVO getLocation(PlaceVO vo);

	//내글보기를 위한 자료
	public int getMemberBoardCnt(PlaceVO vo);

	public ArrayList getMemberBoardList(PlaceVO vo);

	//게시물 목록보기를 위한 자료
	public int getBoardListCnt(PlaceVO vo);

	public ArrayList getBoardList(PlaceVO vo);

	public int getBoardSearchListCnt(PlaceVO vo, int situation);

	public ArrayList getBoardSearchList(PlaceVO vo, int situation);
}
