// JavaScript Document
function nTabs(thisObj,Num,iframeFilename,siteid){


/*if(thisObj.className == "active")return;
var tabObj = thisObj.parentNode.id;
var tabList = document.getElementById(tabObj).getElementsByTagName("li");
for(i=0; i <tabList.length; i++)
{
if (i == Num)
{
   thisObj.className = "active"; 
      document.getElementById(tabObj+"_Content"+i).style.display = "block";
}else{
   tabList[i].className = "normal"; 
   document.getElementById(tabObj+"_Content"+i).style.display = "none";
}
} 
*/
document.theform.css_name.value=Num;
document.theform.iframeFilename.value=iframeFilename;
document.theform.siteid.value=siteid;
document.theform.submit();
}