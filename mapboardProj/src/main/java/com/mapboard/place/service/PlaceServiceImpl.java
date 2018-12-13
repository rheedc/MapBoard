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
	
	/*-----------------------------------�ۼ��� : ������-----------------------------------	 */
	
	//������ �̵������� ������ִ� �Լ�
	public PageUtil getPageInfo(PlaceVO vo,int nowPage,int situation,String searchType) {
		//����
		int totalCount=0;
		//��Ұ˻� �������� �Ѱ������ϱ�
		if(searchType=="placeSearch") {
			totalCount=pdao.getPlaceListCnt(vo, situation);
		}
		//�Խù��˻� �������� �Ѱ������ϱ�
		if(searchType=="boardSearch") {
			totalCount=pdao.getBoardListCnt(vo, situation);
		}
		//�� �������� 10���� �Խù��� �Ѹ���, 5�������� ��������
		PageUtil pInfo=new PageUtil(nowPage, totalCount, 10, 5);
		System.out.println(pInfo.getTotalCount());
		System.out.println(pInfo.getStartPage());
		System.out.println(pInfo.getEndPage());
		return pInfo;
		}
	
	//��Ұ˻������ �������ִ� �Լ�
	public ArrayList getPlaceList(PlaceVO vo,int situation,PageUtil pInfo) {
		System.out.println("��Ұ˻�����Ѹ���");
		
		//����¡ó�� ����
		//����=(����������-1)*(�� �������� ������ �Խù� �� )
		int start=(pInfo.getNowPage()-1)*pInfo.getListCount()+1;
		//��=����������+�� ���������� ������ �Խù���-1
		int end=start+pInfo.getListCount()-1;
		vo.setStart(start);
		vo.setEnd(end);
		
		ArrayList plist=pdao.getPlaceList(vo,situation);
		return plist;
	}
	
	//�Խù��˻������ �������ִ� �Լ�
	public ArrayList getBoardList(PlaceVO vo, int situation,PageUtil pInfo) {
		System.out.println("�Խù��˻�����Ѹ���");
		
		//����¡ó�� ����
		//����=(����������-1)*(�� �������� ������ �Խù� �� )
		int start=(pInfo.getNowPage()-1)*pInfo.getListCount()+1;
		//��=����������+�� ���������� ������ �Խù���-1
		int end=start+pInfo.getListCount()-1;
		vo.setStart(start);
		vo.setEnd(end);
		
		return null;
	}
	
	//��Ұ˻���� ������ �������ִ� �Լ�
	public int getPlaceListCnt(PlaceVO vo,int situation) {
		int placecnt_total=pdao.getPlaceListCnt(vo, situation);
		return placecnt_total;
	}
	//�Խù��˻���� ������ �������ִ� �Լ�
	public int getBoardListCnt(PlaceVO vo,int situation) {
		int reviewcnt_total=pdao.getBoardListCnt(vo, situation);
		return reviewcnt_total;
	}	
}
