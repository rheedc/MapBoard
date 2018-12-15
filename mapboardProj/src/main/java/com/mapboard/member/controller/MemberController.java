package com.mapboard.member.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.mapboard.member.service.MemberService;
import com.mapboard.member.vo.MemberVO;


/*클래스 목적: 메인화면에서 로그인 폼을 보여주고 로그인을 처리하는 클래스
 * 작성자: 이덕천
 * 작성일: 2018-12-11
 * 최종수정일: 2018-12-13
 * 이력
 * 12/11: 최초작성
 * 12/12: 로그인 처리 함수 추가
 * 12/13: joinForm() 추가
 * 12/14: joinProc(), idCheckProc() 추가
 */

@Controller
@RequestMapping("/member")
public class MemberController {
	
	//서비스 클래스를 자동주입하는 명령
	@Autowired
	private MemberService mservice;
	
	
	//아이디 중복체크 처리
	@ResponseBody
	@RequestMapping("/idCheckProc")
	public int idCheckProc(@RequestBody String userid) throws Exception {
		System.out.println("idCheckProc함수 실행"+userid);
		
		int result = mservice.selectID(userid);
		System.out.println(result);
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
			mv.addObject("msg","로그인에 성공하였습니다.");
		}
		else {
			//로그인에 실패했을 경우 로그인 폼으로 이동
			RedirectView rv= new RedirectView("/member/LoginForm.yo");
			mv.setView(rv);
			mv.addObject("msg","로그인에 실패하였습니다.");
			
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
		mv.addObject("msg","로그아웃 되었습니다.");
		return mv;
	}
	
	
	
	
}
