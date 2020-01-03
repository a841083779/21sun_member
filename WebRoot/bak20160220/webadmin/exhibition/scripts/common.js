//删除确认
function delConfirm(){
	if (window.confirm("您确定要删除吗？")){
		return true;
	}
	return false;
}

String.prototype.replaceAll  = function(s1,s2){    
return this.replace(new RegExp(s1,"gm"),s2);    
}  


//复选框全部选择或者全部不选
function CheckAll(){
	var obj2=document.getElementsByName("checkall");
	var bl=true;
	for(var i=0;i<obj2.length;i++){ 
		bl=obj2[i].checked;
	}
	var obj=document.getElementsByName("checkdel");
	for(var i=0;i<obj.length;i++){ 
		if(bl){
			obj[i].checked=true; 	
		}else{
			obj[i].checked=false; 
		}
	}
}

//提交前验证复选框是否选择了一个
function chkget(){
	if(!confirm("您确认要删除选择的数据吗？")){
		return false;
	}
	var isCheck=false;
	var obj=document.getElementsByName("checkdel"); 
	for(var i=0;i<obj.length;i++) { 
		if(obj[i].checked==true){ 
			isCheck=true; 
			break; 
		} 
	}
	if(!isCheck){
		alert("您没有选择任何数据,请先选择需要删除的数据后,再次提交！");
	}else{
		theform.submit();
	}
}

//跳转到其它地方
function linkTO(linkStr){
	window.location.href=linkStr;	
}

//关闭窗口
function closeWindow(){
	window.close();
	opener.document.location.reload();
	//parent.parent.GB_hide();		
}

//清空表单的值
function clearForm(){
  //----表单内对象清空------
       for(var j=0;j<document.theform.elements.length;j++)
       {
         var curObj=document.theform.elements[j];
         if(curObj.type=='text'||curObj.type == "password"){
           curObj.value ="";
         }
       if(curObj.type=='select-one'){
          curObj.selectedIndex="0";
         }
       } 
}

//居中弹出窗口
//u-url n-窗口名称 w-宽度 h-高度
function openWin(u,n, w, h) { 
   var l = (screen.width - w) / 2; 
   var t = (screen.height - h) / 2; 
   var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
   s += ', toolbar=no, scrollbars=yes, menubar=no, location=no, resizable=no'; 
   window.open(u, n, s); 
} 

function openWin2(u,n, w, h) { 
   var l = 5; 
   var t = 5 / 2; 
   var s = 'width=' + (screen.width-50) + ', height=' + (screen.height-70) + ', top=' + t + ', left=' + l; 
   s += ', toolbar=no, scrollbars=yes, menubar=no, location=no, resizable=no'; 
   window.open(u, n, s); 
} 

//列表页面的，当鼠标移动到每条数据的时候，tr的底色变颜色-采用protype
function fmove(evt){  
    var e = Event.findElement(evt, 'TD');		
	if(e.tagName=="TD"){  
      e.parentNode.style.backgroundColor="#CCCCCC";  
    }  
}  
function fout(evt){  
	var e = Event.findElement(evt, 'TD');
    if(e.tagName=="TD"){  
      e.parentNode.style.backgroundColor="white";  
    }  
}  

//====删除行
//====my_flag 0:表示加序号,1:表示不加序号第一个是顺序号
function delete_row_new(obj_table,rowIndex,my_flag)
{
	if(rowIndex==0){
		obj_table.deleteRow();
	}else{
		obj_table.deleteRow(rowIndex);
	}
    var colnums=obj_table.rows[0].cells.length;
    var myid=0; 
    for(var i=2;i<obj_table.rows.length;i++){
		if(my_flag=="0"){
			//obj_table.rows[i].cells[0].innerHTML=i-1;//改变每行数据的第一个文本框设为用于表现序号的
		}else if(my_flag=="1"){
			//try{obj_table.rows[i].cells[0].firstChild.value=i-1;}catch(e){}//改变每行数据的第一个文本框设为用于表现序号的
		}
	//obj_table.rows[i].cells[0].children(0).value=i-1;
	 //=======��������id====
		 var tr_input=obj_table.rows[i].getElementsByTagName("input");
		 for(var j=0;j<tr_input.length;j++){
			if(tr_input[j].name=='zd_id'){
				myid=tr_input[j].value;
				break;
			}
		 }
		 if(myid=="0"){
			obj_table.rows[i].cells[colnums-1].innerHTML="<a href='javascript:delete_row_new("+obj_table.id+","+i+","+my_flag+")'>删除</a>";
		 }
    }
}

