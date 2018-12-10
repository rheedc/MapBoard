package com.mapboard.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.mapboard.member.service.MemberService;

@Controller
public class MemberController {

	@Autowired
	private MemberService mservice;
	
	
}
