package com.mapboard.member.service;

import javax.servlet.http.HttpSession;

import com.mapboard.member.vo.MemberVO;

/*클래스 목적: member서비스 클래스에서 사용할 함수를 정의하여 해당 패키지에서는 공통으로 사용하도록 설정해주는 인터페이스
 * 작성자: 이덕천
 * 작성일: 2018-12-07
 * 최종수정일: 2018-12-12
 */

public interface MemberService {
	//회원 로그인 체크 함수: MemberVO의 데이터와 session의 값을 받아서 처리하는 방식이다.
	public boolean loginProc(MemberVO vo, HttpSession session);
	
	//회원 로그인 처리 함수
	public MemberVO viewMember(MemberVO vo);
	
	//회원 로그아웃 처리 함수
	public void logout(HttpSession session);
	

}
