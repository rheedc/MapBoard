package com.mapboard.vo;

import java.sql.Date;

public class CommonVO {

	private String userid;		//common
	private String juso;	//common
	private double latitude;	//common
	private double longitude;	//common
	private Date createdt;	//common
	private Date updatedt;	//common
	private String status;	//common
	private int place_no;		//common
	private long bidx;		//common
	
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getJuso() {
		return juso;
	}
	public void setJuso(String juso) {
		this.juso = juso;
	}
	public double getLatitude() {
		return latitude;
	}
	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}
	public double getLongitude() {
		return longitude;
	}
	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}
	public Date getCreatedt() {
		return createdt;
	}
	public void setCreatedt(Date createdt) {
		this.createdt = createdt;
	}
	public Date getUpdatedt() {
		return updatedt;
	}
	public void setUpdatedt(Date updatedt) {
		this.updatedt = updatedt;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int getPlace_no() {
		return place_no;
	}
	public void setPlace_no(int place_no) {
		this.place_no = place_no;
	}
	public long getBidx() {
		return bidx;
	}
	public void setBidx(long bidx) {
		this.bidx = bidx;
	}
	
	
	
	
}