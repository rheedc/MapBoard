package com.mapboard.common.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mapboard.common.service.CommonService;

@Controller
public class CommonController {

	@Autowired
	private CommonService service;
	
	// ���� �Լ� �Դϴ�
	@RequestMapping("/common/example")
	public void example() {
		System.out.println("CommonController����");
		
		try {
			//	service �Լ� ���๮
			service.excuteService();
		} catch (Exception e) {
			System.out.println("CommonService ����"+e);
		}
		
		System.out.println("CommonController��");
		
	}
	
}
