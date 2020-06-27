package com.mycompany.project.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
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
import com.mycompany.project.model.Movie;
import com.mycompany.project.model.Ticket;
import com.mycompany.project.service.MemberService;
import com.mycompany.project.service.ReserveService;
import com.mycompany.project.service.SeatService;

@Controller
@RequestMapping("/reserve")
public class ReserveController {
	private static final Logger LOGGER = LoggerFactory.getLogger(ReserveController.class);

	@Autowired
	private ReserveService reserveService;

	@Autowired
	private SeatService seatService;

	@Autowired
	private MemberService memberService;

	@RequestMapping("/reservePage.do")
	public String reservePage(int fno, Model model, HttpServletRequest request) {
		LOGGER.info("실행");
		List<Film> filmList = reserveService.getFilmList();
		model.addAttribute("filmlist", filmList);
		request.setAttribute("fno", fno);
		return "reserve/reservePage";
	}

	@PostMapping("/getTimeTable.do")
	public void getTimeTable(int mvfno, String mvdate, HttpServletResponse response) throws IOException {
		LOGGER.info("{}", mvfno);
		LOGGER.info(mvdate);
		Movie movie = new Movie();
		movie.setMvfno(mvfno);
		movie.setMvdate(mvdate);
		
		response.setContentType("application/json; charset=UTF-8");
		JSONObject jsonObject = new JSONObject();
		
		SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat sdfTime = new SimpleDateFormat("HH:mm");
		Date now = new Date();
		String nowDate = sdfDate.format(now);
		String nowTime = sdfTime.format(now);
		
		List<Movie> movieList = reserveService.getTimeTable(movie);
		int k=0;
		for (int i = 0; i < movieList.size(); i++) {
			JSONObject jsonMovie = new JSONObject();
			if(nowDate.equals(movieList.get(i).getMvdate())) {
				int check = nowTime.compareTo(movieList.get(i).getMvstarttime());
				if(check < 0) {
					jsonMovie = new JSONObject();
					jsonMovie.put("mvno", movieList.get(i).getMvno());
					jsonMovie.put("mvplace", movieList.get(i).getMvplace());
					jsonMovie.put("mvstarttime", movieList.get(i).getMvstarttime());
					jsonObject.put("movie" + k, jsonMovie);
					k++;
				}
			} else {
				jsonMovie = new JSONObject();
				jsonMovie.put("mvno", movieList.get(i).getMvno());
				jsonMovie.put("mvplace", movieList.get(i).getMvplace());
				jsonMovie.put("mvstarttime", movieList.get(i).getMvstarttime());
				jsonObject.put("movie" + k, jsonMovie);
				k++;
			}
		}
		PrintWriter pw = response.getWriter();
		pw.write(jsonObject.toString());
		pw.flush();
		pw.close();
	}
	
	
	@PostMapping("/getDateList.do")
	public void getDateList(HttpServletResponse response) throws IOException {
		response.setContentType("application/json; charset=UTF-8");
		JSONObject jsonObject = new JSONObject();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar time = Calendar.getInstance();
		jsonObject.put("date0", sdf.format(time.getTime()));
		for(int i=1; i<5; i++) {
			time.add(Calendar.DAY_OF_MONTH, 1);
			jsonObject.put("date"+i, sdf.format(time.getTime()));
		}
		

		String json = jsonObject.toString();
		PrintWriter pw = response.getWriter();
		pw.write(json);
		pw.flush();
		pw.close();
	}
	
	
	
	@RequestMapping("/seat.do")
	public String seatChoice(@RequestParam("reserveTime") int mvno, Model model, HttpServletRequest request) {
		LOGGER.info("실행");
		LOGGER.info(mvno + "");
		List seatList = seatService.printSeat(mvno);
		request.setAttribute("smovie", mvno);
		model.addAttribute("seatList", seatList);

		return "/reserve/seatChoice";
	}

	@GetMapping("/purchase.do")
	public String purchaseForm(int smovie, int sno, HttpSession session) {

		Movie movie = seatService.totalInfo(smovie);

		Ticket ticket = new Ticket();
		ticket.setTid((String) session.getAttribute("sessionMid"));
		ticket.setTmoviename(seatService.moiveName(movie.getMvfno()));
		ticket.setTdate(movie.getMvdate());
		ticket.setTplace(movie.getMvplace());
		ticket.setTtime(movie.getMvstarttime());
		ticket.setTseatno(sno);
		ticket.setSmovie(smovie);

		session.setAttribute("ticket", ticket);

		return "/reserve/purchaseForm";
	}

	@RequestMapping("/point.do") // sno가 좌석번호, smovie가 mvno(영화시간대고유번호)
	public void point(String mid, int mpoint, int sno, int smovie, HttpServletResponse response, HttpSession session)
			throws Exception {
		LOGGER.info(mid);
		int dbMpoint = memberService.searchMpoint(mid);

		response.setContentType("application/json; charset=UTF-8");
		JSONObject jsonObject = new JSONObject();
		if (dbMpoint < mpoint) {
			jsonObject.put("result", "No");
			session.setAttribute("ticket", null);
		} else {
			// ajax로 result 넘겨줌
			jsonObject.put("result", "Yes");
			
			// db의 포인트 차감해서 업데이트
			memberService.updateMpoint(dbMpoint - mpoint, mid);
			
			// session에 등록된 member 포인트 업데이트
			Member member = (Member) session.getAttribute("sessionMember");
			member.setMpoint(dbMpoint - mpoint);
			session.setAttribute("sessionMember", member);
			
			// 예매된 좌석 업데이트
			seatService.updateselect(sno, smovie);
			
			// DB에 티켓 추가 
			Ticket ticket = (Ticket) session.getAttribute("ticket");
			reserveService.insertTicket(ticket);
			
			// 세션에 등록된 티켓 삭제
			session.setAttribute("ticket", null);
		}

		PrintWriter pw = response.getWriter();
		pw.write(jsonObject.toString());
		pw.flush();
		pw.close();
	}

	@RequestMapping("/showTicket.do")
	public String myticketForm(Model model, HttpSession session) {
		String tid = (String) session.getAttribute("sessionMid");
		List<Ticket> list = reserveService.getTicketList(tid);
		model.addAttribute("ticketlist", list);
		return "mypage/ticketlist";
	}

	@RequestMapping("/dropTicket.do")
	public String dropTicket(int tno, int smovie, int tseatno, HttpSession session) {
		LOGGER.info("실행이요");
		reserveService.cancelTicket(tno);
		seatService.cancleSeat(tseatno, smovie);
		Member member = (Member) session.getAttribute("sessionMember");
		member.setMpoint(member.getMpoint()+5000);
		memberService.updateMpoint(member.getMpoint(), member.getMid());
		session.setAttribute("sessionMember", member);
		
		return "redirect:/reserve/showTicket.do";
	}
}
