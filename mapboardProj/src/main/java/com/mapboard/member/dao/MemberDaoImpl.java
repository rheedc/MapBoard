package com.mapboard.member.dao;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mapboard.member.vo.MemberVO;

/*클래스 목적: DAO는 컨트롤러, 서비스 클래스에서 사용. 이 클래스는 myBatis를 이용해서 필요한 질의명령( ~~~Sql.xml 파일)을
 * 실행하고 그 결과를 전달하기 위한 클래스. 직접 db에 연결하고 난 뒤 ~~~Sql.xml 파일을 이용해서 질의 명령을 처리하는 방식
 * 작성자: 이덕천
 * 작성일: 2018.12.12
 * 최종수정일: 2018.12.18
 * 이력
 * 12/12: 최초 작성
 * 12/13: memberDao의 함수 변경에 따라 실행함수 변경
 * 12/15: 아이디 체크 함수 추가
 * 12/16: 회원가입 처리 함수 추가
 * 12/17: 게시글 갯수, 본인확인, 사용자 이름 조회, 회원 목록 함수 추가
 * 12/18: 회원탈퇴, 나의정보 수정 함수 추가
 * 12/19: 회원정보 수정 함수 추가
*/

@Service("memberDao")
public class MemberDaoImpl implements MemberDao{

	@Autowired
	protected SqlSessionTemplate sqlSession;
	
	//회원 정보 수정(관리자)
	@Override
	public void memberUpdateAmin(MemberVO vo) {
		sqlSession.update("member.memberUpdateAmin", vo);
			
	}

	//회원탈퇴 처리
	@Override
	public int leaveMemberProc(MemberVO vo) {
		int result=sqlSession.update("member.statusN", vo);
		return result;
	}
		
	//나의 정보 수정
	@Override
	public void memberUpdate(MemberVO vo) {
		sqlSession.update("member.memberUpdate", vo);
		
	}

	//사용자 이름 조회 쿼리문 실행
	@Override
	public MemberVO selectMemberbyId(String userid) {
		
		return sqlSession.selectOne("member.selectMemberbyId",userid);
	}


	//본인확인 쿼리문 실행
	public int selectMeChk(MemberVO vo) {
		int result = sqlSession.selectOne("member.meCheck", vo);
		return result;
	}

	//회원 목록조회 쿼리문 실행
	@Override
	public ArrayList<?> getMemberList(MemberVO vo) {
		ArrayList result=(ArrayList) sqlSession.selectList("member.memeberList",vo);
		return result;
	}

	//게시글 총 갯수를 구하는 쿼리문 실행
	@Override
	public int getTotalCount() {
		int result=sqlSession.selectOne("member.totalCount");
		return result ;
	}


	//회원가입 처리 쿼리문 실행
	@Override
	public void  insertMember(MemberVO vo) {
		sqlSession.insert("member.insertMember", vo);
		
	}
	
	//id체크 쿼리문 실행
	@Override
	public int selectID(String useid) throws Exception {
		int result =sqlSession.selectOne("member.idChk", useid);
		
		return result;
	}	
		
	//회원 로그인 체크 함수
	@Override
	public boolean loginProc(MemberVO vo) {
		String name=sqlSession.selectOne("member.loginChk", vo);
		return (name == null) ? false : true;
	}
	
	//회원 로그인 정보 함수
	@Override
	public MemberVO viewMember(MemberVO vo) {
		return sqlSession.selectOne("member.viewMember", vo);
	}
	//회원 로그아웃 처리 함수
	@Override
	public void logout(HttpSession session) {
				
	}

	
	
}