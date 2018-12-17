package com.mapboard.board.service;
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
import com.mapboard.util.PageUtil;
@Service("boardService")
public class BoardServiceImpl implements BoardService{
	@Autowired
	private BoardcommDao bcDao;
	@Autowired
	private BoardDao bDao;
	@Autowired
	private FileinfoDao fDao;
	
	// board-----------------------------------------------------시작
	//1. 게시물 기록 함수
	@Override
	public void insertBoard(BoardVO vo, HttpSession session, ArrayList list) throws Exception {
		System.out.println("service의 insertBoard 시작 게시물수="+vo.getBidx());
		
		String userid = (String)session.getAttribute("userid");	//MemberService
		//질의 명령을 실행할 때 필요한 데이터는 vo로 묶어서 알려주기로 했으므로...
		vo.setUserid(userid);
		//게시물을 등록
		bDao.insertBoard(vo);	//BoardDao
		
		System.out.println("service의 insertBoard 끝 게시물수="+vo.getBidx());
	}	

	//게시물 정보 구하기 함수
	@Override
	public ArrayList getBoardList(PageUtil pInfo) throws Exception {
		System.out.println("service의 boardList 시작");
		//시작 = (현재페이지-1)*(한 페이지에 보여줄 게시물수)
		int start=(pInfo.getNowPage()-1)*pInfo.getListCount()+1;
		
		//끝 = 시작페이지+그 페이지에서 보여줄 게시물 수-1
		int end=start+pInfo.getListCount()-1;
		
		BoardVO vo = new BoardVO();
		vo.setStart(start);
		vo.setEnd(end);
	
		//질의 실행
		ArrayList list = bDao.getBoardList(vo);
		System.out.println("service의 boardList 끝");
		return list;
	}
	
	
	//페이지 이동 정보를 만들어주는 함수
	@Override
	public PageUtil getPageInfo(int nowPage) throws Exception {
		System.out.println("service의 pageInfo 시작");
		//게시물 총개수 구하기
		int totalCount = bDao.getTotalCount();
		
		//한 페이당 3개의 게시물을 뿌리고, 5페이지씩 보여주자.
		PageUtil pInfo = new PageUtil(nowPage, totalCount, 5, 3);
		System.out.println("service의 pageInfo 끝");
		return pInfo;
	}


	
	
}
