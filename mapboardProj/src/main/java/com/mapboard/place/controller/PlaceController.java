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
		@RequestMapping("/place/placeList2")
		public ModelAndView placeList2(
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
		public void placeListTotal(PlaceVO vo,HttpServletRequest req) {
			System.out.println("��ģ������ ȣ��");
			//����
			//1.�Ķ���� �ް�
			//PlaceVO�� �̿��ؼ� �ޱ�
			String sigungu_name=vo.getSigungu_name();
			String place_name=vo.getPlace_name();
			int category_no=vo.getCategory_no();
			
			System.out.println("�ñ����̸�"+sigungu_name);
			System.out.println("����̸�"+place_name);
			System.out.println("ī�װ���ȣ"+category_no);
			
			//���̽� �з��� ���� ����
			//�ñ��� �̸��� �������� ������
			int situation=0;
			
			//�ñ��� �̸��� �����Ҷ�
			if(sigungu_name!=null && sigungu_name.length()>0) {
				//����̸�X, ī�װ� ��ȣX
				if((place_name==null || place_name.length()==0)&&(category_no==0)) {
					situation=1;
				}
				//����̸�X, ī�װ� ��ȣO
				if((place_name==null || place_name.length()==0)&&(category_no>0)) {
					//ī�װ� ��ü�� ������ ���
					if(category_no==10) {
						situation=2;
					}
					//����ī�װ��� ������ ���
					else {
						situation=3;
					}
				}
				//����̸�O, ī�װ� ��ȣX
				if((place_name!=null && place_name.length()>0)&&(category_no==0)) {
					situation=4;
				}
				//����̸�O, ī�װ� ��ȣO
				if((place_name!=null && place_name.length()>0)&&(category_no>0)) {
					//ī�װ� ��ü�� ������ ���
					if(category_no==10) {
						situation=5;
					}
					//����ī�װ��� ������ ���
					else {
						situation=6;
					}
				}
				System.out.println("situation : "+situation);
			}
			System.out.println("situation : "+situation);
			
			//�����Ͻ���������
			//2.��������
			//�ñ����̸�/����̸� ���� ���̰� 0�Ǵ� ��츦 ����ؾ���
			//ī�װ��� ���� 0�Ǵ� ��츦 ����ؾ���
			
			//��Ұ˻���� ��Ϻҷ�����
			ArrayList plist=pservice.getPlaceList(vo,situation);
			
			//�Խù��˻���� ��Ϻҷ�����
			/*ArrayList blist=pservice.getBoardList(vo,situation);*/

			//3.��
			req.setAttribute("DATA", vo);
			req.setAttribute("situation", situation);
			req.setAttribute("PLIST", plist);
			//4.��ȣ��
		}
}