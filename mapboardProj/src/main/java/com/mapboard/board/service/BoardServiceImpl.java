/*package com.mapboard.board.service;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mapboard.board.dao.BoardDao;
import com.mapboard.board.dao.BoardcommDao;
import com.mapboard.board.dao.FileinfoDao;
import com.mapboard.board.vo.BoardVO;
import com.mapboard.board.vo.FileinfoVO;




@Service("boardService")
public class BoardServiceImpl implements BoardService{

	@Autowired
	private BoardcommDao bcDao;
	@Autowired
	private BoardDao bDao;
	@Autowired
	private FileinfoDao fDao;
	
	// board-----------------------------------------------------����
	//�󼼺��� �Լ�
	@Override
	public BoardVO boardSelectService(int oriNo) throws Exception {
		BoardVO vo = bDao.getBoardView(oriNo);
		return vo;
	}
	
	//�Խù� ��� �Լ�
	@Override
	public void boardInsertService(BoardVO vo, HttpSession session, ArrayList list) throws Exception {
		System.out.println("���ǹ� ���� ���� no ���� ��="+vo.getNo());
		
		String id = (String)session.getAttribute("UID");	//MemberService
		//���� ����� ������ �� �ʿ��� �����ʹ� vo�� ��� �˷��ֱ�� �����Ƿ�...
		vo.setId(id);
		//�Խù��� ���
		fDao.insertBoard(vo, "board");	//FileBoardDAO
		System.out.println("���ǹ� ���� ��"+vo.getNo());
		
		//���ε�� ���������� ���
		//������ ������ list�� ������ �ִ� ������ŭ ó���Ǿ�� �Ѵ�.
		for(int i=0; i<list.size(); i++) {
			//���ǹ��� ������ �� �ʿ��� ��� ������ vo�� �̿��ؼ� �˷��ֱ�� �����Ƿ�...
			vo.setOriNo(vo.getNo());
			//���Ͽ� ���� ������ list�� ������ �ְ�
			//�ϳ��� ������ ������ Map���� ������ �������Ƿ� 
			HashMap map = (HashMap)list.get(i);
			vo.setPath((String)map.get("path"));
			vo.setOriName((String)map.get("oriName"));
			vo.setSaveName((String)map.get("saveName"));
			vo.setLen((Long)map.get("len"));
			//���� ��� ����
			fDao.insertBoard(vo, "fileInfo");
		}//end for
	}

	@Override
	public void boardUpdateService() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void boardDeleteService() throws Exception {
		// TODO Auto-generated method stub
		
	}
	
	//��ȸ�� �������� ���� �Լ�(�󼼺��� ȭ�� �ѷ����� ����)
	@Override
	public void updateHit(int oriNo, HttpSession session) {
		//�ش� �Խù� ��ȸ�� ����ó���� ���ֱ� ���ؼ� ������ �˾Ƴ��� �������θ� �Ǵ�
		//oriNo ��ȸ�� ������ �۹�ȣ
		//���ǿ� "HIT"��� Ű������ ���ſ� �� �Խù� ��ȣ
		//ArrayList�� ��� ������� ����
		��) 1,3�� ������
		 * ArrayList list = new ArrayList();
		 * list.add(1);
		 * list.add(3);
		 * session.setAttribute("HIT",list);
		
		boolean isHit = false;	//��ȸ���� �������� ������ ����� ����
		ArrayList hitList = (ArrayList)session.getAttribute("HIT");
		
		//���� �湮�� ����� ���
		if(hitList==null || hitList.size()==0) {
			isHit = true;
			hitList = new ArrayList();
			hitList.add(oriNo);
			session.setAttribute("HIT",hitList);
		}
		else if(!hitList.contains(oriNo)) {//ó�� �湮�� �ƴ����� �ش� ���� ó������ ���
			isHit = true;
			hitList.add(oriNo);
			session.setAttribute("HIT",hitList);
		}
		else {
			isHit = false;	//��ȸ�� ����x
		}
		
		if(isHit == true) {
			fDao.updateHit(oriNo); //��ȸ�� ����
		}
		
	}
	// board-----------------------------------------------------��
	// boardcomm-----------------------------------------------------����
	@Override
	public void boardcommSelectService() throws Exception {
		System.out.println("boardcommSelectService����");
		
		bcDao.example();
		
		System.out.println("boardcommSelectService��");
		
	}

	@Override
	public void boardcommInsertService() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void boardcommUpdateService() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void boardcommDeleteService() throws Exception {
		// TODO Auto-generated method stub
		
	}
	// boardcomm-----------------------------------------------------��
	// fileinfo-----------------------------------------------------����
	
	//�󼼺��� ÷������
	@Override
	public ArrayList fileinfoSelectService(int oriNo) throws Exception {
		//÷������ ���� �˻��ؼ� �˷��ش�.
		ArrayList list = fDao.getFileInfo(oriNo);
		return list;
	}

	@Override
	public void fileinfoInsertService() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void fileinfoUpdateService() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void fileinfoDeleteService() throws Exception {
		// TODO Auto-generated method stub
		
	}

	//�ٿ�ε� ���� ���� �˻� ���� ���� �Լ�
	@Override
	public FileinfoVO getDownload(int fileNo) {
		FileinfoVO vo = fDao.getDownload(fileNo);
		return vo;
	}
	// filrinfo-----------------------------------------------------��	

	
	

}
*/