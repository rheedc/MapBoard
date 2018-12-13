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

	//÷������ �˻����� ���� �Լ�(�󼼺��� ȭ�鿡 �ѷ��� ����)
	public ArrayList getFileInfo(int oriNo) {
		//������Ʈ��Ʈ ���ϱ� -> ���ǽ���
		return (ArrayList)sqlSession.selectList("fileBoardName.fileInfo", oriNo);	
	}
	
	//�ٿ�ε� ���� ���� �˻� ���� ���� �Լ�
	public FileinfoVO getDownload(int fileNo) {
		return (FileinfoVO)sqlSession.selectOne("fileBoardName.download", fileNo);
	}
	
}
*/