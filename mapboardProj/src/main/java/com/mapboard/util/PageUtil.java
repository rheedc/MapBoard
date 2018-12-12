package com.mapboard.util;

//페이지 이동기능을 만들기 위해서 보조적으로 사용하는 유틸리티 클래스
public class PageUtil {
	//지난번에는 pageCount로 통째로 움직였다면
	//이번에는 nowPage를 중심으로 양옆으로 페이지가 나오게 만들겠다
	
	//	필수 변수(반드시 개발자가 알려주어야 할 변수)
	//		현재 보고싶은 페이지, 총 데이터 개수를 알려주어야 한다.
	private		int		nowPage;		//	현재 보고싶은 페이지
	private		int		totalCount;		//	총 데이터 개수
	
	//	필수 변수(계산을 위해서는 꼭 알아야 할 변수)
	//		한페이지당 몇개의 목록을 보여줄지, 한페이지당 페이지 이동 개수
	//		(이 변수의 데이터는 개발자가 알려줘도 되고, 하드코딩해도 된다.)
	private		int		listCount;		//	한페이지에 나타날 게시물 개수
	private		int		pageCount;		//	한페이지에 나타날 페이지 이동 개수
	
	//	계산 변수(계산에 의해서 계산되어야 할 변수)
	//		총 페이지수, 시작 페이지, 종료 페이지
	private		int		totalPage;		//	총 페이지수
	private		int		startPage;		//	화면에 표시할 시작 페이지수
	private		int		endPage;		//	화면에 표시할 마지막 페이지수
	
	/*페이지 이동기능을 만드는 장소에서 정보를 받아야한다*/
	public PageUtil(int np, int tc) {
//		this.nowPage = np;
//		this.totalCount = tc;
//		this.listCount = 10;
//		this.pageCount = 5;
		
		//	아래쪽에 만든 또다른 생성자를 강제로 호출하면서 필요한 데이터(10, 5)를 강제로
		//	주게 되면 소스가 좀더 간편해 진다.
		this(np, tc, 10, 5);
	}
	//	4개의 데이터를 개발자가 모두 지정하도록 해보자.
	public PageUtil(int np, int tc, int lc, int pc) {
		this.nowPage = np;
		this.totalCount = tc;
		this.listCount = lc;
		this.pageCount = pc;
		
		//생성자에서 함수 호출
		//	new를 시키는 순간 자동 계산되도록 해보자.
		calcTotalPage();
		calcStartPage();
		calcEndPage();
	}
	//	필요한 계산을 하자.
	protected void calcTotalPage() {
		//	총 페이지수는 총 데이터 개수 / 한화면에 보여줄 게시물 개수
		//	주의	마지막 페이지는 한개가 남아도 한 페이지가 더 필요하다.
		//			예>			100 / 10		10
		//						101	/ 10		11
		totalPage = (totalCount % listCount == 0) ? (totalCount / listCount): 
																(totalCount / listCount) + 1;
	}
	protected void calcStartPage() {
		//현재 페이지를 가운데 놓고
		//좌우에 이전 혹은 다음 페이지를 위치시키는 방식으로 만들겠다
		/*
		 * [7]
		 * 5 6 [7] 8 9
		 */
		//나누는 부분은 int처리되므로 0.5부분 삭제됨
		startPage=nowPage-(pageCount/2);
		
		if(startPage<=0) {
			startPage=1;
		}
	}
	protected void calcEndPage() {
		//	원리
		//		시작 페이지 + 화면에 보여줄 이동수 - 1
		//		주의	마지막 화면에는 총 페이지수를 넘어간 내용은 만들지 않아도 된다.
		endPage = startPage + pageCount - 1;
		if(endPage >= totalPage) {
			endPage = totalPage;
		}
	}
	
	//	이렇게 계산된 데이터는 화면(뷰)에서 이용하기 위해서 만든것이다.
	//	뷰에서 이용할 데이터는 getXxx()가 존재해야만 이용할 수 있다.
	public int getNowPage() {
		return nowPage;
	}
	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	public int getListCount() {
		return listCount;
	}
	public void setListCount(int listCount) {
		this.listCount = listCount;
	}
	public int getPageCount() {
		return pageCount;
	}
	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
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
}
