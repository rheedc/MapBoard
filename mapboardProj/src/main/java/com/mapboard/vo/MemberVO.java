package com.mapboard.vo;

/*클래스 목적: 이 클래스는 회원에 대한 데이터를 기억할 VO 클래스
 * 작성자: 이덕천
 * 작성일: 2018-12-07
 * 최종수정일: 2018-12-07
 */

	// VO 에서 변수를 만들 때에는 jsp 파일에서 사용한 name 속성의 명칭과 동일하게 하는 것이 좋다!!
	// set~~() 함수는 파라미터를 받기 위한 함수
	// get~~() 함수는 모델로 파라미터를 넘기기 위한 함수
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
