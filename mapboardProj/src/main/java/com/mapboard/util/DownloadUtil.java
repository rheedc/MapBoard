package com.mapboard.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

//��Ʈ�� ������� ������ ������ Ŭ���̾�Ʈ���� ������ �������� ����ϴ� Ŭ����

//1. ���������� �ٿ�ε带 ���� Ŭ������ ���� ���� 
//	�ݵ�� AbstractView�� ��ӹ޾ƾ� �Ѵ�.
//2. renderMergedOutputModel()�Լ��� Override�Ѵ�.
//	������ ��Ʈ�� ������� ������ Ŭ���̾�Ʈ���� �����ϴ� �۾��� ����� �Լ�
public class DownloadUtil extends AbstractView{
	
	//������ �Լ��� �̿��ؼ� �� Ŭ������ new�� �Ǹ�
	//�������� ��Ʈ������ �����ϵ��� ����.
	//���� �� Ŭ������ xml���Ͽ� <bean>ó���� �����̹Ƿ� �������� �˾Ƽ� new���� ���̴�
	public DownloadUtil() {
		this.setContentType("application/download;charset=UTF-8");
	}

	@Override
	protected void renderMergedOutputModel(Map model, 
			HttpServletRequest req,	HttpServletResponse res) 
			throws Exception {
		//model : ��Ʈ�ѷ��� �˷��ִ� �ٿ�ε� ���Ͽ� ���� ������ ����� ����
		
		//��Ʈ�ѷ��� downloadFile �̶�� Ű������ ������ ������ �˷�����.
		//������ ������ File�̶�� Ŭ������ ���� �����ϱ�� ����.
		
		//Ŭ���̾�Ʈ���� ������ ������ ������ �˾Ƴ���.
		File file = (File)model.get("downloadFile"); //Ű��:downloadFile, ����:file
		
		//�������� ��Ʈ��������� ó������.
		res.setContentType(this.getContentType());
		
		//���� ������ ũ�⸦ �˷�����.
		res.setContentLength((int)file.length());
		
		//�ٿ�ε��� �����̸��� ����
		//������ �����̸��� �ѱ��� ������ ���� ������ �����Ƿ�
		//encodingó���� �ؾ��Ѵ�.. �ƴϸ� �������ϸ� �ְ� �ϴ���..
		String Encoding = 
		new String(file.getName().getBytes("UTF-8"),"8859_1");
		//StringŸ����  => byte�� ��ȯ
		
		//���� �̸����� �ٿ�ε带 �� �� �ְ� ó��...
		//���� �ٿ�ε� ��ȭ���ڸ� ���
		res.setHeader("Content-Disposition",
				"attachment;filename="+Encoding);
		
		//---------------------------------------------------�ٿ�ε� ���� ȯ�� ����
		
		//---------------------------------------------------��Ʈ�� ������� �ٿ�ε带 �����ϸ� �ȴ�.
		//1. ������ ���ϳ����� ��Ʈ��������� �о 
		//FileInputStream fin= new FileInputStream(~~);
		//2. Ŭ���̾�Ʈ���� 	��Ʈ��������� ������ �����ؾ� �Ѵ�.
		//ServletOutputStream sout = res.getOutputStream();
		
		FileInputStream fin = null;
		
		OutputStream fout = null;
		
		try {
			fin = new FileInputStream(file);
			fout  = res.getOutputStream();
			
			//���ʿ��� �о �ٸ��ʿ� ���� ���� �Ʒ� �Լ��� �����Ѵ�.
			//FileCopyUtils.copy(InputStream in, OutputStream out);
			FileCopyUtils.copy(fin, fout);
		}
		catch(Exception e) {
			System.out.println("DownloadUtil �ٿ�ε� ó�� ���� = "+e);
		}
		finally {
			fout.flush();
			fin.close();
			fout.close();
		}
		
	}

}
