<%@ page language="java" import="com.jerehnet.manage.*,org.json.*,java.util.*,com.jerehnet.util.common.*,java.sql.*,com.jerehnet.util.dbutil.*,java.io.File" pageEncoding="UTF-8"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.BufferedWriter"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.OutputStreamWriter"%>
<%@page import="java.io.InputStreamReader"%>
<%
	String path = request.getContextPath();
	String realPath = Common.getAbsolutePath(request)+"action/" ;
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
	Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
	List<Map> wordList=null;
	String rs = "fail";
	 HashMap<String, String> filterMap = null;
	 int reults=0;
	 String fileName="";
	 String wheres="";
	 String appliname="";
	String enumNo = CommonString.getFormatPara(request.getParameter("enumNo"));
	try{
		connection = dbHelper.getConnection() ;
		if(flag.equals("2")){//A类会员验证
		  fileName="filter_hy_keywords.txt";
		  wheres=" and keyword_type='200001'";
		  appliname="filterkeywords_a";
		}else if(flag.equals("1")){//普通会员验证
		  fileName="filter_all_keywords.txt";
		   wheres=" and 1=1";
		   appliname="filterkeywords";
		}
		
		
		   //文件写入
			wordList = dbHelper.getMapList(" select top 50 id,keyword from comm_filter_keywords where is_show=1 "+wheres,new Object [] {},connection);
		   if(wordList!=null){
			for(Map kk:wordList){
				String keyword = CommonString.getFormatPara(kk.get("keyword"));
				 keyword = keyword.replace("\\", "\\\\").replace("|", "@@").replace("-", "\\-").replace(".", "\\.").replace("?", "\\?").replace("[", "\\[").replace("]", "\\]").replace("{", "\\{").replace("}", "\\}").replace("+", "\\+").replace("*", "\\*").replace(":", "\\:").replace("(", "\\(").replace(")", "\\)").replace("^", "\\^");
                    out.print("="+keyword+"--");
				   try{
					   filterMap.put(keyword, "1");
					   }catch(Exception e){
							e.printStackTrace();
				       }
					 
				}
			}
			out.print("filterMap="+filterMap);
			//清空全局变量
			application.removeAttribute(appliname);
			//写入全局变量
			application.setAttribute(appliname, filterMap);
			 Map filterMaps =null;
			filterMaps = (Map) application.getAttribute(appliname);
			if(filterMaps!=null){
				Iterator it = filterMaps.keySet().iterator();  
				int i=1;
					 while (it.hasNext()){  
						String key;  
						key=(String)it.next();
						out.print(i+"="+key+"--");
						i++;
					}
			}
	   
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
	
%>
<%!
public String fileRead(String path) throws IOException{
	    File file=new File(path);
	     FileInputStream fip = new FileInputStream(file);
		InputStreamReader reader = new InputStreamReader(fip, "gbk");
		StringBuffer sb = new StringBuffer();
		while (reader.ready()) {
			sb.append((char) reader.read());
		}
		reader.close();
		fip.close();
		return sb.toString();
	}

%>
<%!
public int fileWrite(String path,List<Map> wordList) throws IOException{
			 int rs=0;
	         File file=new File(path);
	         FileOutputStream out=new FileOutputStream(file,true);   
	         OutputStreamWriter oWriter = new OutputStreamWriter(out,"gbk");
	         BufferedWriter bWriter  = new BufferedWriter(oWriter);
	         for(Map words:wordList){
	        	 StringBuffer sb=new StringBuffer();
	             sb.append( CommonString.getFormatPara(words.get("keyword"))+"^");
	             bWriter.write(sb.toString());
	             rs=1;
	         }        
	         bWriter .close();
	         out.close();
	         return rs;
	     }

%>