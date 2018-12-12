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
	
	/*
	 * �ۼ��� : ������ 
	 * �ۼ��� : 2018-12-12
	 */
	//������ �̵������� ������ִ� �Լ�
	public PageUtil getPageInfo(PlaceVO vo,int nowPage,int situation) {
		//����
		//�Խù� �Ѱ��� ���ϱ�
		int totalCount=pdao.getTotalCount(vo,situation);
		//�� �������� 10���� �Խù��� �Ѹ���, 5�������� ��������
		PageUtil pInfo=new PageUtil(nowPage, totalCount, 10, 5);
		return pInfo;
		}
	
	//��Ұ˻������ �������ִ� �Լ�
	public ArrayList getPlaceList(PlaceVO vo,int situation) {
		System.out.println("��Ұ˻�����Ѹ���");
		ArrayList plist=pdao.getPlaceList(vo,situation);
		return plist;
	}
	
	//�Խù��˻������ �������ִ� �Լ�
		
	
	
}
