package g3way.board.vo;

public class PageVo {
	private int page; // 현재 페이지
	private int maxPage; // 전체 필요한 페이지 갯수
	private int startPage; // 현재 페이지 기준 시작 페이지 값
	private int endPage; // 현재 페이지 기준 종료 페이지 값
	private int pageLimit; // // 한 페이지에 보여줄 게시물의 수
	
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getMaxPage() {
		return maxPage;
	}
	public void setMaxPage(int maxPage) {
		this.maxPage = maxPage;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public int getPageLimit() {
		return pageLimit;
	}
	public void setPageLimit(int pageLimit) {
		this.pageLimit = pageLimit;
	}

}
