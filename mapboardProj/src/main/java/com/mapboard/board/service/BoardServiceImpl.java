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
	
	// board-----------------------------------------------------시작
	//상세보기 함수
	@Override
	public BoardVO boardSelectService(int oriNo) throws Exception {
		BoardVO vo = bDao.getBoardView(oriNo);
		return vo;
	}
	
	//게시물 기록 함수
	@Override
	public void boardInsertService(BoardVO vo, HttpSession session, ArrayList list) throws Exception {
		System.out.println("질의문 실행 전의 no 변수 값="+vo.getNo());
		
		String id = (String)session.getAttribute("UID");	//MemberService
		//질의 명령을 실행할 때 필요한 데이터는 vo로 묶어서 알려주기로 했으므로...
		vo.setId(id);
		//게시물을 등록
		fDao.insertBoard(vo, "board");	//FileBoardDAO
		System.out.println("질의문 실행 후"+vo.getNo());
		
		//업로드된 파일정보를 등록
		//파일의 정보는 list가 가지고 있는 개수만큼 처리되어야 한다.
		for(int i=0; i<list.size(); i++) {
			//질의문을 실행할 때 필요한 모든 정보는 vo를 이용해서 알려주기로 했으므로...
			vo.setOriNo(vo.getNo());
			//파일에 대한 정보는 list가 가지고 있고
			//하나의 파일의 정보는 Map으로 저장해 놓았으므로 
			HashMap map = (HashMap)list.get(i);
			vo.setPath((String)map.get("path"));
			vo.setOriName((String)map.get("oriName"));
			vo.setSaveName((String)map.get("saveName"));
			vo.setLen((Long)map.get("len"));
			//질의 명령 실행
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
	
	//조회수 증가질의 실행 함수(상세보기 화면 뿌려지기 위함)
	@Override
	public void updateHit(int oriNo, HttpSession session) {
		//해당 게시물 조회수 증가처리를 해주기 위해서 세션을 알아내서 증가여부를 판단
		//oriNo 조회수 증가할 글번호
		//세션에 "HIT"라는 키값으로 과거에 본 게시물 번호
		//ArrayList로 묶어서 기억해줄 예정
		예) 1,3번 봤으면
		 * ArrayList list = new ArrayList();
		 * list.add(1);
		 * list.add(3);
		 * session.setAttribute("HIT",list);
		
		boolean isHit = false;	//조회수를 증가할지 말지를 기억할 변수
		ArrayList hitList = (ArrayList)session.getAttribute("HIT");
		
		//최조 방문한 사람인 경우
		if(hitList==null || hitList.size()==0) {
			isHit = true;
			hitList = new ArrayList();
			hitList.add(oriNo);
			session.setAttribute("HIT",hitList);
		}
		else if(!hitList.contains(oriNo)) {//처음 방문은 아니지만 해당 글은 처음보는 경우
			isHit = true;
			hitList.add(oriNo);
			session.setAttribute("HIT",hitList);
		}
		else {
			isHit = false;	//조회수 증가x
		}
		
		if(isHit == true) {
			fDao.updateHit(oriNo); //조회수 증가
		}
		
	}
	// board-----------------------------------------------------끝
	// boardcomm-----------------------------------------------------시작
	@Override
	public void boardcommSelectService() throws Exception {
		System.out.println("boardcommSelectService시작");
		
		bcDao.example();
		
		System.out.println("boardcommSelectService끝");
		
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
	// boardcomm-----------------------------------------------------끝
	// fileinfo-----------------------------------------------------시작
	
	//상세보기 첨부파일
	@Override
	public ArrayList fileinfoSelectService(int oriNo) throws Exception {
		//첨부파일 정보 검색해서 알려준다.
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

	//다운로드 파일 정보 검색 질의 실행 함수
	@Override
	public FileinfoVO getDownload(int fileNo) {
		FileinfoVO vo = fDao.getDownload(fileNo);
		return vo;
	}
	// filrinfo-----------------------------------------------------끝	

	
	

}
*/