//====增加行
//====my_flag 0:表示加序号,1:表示不加序号第一个是顺序号
function insert_row_new(obj_table,sj_obj_table,my_flag){
	var trs = obj_table.getElementsByTagName("tr");
	//var sTr =trs[1];	
  	var tr =obj_table.firstChild.cloneNode(true);
	tr.style.display="";
    // curtr.cells[0].innerHTML="<input type='text' name='xh' size=3 value='"+curRowIndex+"' readonly>";
   	obj_table.appendChild(tr);	
   	if(my_flag=="0"){
   		//tr.cells[0].innerHTML=trs.length-2;//改变每行数据的第一个文本框设为用于表现序号的
	}
    var inputs=tr.getElementsByTagName("input");

    for(var i=0;i<inputs.length;i++){
		if(my_flag=="1"){
		 //inputs[0].value=trs.length-2;//改变每行数据的第一个文本框设为用于表现序号的
		}
		if(inputs[i].name=="zd_id"){
			inputs[i].value="0";
		}
    }
	//var colnums=obj_table.cells.length/obj_table.rows.length;
	var colnums=tr.cells.length;
	tr.cells[colnums-1].innerHTML="<a href='javascript:delete_row_new("+sj_obj_table.id+","+tr.rowIndex+","+my_flag+");'>删除</a>";
}

//验证字符是否为数字
function checknumber(str){
	if(str==null || str=="")return true;
	var Letters = "1234567890";
	var i;
	var c;
	for( i = 0; i < str.length; i ++ ){
		c = str.charAt( i );
		if (Letters.indexOf( c ) ==-1){
			return true;
		}
	}
	return false;
} 
//为checkbox类型的赋值
function setCheckbox(name,value){
var obj=document.getElementsByName(name); 
for(var i=0;i<obj.length;i++) 
{ 
	if(obj[i].value==value) 
	{ 
		obj[i].checked=true; 
		break; 
	} 
}

function isDateTime(str){
var a = str.match(/^(\d{0,4})-(\d{0,2})-(\d{0,2}) (\d{0,2}):(\d{0,2}):(\d{0,2})$/);
if (a == null) return false;
if ( a[2]>=13 || a[3]>=32 || a[4]>=24 || a[5]>=60 || a[6]>=60) return false;
return true;
} 

}

//ajax删除
function deleteData(id,tablename){
	if(confirm("您确认要删除吗？")){
	var url="/webadmin/exhibition/opt_delete.jsp?mypy="+encodeURIComponent(tablename)+"&myvalue="+encodeURIComponent(id);
		$.ajax({
			   url: url,
			   type: 'POST',
			   dataType: 'html',
			   timeout: 1000,
		       error: function(){
                 alert('执行错误!');
               },
              success: function(html){document.location.reload();
               //$(".flexme1").flexReload();
			   //alert('删除成功!');
				//document.location.reload();
              }
           });
  }
}

function success() {
	//alert("OK！删除成功！");
	document.location.reload();
}
//翻页提交
function pageSumit(pagecount) {
	theform.offset.value=pagecount;
	theform.submit();
}

function mouseMove(obj){
	obj.style.backgroundColor ='#D2E1FF';
}
function mouseOut(obj){
	obj.style.backgroundColor ='#ffffff';
}
//======lTrim()
function lTrim(str) 
 {  
 if(str!=null){
	 if (str.charAt(0) == " ") 
	   {
		 str = str.slice(1);
		 str = lTrim(str);
	   } 
 }else{
	str=""; 
 }
  return str; 
 }
  //====rTrim=======
