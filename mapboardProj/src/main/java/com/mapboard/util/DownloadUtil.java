package com.mapboard.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

//스트림 방식으로 서버의 파일을 클라이언트에게 전달할 목적으로 사용하는 클래스

//1. 스프링에서 다운로드를 위한 클래스를 만들 때는 
//	반드시 AbstractView를 상속받아야 한다.
//2. renderMergedOutputModel()함수를 Override한다.
//	실제로 스트림 방식으로 파일을 클라이언트에게 전달하는 작업을 담당할 함수
public class DownloadUtil extends AbstractView{
	
	//생성자 함수를 이용해서 이 클래스가 new가 되면
	//응답방식을 스트림으로 변경하도록 하자.
	//물론 이 클래스는 xml파일에 <bean>처리할 예정이므로 스프링이 알아서 new해줄 것이다
	public DownloadUtil() {
		this.setContentType("application/download;charset=UTF-8");
	}

	@Override
	protected void renderMergedOutputModel(Map model, 
			HttpServletRequest req,	HttpServletResponse res) 
			throws Exception {
		//model : 컨트롤러가 알려주는 다운로드 파일에 대한 정보를 기억할 변수
		
		//컨트롤러가 downloadFile 이라는 키값으로 파일의 정보를 알려주자.
		//파일의 정보는 File이라는 클래스로 만들어서 제공하기로 하자.
		
		//클라이언트에게 전달한 파일의 정보를 알아내자.
		File file = (File)model.get("downloadFile"); //키값:downloadFile, 정보:file
		
		//응답방식을 스트림방식으로 처리하자.
		res.setContentType(this.getContentType());
		
		//응답 파일의 크기를 알려주자.
		res.setContentLength((int)file.length());
		
		//다운로드할 파일이름을 지정
		//문제는 파일이름에 한글이 있으면 깨질 위험이 있으므로
		//encoding처리를 해야한다.. 아니면 영문파일만 넣게 하던가..
		String Encoding = 
		new String(file.getName().getBytes("UTF-8"),"8859_1");
		//String타입을  => byte로 변환
		
		//원본 이름으로 다운로드를 할 수 있게 처리...
		//파일 다운로드 대화상자를 출력
		res.setHeader("Content-Disposition",
				"attachment;filename="+Encoding);
		
		//---------------------------------------------------다운로드 해줄 환경 설정
		
		//---------------------------------------------------스트림 방식으로 다운로드를 실행하면 된다.
		//1. 서버의 파일내용을 스트림방식으로 읽어서 
		//FileInputStream fin= new FileInputStream(~~);
		//2. 클라이언트에게 	스트림방식으로 파일을 전송해야 한다.
		//ServletOutputStream sout = res.getOutputStream();
		
		FileInputStream fin = null;
		
		OutputStream fout = null;
		
		try {
			fin = new FileInputStream(file);
			fout  = res.getOutputStream();
			
			//한쪽에서 읽어서 다른쪽에 쓰는 일을 아래 함수가 실행한다.
			//FileCopyUtils.copy(InputStream in, OutputStream out);
			FileCopyUtils.copy(fin, fout);
		}
		catch(Exception e) {
			System.out.println("DownloadUtil 다운로드 처리 에러 = "+e);
		}
		finally {
			fout.flush();
			fin.close();
			fout.close();
		}
		
	}

}
