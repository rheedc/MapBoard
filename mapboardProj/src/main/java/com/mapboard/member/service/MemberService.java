package com.mapboard.member.service;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import com.mapboard.member.vo.MemberVO;

/*클래스 목적: member서비스 클래스에서 사용할 함수를 정의하여 해당 패키지에서는 공통으로 사용하도록 설정해주는 인터페이스
 * 작성자: 이덕천
 * 작성일: 2018-12-07
 * 최종수정일: 2018-12-16
 * 이력
 * 12/13: 1,2,3 함수 추가
 * 12/14: 4 함수 추가
 * 12/16: 5,6 함수 추가
 */

public interface MemberService {
	//1.회원 로그인 체크 함수: MemberVO의 데이터와 session의 값을 받아서 처리하는 방식이다.
	public boolean loginProc(MemberVO vo, HttpSession session);
	
	//2.회원 로그인 처리 함수
	public MemberVO viewMember(MemberVO vo);
	
	//3.회원 로그아웃 처리 함수
	public void logout(HttpSession session);
	
	//4.아이디 중복체크 함수
	public int selectID(String userid) throws Exception;
	
	//5. 회원가입 처리 함수
	public void insertMember(MemberVO vo);
	
	//6. 사용자 이름 조회 함수
	public MemberVO selectMemberbyId(String userid);
	
	

}
