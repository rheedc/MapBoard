package com.mapboard.member.dao;

import javax.servlet.http.HttpSession;

import com.mapboard.member.vo.MemberVO;

/*클래스 목적: MemberDao와 관련된 함수를 정의하는 인터페이스
 * 작성자:
 * 작성일:2018-12-07
 * 최종수정일: 2018-12-13
 * 수정내용: 함수 변경
 */



public interface MemberDao{
	//회원 로그인 체크
	public  boolean loginProc(MemberVO vo);
	//회원 로그인 정보
	public MemberVO viewMember(MemberVO vo);
	//회원 로그아웃
	public void logout(HttpSession session);
	//아이디 중복체크
	public int selectID(String userid) throws Exception;
	
	
}