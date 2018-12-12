package com.mapboard.place.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mapboard.place.vo.PlaceVO;

@Service("placeDao")
public class PlaceDaoImpl implements PlaceDao{
	
	//	Statement ������ ���� sqlSessionTemplate�� �ʿ�
	@Autowired
	protected SqlSessionTemplate sqlSession;

	
	//	������ �󰡵����� �ѷ��ֱ�
	@Override
	public ArrayList<PlaceVO> getPlaceDao(PlaceVO vo) {
		
		System.out.println("PlaceDao����");
		//	���Ǹ� ������ ������Ʈ��Ʈ ���ϱ�
		ArrayList<PlaceVO> arrayList	=	null;
		
		// ���� �޾� set���ش� �ؿ��� �ӽ÷� �־���
		vo.setSigungu_code(11680);
		vo.setCategory_no(3);
		//	���� ����
		arrayList	=	(ArrayList)sqlSession.selectList("placeSql.placeList", vo);
		System.out.println("PlaceDao��");
		
		//	����� ���񽺿��� ��ȯ
		return arrayList;
				
	}
	
	/*
	 * �ۼ��� : ������ 
	 * �ۼ��� : 2018-12-12
	 */
	//�Խù� �Ѱ��� ���ϱ� ���ǽ��� �Լ�
	public int getTotalCount(PlaceVO vo, int situation) {
		//���Ǹ� ������ ������Ʈ��Ʈ ���ϱ�
		/*int result=sqlSession.selectOne("fileBoardName.totalCount");*/
		int result=0;
		//����� ��ȯ
		return result;
	}
	
	//��Ұ˻���� ��� �ҷ����� �Լ�
	public ArrayList getPlaceList(PlaceVO vo,int situation) {
		ArrayList plist=new ArrayList();
		if(situation==2) {
			plist=(ArrayList) sqlSession.selectList("placeSql.placeList_ct", vo);
		}
		if(situation==3) {
			plist=(ArrayList) sqlSession.selectList("placeSql.placeList_cd", vo);
		}
		if(situation==4||situation==5) {
			plist=(ArrayList) sqlSession.selectList("placeSql.placeList_p_ct", vo);
		}
		if(situation==6) {
			plist=(ArrayList) sqlSession.selectList("placeSql.placeList_p_cd", vo);
		}
		return plist;
	}
	
}
