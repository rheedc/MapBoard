package com.mapboard.place.vo;

import com.mapboard.common.vo.CommonVO;

public class PlaceVO extends CommonVO{
	private String place_name;
	private int category_no;
	private int sigungu_code;
	private String sigungu_name;
	private String doro_juso;
	
	//지도게시판에서 하나의 VO를 사용하려면 
	//게시물 정보를 가져오기 위한 변수도 선언해야한다  
	private String subject;
	private String comm;
	private int point;
	private int likecnt;
	private int readcnt;
	private String nick;
	
	//정보를 뿌리기 위해 추가로 필요한 변수들
	
	public String getNick() {
		return nick;
	}

	public void setNick(String nick) {
		this.nick = nick;
	}
	private int placecnt_total;		//총 필터링된 장소개수
	private float avgpoint;			//장소별 평균평점
	private int goodcnt;				//good개수
	private int sosocnt;					//soso개수
	private int badcnt;					//bad개수
	private int reviewcnt;				//장소에 남긴 게시물개수
	private int reviewcnt_total;	//총 필터링된 게시물개수
	
	
	private String createMonth;	
	private float move_total;
	private int movecnt_total;
	private float move_month;
	private int movecnt_month;
	
	
	public String getCommStr() {
		String tempComm=comm;
		if(comm.length()>=25) {
			tempComm=comm.substring(0,25)+"...";
		}
		return tempComm;
	}
	
	public String getPointStr() {
		String tempPoint="";
		if(point==1) {
			tempPoint="BAD";
		}
		if(point==3) {
			tempPoint="SOSO";
		}
		if(point==5) {
			tempPoint="GOOD";
		}
		return tempPoint;
	}
	public String getCreateMonth() {
		return createMonth;
	}

	public void setCreateMonth(String createMonth) {
		this.createMonth = createMonth;
	}

	public float getMove_total() {
		return move_total;
	}

	public void setMove_total(float move_total) {
		this.move_total = move_total;
	}

	public int getMovecnt_total() {
		return movecnt_total;
	}

	public void setMovecnt_total(int movecnt_total) {
		this.movecnt_total = movecnt_total;
	}

	public float getMove_month() {
		return move_month;
	}

	public void setMove_month(float move_month) {
		this.move_month = move_month;
	}

	public int getMovecnt_month() {
		return movecnt_month;
	}

	public void setMovecnt_month(int movecnt_month) {
		this.movecnt_month = movecnt_month;
	}

	//카테고리번호로 카테고리명 추출하는 방식
	public String getCategoryName() {
		String category_name="";
		if(category_no==1) {
			category_name="관광/여가/오락";
		}
		if(category_no==2) {
			category_name="숙박";
		}
		if(category_no==3) {
			category_name="의료";
		}
		if(category_no==4) {
			category_name="한식/중식/양식";
		}
		if(category_no==5) {
			category_name="커피점/카페";
		}
		if(category_no==6) {
			category_name="기타";
		}
		return category_name;
	}
	
	public int getPlacecnt_total() {
		return placecnt_total;
	}
	public void setPlacecnt_total(int placecnt_total) {
		this.placecnt_total = placecnt_total;
	}
	public float getAvgpoint() {
		return avgpoint;
	}
	public void setAvgpoint(float avgpoint) {
		this.avgpoint = avgpoint;
	}
	public int getGoodcnt() {
		return goodcnt;
	}
	public void setGoodcnt(int goodcnt) {
		this.goodcnt = goodcnt;
	}
	public int getSosocnt() {
		return sosocnt;
	}
	public void setSosocnt(int sosocnt) {
		this.sosocnt = sosocnt;
	}
	public int getBadcnt() {
		return badcnt;
	}
	public void setBadcnt(int badcnt) {
		this.badcnt = badcnt;
	}
	public int getReviewcnt() {
		return reviewcnt;
	}
	public void setReviewcnt(int reviewcnt) {
		this.reviewcnt = reviewcnt;
	}
	public int getReviewcnt_total() {
		return reviewcnt_total;
	}
	public void setReviewcnt_total(int reviewcnt_total) {
		this.reviewcnt_total = reviewcnt_total;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getComm() {
		return comm;
	}
	public void setComm(String comm) {
		this.comm = comm;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public int getLikecnt() {
		return likecnt;
	}
	public void setLikecnt(int likecnt) {
		this.likecnt = likecnt;
	}
	public int getReadcnt() {
		return readcnt;
	}
	public void setReadcnt(int readcnt) {
		this.readcnt = readcnt;
	}
	public String getPlace_name() {
		return place_name;
	}
	public void setPlace_name(String place_name) {
		this.place_name = place_name;
	}
	public int getCategory_no() {
		return category_no;
	}
	public void setCategory_no(int category_no) {
		this.category_no = category_no;
	}
	public int getSigungu_code() {
		return sigungu_code;
	}
	public void setSigungu_code(int sigungu_code) {
		this.sigungu_code = sigungu_code;
	}
	public String getSigungu_name() {
		return sigungu_name;
	}
	public void setSigungu_name(String sigungu_name) {
		this.sigungu_name = sigungu_name;
	}
	public String getDoro_juso() {
		return doro_juso;
	}
	public void setDoro_juso(String doro_juso) {
		this.doro_juso = doro_juso;
	}

}