function rTrim(str) 
{	
	if(str!=null){
		var iLength; 
	  
		iLength = str.length; 
	  
		if(str.charAt(iLength - 1)==" ") 
		{str = str.slice(0, iLength - 1);
		 str = rTrim(str);
		} 
	}else{
		str="";	
	}
	return str; 
}
//=====trim()========
function trim(str) 
{return lTrim(rTrim(str)); 
}
//只能输入数字的方法
function onlyNum() 
{if (!(((event.keyCode>=48)&&(event.keyCode<=57))||(event.keyCode==13))) 
 { 
  event.keyCode=0; 
 } 
 //alert(event.keyCode);
}
//name,url,width 850,heigth 680
function openDivWin(name,url,width,heigth){
 var w =width; 
 var h =heigth; 
 lhgdialog.opendlg(name,url, w, h, true, true,'windiv'); 
}
//====得到checkbox选中的值
//0:表示店铺经营范围,
function Getcheckvalue(form,flag)  
 {var s="";
  for (var i=0;i<form.elements.length;i++) 
   { var e = form.elements[i];
     
	 if ((e.name != 'allcheck')&&(e.type=="checkbox")&&flag==0)
        {if(e.checked&&e.name.substring(0,4)=="area")
		   {if(s=="")
		    s=e.value;
			else
			s=s+","+e.value;
		   }
		}
		else if ((e.name != 'allcheck')&&(e.type=="checkbox")&&flag==1)
        {if(e.checked&&e.name.substring(0,15)=="productCategory")
		   {if(s=="")
		    s=e.value;
			else
			s=s+","+e.value;
		   }
		}
		else if ((e.name != 'allcheck')&&(e.type=="checkbox")&&flag==2)
        {if(e.checked&&e.name.substring(0,5)=="check")
		   {if(s=="")
		    s=e.value;
			else
			s=s+","+e.value;
		   }
		}
	 else if ((e.name != 'allcheck')&&(e.type=="checkbox")&&flag==3)
        {if(e.checked&&e.name.substring(0,11)=="chk_factory")
		   {if(s=="")
		    s=e.value;
			else
			s=s+","+e.value;
		   }
		}
	 else if ((e.name != 'allcheck')&&(e.type=="checkbox")&&flag==4)
        {if(e.checked&&e.name.substring(0,11)=="chk_factory")
		   {if(s=="")
		    s=document.getElementById("lbl"+e.value).innerHTML;
			else
			s=s+","+document.getElementById("lbl"+e.value).innerHTML;
		   }
		}
	 else if ((e.name != 'allcheck')&&(e.type=="checkbox")&&flag==5)
        {if(e.checked&&e.name.substring(0,10)=="catalog_no")
		   {if(s=="")
		    s=e.value;
			else
			s=s+","+e.value;
		   }
		}
}
  //alert(s);
 return s;  
 }
 
//====给checkbox赋值======
function Setcheckvalue(form,str,flag)  
 {var arr_str=str.split(",");
   if(flag==0)
  {for(var k=0;k<arr_str.length;k++)
  eval(form+".area"+arr_str[k]).checked=true;
  }
  else if(flag==1)
  {for(var k=0;k<arr_str.length;k++)
  eval(form+".productCategory"+arr_str[k]).checked=true;
  }
  else if(flag==3)
  {for(var k=0;k<arr_str.length;k++)
  eval(form+".chk_factory"+arr_str[k]).checked=true;
  }
  else if(flag==5)
  {for(var k=0;k<arr_str.length;k++)
  eval(form+".catalog_no"+arr_str[k]).checked=true;
  }
}
//====判断数字===
//调用方式：onkeydown = "DigitInput(this,event);"
function DigitInput(el,ev) {
//8：退格键、46：delete、37-40： 方向键
//48-57：小键盘区的数字、96-105：主键盘区的数字
//110、190：小键盘区和主键盘区的小数
//189、109：小键盘区和主键盘区的负号

    var event = ev || window.event;                             //IE、FF下获取事件对象
    var currentKey = event.charCode||event.keyCode;             //IE、FF下获取键盘码
    //小数点处理
    if (currentKey == 110 || currentKey == 190) {
        if (el.value.indexOf(".")>=0) 
            if (window.event)                       //IE
                event.returnValue=false;                 //e.returnValue = false;效果相同.
            else                                    //Firefox
                event.preventDefault();

    } else
        //负号处理
       if (currentKey == 189 || currentKey == 109) {
            if (getPosition(el)>0 ||el.value.indexOf("-")>=0)
                if (window.event)                       //IE
                    event.returnValue=false;                 //e.returnValue = false;效果相同.
                else                                    //Firefox
                    event.preventDefault();
        } else
       if (currentKey!=8 && currentKey != 46 && (currentKey<37 || currentKey>40) && (currentKey<48 || currentKey>57) && (currentKey<96 || currentKey>105))
            if (window.event)                       //IE
                event.returnValue=false;                 //e.returnValue = false;效果相同.
            else                                    //Firefox
                event.preventDefault();
}
/**
  * 获取光标所在的字符位置
  * @param obj 要处理的控件, 支持文本域和输入框
  * @author hotleave
  */
function getPosition(obj){
    var result = 0;
    if(obj.selectionStart){//非IE浏览器
        result = obj.selectionStart
    }else{//IE
        var rng;
        if(obj.tagName == "TEXTAREA"){ //如果是文本域
            rng = event.srcElement.createTextRange();
            rng.moveToPoint(event.x,event.y);
        }else{                         //输入框
            rng = document.selection.createRange();
        }
        rng.moveStart("character",-event.srcElement.value.length);
        result = rng.text.length;
    }
    return result;
}

function returnRadio(name){
	
	var obj=document.getElementsByName(name); 
	
	for(var i=0;i<obj.length;i++) 
	{ 
		if(obj[i].checked==true) 
		{ 
			return true;
		} 
	}
	return false;

}