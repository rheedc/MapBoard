package com.mapboard.vo;

/*Ŭ���� ����: �� Ŭ������ ȸ���� ���� �����͸� ����� VO Ŭ����
 * �ۼ���: �̴�õ
 * �ۼ���: 2018-12-07
 * ����������: 2018-12-07
 */

	// VO ���� ������ ���� ������ jsp ���Ͽ��� ����� name �Ӽ��� ��Ī�� �����ϰ� �ϴ� ���� ����!!
	// set~~() �Լ��� �Ķ���͸� �ޱ� ���� �Լ�
	// get~~() �Լ��� �𵨷� �Ķ���͸� �ѱ�� ���� �Լ�
public class MemberVO extends CommonVO{
		private String nick;
		private String uname;
		private String passwd;
		private int ulevel;
		
		
		public String getNick() {
			return nick;
		}
		public void setNick(String nick) {
			this.nick = nick;
		}
		public String getUname() {
			return uname;
		}
		public void setUname(String uname) {
			this.uname = uname;
		}
		public String getPasswd() {
			return passwd;
		}
		public void setPasswd(String passwd) {
			this.passwd = passwd;
		}
		public int getUlevel() {
			return ulevel;
		}
		public void setUlevel(int ulevel) {
			this.ulevel = ulevel;
		}
		
		
		

}
