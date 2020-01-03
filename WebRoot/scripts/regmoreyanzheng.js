function formyanzheng(name)
{
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
	if(name=="zd_mem_name"){
		if(obj.value.length==0) {
		   mess = "请输入您的姓名";
		 }else if(strlen(obj.value)<4 || strlen(obj.value)>20 ) {
		   mess = "长度应为4-20位";
		 }else if (obj.value.indexOf(" ")!=-1){
		   mess = "姓名里不能含有空格";
		 }else if (!isSsnhanzi(obj.value)){
		   mess = "不能包含特殊字符";
		 }
	}else if(name=="zd_comp_email"){
		if(obj.value.length==0) {
		   mess = "请输入您的邮箱";
		 }else if (obj.value.indexOf(" ")!=-1){
		   mess = "邮箱里不能含有空格";
		 }else if (!isEmail(obj.value)){
		   mess = "邮箱格式不正确，请重新输入";
		 }
	}else if(name=="zd_comp_phone"){
		if(obj.value.length==0) {
		   mess = "请输入您的联系电话";
		 }else if (obj.value.indexOf(" ")!=-1){
		   mess = "手机号码里不能含有空格";
		 }else if (!isPhone(obj.value)){
		   mess = "请按格式 '18605451292' 如实填写 ";
		 }
	}else if(name=="zd_province"){
		if(obj.value.length==0||obj.value.indexOf("选择省份")!=-1) {
		   mess = "请选择省份城市";
		 }
		 formyanzheng("zd_city");
	}else if(name=="zd_city"){
		if(obj.value.length==0||obj.value.indexOf("选择城市")!=-1) {
		   mess = "请选择所在地";
		 }
	}else if(name=="zd_comp_address"){
		if(obj.value.length==0){
			mess = "请输入详细地址";
		}
	}else if(name=="zd_comp_name"){
		if(obj.value.length==0) {
		   mess = "输入您的公司名称";
		 }
	}else if(name=="zd_main_product"){
		if(obj.value.length==0) {
		   mess = "请输入主营产品";
		 }
	}else if(name=="zd_comp_mobile_phone"){
		if(obj.value.length==0) {
		   mess = "请输入您的办公电话";
		 }else if (obj.value.indexOf(" ")!=-1){
		   mess = "办公电话里不能含有空格";
		 }else if ((!isTel(obj.value)) && (!isPhone(obj.value))){
		   mess = "请按格式 '0535-6792736' 如实填写 ";
		 }
	}else if(name=="zdCompModeValue"){
		//判断主营业务是否选择
		var modObj= document.getElementsByName("zd_comp_mode");
		var comModeVal = document.getElementById("zdCompModeValue");
		var zdCompModeValue = ",";
		for(var i=0;i<modObj.length;i++){
			if(modObj[i].checked){
				zdCompModeValue += modObj[i].value+",";
			}
		}
		if(zdCompModeValue==","){
			zdCompModeValue="";
			mess = "请选择主营行业";
		}
		comModeVal.value = zdCompModeValue;
	}else if(name=="zd_comp_intro"){
		if(obj.value.length==0){
			mess = "请输入公司介绍";
		}else if(obj.value.length<10){
			mess = "公司介绍不能少于10个字";
		}
		
	}
	if(mess==""){
	    objDui.style.display='block';
		objCuo.style.display = 'none';
		objCuoInfo.style.display = 'none';
		return true;
	}else{
		objCuo.style.display = 'block';
		objCuoInfo.style.display = 'block';
		objCuoInfo.innerText = mess;
		objDui.style.display='none';
		parent.scrollTo(0,$(obj).offset().top);
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
	var re = /^([a-zA-Z0-9._-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,4}){1,2})$/;
	if(re.test(ssn)){return true;}else{return false;}
}

function isPhone (ssn){
	//var re=/(^[0-9]{3,4}\-[0-9]{7,8}\-[0-9]{3,4}$)|(^[0-9]{3,4}\-[0-9]{7,8}$)|(^[0-9]{7,8}\-[0-9]{3,4}$)|(^[0-9]{7,15}$)/;
	//var re=/^(13[0-9]|15[0-9]|18[0-9]|14[5|7])\d{8}$/;
	var re=/^(17[0-9]|13[0-9]|15[0-9]|18[0-9]|14[5|7])\d{8}$/;
	if(re.test(ssn)){return true;}else{return false;}
}

function isTel (ssn){
	var re=/(([0\+]\d{2,3}-)?(0\d{2,3})-?)(\d{7,8})(-?(\d{3,}))?/;
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


function submityz(){
	var isOK = 0;
	if(!formyanzheng('zd_mem_name')){
		isOK = isOK+1;
	}
	if(!formyanzheng('zd_comp_phone')){
		isOK = isOK+1;
	}
	if(!formyanzheng('zd_city')){
		isOK = isOK+1;
	}
	if(!formyanzheng('zd_comp_email')){
		isOK = isOK+1;
	}
	if(!formyanzheng('zd_comp_name')){
		isOK = isOK+1;
	}
	if(!formyanzheng('zd_comp_mobile_phone')){
		isOK = isOK+1;
	}
	if(!formyanzheng('zdCompModeValue')){
		isOK = isOK+1;
	}
	if(!formyanzheng('zd_comp_intro')){
		isOK = isOK+1;
	}
	if(isOK>0){
		return false;	
	}
	var comModeVal = document.getElementById("zdCompModeValue");
	document.theform.flagvalue.value="1";
	document.theform.submit();
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
	//隐藏其他信息
	objDui.style.display = 'none';
	objCuo.style.display = 'none';
	objCuoInfo.style.display = 'none';
	//显示提示信息
	objShow.style.display = 'block';	
}