/*package com.mapboard.board.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mapboard.board.vo.BoardVO;


@Service("boardDao")
public class BoardDaoImpl implements BoardDao{

	@Autowired
	protected SqlSessionTemplate sqlSession;
	
	public void insertBoard(BoardVO vo,String kind) {
		sqlSession.insert("fileBoardName.insertBoard", vo);
	}
	
	public int getTotalCount(){
		//질의를 실행할 스테이트먼트 구하기
		//질의문 실행
		int result = sqlSession.selectOne("fileBoardName.totalCount");
		//결과를 반환
		return result;
	}
	
	//해당 페이지에 보여줄 게시물 정보 구하기 질의 실행
	public ArrayList getBoardList(BoardVO vo){
		//스테이트먼트 구하기 -> 질의실행
		return (ArrayList)sqlSession.selectList("fileBoardName.boardList", vo);		
	}
	
	//상세보기 질의명령 실행 함수
	public BoardVO getBoardView(int no) {//sql id
		//스테이트먼트 구하기 -> 질의실행
		return (BoardVO)sqlSession.selectOne("fileBoardName.boardView", no);
	}
	
	//조회수 증가질의 실행 함수(상세보기 화면 뿌려지기 위함)
	public void updateHit(int no) {
		//스테이트먼트 구하기 -> 질의 실행
		sqlSession.update("fileBoardName.updateHit", no);
	}
	
}*/
