package com.mycompany.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.project.dao.ReserveDao;
import com.mycompany.project.model.Film;
import com.mycompany.project.model.Movie;
import com.mycompany.project.model.Ticket;

@Service
public class ReserveService {
	
	@Autowired
	private ReserveDao reserveDao;

	public List<Film> getFilmList() {
		
		return reserveDao.selectAll();
	}

	public List<Movie> getTimeTable(Movie movie) {
		return reserveDao.selectStartTimeByMvfnoMvdate(movie);
		
	}

	public void insertTicket(Ticket ticket) {
		reserveDao.insertTicket(ticket);
	}
	
	public List<Ticket> getTicketList(String tid){
		List<Ticket> list = reserveDao.selectTicketList(tid);
		return list;
	}
	
	public void cancelTicket(int tno) {
		reserveDao.deleteTicketByTno(tno);
	}
	
	public void dropTicketByTid(String tid) {
		reserveDao.deleteTicketByTid(tid);
	}
}
