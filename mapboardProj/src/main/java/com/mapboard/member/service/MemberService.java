package com.mapboard.member.service;

import java.util.ArrayList;
import javax.servlet.http.HttpSession;

import com.mapboard.member.vo.MemberVO;
import com.mapboard.util.PageUtil;

/*클래스 목적: member서비스 클래스에서 사용할 함수를 정의하여 해당 패키지에서는 공통으로 사용하도록 설정해주는 인터페이스
 * 작성자: 이덕천
 * 작성일: 2018-12-07
 * 최종수정일: 2018-12-16
 * 이력
 * 12/13: 1,2,3 함수 추가
 * 12/14: 4 함수 추가
 * 12/16: 5,6 함수 추가
 * 12/17: 7, 8,9 함수 추가
 * 12/18: 10,11 함수 추가
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
	
	//7. 페이지 이동 정보를 만들어 주는 함수
	public PageUtil getPageInfo(int nowPage);
	
	//8. 회원 목록정보 구하기 함수
	public ArrayList<?> getMemberList(PageUtil pInfo);
	
	//9. 본인확인 함수
	public int selectMeChk(MemberVO vo);
	
	//10. 회원탈퇴
	public int leaveMemberProc(MemberVO vo);
	
	//11. 나의 정보 수정
	public void memberUpdate(MemberVO vo);
	

}
