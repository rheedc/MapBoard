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

	//페이징처리를 위해 필요한 변수들
	private int rno;			//common
	private int start;		//common
	private int end;		//common
	
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public int getStart() {
		return start;
	}
	public void setStart(int start) {
		this.start = start;
	}
	public int getEnd() {
		return end;
	}
	public void setEnd(int end) {
		this.end = end;
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