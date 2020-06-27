package com.mycompany.project.service;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.project.dao.HomeDao;
import com.mycompany.project.model.Film;
import com.mycompany.project.model.Pager;
import com.mycompany.project.model.Review;

@Service
public class HomeService {
	private static final Logger LOGGER = LoggerFactory.getLogger(HomeService.class);
	
	@Autowired
	private HomeDao homeDao;
	
	public List<Film> getFilmlist() {
		return homeDao.selectAllFilm();
	}

	public Film getFilm(int fno) {
		return homeDao.selectByFno(fno);
	}
	
	public double getAvgRscore(int rfno) {
		return homeDao.selectAvgRscore(rfno);
	}
	
	public void write(Review review) {
		homeDao.insert(review);
	}
	
	public void updateReview(Review review) {
		homeDao.updateByRno(review);
	}
	
	public void deleteReview(int rno) {
		homeDao.deleteByRno(rno);
	}

	public int getCountReview(int rfno) {
		return homeDao.countReview(rfno);
	}
	
	public int getCountAllReview() {
		return homeDao.countAll();
	}
	
	public void updateFscore(Film film) {
		homeDao.updateFscore(film);
		
	}

	public List<Review> getReviewListByRidRfno(String rid, int rfno) {
		return homeDao.selectByRidRfno(rid, rfno);
	}

	public List<Review> getReviewList(Pager pager, int rfno, String rid){
		List<Review> list = new ArrayList<>();
		Review reviewRid = new Review(); 
		LOGGER.info(rid);
		int rowsPerPage = pager.getRowsPerPage();
		
		if(rid != null) {
			LOGGER.info("rid가 null이 아니다");
			reviewRid = homeDao.getReviewByRidRfno(rid, rfno);		
		} else {
			reviewRid = null;
		}
		
		if(reviewRid==null) {
			list = homeDao.selectByPage(rfno, pager.getPageNo(), pager.getRowsPerPage());
		} else {
			list = homeDao.selectListReviewByRfno(rfno);
			list.remove(list.indexOf(reviewRid));
			list.add(0, reviewRid);
			int startIndex = (pager.getPageNo()-1)*pager.getRowsPerPage();
			if(pager.getPageNo() == pager.getTotalPageNo()) {
				rowsPerPage = pager.getTotalRows()%pager.getRowsPerPage();
				list = list.subList(startIndex, startIndex+rowsPerPage);
			} else {
				list = list.subList(startIndex, startIndex+rowsPerPage);
				LOGGER.info("sublist 실행 : "+ list.size());
			}
		}
		
		return list;
	}
	
	public List<Review> getAllReviewList(int pageNo, int rowsPerPage){
		List<Review> list = homeDao.selectAllReviewByPage(pageNo, rowsPerPage);
		return list;
	}

	public void insertDB(int mvfno, int mvplace, String mvstarttime, int mvdate) {
		homeDao.insertDB(mvfno,mvplace,mvstarttime,mvdate);
	}

	public void updateDB(int i) {
		homeDao.updateDB(i);		
	}

	public boolean judgeToday(String date) {
		return homeDao.judgeToday(date);
	}
	
}
