package com.mapboard.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

//클래스 목적: id,pw 값을 받아 세션에 해당 ID가 있으면 memberController를 실행하고 비회원이면 다시 로그인 폼을 보여주는 기능을 수행.
//					id,pw를 식별하여 True를 리턴하면 컨트롤러를 실행하고 False를 리턴하면 컨트롤러를 실행하지 않는다.
//작성자: 이덕천
//작성일: 2018.12.12
//최종수정일: 2018.12.12



public class LoginCheck extends HandlerInterceptorAdapter {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		System.out.println("LoginCheck.java 인터셉터 실행시작"+handler);
		HttpSession session = request.getSession();		
		String id = (String) session.getAttribute("id");
		if(id==null || id.length()==0) {
			System.out.println("회원 x");
			//로그인이 안된 경우 로그인 폼 화면으로 보내자. 왜??
			//그냥 false를 반환하면 컨트롤러가 실행되지 않으므로 웹페이지가 무응답상태가 된다.
			//따라서 강제로 다른 요청을 실행할 수 있도록 조치하는 것이다.
			try {
				response.sendRedirect("/member/LoginForm.yo");
			}
			catch(Exception e) {}
			return false;
		}else {
			//로그인이 된 경우
			System.out.println("회원 o");
			return true;
		}
	}

}