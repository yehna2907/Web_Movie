package com.mycompany.project.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.project.dao.SeatDao;
import com.mycompany.project.model.Movie;

@Service
public class SeatService {
	private static final Logger LOGGER = LoggerFactory.getLogger(SeatService.class);
	
	@Autowired
	private SeatDao seatDao;

	public List printSeat(int mvno) {
		List list = seatDao.printSeat(mvno);
		return list;
	}

	public void updateselect(int sno, int smovie) {
		LOGGER.info(sno+"");
		seatDao.updateselect(sno, smovie);
		LOGGER.info("실행");
	}

	public Movie totalInfo(int smovie) {
		Movie movie = seatDao.selectBySmovie(smovie);
		return movie;
	}

	public String moiveName(int mvfno) {
		return seatDao.getFtitle(mvfno);
	}

	public void insertSeat(int smovie, int sno) {
		seatDao.insertSeat(smovie, sno);	
	}

	public void cancleSeat(int tseatno, int smovie) {
		seatDao.cancleSeat(tseatno, smovie);
		
	}	
}
