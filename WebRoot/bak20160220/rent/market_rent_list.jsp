<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"%>
<%@ include
	file="/manage/config.jsp"%>
<%
    PoolManager pool3 = new PoolManager(3);
    Connection conn = null;
	try {
		conn = pool3.getConnection();	//SQL查询	
		
		Pagination pagination = new Pagination();
		//设置每页显示条数
		pagination.setCountOfPage(20);  
	    String mem_no ="";
		HashMap memberInfo = new HashMap();
		
		String rent_webmaster_region  ="";  //负责的省份
		String mem_flag="";
		if(session.getAttribute("memberInfo")!=null){   
			memberInfo = (HashMap) session.getAttribute("memberInfo");
			mem_no     = String.valueOf(memberInfo.get("mem_no"));  //登陆账号
			//rent_webmaster_region = String.valueOf(memberInfo.get("rent_webmaster_region"));  //负责的省份
			mem_flag   = String.valueOf(memberInfo.get("mem_flag"));  //权限
		}	
		
		String find_category = Common.getFormatStr(request.getParameter("find_category"));   //设备类别
		String find_class    = Common.getFormatStr(request.getParameter("find_class"));      //出租or求租
		String find_title    = Common.getFormatStr(request.getParameter("find_title"));      //查询关键字
		String find_isstore  = Common.getFormatStr(request.getParameter("find_isstore"));    //查询是否为店铺


		String searchStr = " where 1 = 1 ";
			
		if(!find_title.equals("")){
			searchStr+=" and title like '%"+find_title+"%' ";
		}
		if(!find_category.equals("")){
			searchStr+=" and category='"+find_category+"' ";
		}
		if(!find_class.equals("")){
			searchStr+=" and class='"+find_class+"' ";
		}
		ResultSet rsRentMaster = DataManager.executeQuery(conn," select province from rent_master where mem_no = '"+mem_no+"' ");
		while(rsRentMaster.next()){
			rent_webmaster_region += "'"+rsRentMaster.getString("province")+"',";
		}
		if(rent_webmaster_region.length()>0){
			rent_webmaster_region = rent_webmaster_region.substring(0,rent_webmaster_region.length()-1);
		}
		if(mem_flag.equals("1009")){   //租赁站长
	    if(!rent_webmaster_region.equals("")){ 
	    	 searchStr +=" and province in ( "+rent_webmaster_region+" ) "; 
		}
		}	
		String query="select title, province,city, class, pubdate, pubdays, id , is_pub from rent_info "+searchStr+" order by id desc ";
	    
		String comp_name ="",classId="",pubdays="";
		
	    ResultSet rs = pagination.getQueryResult(query, request,conn);
	    String bar = pagination.pagesPrint(10);  //读取分页提
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/tablestyle.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<script src="../scripts/citys.js"  type="text/javascript"></script>
		<script>
		  function viewList(objstr){	
		     self.location="market_rent_view.jsp?myvalue="+encodeURIComponent(objstr);
		  }
		</script>
<script>
 //==类型===
	var mainclass=new Array();
	var subclass=new Array();
	
	mainclass[0]=new Array("1","挖掘机械");
	mainclass[1]=new Array("2","铲土运输机械");
	mainclass[2]=new Array("3","工程起重机械");
	mainclass[3]=new Array("4","机动工业车辆");
	mainclass[4]=new Array("5","压实机械");
	mainclass[5]=new Array("6","路面机械");
	mainclass[6]=new Array("7","混凝土机械");
	mainclass[7]=new Array("8","桩工机械");
	mainclass[8]=new Array("9","钢筋加工机械");
	mainclass[9]=new Array("10","凿岩机械");
	mainclass[10]=new Array("11","市政机械");
	mainclass[11]=new Array("12","装修机械");
	mainclass[12]=new Array("13","动力机械");
	mainclass[13]=new Array("14","桥梁、铁路设备");
	mainclass[14]=new Array("15","养护机械");
	mainclass[15]=new Array("16","养护材料");
	 
	subclass[0]=new Array("1","14","挖掘机");
	subclass[1]=new Array("1","15","掘进机");
	subclass[2]=new Array("1","16","挖掘装载机");
	subclass[124]=new Array("1","137","挖沟机");
	subclass[125]=new Array("1","138","定向钻机");
	subclass[3]=new Array("1","129","其他");
	 
	subclass[4]=new Array("2","17","推土机");
	subclass[5]=new Array("2","18","装载机");
	subclass[6]=new Array("2","19","铲运机");
	subclass[7]=new Array("2","20","自卸车");
	subclass[8]=new Array("2","21","除荆\根机");
	subclass[9]=new Array("2","128","其他");
	 
	subclass[10]=new Array("3","22","汽车吊");
	subclass[11]=new Array("3","23","塔吊");
	subclass[12]=new Array("3","24","缆索吊");
	subclass[13]=new Array("3","25","桅杆吊");
	subclass[14]=new Array("3","26","抓斗吊");
	subclass[15]=new Array("3","27","高空作业车");
	subclass[16]=new Array("3","28","顶升机");
	subclass[17]=new Array("3","29","升降机");
	subclass[18]=new Array("3","30","龙门吊");
	subclass[19]=new Array("3","32","行走吊");
	subclass[20]=new Array("3","127","其他");
	 
	subclass[21]=new Array("4","31","叉车");
	subclass[22]=new Array("4","33","搬运车");
	subclass[23]=new Array("4","34","拖车");
	subclass[24]=new Array("4","126","其他");
	 
	subclass[25]=new Array("5","35","夯实机");
	subclass[126]=new Array("5","139","压路机");
	subclass[26]=new Array("5","36","其他");
	 
	subclass[27]=new Array("6","37","平地机");
	subclass[28]=new Array("6","38","压路机");
	subclass[29]=new Array("6","39","扫雪机");
	subclass[30]=new Array("6","40","撒沙机");
	subclass[31]=new Array("6","41","摊铺机");
	subclass[32]=new Array("6","42","路面养护车");
	subclass[33]=new Array("6","43","路面拉、凿毛机");
	subclass[34]=new Array("6","44","路面铣刨机");
	subclass[35]=new Array("6","45","边沟成型机");
	subclass[36]=new Array("6","46","路缘成型机");
	subclass[37]=new Array("6","47","路面抹光机");
	subclass[38]=new Array("6","48","路面脱水机");
	subclass[39]=new Array("6","49","路面切缝机");
	subclass[40]=new Array("6","50","路面划线机");
	subclass[41]=new Array("6","51","液态沥青运输车");
	subclass[42]=new Array("6","52","联合碎石设备");
	subclass[43]=new Array("6","53","石屑撒布机");
	subclass[44]=new Array("6","54","沥青搅拌设备");
	subclass[45]=new Array("6","55","沥青路面再生设备");
	subclass[46]=new Array("6","56","沥青路面加热设备");
	subclass[47]=new Array("6","57","沥青泵");
	subclass[48]=new Array("6","58","沥青混合料再生设备");
	subclass[49]=new Array("6","59","沥青稀浆封层机");
	subclass[50]=new Array("6","60","沥青洒布机");
	subclass[51]=new Array("6","61","沥青熔化加热设备");
	subclass[52]=new Array("6","62","沥青乳化设备");
	subclass[53]=new Array("6","63","沥青混凝土摊铺设备");
	subclass[54]=new Array("6","64","沥青混凝土搅拌设备");
	subclass[55]=new Array("6","65","稳定土拌和设备");
	subclass[56]=new Array("6","66","道路翻松机");
	subclass[57]=new Array("6","125","其他");
	 
	subclass[58]=new Array("7","67","搅拌机");
	subclass[59]=new Array("7","68","配料站");
	subclass[60]=new Array("7","69","水泥运输车");
	subclass[61]=new Array("7","70","布料杆");
	subclass[62]=new Array("7","71","混凝土振动机");
	subclass[63]=new Array("7","72","浇注机");
	subclass[64]=new Array("7","73","喷射机");
	subclass[65]=new Array("7","74","混凝土泵");
	subclass[66]=new Array("7","75","搅拌运输车");
	subclass[67]=new Array("7","76","搅拌楼");
	subclass[68]=new Array("7","124","其他");
	 
	subclass[69]=new Array("8","77","打桩锤");
	subclass[70]=new Array("8","78","液压锤");
	subclass[71]=new Array("8","79","打桩机");
	subclass[72]=new Array("8","80","钻孔机");
	subclass[73]=new Array("8","81","压桩机");
	subclass[74]=new Array("8","82","沉拔桩架");
	subclass[75]=new Array("8","83","打桩架");
	subclass[76]=new Array("8","86","孔道成型机");
	subclass[127]=new Array("8","140","软地基加固");
	subclass[77]=new Array("8","123","其他");
	
	 
	subclass[78]=new Array("9","84","灌浆泵");
	subclass[79]=new Array("9","85","穿束机");
	subclass[80]=new Array("9","87","镦头器");
	subclass[81]=new Array("9","88","张拉机");
	subclass[82]=new Array("9","89","预应力液压泵");
	subclass[83]=new Array("9","90","螺纹成型机");
	subclass[84]=new Array("9","91","套筒挤压机");
	subclass[85]=new Array("9","92","焊机");
	subclass[86]=new Array("9","93","网成型机");
	subclass[87]=new Array("9","94","弯箍机");
	subclass[88]=new Array("9","95","弯曲机");
	subclass[89]=new Array("9","96","切断机");
	subclass[90]=new Array("9","97","轧扭机");
	subclass[91]=new Array("9","98","冷拔机");
	subclass[92]=new Array("9","122","其他");
	 
	subclass[93]=new Array("10","99","凿岩机");
	subclass[94]=new Array("10","100","气动马达");
	subclass[95]=new Array("10","101","气动工具");
	subclass[96]=new Array("10","102","破碎机");
	subclass[97]=new Array("10","103","辅助设备");
	subclass[98]=new Array("10","104","钻机");
	subclass[99]=new Array("10","121","其他");
	

	 
	subclass[100]=new Array("11","105","清扫机");
	subclass[101]=new Array("11","106","除雪机");
	subclass[102]=new Array("11","107","排障车");
	subclass[103]=new Array("11","108","洒水车");
	subclass[104]=new Array("11","120","其他");
	 
	subclass[105]=new Array("12","109","喷涂机");
	subclass[106]=new Array("12","110","灰浆机");
	subclass[107]=new Array("12","111","喷刷机");
	subclass[108]=new Array("12","112","装修机具");
	subclass[109]=new Array("12","113","擦窗机");
	subclass[110]=new Array("12","114","高处作业吊蓝");
	subclass[111]=new Array("12","115","地面修整机械");
	subclass[112]=new Array("12","116","油漆制备及喷涂机械");
	subclass[113]=new Array("12","117","其他");
	 
	subclass[114]=new Array("13","118","发电机(组)");
	subclass[115]=new Array("13","119","发动机");
	subclass[116]=new Array("13","122","空压机");
	 
	subclass[117]=new Array("14","130","卸渣机");
	subclass[128]=new Array("14","141","捣固机");
	subclass[129]=new Array("14","142","架桥机");
	subclass[130]=new Array("14","143","运梁车");
	subclass[131]=new Array("14","144","铺轨机");
	subclass[132]=new Array("14","145","轨道车");
	subclass[133]=new Array("14","146","其他");
	 
	subclass[118]=new Array("16","131","养护材料");
	 
	subclass[119]=new Array("15","132","养路王");
	subclass[120]=new Array("15","133","开槽机");
	subclass[121]=new Array("15","134","铣刨机");
	subclass[122]=new Array("15","135","划线车");
	subclass[123]=new Array("15","136","切缝机");
	  
	function clear(o)
	{
	l=o.length;
	for (i = 0; i< l; i++)
	 {o.options[1]=null;}
	}
	 
	function listclass(Obj_,Idx_)
	{
	 clear(Obj_);
	 if(Idx_!="")
	 {
	 for(var j=0;j<subclass.length;j++)
	  {
	   if(mainclass[Idx_][0]==subclass[j][0]&subclass[j][2]!="")
	   {
		Obj_.add(new Option(subclass[j][2],j));
	   }
	  }
	 } 
	}
</script>
</head>
<body>
<form action="" method="get" name="theform" id="theform">
  <div class="loginlist_right">
    <div class="loginlist_right2"><span class="mainyh">市场租赁信息</span></div>
    <div class="loginlist_right1"> <span class="title_bar"></span>
      <div align="center">
        <table border="0" cellspacing="1" width="100%" class="P92"  >
          <tr>
            <td width="11%" align="center"> 
			性质：&nbsp;&nbsp;</td>
			<td width="13%">
			<select size="1" name="find_class">
                <option value="">所有</option>
                <option value="1" <%=find_class.equals("1")?"Selected":""%>>出租</option>
                <option value="0" <%=find_class.equals("0")?"Selected":""%>>求租</option>
            </select>
			</td>
			<td width="10%">
			设备类型:&nbsp;&nbsp;			</td>
			<td width="40%">
			<select name="find_category" bgcolor="#FFFFFF"id="find_category" onclick="javascript:listclass(document.theform.find_subcategory,this.value)">
                <option value="">--请选择类别--</option>
				<script language=javascript>
					for(var i=0;i<mainclass.length;i++){
					  document.write ("<option value="+i+">"+mainclass[i][1]+"</option>");
					 }
				</script>
              </select>
              <select name="find_subcategory" id="find_subcategory">
                <option value="">--下属类别--</option>
              </select>
		    </td>
			  <td width="26%">
			   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				  <input type="submit" name="Submit" value="" style="width:52px;height:19px;border:none;background:url(../images/bottom06.gif) left top no-repeat;cursor: pointer;" />
				  &nbsp;&nbsp;&nbsp;&nbsp;
				  <input type="button" name="Submit2" value="" style="width:52px;height:19px;border:none;background:url(../images/bottom07.gif) left top no-repeat;cursor: pointer;" onclick="javascript:clearForm()" />
			</td>
          </tr>        
        </table>
      </div>
      <table width="100%" border="0" class="list">
        <tr>
          <th width="6%" >ID</th>
          <th width="21%" >标题</th>
          <th width="10%" >性质</th>
          <th width="10%" >发布日期</th>
          <th width="8%" >有效期</th>
          <th width="8%" >操作</th>          
        </tr>
		<%
		int k=0;
		String is_pub = "";
		while (rs!=null && rs.next()){
	  	  k=k+1;			
		  classId= Common.getFormatInt(rs.getString("class"));				
		  is_pub = Common.getFormatStr(rs.getString("is_pub"));
		%>
        <tr >
          <td><%=k%></td>
          <td><a href="http://www.21-rent.com/rent/rentdetail_for_<%=rs.getString("id") %>.htm" target="_blank"><%=Common.getFormatStandard(rs.getString("title"),3,15)%></a></td>
          <td><%=classId.equals("1")?"出租":"求租"%></td>
          <td><%=Common.getFormatDate("yyyy-MM-dd",rs.getDate("pubdate"))%></td>
          <td>
				<%
				pubdays=Common.getFormatStr(rs.getString("pubdays"));
				if(pubdays.equals("10000")){
				   out.print("长期");
				}else{
				   out.print(pubdays+"天");
				}
				%>
		  </td>
		  <td>
		  <%
          	if(is_pub.equals("1")){
          		%><a style="color:green;" href="javascript:void(0);" onclick="setXianShi('<%=rs.getString("id") %>',0);">取消发布</a><%
          	}else{
          		%><a style="color:green;" href="javascript:void(0);" onclick="setXianShi('<%=rs.getString("id") %>',1);">发布</a><%
          	}
          	%>
          	<a style="color:gray;" href="javascript:otherDeleteData('opt_delete.jsp','<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES("rent_info")%>');">删除</a>
		  </td>   
        </tr>
		<%
			}
		%>
      </table>
      <table width="100%" border="0" class="list">
        <tr>
          <td align="left"><%=bar%></td>
        </tr>
      </table>
    </div>
  </div>
</form>
</body>
</html>
<script type="text/javascript">
function setXianShi(id,is_pub){
	$.post("action.jsp",{
		flag : 'xianshi_rent_info',
		id : id ,
		is_pub : is_pub
	},function(){
		window.location.reload();
	});
}
</script>
<%
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		pool3.freeConnection(conn);
	}
%>
