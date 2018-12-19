package com.mapboard.board.dao;

import java.util.ArrayList;

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
	
	//첨부파일 검색(상세보기)
	@Override
	public ArrayList getFileDetail(int bidx) throws Exception {
		return (ArrayList)sqlSession.selectList("board.fileDetail", bidx);
	}
	
	//다운로드 파일 정보 검색 질의 실행 함수
	@Override
	public BoardVO getDownload(int fidx) throws Exception {
		return (BoardVO)sqlSession.selectOne("board.download", fidx);
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

	//게시판 삭제질의
	public int deleteBoard(BoardVO vo) {
		int cnt=sqlSession.update("board.deleteBoard",vo);
		return cnt;
	}

	//추천수 증가처리명령
	public void updateLikeCnt(int bidx) {
		sqlSession.update("board.updateLikeCnt",bidx);		
	}
	
	
}