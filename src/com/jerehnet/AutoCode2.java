package com.jerehnet;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.OutputStreamWriter;
import java.io.Writer;

import freemarker.template.Configuration;

public class AutoCode2 {

	private Configuration cfg;

//	private final String template = "F:/share/show";
//
//	private String createPath = "F:/temp/";
	
	public Configuration getCfg() {
		return cfg;
	}

	public static void replaceFile(File f) {
		String s = new String();
		String s1 = new String();
		try {
			BufferedReader input = new BufferedReader(new FileReader(f));
			while ((s = input.readLine()) != null) {
				s1 += s + "\n";
			}
			input.close();
			s1 = s1.replace("charset=gb2312", "charset=utf-8");
			s1 = s1.replace("charset=gbk", "charset=utf-8");
			s1 = s1.replace("charset=GB2312", "charset=utf-8");
			s1 = s1.replace("charset=GBK", "charset=utf-8");

			FileOutputStream fos = new FileOutputStream(f.getPath());
			Writer out = new OutputStreamWriter(fos, "UTF-8");
			out.write(s1);
			out.close();
			fos.close();
		

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	final static void replaceFolder(File dir) throws Exception {

		File[] fs = dir.listFiles();
		String fileFullName = ""; // 文件全名含扩展名
		String fileNameTxt = ""; // 文件扩展名
	
		for (int i = 0; i < fs.length; i++) {	
			if (fs[i].isDirectory()) {
				try {
					replaceFolder(fs[i]);           //递归遍历目录
				} catch (Exception e) {
					e.printStackTrace();
				}
			} else if (fs[i].isFile()) {
				fileFullName = fs[i].getName();      //获取文件名
				
				if (fileFullName != null && fileFullName.indexOf(".") != -1) {
					fileNameTxt = fileFullName.substring(fileFullName
							.indexOf(".") + 1, fileFullName.length());		//获取文件扩展名			
					if (fileNameTxt.equalsIgnoreCase("htm")
							|| fileNameTxt.equalsIgnoreCase("html")
							|| fileNameTxt.equalsIgnoreCase("asp")) { //查找符合要求在文件
						replaceFile(fs[i]);					
					}
				}
			}			
		}		
	}
	public static void main(String args[]) throws Exception {
		AutoCode2 tt = new AutoCode2();

        /*替换某个文件的编码和属性为utf-8*/	   
		/*String fileName = "F:/share/Untitled-9.html";
		File f1 = new File(fileName);
		tt.replaceFile(f1);*/

		/*替换某个目录下的 html、htm、asp文件的编码和属性为utf-8*/
	
		String folderName = "C:/Documents and Settings/Administrator/My Documents/ee";
		File f2 = new File(folderName);
		replaceFolder(f2);
		
	

	}

}
