package com.mapboard.place.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

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
		//----------송승환 신규장소 등록 
		@RequestMapping("/place/newPlaceProc")
		public ModelAndView newPlaceProc(
				ModelAndView mv, 
				PlaceVO vo, 
				HttpSession session,HttpServletRequest req) {
			
			System.out.println("신규장소 controller시작");
			//파라미터 받고
			String userid	=	req.getParameter("id");
			String place_name	=	req.getParameter("newPlaceName");
			
			String str_gory_no	=	req.getParameter("category_no");
			int category_no	=	Integer.parseInt(str_gory_no);	
			String sigungu_name	= req.getParameter("guname");
			String juso	= req.getParameter("newPlaceAddress1");
			
			String str_lat	=	req.getParameter("newPlaceX");
			double latitude	= Double.parseDouble(str_lat);
			
			String str_lon	=	req.getParameter("newPlaceY");
			double longitude	= Double.parseDouble(str_lon);
			
			// vo에 다 태우자~
			vo.setUserid(userid);
			vo.setPlace_name(place_name);
			vo.setCategory_no(category_no);
			vo.setSigungu_name(sigungu_name);
			vo.setJuso(juso);
			vo.setLatitude(latitude);
			vo.setLongitude(longitude);
			
			//서비스로 일하러 보내자 신규장소 등록 서비스 newPlaceProc
			int place_no= pservice.insertNewPlace(vo);
			
			
			System.out.println("신규장소 controller끝");
			RedirectView rv	=	new RedirectView("/board/writeForm.yo?place_no="+place_no);
			mv.setView(rv);
			
			return mv;
			
		}
		
		
		//----------송승환 내 장소 update 
		//myPlaceProc
		@RequestMapping("/place/myPlaceProc")
		public ModelAndView myPlaceProc(
				ModelAndView mv, 
				PlaceVO vo, 
				HttpSession session,HttpServletRequest req) {
			System.out.println("내 장소 update controller 시작");
			//파라미터 받고
			String userid	=	req.getParameter("id");
			String juso	= req.getParameter("myPlaceAddress1");
			
			String str_lat	=	req.getParameter("myPlaceX");
			double latitude	= Double.parseDouble(str_lat);
			
			String str_lon	=	req.getParameter("myPlaceY");
			double longitude	= Double.parseDouble(str_lon);
			
			// vo에 다 태우자~
			vo.setUserid(userid);
			vo.setJuso(juso);
			vo.setLatitude(latitude);
			vo.setLongitude(longitude);
			
			// myPlaceUpdate 내장소 수정!!! 서비스로 보내서 일하자!
			pservice.myPlaceUpdate(vo);
			
			//뷰는 myPage로 넘기자
			
			System.out.println("내 장소 update controller끝");
			RedirectView rv	=	new RedirectView("/member/memberDetail.yo");
			mv.setView(rv);
			
			return mv;
		}
		
		
		//----------송승환 boardList로 place_no 넘겨주자 
		//../place/boardListProc.yo
		
		@RequestMapping("/place/boardListProc")
		public ModelAndView boardViewProc(
				ModelAndView mv, 
				PlaceVO vo, 
				HttpSession session,HttpServletRequest req) {
			System.out.println("boardViewProc controller시작");
			String juso	= req.getParameter("juso");
			String place_name	= req.getParameter("place_name");

			// vo에 다 태우자~
			vo.setPlace_name(place_name);
			vo.setJuso(juso);
			
			// selectPlaceNo
			int place_no=pservice.selectPlaceNo(vo);
			
			
				
			RedirectView rv	=	new RedirectView("/board/boardList.yo?place_no="+place_no);
			System.out.println("boardViewProc controller끝");
			mv.setView(rv);
			return mv;
		}
		
		
		//../place/writeFormProc.yo
		@RequestMapping("/place/writeFormProc")
		public ModelAndView writeFormProc(
				ModelAndView mv, 
				PlaceVO vo, 
				HttpSession session,HttpServletRequest req) {
			System.out.println("writeFormProc controller시작");
			String juso	= req.getParameter("juso");
			String place_name	= req.getParameter("place_name");

			// vo에 다 태우자~
			vo.setPlace_name(place_name);
			vo.setJuso(juso);
			
			// selectPlaceNo
			int place_no=pservice.selectPlaceNo(vo);
			
			
				
			RedirectView rv	=	new RedirectView("/board/writeForm.yo?place_no="+place_no);
			System.out.println("writeFormProc controller끝");
			mv.setView(rv);
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
		
		//관리자가 장소목록을 보려고할 때 활용할 함수
		@RequestMapping("admin/placeList")
		public ModelAndView adminPlaceList(ModelAndView mv, PlaceVO vo, HttpServletRequest req) {
			
			String type=req.getParameter("type");
			if(type==null || type.length()==0) {
				type="all";
			}
			String strPage=req.getParameter("nowPage");
			int nowPage=0;
			if(strPage==null || strPage.length()==0) {	
				nowPage=1;
			}else {
				nowPage=Integer.parseInt(strPage);
			}
			PageUtil pInfo=pservice.getPageInfo_Admin(nowPage,type);
			ArrayList list=pservice.getPlaceList_Admin(vo, type, pInfo);
			
			mv.addObject("type", type);
			mv.addObject("PINFO", pInfo);
			mv.addObject("LIST", list);
			
			return mv;
		}

		//장소의 노출/미노출 상태변경
		@RequestMapping("admin/changeStatus")
		public ModelAndView changePlaceStatus(ModelAndView mv, PlaceVO vo, HttpServletRequest req) {
			System.out.println("상태변경들어옴");
			
			String type=req.getParameter("type");
			if(type==null || type.length()==0) {
				type="all";
			}
			String strPage=req.getParameter("nowPage");
			int nowPage=0;
			if(strPage==null || strPage.length()==0) {	
				nowPage=1;
			}else {
				nowPage=Integer.parseInt(strPage);
			}
			String nowStatus=req.getParameter("nowStatus");
			vo.setStatus(nowStatus);
			System.out.println(nowPage+","+type+"입니다");
			pservice.changeStatus(vo);
			
			RedirectView rv=new RedirectView("../admin/placeList.yo");
			
			rv.addStaticAttribute("type", type);
			rv.addStaticAttribute("nowPage", nowPage);
			mv.setView(rv);
			return mv;
		}
		
		
		//my통계
		@RequestMapping("member/memberStatistics")
		public ModelAndView myStatistics(ModelAndView mv,PlaceVO vo,HttpSession session) {
			String userid=(String) session.getAttribute("userid");
			vo.setUserid(userid);
			
			HashMap monthMove=new HashMap();
			HashMap monthCnt=new HashMap();
			
			//유저의 중심위치 구하기
			vo=pservice.getLocation(vo);
			
			vo.setUserid(userid);
			
			System.out.println("아이디"+userid);
			
			
			if(vo.getLatitude()>0) {
				System.out.println("내기준지 등록했음");
				//총이동거리구하기
				vo.setMove_total(pservice.getTotalMove(vo));
				
				//총방문건수구하기
				vo.setMovecnt_total(pservice.getTotalMoveCnt(vo));
				
				//월별이동거리구하기
				monthMove=pservice.getMonthMove(vo);
	
				//월별방문건수구하기
				monthCnt=pservice.getMonthMoveCnt(vo);
				
				//내가 남긴 리뷰 내용 모아보기
				String review=pservice.getReview(vo);
				
				System.out.println(review);
				
				

				mv.addObject("DATA",vo);
				mv.addObject("monthMove",monthMove);
				mv.addObject("monthCnt",monthCnt);
				return mv;
			}
			else {
				System.out.println("내기준지 등록안함");
				return mv;
			}
		}

		
		//내 글목록보기
		@RequestMapping("member/memberBoardList")
		public ModelAndView placeListTotal(
				ModelAndView mv, 
				PlaceVO vo, 
				HttpSession session,HttpServletRequest req) {
			
			vo.setUserid((String) session.getAttribute("userid"));
			String strPage=req.getParameter("nowPage");				
			int nowPage=0;
			if(strPage==null || strPage.length()==0) {	
				nowPage=1;
			}else {
				nowPage=Integer.parseInt(strPage);
			}
			
			
			PageUtil pInfo=pservice.getPageInfo_Member(vo,nowPage); 
			ArrayList list=pservice.getMemberBoardList(vo,pInfo);
			
			mv.addObject("LIST", list);
			mv.addObject("PINFO", pInfo);
			
			return mv;
		}
		
		//게시판 목록보기(검색기능 존재)
		@RequestMapping("board/boardList2")
		public ModelAndView boardList(
				ModelAndView mv, 
				PlaceVO vo, 
				HttpServletRequest req) {
			
			//할일
			//1.파라미터 받고
			//장소번호,시군구명,장소명,nowPage
			String place_noStr=req.getParameter("place_no");
			int place_no=Integer.parseInt(place_noStr);
			String sigungu_name=req.getParameter("sigungu_name");
			String place_name=req.getParameter("place_name");
			String strPage=req.getParameter("nowPage");				
			int nowPage=0;
			if(strPage==null || strPage.length()==0) {	
				nowPage=1;
			}else {
				nowPage=Integer.parseInt(strPage);
			}
			//검색케이스분류를 위한 변수
			int situation=0;
			
			if(sigungu_name==null || sigungu_name.length()==0 || sigungu_name.equals("전체") ) {
				//시군구전체,장소전체
				if(place_name==null || place_name.length()==0) {
					situation=1;
				}
				//시군구전체,장소특정
				if(place_name!=null && place_name.length()>0) {
					situation=2;
				}
			}
			else {
				//시군구특정,장소전체
				if(place_name==null || place_name.length()==0) {
					situation=3;
				}
				//시군구특정,장소특정
				if(place_name!=null && place_name.length()>0) {
					situation=4;
				}
			}
			

			System.out.println("userid : "+vo.getUserid());
			System.out.println("place_name : "+place_name);
			System.out.println("place_no : "+place_no);
			System.out.println("sigungu_name : "+sigungu_name);
			System.out.println("nowPage : "+nowPage);
			System.out.println("situation : "+situation);
			
			//2.비지니스로직수행
			//상가번호가 넘어온 경우
			PageUtil pInfo=null;
			ArrayList list=null;
			
			if(place_no!=0) {
				//특정상가번호에 대한 목록보기수행
				pInfo=pservice.getPageInfo_board(vo,nowPage);
				list=pservice.getBoardList(vo,pInfo);				
			}
			//상가번호가 넘어오지 않은 경우
			else {
				pInfo=pservice.getPageInfo_boardSearch(vo,nowPage,situation);
				list=pservice.getBoardSearchList(vo,situation,pInfo);
			}
			mv.addObject("DATA", vo);
			mv.addObject("PINFO", pInfo);
			mv.addObject("LIST", list);	
			return mv;
		}		
}