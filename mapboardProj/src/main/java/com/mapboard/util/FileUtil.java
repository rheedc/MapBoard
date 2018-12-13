package com.mapboard.util;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Calendar;

//�� Ŭ������ ���� ���ε带 �Ҷ� �߻��� �� �ִ� �������� �ذ��ϱ� ����
//���� ����� ����� ���� Ŭ����
public class FileUtil {
	
	static int count = 0;	//����Ǵ� ���ϸ� ���� ��ȣ�� ����� ���� 
	//���ε��� ������ ������?
	//�ڵ����� ����� �ȴ�.
	public static void makeFolder(String path) {
		//���� ��θ� �̿��ؼ� FileŬ������ �����.
		File file = new File(path);
		
		//mkdirs�Լ��� �̿��ؼ� ������ ������ �����.
		file.mkdirs();
	}
	
	//���� �̸��� ������ �����Ѵٸ�?
	//���� ������ �̸��� �ٲ������ν� ����Ⱑ ���� �ʵ��� �����Ѵ�.
	public static String renameTo(String path, String name) {
		
		//�̸��� �ٲٱ� ���� Ȥ�� ������ ������ ������ ����� ��������.
		makeFolder(path);
		
		//�Ű����� ����
		//���(path) ���� �̸�(name)���� ������ �����ε�, �̸� �ٲ���~
		
		//�̸� �ٲܶ��� ���
		/*���� ���� �̸��� ������ �����ϸ�
		 * ���� �����̸� ������ _��ȣ�� �ٿ��� �̸��� �ٲٵ��� �Ѵ�.
		 * ��) a.txt ����
		 * 	  a_1.txt  �ٲ� ����
		 * 	  a_2.txt	�ٲ� ����*/
		
		String TempName = name;	//���� �̸��� ����� ���´�.
		//�̸��� Ȯ���ڸ� �и��� �� �̸��� �����ؼ� Ȯ���ڿ� ��ģ��.
		
		
		int index = name.lastIndexOf(".");	//.�� �������� ������
		String fileName = name.substring(0,	 index);	//a
		String extName = name.substring(index+1); 	//txt
			
		Calendar cal = Calendar.getInstance()  ;
	    
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd_HHmmSS");
			    
		String time = dateFormat.format(cal.getTime());
				
		//���ϸ�ڿ� (����) �ð��� ���δ�
		fileName = fileName+"_"+time;		//a_time~~~
		
		//���� ����� Ȯ���ڸ� �ٿ��� ������ �����̸����� �ٽ� �����.
		TempName = fileName+"."+extName;	//a_time~~~.txt	

		return TempName;
	}
}
