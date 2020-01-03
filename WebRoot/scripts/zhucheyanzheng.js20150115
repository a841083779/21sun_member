// JavaScript Document

    //CharMode函数       
    //测试某个字符是属于哪一类.       
    function CharMode(iN)      
    {       
        if (iN>=48 && iN <=57) //数字       
        return 1;       
        if (iN>=65 && iN <=90) //大写字母       
        return 2;       
        if (iN>=97 && iN <=122) //小写       
        return 4;       
        else       
        return 8; //特殊字符       
    }       
          
    //bitTotal函数       
    //计算出当前密码当中一共有多少种模式       
    function bitTotal(num)      
    {       
        modes=0;       
        for (i=0;i<4;i++)      
        {       
            if (num & 1) modes++;       
            num>>=1;       
        }       
        return modes;       
    }       
          
    //checkStrong函数       
    //返回密码的强度级别       
          
    function checkStrong(sPW)      
    {       
        if (sPW.length<=4)       
        return 0; //密码太短       
        Modes=0;       
        for (i=0;i<sPW.length;i++)      
        {       
            //测试每一个字符的类别并统计一共有多少种模式.       
            Modes|=CharMode(sPW.charCodeAt(i));       
        }       
        return bitTotal(Modes);       
    }       
          
    //pwStrength函数       
    //当用户放开键盘或密码输入框失去焦点时,根据不同的级别显示不同的颜色       
          
    function pwStrength(pwd)      
    {       
       // O_color="#eeeeee";       
        //L_color="#FF0000";       
       // M_color="#FF9900";       
       // H_color="#33CC00";   
		
		O_color="";       
        L_color="show";       
        M_color="show";       
        H_color="show";   
        if (pwd==null||pwd=="")      
        {       
            Lcolor=Mcolor=Hcolor=O_color;       
        }       
        else     
        {       
            S_level=checkStrong(pwd);       
            switch(S_level)      
            {       
                case 0:       
                Lcolor=Mcolor=Hcolor=O_color;       
                case 1:       
                Lcolor=L_color;       
                Mcolor=Hcolor=O_color;       
                break;       
                case 2:       
                Lcolor=Mcolor=M_color;       
                Hcolor=O_color;       
                break;       
                default:       
                Lcolor=Mcolor=Hcolor=H_color;       
            }       
        }       
        //document.getElementById("strength_L").style.background=Lcolor;       
        //document.getElementById("strength_M").style.background=Mcolor;       
        //document.getElementById("strength_H").style.background=Hcolor;  
		document.getElementById("strength_L").className=Lcolor;       
        document.getElementById("strength_M").className=Mcolor;       
        document.getElementById("strength_H").className=Hcolor;
		//同步密码框
		pwd_syc(pwd);
        return;       
    }  
	
function __showBox(index) 
{ //alert(document.getElementById("__box"+""+index).style.display);

	var selectBox= document.getElementById("imgstring"); 
	//alert(selectBox.value);
	var boxName="__box"+index; 
	var boxObj = document.getElementById(boxName); 	
	if(boxObj.style.display=="none") 
	{
		boxObj.style.display=""; 
		selectBox.value=selectBox.value+""+index; 
	} 
	else 
	{ 
		boxObj.style.display="none"; 
		__remove(selectBox.value,index); 
	}
	formyanzheng('imgstring');	 
}
function __remove(selectString,c) 
{ 
var temp= selectString.replace(c,'');
		var selectBox= document.getElementById("imgstring"); 
		selectBox.value=temp; 
} 


