/********
	1.进入
	2.退出
	******/
	function sendState(flag)
	{    var	ms=Date.parse(new Date());
	    //alert(ms);
	    var toUser=document.getElementById("toUser").value;
		var toUserFullName=document.getElementById("toUserFullName").value;
		if(toUser!=null&&toUser!=""){
		var fromUser=document.getElementById("fromUser").value;
		var fromFullName=document.getElementById("fromFullName").value;
		var sendFlag=3;
		if(fromUser==null||fromUser=="")
		{
		fromUser=ms;
		}
		//alert(ms);
		if(fromFullName==null||fromFullName==""){
		fromFullName=fromUser;
		}
		var chatMsg="";
	    if(flag==null){
			chatMsg="异常退出";
			}
		if(flag==1){
		   chatMsg="准备与您对话";
		  }
		if(flag==2){
			 chatMsg="退出对话状态";
		}
		createXMLHttpRequest();
        var url = "/chat.do";
		XMLHttpReq.open("POST", url, true);
		XMLHttpReq.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		XMLHttpReq.onreadystatechange = processResponse;//指定响应函数
		//alert("chatMsg="+chatMsg+"&toUser="+toUser+"&sendFlag="+sendFlag+"&toUserFullName="+toUserFullName+"&fromUser="+fromUser+"&fromFullName="+fromFullName);
		XMLHttpReq.send("chatMsg="+chatMsg+"&toUser="+toUser+"&sendFlag="+sendFlag+"&toUserFullName="+toUserFullName+"&fromUser="+fromUser+"&fromFullName="+fromFullName); // 发送请求
			}
	}
//张恒振20090729
/********弹出聊天窗口*******/
var tid=null;
<!--
function $(d){return document.getElementById(d);}
function gs(d){var t=$(d);if (t){return t.style;}else{return null;}}
function gs2(d,a){
if (d.currentStyle){ 
var curVal=d.currentStyle[a]
}else{ 
var curVal=document.defaultView.getComputedStyle(d, null)[a]
} 
return curVal;
}
function ChatHidden(){gs("ChatBody").display = "none";}
function ChatShow(){gs("ChatBody").display = "";}
function ChatClose(){
if(confirm("您确实关闭窗口么，您将无法看到别人给您发的信息"))
gs("main").display = "none";
sendState(2);
if(tid!=null){
window.clearTimeout(tid);
}
}
if(document.getElementById){
(
function(){
if (window.opera){ document.write("<input type='hidden' id='Q' value=' '>"); }

var n = 500;
var dragok = false;
var y,x,d,dy,dx;

function move(e)
{
if (!e) e = window.event;
if (dragok){
d.style.left = dx + e.clientX - x + "px";
d.style.top= dy + e.clientY - y + "px";
return false;
}
}
function down(e){
if (!e) e = window.event;
var temp = (typeof e.target != "undefined")?e.target:e.srcElement;
if (temp.tagName != "HTML"|"BODY" && temp.className != "dragclass"){
temp = (typeof temp.parentNode != "undefined")?temp.parentNode:temp.parentElement;
}
if('TR'==temp.tagName){
temp = (typeof temp.parentNode != "undefined")?temp.parentNode:temp.parentElement;
temp = (typeof temp.parentNode != "undefined")?temp.parentNode:temp.parentElement;
temp = (typeof temp.parentNode != "undefined")?temp.parentNode:temp.parentElement;
}
if (temp.className == "dragclass"){
if (window.opera){ document.getElementById("Q").focus(); }
dragok = true;
temp.style.zIndex = n++;
d = temp;
dx = parseInt(gs2(temp,"left"))|0;
dy = parseInt(gs2(temp,"top"))|0;
x = e.clientX;
y = e.clientY;
document.onmousemove = move;
return false;
}
}
function up(){
dragok = false;
document.onmousemove = null;
}
document.onmousedown = down;
document.onmouseup = up;
}
)();
}
/**************************************************/
function play(){
document.all.sound.src = "/sound/msg.wav";
}

function trim(str){  //删除左右两端的空格   
     return str.replace(/(^\s*)|(\s*$)/g, "");   
    }   
function ltrim(str){  //删除左边的空格   
     return str.replace(/(^\s*)/g,"");   
    }   
function rtrim(str){  //删除右边的空格   
     return str.replace(/(\s*$)/g,"");   
    }   
