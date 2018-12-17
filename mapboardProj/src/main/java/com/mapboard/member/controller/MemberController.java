package com.mapboard.member.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.mapboard.member.service.MemberService;
import com.mapboard.member.vo.MemberVO;
import com.mapboard.util.PageUtil;


/*클래스 목적: 메인화면에서 로그인 폼을 보여주고 로그인을 처리하는 클래스
 * 작성자: 이덕천
 * 작성일: 2018-12-11
 * 최종수정일: 2018-12-16
 * 이력
 * 12/11: 최초작성
 * 12/12: 로그인 처리 함수 추가
 * 12/13: joinForm() 추가
 * 12/14: joinProc(), idCheckProc() 추가
 * 12/16: joinProc() 변경, memberDetail() 추가
 * 12/17: memberUpdateForm() 추가
 */

@Controller
@RequestMapping("/member")
public class MemberController {
	
	//서비스 클래스를 자동주입하는 명령
	@Autowired
	private MemberService mservice;
	
	
	//회원목록보기 요청 처리
	@RequestMapping("/memberList")
	public String memberList(@RequestParam(value="nowPage", defaultValue="1") int nowPage, HttpServletRequest req) {
		PageUtil pInfo = mservice.getPageInfo(nowPage);
		ArrayList list=mservice.getMemberList(pInfo);
		System.out.println("게시물 수="+list.size());
		
		//모델
		req.setAttribute("PINFO",pInfo);
		req.setAttribute("MLIST", list);
		
		//뷰
		return "admin/memberList";
		
	}
	
	

	//나의 정보 수정 폼 보여주기 요청 처리
	@RequestMapping("/memberUpdateForm")
	public ModelAndView memberUpdateForm(ModelAndView mv, HttpServletRequest req) {
		HttpSession session = req.getSession();
		String userid = session.getAttribute("userid").toString();
		System.out.println("회원정보수정 컨트롤러 실행 userid="+userid);
		MemberVO vo = new MemberVO();
		vo=mservice.selectMemberbyId(userid);
		
		//모델
		mv.addObject("VIEW", vo);
		
		//뷰
		mv.setViewName("/member/memberUpdateForm");
		return mv;
		
	}
	
	
	
	
	//나의 정보 상세보기 처리
	@RequestMapping("/memberDetail")
	public ModelAndView memberDatail(ModelAndView mv, HttpServletRequest req) {
		HttpSession session = req.getSession();
		String userid = session.getAttribute("userid").toString();
		System.out.println("회원상세 컨트롤러 실행 userid="+userid);
		MemberVO vo = new MemberVO();
		vo=mservice.selectMemberbyId(userid);
		
		//모델
		mv.addObject("VIEW", vo);
		
		//뷰
		mv.setViewName("/member/memberDetail");
		return mv;
	}
	
	//회원가입 요청 처리 
	@RequestMapping("/joinProc")
	public ModelAndView joinProc(MemberVO vo, ModelAndView mv, HttpServletRequest req) {
		//파라미터는 VO로 받고
		String userid = req.getParameter("userid");
		System.out.println("회원가입 컨트롤러 실행 userid="+userid);
		//입력 받은 값을 DB에 insert 하는 로직
		//해당 ID에 대한 이름을 select하는 로직=> 서비스 위임
		mservice.insertMember(vo);
		vo=mservice.selectMemberbyId(userid);
		
		//모델
		mv.addObject("VIEW", vo);
		
		//뷰
		mv.setViewName("/member/actionResult");
		return mv;
	}
		
			
	//아이디 중복체크 처리
	@ResponseBody
	@RequestMapping(value="/idCheckProc", method=RequestMethod.POST)
	public String idCheckProc(@RequestBody String userid) throws Exception {
		System.out.println("idCheckProc함수 실행 시작 아이디="+userid+" 받음");
		
		int intResult=mservice.selectID(userid);
		String result =Integer.toString(intResult);
		
		System.out.println("idCheckProc함수 실행 결과 ="+result+" 받음");
		return result;
	}
	
		
	//회원가입 폼 보여주기 요청 처리
	@RequestMapping("/joinForm")
	public void joinForm() {
		//할일: 요청을 받아 회원가입폼 jsp 로 Redirect 시켜주는 기능
		// 1. 파라미터 받고: 해당 없음
		// 2. 로직처리=> 서비스 위임: 해당없음
		// 3. 모델: 해당없음
		// 4. 뷰에게 전달
	
	}
		
	//로그인 폼 보여주기 요청 처리
	@RequestMapping("/LoginForm")
	public void loginForm() {
		//할일: 요청을 받아 로그인폼 jsp 로 Redirect 시켜주는 기능
		// 1. 파라미터 받고: 해당 없음
		// 2. 로직처리=> 서비스 위임: 해당없음
		// 3. 모델: 해당없음
		// 4. 뷰에게 전달
	
	}
	
	//로그인 요청 처리
	@RequestMapping("/LoginProc")
	public ModelAndView loginProc(MemberVO vo, HttpSession session) {
		System.out.println("loginProc실행 시작");
		//할일: 입력받은 ID,PW를 식별하여 로그인을 처리해 주는 기능
		// 1. 파라미터 받고 MemberVO vo, HttpSession session
		
		// 2. 로직처리=> 서비스 위임, 로그인 검사=> 해당 회원이 있는지 확인
		boolean result = mservice.loginProc(vo, session);
				
		//3. 그 결과 받아서 모델 생성
		ModelAndView mv= new ModelAndView();
		
		//4. 뷰를 호출=> Redirect 코드
		if(result==true) {
			//로그인을 성공할 경우 홈페이지로 이동
			RedirectView rv= new RedirectView("/");
			mv.setView(rv);
			//mv.addObject("msg","로그인에 성공하였습니다.");
		}
		else {
			//로그인에 실패했을 경우 로그인 폼으로 이동
			RedirectView rv= new RedirectView("/member/LoginForm.yo");
			mv.setView(rv);
			//mv.addObject("msg","로그인에 실패하였습니다.");
			
		}
				
		System.out.println("loginProc실행 완료");
		return mv;
	}
	
	//로그아웃 요청 처리
	@RequestMapping("/LogoutProc")
	public ModelAndView logoutProc(HttpSession session) {
		mservice.logout(session);
		ModelAndView mv= new ModelAndView();
		RedirectView rv= new RedirectView("/member/LoginForm.yo");
		mv.setView(rv);
		//mv.addObject("msg","로그아웃 되었습니다.");
		return mv;
	}
	
	
	
	
}
