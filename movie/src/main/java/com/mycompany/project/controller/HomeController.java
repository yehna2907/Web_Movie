package com.mycompany.project.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mycompany.project.model.Film;
import com.mycompany.project.model.Member;
import com.mycompany.project.model.Pager;
import com.mycompany.project.model.Review;
import com.mycompany.project.service.HomeService;
import com.mycompany.project.service.SeatService;


@Controller
@RequestMapping("/home")
public class HomeController {
	private static final Logger LOGGER = LoggerFactory.getLogger(HomeController.class);

	@Autowired
	private HomeService homeService;
	
	@Autowired
	SeatService seatService;
	
	@RequestMapping("/main.do")
	public String main(Model model) {
		LOGGER.info("실행");
		//movieDB생성코드
//		String[] mvstarttime = {"10:00","12:00","14:00","16:00","18:00","20:00","22:00"};
//		for(int i=0;i<5;i++) {
//			for(int j=0;j<7; j++) {
//				homeService.insertDB(
//						((int)(Math.random()*7)+1),
//						1,mvstarttime[j],i);
//			}
//		}
//		for(int i=0;i<5;i++) {
//			for(int j=0;j<7; j++) {
//				homeService.insertDB(
//						((int)(Math.random()*7)+1),
//						2,mvstarttime[j],i);
//			}
//		}
		
		//seatDB생성 코드
//		for(int i=1;i<=70;i++) {
//			for(int j=1;j<=30; j++) {
//				seatService.insertSeat(i,j);
//			}
//		}
		
		//오늘날짜로 DB업데이트
		Date now = new Date();
		SimpleDateFormat sdf = new  SimpleDateFormat("yyyy-MM-dd");
		String date = sdf.format(now).toString();
		
		if(!homeService.judgeToday(date)) {
			for(int i=4;i>=0;i--) {
				homeService.updateDB(i);
			}
		}
		
		List<Film> filmList = homeService.getFilmlist();
		model.addAttribute("filmlist", filmList);
		return "home/main";
	}
	
	@RequestMapping("/login.do")
	public String login() {
		LOGGER.info("실행");
		return "/home/loginForm";
	}

	@GetMapping("/movieDetail.do")
	public String movieDetail(@RequestParam(defaultValue="1") int pageNo,
			@RequestParam(defaultValue="10")int rowsPerPage,
			int fno, Model model, HttpSession session) {
		LOGGER.info("실행");
		LOGGER.info("pageNo : " + pageNo+"");
		
		Pager pager = new Pager(rowsPerPage, 5, homeService.getCountReview(fno), pageNo);
		model.addAttribute("pager", pager);
		
		Film film = homeService.getFilm(fno);												
		String temp = film.getFsummary();
		temp = temp.replaceAll("\n", "<br/>");
		film.setFsummary(temp);

		String sessionMid = (String) session.getAttribute("sessionMid");
		List<Review> reviewList = homeService.getReviewList(pager, fno, sessionMid);
		
		model.addAttribute("reviewlist", reviewList);
		model.addAttribute("film", film);
		return "home/movieDetail";

	}
	
	@PostMapping("/writeReview.do")
	public String writeReview(Review review) {
		LOGGER.info("실행");
		homeService.write(review);
		//영화 평점 업데이트
		double newScore = homeService.getAvgRscore(review.getRfno());
		newScore = Math.round(newScore*100)/100.0;
		
		Film film = new Film();
		film.setFno(review.getRfno());
		film.setFscore(newScore);
		
		homeService.updateFscore(film);
		
		return "redirect:/home/movieDetail.do?fno=" + review.getRfno();
	}
	
	@PostMapping("/updateReview.do")
	public String updateReview(Review review, double oldRscore) {
		//리뷰 업데이트
		homeService.updateReview(review);
		
		//영화 평점 업데이트
		double newScore = homeService.getAvgRscore(review.getRfno());
		newScore = Math.round(newScore*100)/100.0;
		
		Film film = new Film();
		film.setFno(review.getRfno());
		film.setFscore(newScore);
		
		homeService.updateFscore(film);
		return "redirect:/home/movieDetail.do?fno=" + review.getRfno();
	}
	
	@GetMapping("/deleteReview.do")
	public String deleteReview(int fno, int rno, double rscore) {
		//리뷰 삭제
		homeService.deleteReview(rno);
		
		//영화 평점 업데이트
		double newScore = homeService.getAvgRscore(fno);
		newScore = Math.round(newScore*100)/100.0;
		
		Film film = new Film();
		film.setFno(fno);
		film.setFscore(newScore);
		
		homeService.updateFscore(film);
		return "redirect:/home/movieDetail.do?fno=" + fno;
	}
	
	@PostMapping("/checkDuplicateId.do")
	public void checkDuplicateId(String rid, int rfno ,HttpServletResponse response, HttpSession session) throws IOException {
		String result;	
		Member member = (Member)session.getAttribute("sessionMember");
		if (member == null) {
			rid = null;
		}
		
		List<Review> list = homeService.getReviewListByRidRfno(rid, rfno);
		
		if(rid == null) {
			result = "NotLogined";
		} else {
			if(list.size() == 0) {
				result = "canWrite";
			} else {
				result = "alreadyHave";
			}
		}
		
		response.setContentType("application/json; charset=UTF-8");
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("result", result);
		PrintWriter pw = response.getWriter();
		pw.write(jsonObject.toString());
		pw.flush();
		pw.close();
	}
	
	@GetMapping("/allreview.do")
	public String allreview(
			@RequestParam(defaultValue="1") int pageNo,
			@RequestParam(defaultValue="20") int rowsPerPage,
			Model model, HttpSession session) {
		//영화 리스트 넘겨주기 : 셀렉트박스
		List<Film> filmList = homeService.getFilmlist();
		model.addAttribute("filmlist", filmList);
		
		List<Review> reviewList = homeService.getAllReviewList(pageNo, rowsPerPage);
		model.addAttribute("reviewlist", reviewList);
		
		List<String> filmNameList = new ArrayList<>();
		for(Review r:reviewList) {
			filmNameList.add(homeService.getFilm(r.getRfno()).getFtitle());
		}
		Pager pager = new Pager(rowsPerPage, 5, homeService.getCountAllReview(), pageNo);
		
		model.addAttribute("pager", pager);
		
		model.addAttribute("filmnamelist", filmNameList);
		return "home/allreviewPage";
	}

}
