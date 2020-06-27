package com.mycompany.project.dao;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.mycompany.project.model.Film;
import com.mycompany.project.model.Movie;
import com.mycompany.project.model.Ticket;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class ReserveDao extends EgovAbstractMapper {
	private static final Logger LOGGER = LoggerFactory.getLogger(ReserveDao.class);
	
	public List<Film> selectAll() {
		return selectList("film.selectAll");
	}

	public List<Movie> selectStartTimeByMvfnoMvdate(Movie movie) {
		LOGGER.info("실행");
//		List<Movie> list = selectList("movie.selectStartTimeByMvfnoMvdate", movie);
//		for(Movie m:list) {
//			LOGGER.info("{}", m.getMvno());
//			LOGGER.info("{}", m.getMvplace());
//			LOGGER.info(m.getMvstarttime());
//		}
		return selectList("movie.selectStartTimeByMvfnoMvdate", movie);
		
	}

	public void insertTicket(Ticket ticket) {
		insert("ticket.insertTicket", ticket);
	}
	
	public List<Ticket> selectTicketList(String tid){
		List<Ticket> list = new ArrayList<>();
		list = selectList("ticket.selectTicketList", tid);
		return list;
	}
	
	public int deleteTicketByTno(int tno) {
		int result = delete("ticket.deleteTicketByTno", tno);
		return result;
	}
	
	public int deleteTicketByTid(String tid) {
		int result = delete("ticket.deleteTicketByTid", tid);
		return result;
	}
}
