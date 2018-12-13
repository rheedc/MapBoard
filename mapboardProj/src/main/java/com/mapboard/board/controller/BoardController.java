/*package com.mapboard.board.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.mapboard.board.service.BoardService;
import com.mapboard.board.vo.BoardVO;
import com.mapboard.board.vo.FileinfoVO;
import com.mapboard.util.PageUtil;



@Controller
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private BoardService service;
	
	//1. ��Ϻ���
	@RequestMapping("/boardList")
	public void boardList(@RequestParam(value="nowPage", defaultValue="1") int nowPage,
									HttpServletRequest req) {
		
		System.out.println("controller�� boardList ����");
		
		//1) ������ �̵� ���
		PageUtil pInfo =service.getPageInfo(nowPage);
		
		//2) �Խù� ��������
		ArrayList list = service.getBoardList(pInfo);
		System.out.println("�Խù��� = "+list.size());
		
		//3) �� �����
		req.setAttribute("PINFO", pInfo);
		req.setAttribute("LIST", list);
		
		System.out.println("controller��  boardList ��");
	}
	
	//2. �۾��� ������ ��û
	@RequestMapping("/writeForm")
	public void writeForm() {
		//���ͼ��͸� �̿��Ͽ� �α��� ó�� �߱� ������ ���� ������ ����.
		System.out.println("controller�� writeForm ���۰� ��");
	}									
	
	
	//3. �۾���
	@RequestMapping("/writeProc")
	public ModelAndView writeProc(BoardVO vo, HttpSession session) {
		System.out.println("controller�� writeProc ����");
		
		//1) �Ķ����
		String path = "E:\\upload";
		//���������� �ϳ��� ���� ���� ����
		ArrayList list = new ArrayList();
		for(int i=0 ; i<vo.getFiles().length ; i++) {
			//�ϳ��� ������ ���� �̸��� �˾Ƴ���
			String oriName = vo.getFiles()[i].getOriginalFilename();
			//������ ���ε� ���� ������ ���� �����۾��� �õ��Ѵ�.
			if(oriName==null || oriName.length()==0) {
				continue;
			}
			String saveName = FileUtil.renameTo(path, oriName);		//FileUtil			
			File file = new File(path, saveName);					
			//transferTo()�� �̿��ؼ� ����
			try {
				vo.getFiles()[i].transferTo(file);	//path�� saveName�� ����
			} catch (Exception e) {
				System.out.println("�������� ���� = "+e);
			} 			
			//���� �ϳ��� ������ ���ε�� ����
			//���ε�� ������ ������ Map���� ����.(path,oriName,saveName,len)
			HashMap map = new HashMap();
			map.put("path", path);
			map.put("oriName", oriName);
			map.put("saveName", saveName);
			map.put("len", file.length());			
			list.add(map);	//�ѹ��� �� ������ ����Ʈ�� �߰�			
		}//for ��
		
		//2) ����
		service.insertBoard(vo, session, list); 
		
		//3) ��
		//4) �� ȣ��
		ModelAndView mv = new ModelAndView();
		RedirectView view = new RedirectView("../fileBoard/boardList.sun");
		mv.setView(view);
		return mv;
	}
	
	//4. ��ȸ�� ����
	@RequestMapping("/hitProc")
	public ModelAndView boardHitProc(HttpServletRequest req, ModelAndView mv,
																					HttpSession session) {
		//1) �Ķ����
		String strNo = req.getParameter("oriNo");
		int oriNo = Integer.parseInt(strNo);
		String nowPage = req.getParameter("nowPage");	//�����̿�
		
		//2) ����	
		service.updateHit(oriNo, session);
		
		//3) �� 4)��
		//��Ʈ�ѷ����� ������ �󼼺��� Redirect
		RedirectView rv = new RedirectView("../fileBoard/boardView.sun");
		//��Ʈ�ѷ����� Redirect�ϸ鼭 �Ķ���͸� ������ �ʹٸ� 
		//rv.addStaticAttribute(String���� "Ű��",  ������);
		rv.addStaticAttribute("oriNo", oriNo);
		rv.addStaticAttribute("nowPage", nowPage);
		mv.setView(rv);
		return mv;
	}
	
	//5. �󼼺��� �Լ�
	@RequestMapping("/boardView")
	public ModelAndView boardView(@RequestParam(value="oriNo") int oriNo,
			@RequestParam(value="nowPage") int nowPage) {		

		//2) ����
		//(1) �󼼺��� ����˻�
		BoardVO vo = service.getBoardView(oriNo);
						
		//(2) �������� �˻�
		ArrayList list = service.getFileInfo(oriNo);
		
		//3) ��
		ModelAndView mv = new ModelAndView();
		mv.addObject("VIEW", vo);									//����
		mv.addObject("LIST", list);									//÷������ ����
		mv.addObject("nowPage", nowPage);			//�����̿�
		
		//4) ��
		mv.setViewName("fileBoard/boardView");
		return mv;
	}
	
	//6. ���� �ٿ�ε�
	@RequestMapping("/fileDownload")
	public ModelAndView fileDownload(
			@RequestParam(value="fileNo") int fileNo) {
		
		//2) ����
		FileinfoVO vo = service.getDownload(fileNo);
		//�ٿ�ε� �� ������ File�̶�� Ŭ������ ���� �����ϱ�� �ߴ�.
		File file = new File(vo.getPath(),vo.getSaveName());
		
		//3) �� 4) ��
		//setView : redirect��
		//setViewName : �Ϲݺ�
		//�ڡڡڻ���� ���� �� ȣ���ϱ�
		//����> new ModelAndView("��������� ���","������ ������ Ű��",������ ������);
		ModelAndView mv = 
					new ModelAndView("download", "downloadFile", file); 	//sun-context.xml
		return mv;
		}	
	
	
	
	
	
	//7. ���----------------------------------------------------���߿� �ϱ�
	@RequestMapping("board/replyModify")
	public void replyModify() {
		System.out.println("test ��Ʈ�ѷ��� replyModify");
	}
	
	@RequestMapping("board/modifyForm")
	public void replyForm() {
		System.out.println("test ��Ʈ�ѷ��� replyForm");
	}
	
	@RequestMapping("board/boardDetail")
	public void boardDetail() {
		System.out.println("test ��Ʈ�ѷ��� boardDetail");
	}
	
	
	
	
	
	
	// ���� �Լ� �Դϴ�-----------------------------------------------------------------------------------------------
		@RequestMapping("/board/example")
		public void example() {
			System.out.println("BoardController����");
			
			try {
				//	service �Լ� ���๮
				service.boardcommSelectService();
			} catch (Exception e) {
				System.out.println("BoardController ����"+e);
			}
			
			System.out.println("BoardController��");
			
		}
		
}
*/