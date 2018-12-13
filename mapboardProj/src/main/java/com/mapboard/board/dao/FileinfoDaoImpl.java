/*package com.mapboard.board.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mapboard.board.vo.FileinfoVO;


@Service("fileinfoDao")
public class FileinfoDaoImpl implements FileinfoDao{

	@Autowired
	protected SqlSessionTemplate sqlSession;
	
	public void insertBoard(FileinfoVO vo,String kind) {
		sqlSession.insert("fileBoardName.insertFileInfo", vo);
	}

	//첨부파일 검색질의 실행 함수(상세보기 화면에 뿌려질 내용)
	public ArrayList getFileInfo(int oriNo) {
		//스테이트먼트 구하기 -> 질의실행
		return (ArrayList)sqlSession.selectList("fileBoardName.fileInfo", oriNo);	
	}
	
	//다운로드 파일 정보 검색 질의 실행 함수
	public FileinfoVO getDownload(int fileNo) {
		return (FileinfoVO)sqlSession.selectOne("fileBoardName.download", fileNo);
	}
	
}
*/