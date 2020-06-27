package com.mycompany.project.dao;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.mycompany.project.model.Movie;
import com.mycompany.project.model.Seat;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class SeatDao extends EgovAbstractMapper{
	private static final Logger LOGGER = LoggerFactory.getLogger(SeatDao.class);
	
	public List printSeat(int mvno) {
		List list = selectList("seat.selectByMvno", mvno);
		return list;
	}

	public void updateselect(int sno, int smovie) {
		Seat seat = new Seat();
		seat.setSmovie(smovie);
		seat.setSno(sno);
		update("seat.updateBySno", seat);	
	}

	public Movie selectBySmovie(int smovie) {
		Movie movie = selectOne("movie.selectBySmovie", smovie);
		return movie;
	}

	public String getFtitle(int mvfno) {	
		return selectOne("film.getFtitle", mvfno);
	}

	public void insertSeat(int smovie, int sno) {
		Seat seat = new Seat();
		seat.setSmovie(smovie);
		seat.setSno(sno);
		insert("seat.insertSeat", seat);
		
	}

	public void cancleSeat(int sno, int smovie) {
		Seat seat = new Seat();
		seat.setSmovie(smovie);
		seat.setSno(sno);
		update("seat.cancleSeat", seat);	
		
	}
	
}
