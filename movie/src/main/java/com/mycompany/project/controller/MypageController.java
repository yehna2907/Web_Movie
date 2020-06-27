package com.mycompany.project.controller;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mycompany.project.model.Member;
import com.mycompany.project.service.MemberService;
import com.mycompany.project.validator.EditFormValidator;

@Controller
@RequestMapping("/mypage")
public class MypageController {

	private static final Logger LOGGER = LoggerFactory.getLogger(MypageController.class);

	@Autowired
	MemberService memberService;
	
	@RequestMapping("/mypageMain.do")
	public String mypageMain(Model model, HttpSession session) {
		LOGGER.info("실행");
		return "mypage/mypageMain";
	}

	@GetMapping("edit.do")
	public String editForm(HttpSession session, Model model) {
		LOGGER.info("실행");
		Member member = (Member) session.getAttribute("sessionMember");
		model.addAttribute(member);
		return "mypage/editForm";
	}

	@Autowired
	private EditFormValidator editFormValidator;

	@InitBinder("member")
	public void editFormInitBinder(WebDataBinder binder) {
		LOGGER.info("실행");
		binder.setValidator(editFormValidator);
	}

	@PostMapping("edit.do")
	public String edit(@Valid Member member, BindingResult bindingResult, HttpSession session) {
		LOGGER.info("실행");
		Member sessionMember = (Member)session.getAttribute("sessionMember");
		if(sessionMember == null)
			return "mypage/editForm";
		member.setMid(sessionMember.getMid());
		member.setMpoint(sessionMember.getMpoint());
		if (bindingResult.hasErrors()) {
			LOGGER.info("에러 발생");
			return "mypage/editForm";
		} else {
			memberService.edit(member);
			session.setAttribute("sessionMember", member);
			return "redirect:/mypage/mypageMain.do";
		}
	}

	@RequestMapping("chargePointForm.do")
	public String chargePointForm() {
		LOGGER.info("실행");
		return "mypage/chargePoint";
	}

	@RequestMapping("chargePoint.do")
	public String chargePoint(int point, HttpSession session) {
		Member member = (Member) session.getAttribute("sessionMember");
		int updatedPoint = member.getMpoint() + point;
		member.setMpoint(updatedPoint);
		LOGGER.info("mid: {}", member.getMid());
		LOGGER.info("point: {}", point);
		memberService.updateMpoint(updatedPoint, member.getMid());
		session.setAttribute("sessionMember", member);
		return "redirect:/mypage/mypageMain.do";
	}
}
