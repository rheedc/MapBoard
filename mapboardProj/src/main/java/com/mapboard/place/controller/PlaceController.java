package com.mapboard.place.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.mapboard.place.service.PlaceService;
import com.mapboard.place.vo.PlaceVO;

@Controller
public class PlaceController {

	@Autowired
	private PlaceService pservice;
	
	//PlaceListService plistService;
	
	// �������ٰ� ����ǥ�� �ѷ��� �Լ��Դϴ�.
		@RequestMapping("/place/placeList")
		public ModelAndView placeList(
				ModelAndView mv, 
				PlaceVO vo, 
				ArrayList<PlaceVO> placeList,
				HttpSession session) {
		
			//	����
			//	������ �����ٰž�		
			System.out.println("placeList����");
			
			placeList	=	pservice.getPlaceService(vo);
			mv.addObject("PLACELIST",placeList);
			
			String juso	=	placeList.get(2026).getJuso();
			String doroJuso	=	placeList.get(2026).getDoro_juso();
			double latitude	=	placeList.get(2026).getLatitude();
			double longitude	=	placeList.get(2026).getLongitude();
			
			System.out.println(doroJuso+latitude+juso+"placeList��"+longitude);
			
			//plist = plistService.getPList(vo);
			//mv.addObject("?",plist);

			return mv;			
		}
		
		// �ű���� ����� ������ �����ֱ�
		@RequestMapping("place/newPlaceForm")
		public void newPlaceForm() {
			System.out.println("�ű���� ����� ������ ȣ��");
		}
		
		// my��� ����� ������ �����ֱ�
		@RequestMapping("place/myPlaceForm")
		public void myPlaceForm() {
			System.out.println("my��� ����� ������ ȣ��");
		}
		
		
		@RequestMapping("total/totalPlaceList")
		public void placeListTotal(PlaceVO vo) {
			System.out.println("��ģ������ ȣ��");
			//����
			//1.�Ķ���� �ް�
			//PlaceVO�� �̿��ؼ� �ޱ�
			String sigungu_name=vo.getSigungu_name();
			String place_name=vo.getPlace_name();
			int category_name=vo.getCategory_no();
			
			System.out.println("�ñ����̸�"+sigungu_name);
			System.out.println("����̸�"+place_name);
			System.out.println("ī�װ���ȣ"+category_name);
			
			//2.��������
			//�ñ����̸�/����̸� ���� ���̰� 0�Ǵ� ��츦 ����ؾ���
			//ī�װ��� ���� 0�Ǵ� ��츦 ����ؾ���
			
			
			//3.��
			//4.��ȣ��
		}
	
		//��� ��Ϻ��� ��û�� ���� �Լ�
		@RequestMapping("place/searchResult")
		public void searchResult() {
			System.out.println("�����Ϻ��� ��û");
		}
	
}