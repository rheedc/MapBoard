package com.mapboard.board.controller;
import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.mapboard.board.service.BoardService;
import com.mapboard.board.vo.BoardVO;
import com.mapboard.board.vo.FileinfoVO;
import com.mapboard.util.FileUtil;


@Controller
@RequestMapping("/board")
public class BoardController {
	@Autowired
	private BoardService service;

	
	
	//1-1. 글쓰기 폼보기 요청
	@RequestMapping("/writeForm")
	public void writeForm(@RequestParam(value="place_no")int place_no,
							HttpServletRequest req) throws Exception {
		//인터셉터를 이용하여 로그인 처리 했기 때문에 딱히 할일이 없다.
		System.out.println("controller의 writeForm 시작"+place_no);
		
		//2) 서비스
		BoardVO vo = service.getSelectName(place_no);
		req.setAttribute("VO", vo);
		
		System.out.println("controller의 writeForm 끝");
	}									
	
	
	//1-2. 글쓰기
	@RequestMapping("/writeProc")
	public ModelAndView writeProc(BoardVO vo, HttpSession session,HttpServletRequest req) throws Exception {
		System.out.println("controller의 writeProc 시작");
		
		String spno=req.getParameter("place_no");
		int place_no = Integer.parseInt(spno);
		vo.setPlace_no(place_no);
		System.out.println(place_no);
	
		String fpath = "E:\\upload";

		
		//1) 파라미터
		ArrayList list = new ArrayList();
		for(int i=0 ; i<vo.getFiles().length ; i++) {
			//하나씩 파일의 실제 이름을 알아내자
			String foriname = vo.getFiles()[i].getOriginalFilename();
			
			//파일이 업로드 되지 않으면 다음 파일작업을 시도한다.
			if(foriname==null || foriname.length()==0) {
				continue;
			}
			
			String fsname = FileUtil.renameTo(fpath, foriname);		//FileUtil
			
			File file = new File(fpath, fsname);		
			
			//transferTo()를 이용해서 복사
			try {
				vo.getFiles()[i].transferTo(file);	//path에 saveName을 저장
			} catch (Exception e) {
				System.out.println("강제복사 에러 = "+e);
			} 
			
			//이제 하나의 파일이 업로드된 상태
			//업로드된 파일의 정보를 Map으로 묶자.(path,oriName,saveName,len)
			HashMap map = new HashMap();
			map.put("fpath", fpath);
			map.put("foriname", foriname);
			map.put("fsname", fsname);
			map.put("fsize", file.length());
			
			list.add(map);	//한번씩 돌 때마다 리스트에 추가
			
		}//for
		
		//2) 서비스
		service.insertBoard(vo, session, list); 
		
		//3) 모델
		//4) 뷰 호출
		ModelAndView mv = new ModelAndView();
		RedirectView view = new RedirectView("../board/boardList2.yo");
		mv.setView(view);
		System.out.println("controller의 writeProc 끝");
		return mv;
	}
	
	
	//상세보기
	@RequestMapping("/hitProc")
	public ModelAndView boardHitProc(ModelAndView mv, HttpSession session,
						HttpServletRequest req) throws Exception {
		
		
		System.out.println("조회수 증가요청들어옴");
		//조회수 증가서비스실행
		String sbidx = req.getParameter("bidx");
		int bidx = Integer.parseInt(sbidx);
		String nowPage = req.getParameter("nowPage");	//릴레이용
		
		service.updateHit(bidx,session);
		
		RedirectView rv = new RedirectView("../board/boardDetail.yo");
		//컨트롤러에서 Redirect하면서 파라미터를 보내고 싶다면 
		//rv.addStaticAttribute(String형태 "키값",  데이터);
		rv.addStaticAttribute("bidx", bidx);
		rv.addStaticAttribute("nowPage", nowPage);
		
		mv.setView(rv);
		return mv;
	}
	
