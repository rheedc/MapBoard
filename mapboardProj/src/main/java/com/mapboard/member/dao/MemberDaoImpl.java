package com.mapboard.member.dao;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mapboard.member.vo.MemberVO;

/*클래스 목적: DAO는 컨트롤러, 서비스 클래스에서 사용. 이 클래스는 myBatis를 이용해서 필요한 질의명령( ~~~Sql.xml 파일)을
 * 실행하고 그 결과를 전달하기 위한 클래스. 직접 db에 연결하고 난 뒤 ~~~Sql.xml 파일을 이용해서 질의 명령을 처리하는 방식
 * 작성자: 이덕천
 * 작성일: 2018.12.12
 * 최종수정일: 2018.12.13
 * 이력
 * 12/12: 최초 작성
 * 12/13: memberDao의 함수 변경에 따라 실행함수 변경
 * 12/15: 아이디 체크 함수 추가
 * 12/16: 회원가입 처리 함수 추가
 * 
*/

@Service("memberDao")
public class MemberDaoImpl implements MemberDao{

	@Autowired
	protected SqlSessionTemplate sqlSession;
	//membersql.xml 파일의 쿼리문을 실행하고 그 결과값을 map 담아 반환한다.
	
	
	
	//사용자 이름 검색 쿼리문 실행
	@Override
	public MemberVO selectMemberbyId(String userid) {
		System.out.println("사용자 정보 검색 쿼리 실행");
		return sqlSession.selectOne("member.selectMemberbyId",userid);
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
		System.out.println("아이디 체크 실행결과="+result);
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