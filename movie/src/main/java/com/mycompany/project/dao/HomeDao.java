package com.mycompany.project.dao;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.mycompany.project.model.Film;
import com.mycompany.project.model.Review;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class HomeDao extends EgovAbstractMapper {
	private static final Logger LOGGER = LoggerFactory.getLogger(HomeDao.class);
	
	public List<Film> selectAllFilm() {
		return selectList("film.selectAll");
	}

	public Film selectByFno(int fno) {
		return selectOne("film.selectByFno", fno);
	}

	public double selectAvgRscore(int rfno) {
		String strAvg = selectOne("review.selectAvgRscore", rfno);
		
		if(strAvg == null) {
			strAvg = "0.0";
		}
		return Double.parseDouble(strAvg);
	}
	
	public int insert(Review review) {
		LOGGER.info("실행");
		int rows = insert("review.insert", review);
		return rows;
	}
	
	public Review getReviewByRidRfno(String rid, int rfno) {
		LOGGER.info("실행");
		Review review = new Review();
		review.setRid(rid);
		review.setRfno(rfno);
		review = selectOne("review.selectByRidRfno",review);
		return review;
	}

	public void updateByRno(Review review) {
		update("review.updateByRno", review);
	}

	public void deleteByRno(int rno) {
		delete("review.deleteByRno", rno);
	}
	
	public int countReview(int rfno) {
		return selectOne("review.countReview", rfno);
	}
	
	public int countAll() {
		return selectOne("review.countAll");
	}
	
	public void updateFscore(Film film) {
		update("film.updateFscore", film);
		
	}

	public List<Review> selectByRidRfno(String rid, int rfno) {
		Review review = new Review();
		review.setRid(rid);
		review.setRfno(rfno);
		return selectList("review.selectByRidRfno", review);
	}
	
	public List<Review> selectByPage(int rfno, int pageNo, int rowsPerPage){
		int startIndex = (pageNo-1)*rowsPerPage;
		Map<String, Integer> map = new HashMap<>();		//selectList의 매개변수 object 객체 하나만 받을 수 있기때문에 Map 사용
		map.put("rfno", rfno);
		map.put("startIndex", startIndex);
		map.put("rowsPerPage", rowsPerPage);

		List<Review> list = selectList("review.selectByRfno", map );
		
		return list;
	}
	
	public List<Review> selectAllReviewByPage(int pageNo, int rowsPerPage){
		int startIndex = (pageNo-1)*rowsPerPage;
		Map<String, Integer> map = new HashMap<>();		//selectList의 매개변수 object 객체 하나만 받을 수 있기때문에 Map 사용
		map.put("startIndex", startIndex);
		map.put("rowsPerPage", rowsPerPage);

		List<Review> list = selectList("review.selectAllReview", map );
		
		return list;
	}

	public void insertDB(int mvfno, int mvplace, String mvstarttime, int mvdate) {
		HashMap map = new HashMap();
		map.put("mvfno", mvfno);
		map.put("mvplace", mvplace);
		map.put("mvstarttime", mvstarttime);
		map.put("mvdate", mvdate);
		
		insert("movie.insertDB", map);
		
	}

	public void updateDB(int i) {
		
		int olddate =i-1;
		int newdate =i;
		HashMap map = new HashMap();
		map.put("olddate", olddate);
		map.put("newdate", newdate);
		update("movie.updateDB", map);
		update("ticket.updateDB",map);
	}
	
	public boolean judgeToday(String date) {
		if(date.equals(selectOne("movie.selectDate"))){
			LOGGER.info("오늘날~~");
			return true;
		}
		return false;
	}

	public List<Review> selectListReviewByRfno(int rfno) {
		return selectList("review.selectListReviewByRfno", rfno);
	}

}