	//상세보기 요청 함수(내용/첨부파일)
		@RequestMapping("/boardDetail")
		public ModelAndView boardDetail(@RequestParam(value="bidx") int bidx,
												@RequestParam(value="nowPage") int nowPage,
												HttpServletRequest req) throws Exception {		
			
			String sigungu_name=req.getParameter("sigungu_name");
			String place_name=req.getParameter("place_name");
			
			BoardVO vo =service.getBoardDetail(bidx);
			ArrayList list = service.getFileDetail(bidx);
			
			//모델
			ModelAndView mv = new ModelAndView();
			mv.addObject("VIEW", vo);									//내용
			mv.addObject("LIST", list);									//첨부파일 정보
			mv.addObject("nowPage", nowPage);			//릴레이용
			mv.addObject("sigungu_name", sigungu_name);
			mv.addObject("place_name", place_name);	
			//뷰
			mv.setViewName("fileBoard/boardView");
			return mv;
		}

	//파일 다운로드 요청 처리 함수
	@RequestMapping("/fileDownload")
	public ModelAndView fileDownload(
			@RequestParam(value="fileNo") int fidx) throws Exception {
		
		BoardVO vo = service.getDownload(fidx);
		//다운로드 할 파일을 File이라는 클래스로 만들어서 제공하기로 했다.
		File file = new File(vo.getFpath(),vo.getFsname());
		
		ModelAndView mv = new ModelAndView("download", "downloadFile", file); 	//sun-context.xml
		
		return mv;
	}
	
	//수정하기
	@RequestMapping("/updateForm")
	public ModelAndView updateForm(HttpServletRequest req,
								ModelAndView mv) throws Exception {
		String sbidx = req.getParameter("bidx");
		int bidx = Integer.parseInt(sbidx);
		String nowPage = req.getParameter("nowPage");

		//서비스
		BoardVO vo = service.getBoardDetail(bidx);
		
		mv.addObject("VIEW", vo);
		mv.addObject("nowPage", nowPage);
		
		mv.setViewName("board/updateForm");
		return mv;
	}
	
	//수정하기 처리
	@RequestMapping("/updateProc")
	public void updateProc(BoardVO vo, ModelAndView mv, RedirectView rv) throws Exception {
		//내용수정
		service.updateBoard(vo);
	}
	
	//게시판 내용삭제
	@RequestMapping("/boardDelete")
	public ModelAndView boardDelete(@RequestParam(value="bidx") int bidx,
			@RequestParam(value="nowPage") int nowPage,
			HttpSession session,
			HttpServletRequest req) {
		
		//파라미터 받고
		BoardVO vo=new BoardVO();
		ModelAndView mv=new ModelAndView();
		

		String sigungu_name=req.getParameter("sigungu_name");
		String place_name=req.getParameter("place_name");
		
		/*if(req.getParameter("sigungu_name").length()>0) {
			sigungu_name=req.getParameter("sigungu_name");
		}
		if(req.getParameter("place_name").length()>0) {
			place_name=req.getParameter("place_name");
		}*/
		System.out.println(sigungu_name);
		System.out.println(place_name);
		
		vo.setBidx(bidx);
		
		int cnt=service.deleteBoard(vo);
		
		RedirectView rv=null;
		
		//뷰
		//삭제가 실패하면 상세보기
		if(cnt==0) {
			System.out.println("삭제실패");
			rv=new RedirectView("../board/boardDetail.yo?nowPage="+nowPage+"&bidx="+bidx+"&sigungu_name="+sigungu_name+"&place_name="+place_name);
		}
		else {
			//삭제가 성공하면 목록보기
			System.out.println("삭제성공");
			//검색기능을 제외하고 전체 목록으로 들어가게함(기능보다 정확하게 수정할 필요있음)
			rv=new RedirectView("../board/boardList2.yo");
		}
		mv.setView(rv);
		return mv;
	}
	
	
	
	// 예시 함수 입니다-----------------------------------------------------------------------------------------------
		@RequestMapping("/board/example")
		public void example() {
			System.out.println("BoardController시작");
			
			try {
				//	service 함수 실행문
				//service.boardcommSelectService();
			} catch (Exception e) {
				System.out.println("BoardController 오류"+e);
			}
			
			System.out.println("BoardController끝");
			
		}
		
}
