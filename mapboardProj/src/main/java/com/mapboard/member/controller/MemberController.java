package com.mapboard.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.mapboard.member.service.MemberService;

/*클래스 목적: 이 클래스는 회원가입, 로그인 등의 업무를 처리하는 클래스
 * 작성자: 이덕천
 * 작성일: 2018-12-07
 * 최종수정일: 2018-12-07
 */
@Controller
public class MemberController {

	@Autowired
	private MemberService mservice;
	
	
}
