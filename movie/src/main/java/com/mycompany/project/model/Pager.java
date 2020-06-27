package com.mycompany.project.model;

public class Pager {
	private int totalRows;
	private int totalPageNo;
	private int totalGroupNo;
	private int startPageNo;
	private int endPageNo;
	private int pageNo;
	private int pagesPerGroup;
	private int groupNo;
	private int rowsPerPage;
	
	public Pager(int rowsPerPage, int pagesPerGroup, int totalRows, int pageNo) {
		this.rowsPerPage = rowsPerPage;
		this.pagesPerGroup = pagesPerGroup;
		this.totalRows= totalRows;
		this.pageNo = pageNo;
		
		totalPageNo =totalRows/rowsPerPage;
		if(totalRows % rowsPerPage != 0) totalPageNo++;
		
		totalGroupNo = totalPageNo / pagesPerGroup;
		if(totalPageNo % pagesPerGroup !=0 ) totalGroupNo++;
		
		groupNo = (pageNo-1)/pagesPerGroup+1;
		
		startPageNo = (groupNo-1) * pagesPerGroup+1;
		
		endPageNo=startPageNo + pagesPerGroup-1;
		if(groupNo==totalGroupNo) endPageNo=totalPageNo;
	}
	
	public int getTotalRows() {
		return totalRows;
	}
	public int getTotalPageNo() {
		return totalPageNo;
	}
	public int getTotalGroupNo() {
		return totalGroupNo;
	}
	public int getStartPageNo() {
		return startPageNo;
	}
	public int getEndPageNo() {
		return endPageNo;
	}
	public int getPageNo() {
		return pageNo;
	}
	public int getPagesPerGroup() {
		return pagesPerGroup;
	}
	public int getGroupNo() {
		return groupNo;
	}
	public int getRowsPerPage() {
		return rowsPerPage;
	}
	
	
}
