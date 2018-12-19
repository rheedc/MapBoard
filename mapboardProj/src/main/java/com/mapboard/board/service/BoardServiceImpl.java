package com.mapboard.board.service;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
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
	
	//1-1. 상가명 가져오기
	@Override
	public BoardVO getSelectName(int place_no)throws Exception{
		System.out.println("service의 selectName 시작");
		
		BoardVO vo = bDao.getSelectName(place_no);
		
		return vo;
	}
	
	//1-2. 게시물 기록 함수
	@Override
	public void insertBoard(BoardVO vo, HttpSession session, ArrayList list) throws Exception {
		System.out.println("service의 insertBoard 시작");
		
		String userid = (String)session.getAttribute("userid");	//MemberService
		System.out.println(userid);
		
		//질의 명령을 실행할 때 필요한 데이터는 vo로 묶어서 알려주기로 했으므로...
		vo.setUserid(userid);
		//게시물을 등록
		bDao.insertBoard(vo,"board");	//BoardDao
		
		
		
		//파일의 정보는 list가 가지고 있는 개수만큼 처리되어야 한다.
		for(int i=0; i<list.size(); i++) {
			
			//질의문을 실행할 때 필요한 모든 정보는 vo를 이용해서 알려주기로 했으므로...
			vo.setBidx(vo.getBidx());
			
			//파일에 대한 정보는 list가 가지고 있고
			//하나의 파일의 정보는 Map으로 저장해 놓았으므로 
			HashMap map = (HashMap)list.get(i);
			vo.setFpath((String)map.get("fpath"));
			vo.setForiname((String)map.get("foriname"));
			vo.setFsname((String)map.get("fsname"));
			vo.setFsize((Long)map.get("fsize"));
			
			//질의 명령 실행
			bDao.insertBoard(vo,"fileInfo");
		}
		System.out.println("service의 insertBoard 끝");
		
	}
	
	//상세보기
	@Override
	public BoardVO getBoardDetail(int bidx) throws Exception {
		BoardVO vo = bDao.getBoardDetail(bidx);
		return vo;
	}
	
	//게시물 수정
	@Override
	public void updateBoard(BoardVO vo) throws Exception {
		bDao.updateBoard(vo);
		
	}

	//조회수 증가처리함수
	public void updateHit(int bidx, HttpSession session) {
		
		boolean isHit=false;		//조회수를 증가할지 말지를 기억하는 변수
		ArrayList hitList=(ArrayList)session.getAttribute("HIT");
		
		//최초방문한 사람인 경우
		if(hitList==null || hitList.size()==0) {
			isHit=true;
			hitList=new ArrayList();
			hitList.add(bidx);
			session.setAttribute("HIT", hitList);
		}
		//처음방문은 아니지만 해당 글은 처음보는 경우
		else if(!hitList.contains(bidx)) {
			isHit=true;
			hitList.add(bidx);
		}
		else {
			isHit=false;
		}
		//isHit가 true인 경우에만 조회수를 증가시킨다
		if(isHit) {			
			bDao.updateHit(bidx);
		}
	}

	

		

	


	
	
	

	
}
