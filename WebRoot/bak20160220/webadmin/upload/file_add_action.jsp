<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*,com.jerehnet.cmbol.action.*"
%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ include file ="../manage/config.jsp"%>
<%
	if(pool==null){
		pool = new PoolManager();
	} 
	Connection conn = pool.getConnection();


	String tag=Common.getFormatInt(request.getParameter("tag"));
	
	
	String fieldname = request.getParameter("fieldname");
	if(fieldname==null){
		fieldname="";
	}
	String flag = Common.getFormatInt(request.getParameter("flag"));

    String uploadPath = application.getRealPath("/uploadfiles");
	String subPath="system";

	//====创建目录====
	File myFilePath = new File(uploadPath+"/"+subPath);
	if(!myFilePath.exists()) 
	myFilePath.mkdir();
	//==================
	
	String newFileName = "";
    // 临时文件目录
    File tempPathFile = new File("d:\\temp\\buffer\\");
    if (!tempPathFile.exists()) {
       tempPathFile.mkdirs();
    }
    try {
       // Create a factory for disk-based file items
       DiskFileItemFactory factory = new DiskFileItemFactory();
       // Set factory constraints
       factory.setSizeThreshold(4096); // 设置缓冲区大小，这里是4kb
       factory.setRepository(tempPathFile);//设置缓冲区目录
       // Create a new file upload handler
       ServletFileUpload upload = new ServletFileUpload(factory);
       //Set overall request size constraint
       //upload.setSizeMax(4194304); // 设置最大文件尺寸，这里是4MB
       List items = upload.parseRequest(request);//得到所有的文件
       Iterator i = items.iterator();
       while (i.hasNext()) {
           FileItem fi = (FileItem) i.next();
           // 忽略简单form字段而不是上传域的文件域
           if (fi == null || fi.isFormField()) {
    			continue;
   			}
           String fileName = fi.getName();
           //获取文件大小
           NumberFormat nformat=NumberFormat.getInstance();
		   nformat.setMaximumFractionDigits(2);
		   nformat.setMinimumFractionDigits(2);
		   String sizeStr=nformat.format(fi.getSize()/1024.0/1024.0);
		   
           if (fileName != null) {
	       File fullFile = new File(fi.getName()); 
       	   //得到去除路径的文件名
		   String t_name = fileName.substring(fileName.lastIndexOf("\\") + 1);
		   //得到文件的扩展名(无扩展名时将得到全名)
		   String t_ext = t_name.substring(t_name.lastIndexOf(".") + 1);
	       //旧文件名
	       String oldFileName = t_name.substring(0,t_name.indexOf("."));

	      
		   //获得新文件名
	       newFileName=Common.generateDateRandom()+"_0."+t_ext;
	       File savedFile = new File(uploadPath+"/"+subPath, newFileName);
       	   fi.write(savedFile);
       	  
       	  
       	}
      }
       out.print("上传成功！");
%>
<%
//区分：除了1之外为编辑器插入
if(!newFileName.equals("")){
%>
	<script>
		alert("上传成功！");
		opener.document.getElementById("<%=fieldname%>").value="/uploadfiles/<%=subPath%>/<%=newFileName%>";
		window.close();
	</script>
<%}%>
<html>
<head>
<title>File upload</title>
</head>
<body>
</body>
</html>
<%
	} catch (Exception e) {
       e.printStackTrace();
    }finally{
    	pool.freeConnection(conn);
    }
%>