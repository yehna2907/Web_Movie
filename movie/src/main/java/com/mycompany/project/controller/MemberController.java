package com.mycompany.project.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mycompany.project.model.LoginForm;
import com.mycompany.project.model.Member;
import com.mycompany.project.service.MemberService;
import com.mycompany.project.service.ReserveService;
import com.mycompany.project.validator.LoginFormValidator;
import com.mycompany.project.validator.MemberValidator;

@Controller
@RequestMapping("/member")
public class MemberController {
	private static final Logger LOGGER = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	private MemberService memberService;

	@GetMapping("/login.do")
	public String loginForm(LoginForm loginForm) {
		LOGGER.info("실행");
		return "/member/loginForm";
	}

	@Autowired
	private LoginFormValidator loginFormValidator;

	@InitBinder("loginForm")
	public void loginFormInitBinder(WebDataBinder binder) {
		LOGGER.info("실행");
		binder.setValidator(loginFormValidator);
	}

	@PostMapping("/login.do")
	public String login(@Valid LoginForm loginForm, 
			BindingResult bindingResult, HttpSession session) {
		LOGGER.info("실행");
		LOGGER.info(loginForm.getMid());
		LOGGER.info(loginForm.getMpassword());

		String viewName = "member/loginForm";
		
		if (bindingResult.hasErrors()) {
			return viewName;
		}

		int result = memberService.login(loginForm);
		if (result == MemberService.LOGIN_SUCCESS) {
			session.setAttribute("sessionMid", loginForm.getMid());
			Member member = memberService.getMemberInfo(loginForm.getMid());
			session.setAttribute("sessionMember", member);
			return "redirect:/home/main.do";
		}
		else if (result == MemberService.LOGIN_FAIL_MID) {
			bindingResult.rejectValue("mid", "", "아이디가 틀렸습니다.");
			return viewName;
		} else if (result == MemberService.LOGIN_FAIL_MPASSWORD) {
			bindingResult.rejectValue("mpassword", "", "비밀번호가 틀렸습니다.");
			return viewName;
		}

		return viewName;
	}

	@GetMapping("/join.do")
	public String join(Member member) {
		LOGGER.info("실행");
		return "member/joinForm";
	}

	@Autowired
	MemberValidator memberValidator;
	
	@InitBinder("member")
	public void memberInitBinder(WebDataBinder binder) {
		binder.setValidator(memberValidator);
	}
	
	@PostMapping("/join.do")
	public String joinForm(@Valid Member member, BindingResult bindingResult) {
		if (bindingResult.hasErrors()) {
			return "member/joinForm";
		} else {
			memberService.join(member);
			return "redirect:/home/main.do";
		}
	}
	
	@GetMapping("/forgot.do")
	public String forgotForm() {
		return "member/forgotForm";
	}

	@PostMapping("/forgotMid.do")
	public void findMid(String mname, String mbirth, String mtel, HttpServletResponse response) throws Exception {
		Member member = new Member();
		member.setMname(mname);
		member.setMbirth(mbirth);
		member.setMtel(mtel);
		String result = memberService.searchMid(member);
		response.setContentType("application/json; charset=UTF-8");

		LOGGER.info(result);
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("result", result);

		PrintWriter pw = response.getWriter();
		pw.write(jsonObject.toString());
		pw.flush();
		pw.close();
	}

	@PostMapping("/forgotMpassword.do")
	public void forgotMpassword(String mid, String mbirth, String mtel, HttpServletResponse response) throws Exception {
		LOGGER.info("실행");
		Member member = new Member();
		member.setMid(mid);
		member.setMbirth(mbirth);
		member.setMtel(mtel);
		String result = memberService.searchMpassword(member);

		response.setContentType("application/json; charset=UTF-8");
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("result", result);
		String json = jsonObject.toString();
		PrintWriter pw = response.getWriter();
		pw.write(json);
		pw.flush();
		pw.close();

	}

	@RequestMapping("/logout.do")
	public String logout(HttpSession session) {
		LOGGER.info("실행");
		session.invalidate();
		return "redirect:/home/main.do";
	}
	
	@Autowired
	ReserveService reserveService;
	
	@GetMapping("/drop.do")
	   public String drop(HttpSession session) {
	      LOGGER.info("실행");
	      String mid = (String)session.getAttribute("sessionMid");
	      memberService.drop(mid);
	      reserveService.dropTicketByTid(mid);
	      session.invalidate();
	      return "member/dropForm";
	}
}
