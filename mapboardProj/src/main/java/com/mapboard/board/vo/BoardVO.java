package com.mapboard.board.vo;

import org.springframework.web.multipart.MultipartFile;

import com.mapboard.common.vo.CommonVO;

public class BoardVO extends CommonVO{
	private String subject;
	private String comm;
	private int point;
	private int likecnt;
	private int readcnt;
	
	private int bcidx;
	
	private long fidx;
	private String fpath;
	private String foriname;
	private String fsname;
	
	private long fsize;
	private MultipartFile[] files;
	
	private String place_name;
	private int filecount;


	private int category_no;
	
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
	
	
	
	public int getCategory_no() {
		return category_no;
	}


	public void setCategory_no(int category_no) {
		this.category_no = category_no;
	}

	
	
	public int getFilecount() {
		return filecount;
	}
	public void setFilecount(int filecount) {
		this.filecount = filecount;
	}

	public String getPlace_name() {
		return place_name;
	}
	public void setPlace_name(String place_name) {
		this.place_name = place_name;
	}
	public long getFidx() {
		return fidx;
	}
	public void setFidx(long fidx) {
		this.fidx = fidx;
	}
	public String getFpath() {
		return fpath;
	}
	public void setFpath(String fpath) {
		this.fpath = fpath;
	}
	public String getForiname() {
		return foriname;
	}
	public void setForiname(String foriname) {
		this.foriname = foriname;
	}
	public String getFsname() {
		return fsname;
	}
	public void setFsname(String fsname) {
		this.fsname = fsname;
	}
	public long getFsize() {
		return fsize;
	}
	public void setFsize(long fsize) {
		this.fsize = fsize;
	}
	public MultipartFile[] getFiles() {
		return files;
	}
	public void setFiles(MultipartFile[] files) {
		this.files = files;
	}
	public int getBcidx() {
		return bcidx;
	}

	public void setBcidx(int bcidx) {
		this.bcidx = bcidx;
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
	
	
	

	


	
	
	

}