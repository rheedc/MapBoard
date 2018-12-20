package com.mapboard.board.dao;

import java.util.ArrayList;

import com.mapboard.board.vo.BoardVO;
import com.mapboard.board.vo.FileinfoVO;



public interface BoardDao {

	//여기서 함수를 작성 후 BoardDaoImpl.java에 구현해주세요
	public BoardVO getSelectName(int place_no)throws Exception;
	
	public void insertBoard(BoardVO vo, String kind) throws Exception;
	
	public BoardVO getBoardDetail(int bidx) throws Exception;
	
	//첨부파일 검색(상세보기)
	public ArrayList getFileDetail(int bidx) throws Exception;
	
	//다운로드 파일 정보 검색 질의 실행 함수
	public BoardVO getDownload(int fileNo)  throws Exception;
	
	//게시판 수정
	public void updateBoard(BoardVO bvo) throws Exception;

	//첨부 파일 정보 삭제
	public void deleteFileInfo(int bidx) throws Exception;

	//게시판 삭제질의
	public int deleteBoard(BoardVO vo) throws Exception;

	//조회수 증가처리명령
	public void updateHit(int bidx) throws Exception;
		
	//추천수 증가처리명령
	public void updateLikeCnt(int bidx) throws Exception;
	
	
}