function selectUser(usr,fullName){
	try{
	    if(usr!=null&&usr!=""){ 
		document.getElementById("toUser").value=usr;
		document.getElementById("toUserFullName").value=fullName;
		}
		}catch(e){
		}
	 }
	var XMLHttpReq;
	//创建XMLHttpRequest对象       
    function createXMLHttpRequest()
	{
		if(window.XMLHttpRequest)
		{ //Mozilla 浏览器
			XMLHttpReq = new XMLHttpRequest();
		}
		else if (window.ActiveXObject)
		{
			// IE浏览器
			try
			{
				XMLHttpReq = new ActiveXObject("Msxml2.XMLHTTP");
			}
			catch (e)
			{
				try
				{
					XMLHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
				}
				catch (e)
				{
				}
			}
		}
	}
	//发送请求函数
	function sendRequest()
	{
	    var toUser=document.getElementById("toUser").value;
		var toUserFullName=document.getElementById("toUserFullName").value;
		var fromUser=document.getElementById("fromUser").value;
		var fromFullName=document.getElementById("fromFullName").value;
		var	ms=Date.parse(new Date());
		var sendFlag=2;
		if(toUser==null||toUser=="")
		{
		 alert("请点击要对话的人")
		 return false;
		}
		if(fromUser==null||fromUser=="")
		{
		 fromUser=ms;
		}
		if(fromFullName==null||fromFullName==""){
		fromFullName=fromUser;
		}
		var chatMsg = document.getElementById("chatMsg").value;
		var view_chat_message=document.getElementById("chatArea").innerHTML;
		if(chatMsg!=null&&trim(chatMsg)!=""){
		document.getElementById("mes").innerHTML = "";
		view_chat_message=view_chat_message+"我对"+toUserFullName+"说："+chatMsg+"<br>";
		document.getElementById("chatArea").innerHTML=view_chat_message;
		document.getElementById("chatArea").scrollTop=document.getElementById("chatArea").scrollHeight ;//对 texarea和div都好用
		}else{
		alert("不允许发空信息");
		return false;
		} 
		createXMLHttpRequest();
        var url = "/chat.do";
		XMLHttpReq.open("POST", url, true);
		XMLHttpReq.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		XMLHttpReq.onreadystatechange = processResponse;//指定响应函数
		document.getElementById("chatMsg").value="";
		//alert("chatMsg="+chatMsg+"&toUser="+toUser+"&sendFlag="+sendFlag+"&toUserFullName="+toUserFullName+"&fromUser="+fromUser+"&fromFullName="+fromFullName);
		XMLHttpReq.send("chatMsg="+chatMsg+"&toUser="+toUser+"&sendFlag="+sendFlag+"&toUserFullName="+toUserFullName+"&fromUser="+fromUser+"&fromFullName="+fromFullName); // 发送请求
	}
	function sendEmptyRequest()
	{
	    var toUser=document.getElementById("toUser").value;
		var toUserFullName=document.getElementById("toUserFullName").value;
		var fromUser=document.getElementById("fromUser").value;
		var fromFullName=document.getElementById("fromFullName").value;
		var sendFlag=2;
		//店铺对游客
		createXMLHttpRequest();
        var url = "/chat.do";
		XMLHttpReq.open("POST", url, true);
		XMLHttpReq.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		XMLHttpReq.onreadystatechange = processResponse;//指定响应函数
		XMLHttpReq.send("toUser="+toUser+"&sendFlag="+sendFlag+"&toUserFullName="+toUserFullName+"&fromUser="+fromUser+"&fromFullName="+fromFullName); // 发送请求
		//alert(1);
		tid=setTimeout("sendEmptyRequest()" , 1000);
	}
// 处理返回信息函数
    function processResponse()
	{
		 var view_chat_message="";
		 //alert(view_chat_message);
		if (XMLHttpReq.readyState == 4)
		{
			//alert(XMLHttpReq.status);
			// 判断对象状态
			if (XMLHttpReq.status == 200)
			{
				// 信息已经成功返回，开始处理信息
				document.getElementById("status").innerHTML = "<font color='#006600'>网络状态：正常</font>";
				if(XMLHttpReq.responseText!=null&&(trim(XMLHttpReq.responseText))!=""){
			     //alert(XMLHttpReq.responseText.length);
				 //有信息来声音提示
				 document.getElementById("mes").innerHTML = "<font color='#FF3300'>新信息</font>";
				 // play();firefox有问题
				 // alert()
				 //alert(XMLHttpReq.responseText);
				 //alert(document.getElementById("chatArea").innerHTML)
				  if(document.getElementById("chatArea").innerHTML!=null&&document.getElementById("chatArea").innerHTML!=""){
				  view_chat_message=document.getElementById("chatArea").innerHTML;
				  }
				  //alert(view_chat_message);
				  view_chat_message=view_chat_message+XMLHttpReq.responseText;
				  //alert(document.getElementById("chatArea"));
		          document.getElementById("chatArea").innerHTML=view_chat_message;
				  //document.getElementById("bd").focus();
		        //texarea是.value
				  document.getElementById("chatArea").scrollTop=document.getElementById("chatArea").scrollHeight ;//对 texarea和div都好用   

				}
            }
			else
			{
				//页面不正常
               // window.alert("您所请求的页面有异常。");
			    document.getElementById("status").innerHTML = "<font color='#FF3300'>网络状态：网络不通,请稍后再发</font>";
				document.getElementById("mes").innerHTML = "";
            }
        }
    }
	function enterHandler(event)
	{
		var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
		if (keyCode == 13) {
			sendRequest();
		} 
	}