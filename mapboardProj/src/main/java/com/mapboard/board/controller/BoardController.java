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
	
		/*String sPath=req.getServletPath();
		sPath.equals("/upload/")
		req.getRealPath("/upload/");*/
		String fpath=req.getSession().getServletContext().getRealPath("/upload/");
		/*String fpath = req.getServletPath().getRealPath("/upload/");*/
		System.out.println("path="+fpath);
		
		//1) 파라미터
		ArrayList list = new ArrayList();
		for(int i=0 ; i<vo.getFiles().length ; i++) {
			//하나씩 파일의 실제 이름을 알아내자
			String foriname = vo.getFiles()[i].getOriginalFilename();
			
			//이미지 파일만 올라가도록 파일 확장자 제한하기
			if(!(foriname.toLowerCase().endsWith(".jpg") ||
					foriname.toLowerCase().endsWith(".jpeg") ||
					foriname.toLowerCase().endsWith(".png") ||
					foriname.toLowerCase().endsWith(".gif") ||
					foriname.toLowerCase().endsWith(".bmp"))) {
				continue;
			}
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
		
		//어디로 보낼지 구분하는 변수
		String my=req.getParameter("my");
		String sbidx = req.getParameter("bidx");
		int bidx = Integer.parseInt(sbidx);
		String strPage=req.getParameter("nowPage");				
		int nowPage=0;
		if(strPage==null || strPage.length()==0) {	
			nowPage=1;
		}else {
			nowPage=Integer.parseInt(strPage);
		}
		String sigungu_name=req.getParameter("sigungu_name");
		String place_name=req.getParameter("place_name");
		
		service.updateHit(bidx,session);
		
		RedirectView rv = new RedirectView("../board/boardDetail.yo");
		//컨트롤러에서 Redirect하면서 파라미터를 보내고 싶다면 
		//rv.addStaticAttribute(String형태 "키값",  데이터);
		rv.addStaticAttribute("bidx", bidx);
		rv.addStaticAttribute("nowPage", nowPage);
		rv.addStaticAttribute("sigungu_name", sigungu_name);
		rv.addStaticAttribute("place_name", place_name);	
		rv.addStaticAttribute("my", my);
		mv.setView(rv);
		return mv;
	}
	
	//상세보기 요청 함수(내용/첨부파일)
	@RequestMapping("/boardDetail")
	public ModelAndView boardDetail(@RequestParam(value="bidx") int bidx,
								@RequestParam(value="nowPage") int nowPage,
								HttpServletRequest req) throws Exception {		
		//어디로 보낼지 구분하는 변수
		String my=req.getParameter("my");
		
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
		mv.addObject("my", my);
		mv.setViewName("board/boardDetail");
		return mv;
	}

	//추천수 증가요청 함수
	@RequestMapping("/boardAddLike")
	public ModelAndView boardAddLike(ModelAndView mv, HttpSession session,
				HttpServletRequest req) throws Exception {
	
	
	System.out.println("추천수 증가요청들어옴");
	
	//어디로 보낼지 구분하는 변수
	String my=req.getParameter("my");
	String sbidx = req.getParameter("bidx");
	int bidx = Integer.parseInt(sbidx);
	String nowPage = req.getParameter("nowPage");	//릴레이용
	String sigungu_name=req.getParameter("sigungu_name");
	String place_name=req.getParameter("place_name");
	
	service.updateLikeCnt(bidx,session);
	
	RedirectView rv = new RedirectView("../board/boardDetail.yo");
	//컨트롤러에서 Redirect하면서 파라미터를 보내고 싶다면 
	//rv.addStaticAttribute(String형태 "키값",  데이터);
	rv.addStaticAttribute("bidx", bidx);
	rv.addStaticAttribute("nowPage", nowPage);
	rv.addStaticAttribute("sigungu_name", sigungu_name);
	rv.addStaticAttribute("place_name", place_name);	
	rv.addStaticAttribute("my", my);
	mv.setView(rv);
	return mv;
	}
	
	//파일 다운로드 요청 처리 함수
	@RequestMapping("/fileDownload")
	public ModelAndView fileDownload(
			@RequestParam(value="fidx") int fidx) throws Exception {
		
		BoardVO vo = service.getDownload(fidx);
		//다운로드 할 파일을 File이라는 클래스로 만들어서 제공하기로 했다.
		File file = new File(vo.getFpath(),vo.getFsname());
		
		ModelAndView mv = new ModelAndView("download", "downloadFile", file); 	//
		
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
	public ModelAndView updateProc(BoardVO vo, ModelAndView mv,
							HttpServletRequest req, RedirectView rv) throws Exception {
		boolean	isUpload = false;	//	첨부 파일 유무를 판단하는 변수
		//	확인하는 법 : 배열 변수의 내용을 하나씩 살펴서 한개라도 첨부 파일이 있으면 첨부 파일이 있는것.
		for(int i = 0; i < vo.getFiles().length; i++) {
			//	파일의 이름이 있는지 확인한다.
			String tempName = vo.getFiles()[i].getOriginalFilename();
			if(tempName != null && tempName.length() != 0) {   //	파일의 이름이 존재하므로 첨부 파일이 있는 것이다.
				isUpload = true;
				break;
			}
		}
				
		//	첨부 파일이 한개라도 있으면 파일을 업로드 시킨다.
		String	fpath = req.getSession().getServletContext().getRealPath("/upload/");
		ArrayList	fileList = new ArrayList();		//	실제 업로드된 파일의 정보를 기억할 변수
	
		//	한개의 업로드된 파일의 정보를 HashMap으로 만들어서
		//	이것을 ArrayList에 묶어서 처리할 예정
		if(isUpload == true) {
			//	첨부 파일의 개수만큼 반복하면서 하나씩 복사한다.
			for(int i = 0; i < vo.getFiles().length; i++) {
				//하나씩 파일의 실제이름을 알아내자
				String foriname = vo.getFiles()[i].getOriginalFilename();
				
				//파일이 업로드되지 않으면 다음 파일작업을 시도한다
				if(foriname==null || foriname.length()==0 ) {
					continue;
				}
				
				String fsname= FileUtil.renameTo(fpath, foriname);
				
				File file = new File(fpath, fsname);
				
				//transferTo()를 이용해서 복사
				try {
					vo.getFiles()[i].transferTo(file);
				} catch (Exception e) {
					e.printStackTrace();
					System.out.println("강제 복사 에러 = "+e);
				}
				
				//이제 하나의 파일이 업로드된 상태이다
				//업로드된 파일의 정보를  Map 묶자(path, oriName, saveName,len)
				HashMap map = new HashMap();
				//map.put("path",path);
				map.put("foriname",foriname);
				map.put("fsname",fsname);
				map.put("fsize",file.length());
				
				fileList.add(map);
			}//for
		}//if
		
		//	내용 수정하고
		//		데이터베이스를 이용해서 UPDATE 처리하고
		service.updateBoard(vo);
	
		//	항상 실행하는 것이 아니고 첨부 파일이 존재할 경우에만 실행하는 부분이다.
		if(isUpload == true) {
			
			//	1.	과거에 업로드된 파일을 삭제하자.
			//		1)	과거에 업로드된 파일의 정보를 디비에서 알아내고
			ArrayList list = service.getFileDetail((int)vo.getBidx());
			if(list != null && list.size()!=0 ) {
				for(int i=0; i<list.size(); i++) {
					//2)	그 파일을 File 객체로 만들어서(첨부파일은 여러개 있으므로...)
					//	한개씩 파일의 정보를 꺼내자.
					BoardVO tempVo = (BoardVO)list.get(i);
					File tempFile = new File(fpath, tempVo.getFsname());
					
					//3)	삭제한다.
					tempFile.delete();
				}//for
			}//if
	
			//	2.	기존 첨부 파일의 정보를 지우고
			service.deleteFileInfo((int)vo.getBidx());
			
			
			//	3.	데이터베이스에  재 등록한다.
			for(int i = 0; i < fileList.size(); i++) {
				BoardVO vo1 = new BoardVO();
				vo1.setBidx(vo.getBidx());
				vo1.setFpath(fpath);
				
				//앞에서 선택한 파일들  정보를 이용해서 등록하자.
				HashMap tempmap = (HashMap) fileList.get(i);
				//map.put("path",path);
				vo1.setForiname((String)tempmap.get("foriname"));
				vo1.setFsname((String)tempmap.get("fsname"));
				vo1.setFsize((java.lang.Long)tempmap.get("fsize"));
				
				service.insertFileInfo(vo1);
			}//for
		}//if – fService.updateBoard(vo);이후
		
		
		//	뷰
		// RedirectView rv = new RedirectView("요청내용");
		rv.setUrl("../board/boardDetail.yo");//상세보기
		rv.addStaticAttribute("bidx",vo.getBidx());
		rv.addStaticAttribute("nowPage", vo.getNowPage());
		mv.setView(rv);
		return mv;
	}
	
	//게시판 내용삭제
	@RequestMapping("/boardDelete")
	public ModelAndView boardDelete(@RequestParam(value="bidx") int bidx,
			@RequestParam(value="nowPage") int nowPage,
			HttpSession session,
			HttpServletRequest req) throws Exception {
		
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
