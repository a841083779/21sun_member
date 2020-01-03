<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"%>
<%
//1:表示调用107上的SQLserver数据库,2:表示调用115上的db2数据库,3:表示调用的租赁数据库,4:表示调用二手的数据
	PoolManager pool1 = new PoolManager(4);
	DataManager dataManager1=new DataManager();
	Connection conn1=pool1.getConnection();
	//System.out.print(conn1);
			
String sql1="select id,add_user,add_date,add_ip,agent_no,sort,model,machine_no,picture,manufacture_date,working_hours,agent_name,prices,source,published_date,is_recommend,view_count,location,is_published,is_sales from doosan_used_machine where 1=1 and is_published=1 and is_sales in ('0') order by id";
ResultSet rs=DataManager.executeQuery(conn1, sql1);

ResultSet rs1 = null;

HashMap<String , String> locationMap = new HashMap<String,String>();
locationMap.put("ah","安徽");
locationMap.put("fj","福建");
locationMap.put("gs","甘肃");
locationMap.put("gx_001","广西");
locationMap.put("hain","海南");
locationMap.put("hlj","黑龙江");
locationMap.put("hn","河南");
locationMap.put("jl","吉林");
locationMap.put("ln","辽宁");
locationMap.put("nmg","内蒙古");
locationMap.put("nx","宁夏");
locationMap.put("sc","四川");
locationMap.put("sd","山东");
locationMap.put("shx","陕西");

HashMap<String,String> pictureMap = new HashMap<String,String>();
String picture_temp="";

String catalog_no="";
String sql="";
String temp_img="",temp_img_x="";
String temp_location="";
String temp_id="";
int k=0;
while(rs.next())
{
 k=k+1;
if(!Common.getFormatStr(rs.getString("picture")).equals("")){
   temp_img = Common.getFormatStr(rs.getString("picture"));
   if(!temp_img.equals("") && temp_img.indexOf("used_machine/")!=-1){
       temp_img=temp_img.replaceAll("used_machine/","/import_pic/doosan/");
	   if(temp_img.indexOf(".")!=-1){
		  temp_img_x = temp_img.substring(0,temp_img.lastIndexOf("."))+"_x"+temp_img.substring(temp_img.lastIndexOf("."));
	   }
   }
}
//System.out.println("temp_img="+temp_img);
temp_location = Common.getFormatStr(rs.getString("location"));
if(!temp_location.equals("")){
  temp_location = locationMap.get(temp_location);
}
if(pictureMap!=null)pictureMap.clear();
temp_id = Common.getFormatStr(rs.getString("id"));
if(!temp_id.equals("")){
  rs1=DataManager.executeQuery(conn1, "select picture,order_no from doosan_used_machine_picture where 1=1 and products_id='"+temp_id+"' order by id ");
 while(rs1.next()){
    picture_temp =  Common.getFormatStr(rs1.getString("picture"));
	if(!picture_temp.equals("") && picture_temp.indexOf("used_machine/")!=-1){
        picture_temp=picture_temp.replaceAll("used_machine/","/import_pic/doosan/");
	}	
    pictureMap.put(Common.getFormatStr(rs1.getString("order_no")),picture_temp);
  }rs1.close();
}

sql="insert into equipment (mem_no,add_date,add_ip,category,model,car_no,img1,img1_1,factorydate,workingtime,mem_name,price,source,pubdate,is_recom,clicked,province,is_pub,is_sale,img2,img5,img10,img12,img13,img14,img22,img3,img4,img11,brand,brandname) values('"+Common.getFormatStr(rs.getString("agent_no"))+"','"+Common.getFormatDate("yyyy-MM-dd",rs.getDate("add_date"))+"','"+Common.getFormatStr(rs.getString("add_ip"))+"','1','"+Common.getFormatStr(rs.getString("model"))+"','"+Common.getFormatStr(rs.getString("machine_no"))+"','"+temp_img+"','"+temp_img_x+"','"+Common.getFormatDate("yyyy-MM-dd",rs.getDate("manufacture_date"))+"','"+Common.getFormatStr(rs.getString("working_hours"))+"','"+Common.getFormatStr(rs.getString("agent_name"))+"','"+Common.getFormatStr(rs.getString("prices"))+"','"+Common.getFormatStr(rs.getString("source"))+"','"+Common.getFormatDate("yyyy-MM-dd",rs.getDate("published_date"))+"','"+Common.getFormatStr(rs.getString("is_recommend"))+"','"+Common.getFormatStr(rs.getString("view_count"))+"','"+Common.getFormatStr(temp_location)+"','"+Common.getFormatStr(rs.getString("is_published"))+"','"+Common.getFormatStr(rs.getString("is_sales"))+"','"+Common.getFormatStr(pictureMap.get("1"))+"','"+Common.getFormatStr(pictureMap.get("2"))+"','"+Common.getFormatStr(pictureMap.get("3"))+"','"+Common.getFormatStr(pictureMap.get("4"))+"','"+Common.getFormatStr(pictureMap.get("5"))+"','"+Common.getFormatStr(pictureMap.get("6"))+"','"+Common.getFormatStr(pictureMap.get("7"))+"','"+Common.getFormatStr(pictureMap.get("8"))+"','"+Common.getFormatStr(pictureMap.get("9"))+"','"+Common.getFormatStr(pictureMap.get("10"))+"','192','斗山')";

dataManager1.dataOperation(conn1, sql);
sql="";
}rs.close();

System.out.println("k="+k);

pool1.freeConnection(conn1);
out.println("导入成功!");
%>