function formyanzheng(name){
	var obj = document.getElementById(name);
	var objDui = document.getElementById(name+"_dui");
	var objCuo = document.getElementById(name+"_cuo");
	var objCuoInfo = document.getElementById(name+"_cuo_info");	
	var objShow =document.getElementById(name+'_show_info'); 
	//移除提示
	if(typeof(objShow) != "undefined" && objShow != null)
	{
		objShow.style.display='none';
	}
	var mess = "";
	if(name=="mem_no"){
		if(obj.value.length==0) {
		   mess = "请输入用户名称";
		 }else if(obj.value.length<4 || obj.value.length>18 ) {
		   mess = "长度应为4-18位";
		 }
		// else if (!isSsnString(obj.value)){
		//   mess = "不能包含特殊字符或不要以标点符号结束";
		// }
		 else{
		   checkUsername(obj.value,obj,objDui,objCuo,objCuoInfo);	 
		 }
	}else if(name=="passw"){
		if(obj.value.length==0) {
		   mess = "请输入密码";
		 }else if(obj.value.length<4 || obj.value.length>18 ) {
		   mess = "长度应为4-18位";
		 }else if (obj.value.indexOf(" ")!=-1){
		   mess = "密码里不能含有空格";
		 }
	}else if(name=="passw2"){
		if(obj.value.length==0) {
		   mess = "请再次输入密码";
		 }else if(obj.value !=  document.getElementById("passw").value) {
		   mess = "两次输入的密码不相同";
		 }
	}else if(name=="mem_name"){
		if(obj.value.length==0) {
		   mess = "请输入您的姓名";
		 }else if(strlen(obj.value)<4 || strlen(obj.value)>20 ) {
		   mess = "长度应为4-20位";
		 }else if (obj.value.indexOf(" ")!=-1){
		   mess = "姓名里不能含有空格";
		 }else if (!isSsnhanzi(obj.value)){
		   mess = "不能包含特殊字符";
		 }
	}else if(name=="per_email"){
		if(obj.value.length==0) {
		   mess = "请输入您的邮箱";
		 }else if (obj.value.indexOf(" ")!=-1){
		   mess = "邮箱里不能含有空格";
		 }else if (!isEmail(obj.value)){
		   mess = "邮箱格式不正确，请重新输入";
		 }
	}else if(name=="per_phone"){
		if(obj.value.length==0) {
		   mess = "请输入您的手机号码";
		 }else if (obj.value.indexOf(" ")!=-1){
		   mess = "手机号码里不能含有空格";
		 }else if (!isPhone(obj.value)){
		   mess = "手机号码格式不正确，请重新输入";
		 }
	}else if(name=="zd_province"){
		if(obj.value.length==0||obj.value.indexOf("选择省份")!=-1) {
		   mess = "请选择省份城市";
		 }
		 formyanzheng("zd_city");
	}else if(name=="zd_city"){
		if(obj.value.length==0||obj.value.indexOf("选择城市")!=-1) {
		   mess = "请选择省份城市";
		 }
	}else if(name=="imgstring"){
		if(obj.value.length==0) {
		   mess = "验证码不正确";
		 }else{
		   checkYanzheng(obj.value,obj,objDui,objCuo,objCuoInfo);	 
		 }
	}else if(name=="is_accept"){
		if(!isAccpet()) {
		   mess = "请选中［我接受中国工程机械商贸网的服务条款］";
		 }
	}else if(name=="rand"){
		if(obj.value.length==0) {
		   mess = "请输入验证码";
		 }else if(obj.value.length!=4) {
		   mess = "长度应为4位";
		 }else if (!isSsnString(obj.value)){
		   mess = "不能包含特殊字符";
		 }else{
		   checkRandom(obj.value,obj,objDui,objCuo,objCuoInfo);	 
		 }
	}else if(name=="purpose"){
		obj = document.getElementsByName("purpose");
		var checked = "";
		for(i=0;i<obj.length;i++){
			if(obj[i].checked){
				checked = "1";  
			}  
		}
		if(checked!="1"){
			mess = "请选择注册目的";
		}
	}
	if(mess==""){
	    objDui.style.display='block';
		objCuo.style.display = 'none';
		objCuoInfo.style.display = 'none';
		//alert(obj);
		if(name!="is_accept"){
			obj.className='ri';
		}
		return true;
	}else{
		objCuo.style.display = 'block';
		objCuoInfo.style.display = 'block';
		objCuoInfo.innerText = mess;
		objDui.style.display='none';
		if(name!="is_accept"){
			obj.className='ri';
		}
		return false;
	}

}

//密码找回验证
function findformyanzheng(name){
	var obj = document.getElementById(name);
	var objDui = document.getElementById(name+"_dui");
	var objCuo = document.getElementById(name+"_cuo");
	var objCuoInfo = document.getElementById(name+"_cuo_info");	
	var objShow =document.getElementById(name+'_show_info'); 
	//移除提示
	if(typeof(objShow) != "undefined" && objShow != null)
	{
		objShow.style.display='none';
	}
	var mess = "";
	if(name=="mem_no"){
		if(obj.value.length==0) {
		   mess = "请输入用户名称";
		 }else if(obj.value.length<4 || obj.value.length>18 ) {
		   mess = "长度应为4-18位";
		 }else if (!isSsnString(obj.value)){
		   mess = "不能包含特殊字符或不要以标点符号结束";
		 }
	}else if(name=="per_email"){
		if(obj.value.length==0) {
		   mess = "请输入您的邮箱";
		 }else if (obj.value.indexOf(" ")!=-1){
		   mess = "邮箱里不能含有空格";
		 }else if (!isEmail(obj.value)){
		   mess = "邮箱格式不正确，请重新输入";
		 }
	}else if(name=="rand"){
		if(obj.value.length==0) {
		   mess = "请输入验证码";
		 }else if(obj.value.length!=4) {
		   mess = "长度应为4位";
		 }else if (!isSsnString(obj.value)){
		   mess = "不能包含特殊字符";
		 }else{
		   checkRandom(obj.value,obj,objDui,objCuo,objCuoInfo);	 
		 }
	}
	if(mess==""){
	    objDui.style.display='inline-block';
		objCuo.style.display = 'none';
		objCuoInfo.style.display = 'none';
		//alert(obj);
		if(name!="is_accept"){
			obj.className='ri';
		}
		return true;
	}else{
		objCuo.style.display = 'inline-block';
		objCuoInfo.style.display = 'inline-block';
		objCuoInfo.innerText = mess;
		objDui.style.display='none';
		if(name!="is_accept"){
			obj.className='ri';
		}
		return false;
	}

}

