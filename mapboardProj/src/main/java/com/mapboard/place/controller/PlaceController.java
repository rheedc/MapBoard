package com.mapboard.place.controller;

import java.util.ArrayList;

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
		
		@RequestMapping("place/totalPlaceList")
		public void placeListTotal() {
			System.out.println("합친페이지 호출");
		}
	
	
}