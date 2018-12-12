package com.mapboard.util;

//������ �̵������ ����� ���ؼ� ���������� ����ϴ� ��ƿ��Ƽ Ŭ����
public class PageUtil {
	//���������� pageCount�� ��°�� �������ٸ�
	//�̹����� nowPage�� �߽����� �翷���� �������� ������ ����ڴ�
	
	//	�ʼ� ����(�ݵ�� �����ڰ� �˷��־�� �� ����)
	//		���� ������� ������, �� ������ ������ �˷��־�� �Ѵ�.
	private		int		nowPage;		//	���� ������� ������
	private		int		totalCount;		//	�� ������ ����
	
	//	�ʼ� ����(����� ���ؼ��� �� �˾ƾ� �� ����)
	//		���������� ��� ����� ��������, ���������� ������ �̵� ����
	//		(�� ������ �����ʹ� �����ڰ� �˷��൵ �ǰ�, �ϵ��ڵ��ص� �ȴ�.)
	private		int		listCount;		//	���������� ��Ÿ�� �Խù� ����
	private		int		pageCount;		//	���������� ��Ÿ�� ������ �̵� ����
	
	//	��� ����(��꿡 ���ؼ� ���Ǿ�� �� ����)
	//		�� ��������, ���� ������, ���� ������
	private		int		totalPage;		//	�� ��������
	private		int		startPage;		//	ȭ�鿡 ǥ���� ���� ��������
	private		int		endPage;		//	ȭ�鿡 ǥ���� ������ ��������
	
	/*������ �̵������ ����� ��ҿ��� ������ �޾ƾ��Ѵ�*/
	public PageUtil(int np, int tc) {
//		this.nowPage = np;
//		this.totalCount = tc;
//		this.listCount = 10;
//		this.pageCount = 5;
		
		//	�Ʒ��ʿ� ���� �Ǵٸ� �����ڸ� ������ ȣ���ϸ鼭 �ʿ��� ������(10, 5)�� ������
		//	�ְ� �Ǹ� �ҽ��� ���� ������ ����.
		this(np, tc, 10, 5);
	}
	//	4���� �����͸� �����ڰ� ��� �����ϵ��� �غ���.
	public PageUtil(int np, int tc, int lc, int pc) {
		this.nowPage = np;
		this.totalCount = tc;
		this.listCount = lc;
		this.pageCount = pc;
		
		//�����ڿ��� �Լ� ȣ��
		//	new�� ��Ű�� ���� �ڵ� ���ǵ��� �غ���.
		calcTotalPage();
		calcStartPage();
		calcEndPage();
	}
	//	�ʿ��� ����� ����.
	protected void calcTotalPage() {
		//	�� ���������� �� ������ ���� / ��ȭ�鿡 ������ �Խù� ����
		//	����	������ �������� �Ѱ��� ���Ƶ� �� �������� �� �ʿ��ϴ�.
		//			��>			100 / 10		10
		//						101	/ 10		11
		totalPage = (totalCount % listCount == 0) ? (totalCount / listCount): 
																(totalCount / listCount) + 1;
	}
	protected void calcStartPage() {
		//���� �������� ��� ����
		//�¿쿡 ���� Ȥ�� ���� �������� ��ġ��Ű�� ������� ����ڴ�
		/*
		 * [7]
		 * 5 6 [7] 8 9
		 */
		//������ �κ��� intó���ǹǷ� 0.5�κ� ������
		startPage=nowPage-(pageCount/2);
		
		if(startPage<=0) {
			startPage=1;
		}
	}
	protected void calcEndPage() {
		//	����
		//		���� ������ + ȭ�鿡 ������ �̵��� - 1
		//		����	������ ȭ�鿡�� �� ���������� �Ѿ ������ ������ �ʾƵ� �ȴ�.
		endPage = startPage + pageCount - 1;
		if(endPage >= totalPage) {
			endPage = totalPage;
		}
	}
	
	//	�̷��� ���� �����ʹ� ȭ��(��)���� �̿��ϱ� ���ؼ� ������̴�.
	//	�信�� �̿��� �����ʹ� getXxx()�� �����ؾ߸� �̿��� �� �ִ�.
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
