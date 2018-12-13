package com.mapboard.place.vo;

import com.mapboard.common.vo.CommonVO;

public class PlaceVO extends CommonVO{
	private String place_name;
	private int category_no;
	private int sigungu_code;
	private String sigungu_name;
	private String doro_juso;
	
	//�����Խ��ǿ��� �ϳ��� VO�� ����Ϸ��� 
	//�Խù� ������ �������� ���� ������ �����ؾ��Ѵ�  
	private String subject;
	private String comm;
	private int point;
	private int likecnt;
	private int readcnt;
	
	//������ �Ѹ��� ���� �߰��� �ʿ��� ������
	
	private int placecnt_total;		//�� ���͸��� ��Ұ���
	private float avgpoint;			//��Һ� �������
	private int goodcnt;				//good����
	private int sosocnt;					//soso����
	private int badcnt;					//bad����
	private int reviewcnt;				//��ҿ� ���� �Խù�����
	private int reviewcnt_total;	//�� ���͸��� �Խù�����
	

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
