package com.mapboard.common.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mapboard.common.service.CommonService;

@Controller
public class CommonController {

	@Autowired
	private CommonService service;
	
	// 예시 함수 입니다
	@RequestMapping("/common/example")
	public void example() {
		System.out.println("CommonController시작");
		
		try {
			//	service 함수 실행문
			service.excuteService();
		} catch (Exception e) {
			System.out.println("CommonService 오류"+e);
		}
		
		System.out.println("CommonController끝");
		
	}
	
}
