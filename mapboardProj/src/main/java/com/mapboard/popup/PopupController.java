package com.mapboard.popup;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/*클래스 설명: 팝업창 사용시 팝업창 경로로 이동하도록 처리하는 클래스 이다.
 * 작성자: 이덕천
 * 작성일: 2018-12-15
 * 최종수정일: 2018-12-15
 * 
 */


@Controller
@RequestMapping("/popup")
public class PopupController {
		
	//아이디 중복체크 팝업창 보이기
	@RequestMapping("/popup_IdCheck")
	public void idCheckPop(){
						
	}
	
	
}
