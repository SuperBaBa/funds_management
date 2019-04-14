package com.jcq.util;

public class TurnPage {
	private long total;// 总记录数
	private int pageCount;// 总页数
	private int page;// 当前页
	private int rows;// 每页多少行
	private int startNum;// 查询开始的记录数
	private int status;
	private String sort;
	private String order;
	

	

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public long getTotal() {
		return total;
	}

	public void setTotal(long Total) {
		this.total = Total;
	}

	public int getPageCount() {
		long tmp = (this.total % (long) this.rows == 0) ? (this.total / this.rows) : (this.total / this.rows) + 1;
		// long包装类型转换为int
		pageCount = (new Long(tmp)).intValue();
		return pageCount;
	}

	@Override
	public String toString() {
		return "TurnPage [total=" + total + ", pageCount=" + pageCount + ", page=" + page + ", rows=" + rows
				+ ", startNum=" + startNum + ", status=" + status + "]";
	}

	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getRows() {
		return rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	public int getStartNum() {
		startNum = (page - 1) * this.rows;
		return startNum;
	}

	public void setStartNum(int startNum) {
		this.startNum = startNum;
	}

	/**
	 * 计算总共的页数
	 */
	// public int getPageCount() {
	// long tmp = (this.pageTotal % this.rows == 0) ? (this.pageTotal / this.rows) :
	// (this.pageTotal / this.rows) + 1;
	// // long包装类型转换为int
	// pageCount = (new Long(tmp)).intValue();
	// return pageCount;
	// }

	/**
	 * 执行查询时，开始的记录数
	 */
	// public int getStartNum() {
	// startNum = (page - 1) * this.rows;
	// return startNum;
	// }

}
