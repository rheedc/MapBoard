/*package com.mapboard.board.controller;

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
import com.mapboard.util.PageUtil;



@Controller
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private BoardService service;
	
	//1. 목록보기
	@RequestMapping("/boardList")
	public void boardList(@RequestParam(value="nowPage", defaultValue="1") int nowPage,
									HttpServletRequest req) {
		
		System.out.println("controller의 boardList 시작");
		
		//1) 페이지 이동 기능
		PageUtil pInfo =service.getPageInfo(nowPage);
		
		//2) 게시물 꺼내오기
		ArrayList list = service.getBoardList(pInfo);
		System.out.println("게시물수 = "+list.size());
		
		//3) 모델 만들기
		req.setAttribute("PINFO", pInfo);
		req.setAttribute("LIST", list);
		
		System.out.println("controller의  boardList 끝");
	}
	
	//2. 글쓰기 폼보기 요청
	@RequestMapping("/writeForm")
	public void writeForm() {
		//인터셉터를 이용하여 로그인 처리 했기 때문에 딱히 할일이 없다.
		System.out.println("controller의 writeForm 시작과 끝");
	}									
	
	
	//3. 글쓰기
	@RequestMapping("/writeProc")
	public ModelAndView writeProc(BoardVO vo, HttpSession session) {
		System.out.println("controller의 writeProc 시작");
		
		//1) 파라미터
		String path = "E:\\upload";
		//파일정보를 하나로 묶기 위한 변수
		ArrayList list = new ArrayList();
		for(int i=0 ; i<vo.getFiles().length ; i++) {
			//하나씩 파일의 실제 이름을 알아내자
			String oriName = vo.getFiles()[i].getOriginalFilename();
			//파일이 업로드 되지 않으면 다음 파일작업을 시도한다.
			if(oriName==null || oriName.length()==0) {
				continue;
			}
			String saveName = FileUtil.renameTo(path, oriName);		//FileUtil			
			File file = new File(path, saveName);					
			//transferTo()를 이용해서 복사
			try {
				vo.getFiles()[i].transferTo(file);	//path에 saveName을 저장
			} catch (Exception e) {
				System.out.println("강제복사 에러 = "+e);
			} 			
			//이제 하나의 파일이 업로드된 상태
			//업로드된 파일의 정보를 Map으로 묶자.(path,oriName,saveName,len)
			HashMap map = new HashMap();
			map.put("path", path);
			map.put("oriName", oriName);
			map.put("saveName", saveName);
			map.put("len", file.length());			
			list.add(map);	//한번씩 돌 때마다 리스트에 추가			
		}//for 끝
		
		//2) 서비스
		service.insertBoard(vo, session, list); 
		
		//3) 모델
		//4) 뷰 호출
		ModelAndView mv = new ModelAndView();
		RedirectView view = new RedirectView("../fileBoard/boardList.sun");
		mv.setView(view);
		return mv;
	}
	
	//4. 조회수 증가
	@RequestMapping("/hitProc")
	public ModelAndView boardHitProc(HttpServletRequest req, ModelAndView mv,
																					HttpSession session) {
		//1) 파라미터
		String strNo = req.getParameter("oriNo");
		int oriNo = Integer.parseInt(strNo);
		String nowPage = req.getParameter("nowPage");	//릴레이용
		
		//2) 서비스	
		service.updateHit(oriNo, session);
		
		//3) 모델 4)뷰
		//컨트롤러에서 강제로 상세보기 Redirect
		RedirectView rv = new RedirectView("../fileBoard/boardView.sun");
		//컨트롤러에서 Redirect하면서 파라미터를 보내고 싶다면 
		//rv.addStaticAttribute(String형태 "키값",  데이터);
		rv.addStaticAttribute("oriNo", oriNo);
		rv.addStaticAttribute("nowPage", nowPage);
		mv.setView(rv);
		return mv;
	}
	
	//5. 상세보기 함수
	@RequestMapping("/boardView")
	public ModelAndView boardView(@RequestParam(value="oriNo") int oriNo,
			@RequestParam(value="nowPage") int nowPage) {		

		//2) 서비스
		//(1) 상세보기 내용검색
		BoardVO vo = service.getBoardView(oriNo);
						
		//(2) 파일정보 검색
		ArrayList list = service.getFileInfo(oriNo);
		
		//3) 모델
		ModelAndView mv = new ModelAndView();
		mv.addObject("VIEW", vo);									//내용
		mv.addObject("LIST", list);									//첨부파일 정보
		mv.addObject("nowPage", nowPage);			//릴레이용
		
		//4) 뷰
		mv.setViewName("fileBoard/boardView");
		return mv;
	}
	
	//6. 파일 다운로드
	@RequestMapping("/fileDownload")
	public ModelAndView fileDownload(
			@RequestParam(value="fileNo") int fileNo) {
		
		//2) 서비스
		FileinfoVO vo = service.getDownload(fileNo);
		//다운로드 할 파일을 File이라는 클래스로 만들어서 제공하기로 했다.
		File file = new File(vo.getPath(),vo.getSaveName());
		
		//3) 모델 4) 뷰
		//setView : redirect용
		//setViewName : 일반뷰
		//★★★사용자 정의 뷰 호출하기
		//형식> new ModelAndView("사용자정의 뷰명","전달할 데이터 키값",전달할 데이터);
		ModelAndView mv = 
					new ModelAndView("download", "downloadFile", file); 	//sun-context.xml
		return mv;
		}	
	
	
	
	
	
	//7. 댓글----------------------------------------------------나중에 하기
	@RequestMapping("board/replyModify")
	public void replyModify() {
		System.out.println("test 컨트롤러의 replyModify");
	}
	
	@RequestMapping("board/modifyForm")
	public void replyForm() {
		System.out.println("test 컨트롤러의 replyForm");
	}
	
	@RequestMapping("board/boardDetail")
	public void boardDetail() {
		System.out.println("test 컨트롤러의 boardDetail");
	}
	
	
	
	
	
	
	// 예시 함수 입니다-----------------------------------------------------------------------------------------------
		@RequestMapping("/board/example")
		public void example() {
			System.out.println("BoardController시작");
			
			try {
				//	service 함수 실행문
				service.boardcommSelectService();
			} catch (Exception e) {
				System.out.println("BoardController 오류"+e);
			}
			
			System.out.println("BoardController끝");
			
		}
		
}
*/