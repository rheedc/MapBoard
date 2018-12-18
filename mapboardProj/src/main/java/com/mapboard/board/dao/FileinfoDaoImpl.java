package com.mapboard.board.dao;
import java.util.ArrayList;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mapboard.board.vo.BoardVO;
import com.mapboard.board.vo.FileinfoVO;
@Service("fileinfoDao")
public class FileinfoDaoImpl implements FileinfoDao{
	@Autowired
	protected SqlSessionTemplate sqlSession;
	
	//파일을 게시물에 등록
	public void insertFileInfo(FileinfoVO fvo) {
		sqlSession.insert("fileinfo.insertFileInfo", fvo);
	}
		
	
	
	
}
