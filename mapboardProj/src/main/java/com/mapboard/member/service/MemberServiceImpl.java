package com.mapboard.member.service;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mapboard.member.dao.MemberDao;
import com.mapboard.member.vo.MemberVO;


/*클래스 목적: 이 클래스는 MemberController에서 로직처리를 위임 받아 회원여부를 판단한 후 회원일 경우 로그인 처리를, 회원이 아닐경우 로그인 폼을 보여주는 기능
 * 작성자: 이덕천
 * 작성일: 2018-12-07
 * 최종수정일: 2018-12-16
 * 이력
 * 12/13 로그인 체크함수, 로그아웃 처리 함수 추가
 * 12/16 회원가입 처리 함수 추가
 */


@Service("memberService")
public class MemberServiceImpl implements MemberService{

	@Autowired
	private MemberDao mdao;
	
	//사용자 이름 조회 함수
	public MemberVO selectMemberbyId(String userid) {
		return mdao.selectMemberbyId(userid);
	}
	
	
	
	//회원가입 처리 함수
	@Override
	public void insertMember(MemberVO vo) {
		mdao.insertMember(vo);
	}

	//아이디 중복체크 함수
	@Override
	public int selectID(String userid) throws Exception {
		System.out.println("아이디 체크 서비스 실행 아이디="+userid);
		return mdao.selectID(userid);
	}
		
	
	//회원 로그인 체크하는 함수
	@Override
	public boolean loginProc(MemberVO vo, HttpSession session) {
		boolean result=mdao.loginProc(vo);
		if(result) {
			//true일 경우 세션에 등록
			MemberVO vo2 = viewMember(vo);
			//세션 변수에 등록
			session.setAttribute("userid", vo2.getUserid());
			session.setAttribute("uname", vo2.getUname());
			session.setAttribute("ulevel", vo2.getUlevel());
			
		}
		return result;
	}
	//회원 로그인 정보 처리 함수
	@Override
	public MemberVO viewMember(MemberVO vo) {
		return mdao.viewMember(vo);
		
	}
	//회원 로그아웃 처리 함수
	@Override
	public void logout(HttpSession session) {
		//세션변수 개별 삭제
		//session.removeAttribute("userId");
		//세션정보를 초기화 시킴
		session.invalidate();
		
	}
		
}