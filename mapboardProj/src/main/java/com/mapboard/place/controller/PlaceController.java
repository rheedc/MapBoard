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
import com.mapboard.util.PageUtil;

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
				HttpSession session,HttpServletRequest req) {
		
			//	����
			//	������ �����ٰž�		
			System.out.println("placeList����");
			
			placeList	=	pservice.getPlaceService(vo);
			mv.addObject("PLACELIST",placeList);
			
			/**********�����ڵ�Ʒ��߰�**********/
			
			//����
			//1.�Ķ���� �ް�
			//PlaceVO�� �̿��ؼ� �ޱ�
			String sigungu_name=vo.getSigungu_name();
			String place_name=vo.getPlace_name();
			int category_no=vo.getCategory_no();
			String strPage=req.getParameter("nowPage");				//�����̿뺯��
			int nowPage=0;
			if(strPage==null || strPage.length()==0) {	
				nowPage=1;
			}else {
				nowPage=Integer.parseInt(strPage);
			}
			String searchType=req.getParameter("searchType");	//��Ұ˻��� ���ϴ��� �Խù��˻��� ���ϴ���
			if(searchType==null||searchType.length()==0) {
				searchType="placeSearch";											//���� ������ placeSearch�� ����
			}
			int situation=0;																	//���̽� �з��� ���� ����
		
			//�ñ��� �̸��� �������� ������ => �ƹ��͵� ����
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
			}
			
			//�����Ͻ���������
			//2.��������
			//�ñ����̸�/����̸� ���� ���̰� 0�Ǵ� ��츦 ����ؾ���
			//ī�װ��� ���� 0�Ǵ� ��츦 ����ؾ���
			
			//������ �̵����
			PageUtil pInfo=pservice.getPageInfo(vo,nowPage,situation,searchType); 
			
			if(searchType=="placeSearch") {				
				//��Ұ˻���� ���� �ҷ�����
				int placecnt_total=pservice.getPlaceListCnt(vo,situation);
				//��Ұ˻���� ��Ϻҷ�����
				ArrayList plist=pservice.getPlaceList(vo,situation,pInfo);
				mv.addObject("PLIST", plist);
				mv.addObject("placecnt_total", placecnt_total);
			}
			if(searchType=="boardSearch") {				
				//�Խù��˻���� ���� �ҷ�����
				int reviewcnt_total=pservice.getBoardListCnt(vo,situation);
				//�Խù��˻���� ��Ϻҷ�����
				ArrayList blist=pservice.getBoardList(vo,situation,pInfo);
				mv.addObject("BLIST", blist);
				mv.addObject("reviewcnt_total", reviewcnt_total);			
			}

			//3.��
			mv.addObject("DATA", vo);
			mv.addObject("PINFO", pInfo);
			mv.addObject("situation", situation);
			mv.addObject("searchType", searchType);
			
			System.out.println("����");
			
			//4.��ȣ��
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
		
		/*-----------------------------------�ۼ��� : ������-----------------------------------	 */
		
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
		public ModelAndView placeListTotal(
				ModelAndView mv, 
				PlaceVO vo, 
				ArrayList<PlaceVO> placeList,
				HttpSession session,HttpServletRequest req) {
			
			//����
			//1.�Ķ���� �ް�
			//PlaceVO�� �̿��ؼ� �ޱ�
			String sigungu_name=vo.getSigungu_name();
			String place_name=vo.getPlace_name();
			int category_no=vo.getCategory_no();
			String strPage=req.getParameter("nowPage");				//�����̿뺯��
			int nowPage=0;
			if(strPage==null || strPage.length()==0) {	
				nowPage=1;
			}else {
				nowPage=Integer.parseInt(strPage);
			}
			String searchType=req.getParameter("searchType");	//��Ұ˻��� ���ϴ��� �Խù��˻��� ���ϴ���
			if(searchType==null||searchType.length()==0) {
				searchType="placeSearch";											//���� ������ placeSearch�� ����
			}
			int situation=0;																	//���̽� �з��� ���� ����
		
			//�ñ��� �̸��� �������� ������ => �ƹ��͵� ����
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
			}
			
			//�����Ͻ���������
			//2.��������
			//�ñ����̸�/����̸� ���� ���̰� 0�Ǵ� ��츦 ����ؾ���
			//ī�װ��� ���� 0�Ǵ� ��츦 ����ؾ���
			
			//������ �̵����
			PageUtil pInfo=pservice.getPageInfo(vo,nowPage,situation,searchType); 
			
			if(searchType=="placeSearch") {				
				//��Ұ˻���� ���� �ҷ�����
				int placecnt_total=pservice.getPlaceListCnt(vo,situation);
				//��Ұ˻���� ��Ϻҷ�����
				ArrayList plist=pservice.getPlaceList(vo,situation,pInfo);
				mv.addObject("PLIST", plist);
				mv.addObject("placecnt_total", placecnt_total);
			}
			if(searchType=="boardSearch") {				
				//�Խù��˻���� ���� �ҷ�����
				int reviewcnt_total=pservice.getBoardListCnt(vo,situation);
				//�Խù��˻���� ��Ϻҷ�����
				ArrayList blist=pservice.getBoardList(vo,situation,pInfo);
				mv.addObject("BLIST", blist);
				mv.addObject("reviewcnt_total", reviewcnt_total);			
			}

			//3.��
			mv.addObject("DATA", vo);
			mv.addObject("PINFO", pInfo);
			mv.addObject("situation", situation);
			mv.addObject("searchType", searchType);
			
			System.out.println("����");
			
			//4.��ȣ��
			return mv;
		}
		
}