//验证用户名中是否有空格
function isWhiteWpace (s){
	  var whitespace = " \t\n\r";
	  var i;
	  for (i = 0; i < s.length; i++){  
	   var c = s.charAt(i);
	   if (whitespace.indexOf(c) >= 0) {return true;}
	 }
	return false;
}

//验证用户名是否合法
function isSsnString (ssn){
	var re=/^[0-9a-z][\w-]*[0-9a-z]$/i;
	if(re.test(ssn)){return true;}else{return false;}
}

function isSsnhanzi (ssn){
	var re=/^(\w|[\u4E00-\u9FA5])*$/;
	if(re.test(ssn)){return true;}else{return false;}
}

function isEmail (ssn){
	var re = /^([a-zA-Z0-9._-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;
	if(re.test(ssn)){return true;}else{return false;}
}

function isPhone (ssn){
	//var re=/(^[0-9]{3,4}\-[0-9]{7,8}\-[0-9]{3,4}$)|(^[0-9]{3,4}\-[0-9]{7,8}$)|(^[0-9]{7,8}\-[0-9]{3,4}$)|(^[0-9]{7,15}$)/;
	var re=/^(13[0-9]|15[0-9]|18[0-9]|14[5|7])\d{8}$/;
	if(re.test(ssn)){return true;}else{return false;}
}

function strlen(strTemp) {   
   var i,sum; 
    sum=0; 
    for(i=0;i <strTemp.length;i++){ 
        if ((strTemp.charCodeAt(i)>=0) && (strTemp.charCodeAt(i) <=255)){ 
            sum=sum+1; 
        }else{ 
            sum=sum+2; 
        } 
    } 
    return sum; 
}

function checkUsername(mem_no,obj,objDui,objCuo,objCuoInfo){
	var isOK=false;
	var rand=Math.round((Math.random()*10000));
	$.ajax({
		type:"get",
		url:"/ajax.jsp?flag=1&mem_no="+mem_no+"&rand="+rand,
		data:"",
		success:function(mess){
			if(mess=="succ"){
			   isOK=true;
			   mess="用户名已经存在";
			   objCuo.style.display = 'block';
		       objCuoInfo.style.display = 'block';
		       objCuoInfo.innerText = mess;
		       objDui.style.display='none';
		       obj.className='ri';			   
			   return false;
			}else{
			   objDui.style.display='block';
			   objCuo.style.display = 'none';
			   objCuoInfo.style.display = 'none';
			   obj.className='ri';
			   return true;
			}
		}
		//error:function(){}
	});
	
}

//验证码
function checkRandom(random,obj,objDui,objCuo,objCuoInfo){
	var isOK=false;
	var rand=Math.round((Math.random()*10000));
	$.ajax({
		type:"get",
		url:"/ajax.jsp?flag=3&random="+random+"&rand="+rand,
		data:"",
		success:function(mess){
			if(mess=="error"){
			   isOK=true;
			   mess="验证码有误";
			   objCuo.style.display = 'block';
		       objCuoInfo.style.display = 'block';
		       objCuoInfo.innerText = mess;
		       objDui.style.display='none';
		       obj.className='ri';			   
			   return false;
			}else if(mess=="succ"){
			   objDui.style.display='block';
			   objCuo.style.display = 'none';
			   objCuoInfo.style.display = 'none';
			   obj.className='ri';
			   			     
			   jQuery("#getRandTxt").hide() ;
			   clearInterval(TimerID);
			   jQuery('#code-get').attr('disabled','disabled');
			   return true;
			}
		}
		//error:function(){}
	});
	
}

function checkYanzheng(yanzhengStr,obj,objDui,objCuo,objCuoInfo){
	var isOK=false;
	//alert(yanzhengStr);
	$.ajax({
		type:"get",
		url:"/ajax.jsp?flag=2&yanzhengStr="+yanzhengStr,
		data:"",
		success:function(mess){
			if(mess=="error"){
			   isOK=true;
			   mess="验证码不正确";
			   objCuo.style.display = 'block';
		       objCuoInfo.style.display = 'block';
		       objCuoInfo.innerText = mess;
		       objDui.style.display='none';
		       obj.className='ri';			   
			   return false;
			}else{
			   objDui.style.display='block';
			   objCuo.style.display = 'none';
			   objCuoInfo.style.display = 'none';
			   obj.className='ri';
			   return true;
			}
		}
		//error:function(){}
	});
	
}

//是否接受条款
function isAccpet(){
var obj=parent.document.getElementsByName("is_accept"); 
for(var i=0;i<obj.length;i++) 
{ 
	if(obj[i].checked==true){
		return true;	
	} else{
		return false;	
	}
}
}

function regYanzheng(){
	var isOK = 0;
	if(!formyanzheng('mem_no')){
		isOK = isOK+1;
	}
	if(!formyanzheng('rand')){
		isOK = isOK+1;
	}
	if(!formyanzheng('passw')){
		isOK = isOK+1;
	}
	if(!formyanzheng('passw2')){
		isOK = isOK+1;
	}
//	if(!formyanzheng('mem_name')){
//		isOK = isOK+1;
//	}
	if(!formyanzheng('per_email')){
		isOK = isOK+1;
	}
	if(!formyanzheng('per_phone')){
		isOK = isOK+1;
	}
	if(!formyanzheng('purpose')){
		isOK = isOK+1;
	}
//	if(!formyanzheng('imgstring')){
//		isOK = isOK+1;
//	}
//	if(!formyanzheng('zd_city')){
//		isOK = isOK+1;
//	}
//	if(!formyanzheng('is_accept')){
//		isOK = isOK+1;
//	}
	if(isOK>0){
		window.location.hash = "regs";
		return false;	
	}
}
function findYanzheng(){
	var isOK = 0;
	if(!findformyanzheng('mem_no')){
		isOK = isOK+1;
	}
	if(!findformyanzheng('per_email')){
		isOK = isOK+1;
	}
	if(isOK>0){
		window.location.hash = "find";
		return false;	
	}
}

function regYanzheng_jiang(){
	var isOK = 0;
	if(!formyanzheng('mem_no')){
		isOK = isOK+1;
	}
	if(!formyanzheng('passw')){
		isOK = isOK+1;
	}
	if(!formyanzheng('passw2')){
		isOK = isOK+1;
	}

	if(!formyanzheng('per_phone')){
		isOK = isOK+1;
	}
	if(!formyanzheng('per_email')){
		isOK = isOK+1;
	}
	if(isOK>0){
		window.location.hash = "regs";
		return false;	
	}
}

//
function isSpecialChar(myInput){ 
	var iptData=document.getElementById(myInput); 
	if(iptData.value.match(/[^\x00-\xff]/ig)){ 
		iptData.value=iptData.value.replace(/[^\x00-\xff]/ig,""); 
	} 
}

//firfox中innerText
function isIE(){ //ie?
  if (window.navigator.userAgent.toLowerCase().indexOf("msie")>=1)
  	return true;
  else
  	return false;
}

if(!isIE()){ //firefox innerText define
  HTMLElement.prototype.__defineGetter__( "innerText",
  function(){
  	var anyString = "";
  	var childS = this.childNodes;
  	for(var i=0; i <childS.length; i++) {
  		if(childS[i].nodeType==1)
 	 		anyString += childS[i].tagName=="BR" ? '\n' : childS[i].innerText;
  		else if(childS[i].nodeType==3)
  			anyString += childS[i].nodeValue;
  	}
  	return anyString;
  }
  );
  HTMLElement.prototype.__defineSetter__( "innerText",
  function(sText){
  	this.textContent=sText;
  }
  );
}
//显示提示信息
function showText(name)
{	var obj = document.getElementById(name);
	var objDui = document.getElementById(name+"_dui");
	var objCuo = document.getElementById(name+"_cuo");
	var objCuoInfo = document.getElementById(name+"_cuo_info");	
	var objShow =document.getElementById(name+'_show_info'); 
	//css
	obj.className = "regi";
	//隐藏其他信息
	objDui.style.display = 'none';
	objCuo.style.display = 'none';
	objCuoInfo.style.display = 'none';
	//显示提示信息
	objShow.style.display = 'block';	
}