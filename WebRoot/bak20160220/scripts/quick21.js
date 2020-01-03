// JavaScript Document
var lastScrollY=0;
 function heartBeat(){ 
  diffY=document.documentElement.scrollTop; 
  percent=0.1*(diffY-lastScrollY); 
  if(percent>0)percent=Math.ceil(percent); 
  else percent=Math.floor(percent); 
  //document.getElementById("sorollDiv1").style.top=parseInt(document.getElementById("sorollDiv1").style.top)+percent+"px";
  if(document.getElementById("floater2")!=null){
	document.getElementById("floater2").style.top=parseInt(document.getElementById("floater2").style.top)+percent+"px";  
  }
  lastScrollY=lastScrollY+percent; 
 }
 window.setInterval("heartBeat()",1);

