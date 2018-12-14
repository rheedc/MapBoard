package com.mapboard.board.vo;

import com.mapboard.common.vo.CommonVO;

public class FileinfoVO extends CommonVO{
	
	private long fidx;
	private String fpath;
	private String foriname;
	private String fsname;
	private long fsize;
	
	
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
	
	

}