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
		//���Ǹ� ������ ������Ʈ��Ʈ ���ϱ�
		//���ǹ� ����
		int result = sqlSession.selectOne("fileBoardName.totalCount");
		//����� ��ȯ
		return result;
	}
	
	//�ش� �������� ������ �Խù� ���� ���ϱ� ���� ����
	public ArrayList getBoardList(BoardVO vo){
		//������Ʈ��Ʈ ���ϱ� -> ���ǽ���
		return (ArrayList)sqlSession.selectList("fileBoardName.boardList", vo);		
	}
	
	//�󼼺��� ���Ǹ�� ���� �Լ�
	public BoardVO getBoardView(int no) {//sql id
		//������Ʈ��Ʈ ���ϱ� -> ���ǽ���
		return (BoardVO)sqlSession.selectOne("fileBoardName.boardView", no);
	}
	
	//��ȸ�� �������� ���� �Լ�(�󼼺��� ȭ�� �ѷ����� ����)
	public void updateHit(int no) {
		//������Ʈ��Ʈ ���ϱ� -> ���� ����
		sqlSession.update("fileBoardName.updateHit", no);
	}
	
}*/
