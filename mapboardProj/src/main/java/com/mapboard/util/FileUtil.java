package com.mapboard.util;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Calendar;

//이 클래스는 파일 업로드를 할때 발생할 수 있는 문제점을 해결하기 위한
//각종 기능을 만들어 놓은 클래스
public class FileUtil {
	
	static int count = 0;	//변경되는 파일명에 붙일 번호를 기억할 변수 
	//업로드할 폴더가 없으면?
	//자동으로 만들면 된다.
	public static void makeFolder(String path) {
		//받은 경로를 이용해서 File클래스를 만든다.
		File file = new File(path);
		
		//mkdirs함수를 이용해서 강제로 폴더를 만든다.
		file.mkdirs();
	}
	
	//같은 이름의 파일이 존재한다면?
	//현재 파일의 이름을 바꿔줌으로써 덮어쓰기가 되지 않도록 방지한다.
	public static String renameTo(String path, String name) {
		
		//이름을 바꾸기 전에 혹시 저장할 폴더가 없으면 만들고 시작하자.
		makeFolder(path);
		
		//매개변수 설명
		//어디에(path) 무슨 이름(name)으로 저장할 예정인데, 이름 바꿔줘~
		
		//이름 바꿀때의 약속
		/*만약 같은 이름의 파일이 존재하면
		 * 현재 파일이름 다음에 _번호를 붙여서 이름을 바꾸도록 한다.
		 * 예) a.txt 파일
		 * 	  a_1.txt  바꿀 예정
		 * 	  a_2.txt	바꿀 예정*/
		
		String TempName = name;	//현재 이름을 기억해 놓는다.
		//이름과 확장자를 분리한 후 이름을 변경해서 확장자와 합친다.
		
		
		int index = name.lastIndexOf(".");	//.을 기준으로 나누기
		String fileName = name.substring(0,	 index);	//a
		String extName = name.substring(index+1); 	//txt
			
		Calendar cal = Calendar.getInstance()  ;
	    
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd_HHmmSS");
			    
		String time = dateFormat.format(cal.getTime());
				
		//파일명뒤에 (위의) 시간을 붙인다
		fileName = fileName+"_"+time;		//a_time~~~
		
		//위의 결과에 확장자를 붙여서 온전한 파일이름으로 다시 만든다.
		TempName = fileName+"."+extName;	//a_time~~~.txt	

		return TempName;
	}
}