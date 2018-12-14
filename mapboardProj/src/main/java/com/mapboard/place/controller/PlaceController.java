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
	
	// 지도에다가 상가좌표를 뿌려줄 함수입니다.
		@RequestMapping("/place/placeList")
		public ModelAndView placeList(
				ModelAndView mv, 
				PlaceVO vo, 
				ArrayList<PlaceVO> placeList,
				HttpSession session,HttpServletRequest req) {
		
			//	할일
			//	지도를 보여줄거야		
			System.out.println("placeList시작");
			
			placeList	=	pservice.getPlaceService(vo);
			mv.addObject("PLACELIST",placeList);
			
			/**********은비코드 시작**********/
			//할일
			//1.파라미터 받고
			//PlaceVO를 이용해서 받기
			String sigungu_name=vo.getSigungu_name();
			String place_name=vo.getPlace_name();
			int category_no=vo.getCategory_no();
			String strPage=req.getParameter("nowPage");				//릴레이용변수
			int nowPage=0;
			if(strPage==null || strPage.length()==0) {	
				nowPage=1;
			}else {
				nowPage=Integer.parseInt(strPage);
			}
			String searchType=req.getParameter("searchType");	//장소검색을 원하는지 게시물검색을 원하는지
			if(searchType==null||searchType.length()==0) {
				searchType="placeSearch";											//값이 없으면 placeSearch로 지정
			}
			int situation=0;																	//케이스 분류를 위한 변수
		
			//시군구 이름이 존재하지 않을때 => 아무것도 안함
			//시군구 이름이 존재할때
			if(sigungu_name!=null && sigungu_name.length()>0) {
				//장소이름X, 카테고리 번호X
				if((place_name==null || place_name.length()==0)&&(category_no==0)) {
					situation=1;
				}
				//장소이름X, 카테고리 번호O
				if((place_name==null || place_name.length()==0)&&(category_no>0)) {
					//카테고리 전체를 선택한 경우
					if(category_no==10) {
						situation=2;
					}
					//세부카테고리를 선택한 경우
					else {
						situation=3;
					}
				}
				//장소이름O, 카테고리 번호X
				if((place_name!=null && place_name.length()>0)&&(category_no==0)) {
					situation=4;
				}
				//장소이름O, 카테고리 번호O
				if((place_name!=null && place_name.length()>0)&&(category_no>0)) {
					//카테고리 전체를 선택한 경우
					if(category_no==10) {
						situation=5;
					}
					//세부카테고리를 선택한 경우
					else {
						situation=6;
					}
				}
			}
			
			//비지니스로직수행
			//2.서비스위임
			//시군구이름/장소이름 값의 길이가 0되는 경우를 고려해야함
			//카테고리의 값이 0되는 경우를 고려해야함
			
			//페이지 이동기능
			PageUtil pInfo_p=pservice.getPageInfo(vo,nowPage,situation,"placeSearch"); 
			PageUtil pInfo_b=pservice.getPageInfo(vo,nowPage,situation,"boardSearch");
			
			//장소검색결과 목록불러오기(전체목록)
			ArrayList tlist=pservice.getTotalPlaceList(vo,situation);

			//장소검색결과 개수 불러오기
			int placecnt_total=pservice.getPlaceListCnt(vo,situation);
			//장소검색결과 목록불러오기
			ArrayList plist=pservice.getPlaceList(vo,situation,pInfo_p);

		
			//게시물검색결과 개수 불러오기
			int reviewcnt_total=pservice.getBoardListCnt(vo,situation);
			//게시물검색결과 목록불러오기
			ArrayList blist=pservice.getBoardList(vo,situation,pInfo_b);


			//3.모델
			mv.addObject("DATA", vo);
			mv.addObject("PINFO_P", pInfo_p);
			mv.addObject("PINFO_B", pInfo_b);
			mv.addObject("TLIST",tlist);
			mv.addObject("PLIST", plist);
			mv.addObject("BLIST", blist);
			mv.addObject("placecnt_total", placecnt_total);
			mv.addObject("reviewcnt_total", reviewcnt_total);			
			mv.addObject("situation", situation);
			mv.addObject("searchType", searchType);
			
			System.out.println("모델 다시 넘겨볼게");
			
			//4.뷰호출
			return mv;
			/**********은비코드 끝**********/
				
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
		
		/*-----------------------------------작성자 : 조은비-----------------------------------	 */
		
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
		public ModelAndView placeListTotal(
				ModelAndView mv, 
				PlaceVO vo, 
				ArrayList<PlaceVO> placeList,
				HttpSession session,HttpServletRequest req) {
			
			//할일
			//1.파라미터 받고
			//PlaceVO를 이용해서 받기
			String sigungu_name=vo.getSigungu_name();
			String place_name=vo.getPlace_name();
			int category_no=vo.getCategory_no();
			String strPage=req.getParameter("nowPage");				//릴레이용변수
			int nowPage=0;
			if(strPage==null || strPage.length()==0) {	
				nowPage=1;
			}else {
				nowPage=Integer.parseInt(strPage);
			}
			String searchType=req.getParameter("searchType");	//장소검색을 원하는지 게시물검색을 원하는지
			if(searchType==null||searchType.length()==0) {
				searchType="placeSearch";											//값이 없으면 placeSearch로 지정
			}
			int situation=0;																	//케이스 분류를 위한 변수
		
			//시군구 이름이 존재하지 않을때 => 아무것도 안함
			//시군구 이름이 존재할때
			if(sigungu_name!=null && sigungu_name.length()>0) {
				//장소이름X, 카테고리 번호X
				if((place_name==null || place_name.length()==0)&&(category_no==0)) {
					situation=1;
				}
				//장소이름X, 카테고리 번호O
				if((place_name==null || place_name.length()==0)&&(category_no>0)) {
					//카테고리 전체를 선택한 경우
					if(category_no==10) {
						situation=2;
					}
					//세부카테고리를 선택한 경우
					else {
						situation=3;
					}
				}
				//장소이름O, 카테고리 번호X
				if((place_name!=null && place_name.length()>0)&&(category_no==0)) {
					situation=4;
				}
				//장소이름O, 카테고리 번호O
				if((place_name!=null && place_name.length()>0)&&(category_no>0)) {
					//카테고리 전체를 선택한 경우
					if(category_no==10) {
						situation=5;
					}
					//세부카테고리를 선택한 경우
					else {
						situation=6;
					}
				}
			}
			
			//비지니스로직수행
			//2.서비스위임
			//시군구이름/장소이름 값의 길이가 0되는 경우를 고려해야함
			//카테고리의 값이 0되는 경우를 고려해야함
			
			//페이지 이동기능
			PageUtil pInfo_p=pservice.getPageInfo(vo,nowPage,situation,"placeSearch"); 
			PageUtil pInfo_b=pservice.getPageInfo(vo,nowPage,situation,"boardSearch");
			
			//장소검색결과 목록불러오기(전체목록)
			ArrayList tlist=pservice.getTotalPlaceList(vo,situation);

			//장소검색결과 개수 불러오기
			int placecnt_total=pservice.getPlaceListCnt(vo,situation);
			//장소검색결과 목록불러오기
			ArrayList plist=pservice.getPlaceList(vo,situation,pInfo_p);

		
			//게시물검색결과 개수 불러오기
			int reviewcnt_total=pservice.getBoardListCnt(vo,situation);
			//게시물검색결과 목록불러오기
			ArrayList blist=pservice.getBoardList(vo,situation,pInfo_b);


			//3.모델
			mv.addObject("DATA", vo);
			mv.addObject("PINFO_P", pInfo_p);
			mv.addObject("PINFO_B", pInfo_b);
			mv.addObject("TLIST",tlist);
			mv.addObject("PLIST", plist);
			mv.addObject("BLIST", blist);
			mv.addObject("placecnt_total", placecnt_total);
			mv.addObject("reviewcnt_total", reviewcnt_total);			
			mv.addObject("situation", situation);
			mv.addObject("searchType", searchType);
			
			System.out.println("모델 다시 넘겨볼게");
			
			//4.뷰호출
			return mv;
		}
		
}