<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.sql.Connection,com.jerehnet.util.file.*,org.json.*,org.apache.commons.fileupload.disk.DiskFileItemFactory,org.apache.commons.fileupload.*,java.util.*,com.jerehnet.util.dbutil.*,org.apache.commons.fileupload.servlet.ServletFileUpload,com.jerehnet.util.common.*,java.io.*" pageEncoding="UTF-8"%><%
	String folderType = CommonString.getFormatPara(request.getParameter("t"));
	String state = "SUCCESS";
	Long maxSize = 100000000l;
	String uploadSource = "http://resource.21-sun.com";
	response.setContentType("application/json; charset=UTF-8");
	String watermark  = CommonString.getFormatPara(request.getParameter("watermark"));
	// 文件保存目录路径
	String savePath = request.getSession().getServletContext().getRealPath("/")+ "uploadfiles/";
	try{
		if (!ServletFileUpload.isMultipartContent(request)) {
			Common.println("请选择文件");
			state = "ERROR";
		}
		// 检查目录
		File uploadDir = new File(savePath);
		if (!uploadDir.isDirectory()) {
			Common.println("上传目录不存在。");
			return;
		}
		// 检查目录写权限
		if (!uploadDir.canWrite()) {
			Common.println("上传目录没有写权限。");
			state = "ERROR";
		}
		FileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setHeaderEncoding("UTF-8");
		List items = new ArrayList(0);
		try {
			items = upload.parseRequest(request);
		} catch (FileUploadException e) {
			e.printStackTrace();
		}
		Iterator itr = items.iterator();
		FileItem item = null;
		File uploadedFile = null;
		String newFileName = null;
		while (itr.hasNext()) {
			item = (FileItem) itr.next();
			String fileName = item.getName();
			@SuppressWarnings("unused")
			long fileSize = item.getSize();
			if (!item.isFormField()) {
				// 检查文件大小
				if (item.getSize() > maxSize) {
					Common.println("上传文件大小超过限制。"); 
					state = "ERROR";
				}
				String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
				String fileExts = "jpg,gif,png,bmp" ;
				if(fileExts.indexOf(fileExt)!=-1){
				newFileName = CommonDate.getToday("yyyyMMddHHmmss") + "_" + new Random().nextInt(1000) + "." + fileExt;
				uploadedFile = new File(savePath, newFileName);
				item.write(uploadedFile);
				if(!"".equals(watermark)&&"false".equals(watermark)){
					newFileName = FileUtils.doHttpClientUpload(uploadSource+"/"+folderType+".upload?watermark="+watermark,uploadedFile);
				}else{
					newFileName = FileUtils.doHttpClientUpload(uploadSource+"/"+folderType+".upload",uploadedFile);
				}
				JSONObject obj = new JSONObject();
				obj.put("url", uploadSource + newFileName);
				obj.put("title","");
				obj.put("state",state);
				out.println(obj.toString());
				try{
					uploadedFile.delete();
				}catch(Exception e){
				}
			}else{
				JSONObject obj = new JSONObject();
				obj.put("state","3");
				out.println(obj.toString());
				try{
					uploadedFile.delete();
				}catch(Exception e){
				}
			}
			}
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>
