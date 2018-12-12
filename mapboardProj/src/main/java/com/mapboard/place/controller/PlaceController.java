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
	
	// 지도에다가 상가좌표를 뿌려줄 함수입니다.
		@RequestMapping("/place/placeList")
		public ModelAndView placeList(
				ModelAndView mv, 
				PlaceVO vo, 
				ArrayList<PlaceVO> placeList,
				HttpSession session) {
		
			//	할일
			//	지도를 보여줄거야		
			System.out.println("placeList시작");
			
			placeList	=	pservice.getPlaceService(vo);
			mv.addObject("PLACELIST",placeList);
			
			String juso	=	placeList.get(2026).getJuso();
			String doroJuso	=	placeList.get(2026).getDoro_juso();
			double latitude	=	placeList.get(2026).getLatitude();
			double longitude	=	placeList.get(2026).getLongitude();
			
			System.out.println(doroJuso+latitude+juso+"placeList끝"+longitude);
			
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
		
			//	할일
			//	지도를 보여줄거야		
			System.out.println("placeList시작");
			
			placeList	=	pservice.getPlaceService(vo);
			mv.addObject("PLACELIST",placeList);
			
			String juso	=	placeList.get(2026).getJuso();
			String doroJuso	=	placeList.get(2026).getDoro_juso();
			double latitude	=	placeList.get(2026).getLatitude();
			double longitude	=	placeList.get(2026).getLongitude();
			
			System.out.println(doroJuso+latitude+juso+"placeList끝"+longitude);
			
			//plist = plistService.getPList(vo);
			//mv.addObject("?",plist);

			return mv;			
		}
		
		// 신규장소 등록폼 페이지 보여주기
		@RequestMapping("place/newPlaceForm")
		public void newPlaceForm() {
			System.out.println("신규장소 등록폼 페이지 호출");
		}
		
		// my장소 등록폼 페이지 보여주기
		@RequestMapping("place/myPlaceForm")
		public void myPlaceForm() {
			System.out.println("my장소 등록폼 페이지 호출");
		}
		
		
		@RequestMapping("total/totalPlaceList")
		public void placeListTotal(PlaceVO vo,HttpServletRequest req) {
			System.out.println("합친페이지 호출");
			//할일
			//1.파라미터 받고
			//PlaceVO를 이용해서 받기
			String sigungu_name=vo.getSigungu_name();
			String place_name=vo.getPlace_name();
			int category_no=vo.getCategory_no();
			
			System.out.println("시군구이름"+sigungu_name);
			System.out.println("장소이름"+place_name);
			System.out.println("카테고리번호"+category_no);
			
			//2.서비스위임
			//시군구이름/장소이름 값의 길이가 0되는 경우를 고려해야함
			//카테고리의 값이 0되는 경우를 고려해야함

			//3.모델
			req.setAttribute("DATA", vo);
			
			//4.뷰호출
		}
	
		//결과 목록보기 요청에 대한 함수
		@RequestMapping("place/searchResult")
		public void searchResult(PlaceVO vo) {
			System.out.println("결과목록보기 요청");
			
			//파라미터 받기
			String sigungu_name=vo.getSigungu_name();
			String place_name=vo.getPlace_name();
			int category_no=vo.getCategory_no();
			
			//케이스 분류를 위한 변수
			int situation=0;
			
			//비지니스로직수행
			//시군구 이름이 존재할때
			if(sigungu_name!=null && sigungu_name.length()>0) {
				//장소이름X, 카테고리 번호X
				if((place_name==null || place_name.length()==0)&&(category_no==0)) {
					situation=1;
				}
				//장소이름X, 카테고리 번호O
				if((place_name==null || place_name.length()==0)&&(category_no>0)) {
					situation=2;
				}
				//장소이름O, 카테고리 번호X
				if((place_name!=null && place_name.length()>0)&&(category_no==0)) {
					situation=3;
				}
				//장소이름O, 카테고리 번호O
				if((place_name!=null && place_name.length()>0)&&(category_no>0)) {
					situation=4;
				}
				System.out.println("situation : "+situation);
			}
		}
	
}