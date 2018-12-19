package com.mapboard.board.dao;

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
	public void insertBoard(BoardVO vo, String kind) throws Exception{
		System.out.println("insertBoardDAO시작");
		if(kind.equals("board")) {
			sqlSession.insert("board.insertBoard", vo);
		}
		else if(kind.equals("fileInfo")) {
			sqlSession.insert("board.insertFileInfo",vo);
		}
		
	}
	
	
	//상세보기
	@Override
	public BoardVO getBoardDetail(int bidx) throws Exception {
		
		return (BoardVO)sqlSession.selectOne("board.boardDetail",bidx);
	}
	
	//게시물 수정
	@Override
	public void updateBoard(BoardVO vo) throws Exception {
		sqlSession.update("board.updateBoard", vo);
		
	}

	//조회수 증가처리명령
	public void updateHit(int bidx) {
		sqlSession.update("board.updateHit",bidx);
	}
	
	
}