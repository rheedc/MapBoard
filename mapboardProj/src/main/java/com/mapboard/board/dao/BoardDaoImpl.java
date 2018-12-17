package com.mapboard.board.dao;
import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.mapboard.board.vo.BoardVO;
import com.mapboard.board.vo.FileinfoVO;
@Service("boardDao")
public class BoardDaoImpl implements BoardDao{
	@Autowired
	protected SqlSessionTemplate sqlSession;
	
	//1-1. 상가명 가져오기
	public BoardVO getSelectName(int place_no)throws Exception{
		return (BoardVO) sqlSession.selectOne("board.selectName", place_no);
		
	}
	
	//1-2. 게시물 등록
	public void insertBoard(BoardVO vo) throws Exception{
		sqlSession.insert("board.insertBoard", vo);
	}
	
	
	//2-1. 해당 페이지에 보여줄 게시물 정보 구하기 질의 실행 : 페이징
	public ArrayList getBoardList(BoardVO vo)throws Exception{
		//스테이트먼트 구하기 -> 질의실행
		return (ArrayList)sqlSession.selectList("board.boardList", vo);		
	}
	
	//2-2. 게시물 수 구하기
	public int getTotalCount()throws Exception{
		//질의를 실행할 스테이트먼트 구하기
		//질의문 실행
		int result = sqlSession.selectOne("board.totalCount");
		//결과를 반환
		return result;
	}
	

	
	
	
}