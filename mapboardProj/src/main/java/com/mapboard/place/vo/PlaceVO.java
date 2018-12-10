package com.mapboard.place.vo;

import com.mapboard.common.vo.CommonVO;

public class PlaceVO extends CommonVO{
	private String place_name;
	private int category_no;
	private int sigungu_code;
	private String sigungu_name;
	private String doro_juso;
	
	
	
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
