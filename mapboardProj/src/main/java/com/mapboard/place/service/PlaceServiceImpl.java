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

	
	//		���� ��ǥ������ �������ִ� �Լ�
	@Override
	public ArrayList<PlaceVO> getPlaceService(PlaceVO vo) {
		System.out.println("PlaceService����");
		//	����
		// ���� ��ǥ ���ϱ� dao���� ������ �ѱ��
		ArrayList<PlaceVO> arrayList	=	null;
		arrayList	=	pdao.getPlaceDao(vo);
		
		System.out.println(arrayList.size());
		System.out.println("PlaceService��");
		
		
		return arrayList;
	}
		
		
	
	
}
