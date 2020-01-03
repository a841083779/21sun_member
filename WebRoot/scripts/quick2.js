// JavaScript Document
 self.onError=null;
 currentX = currentY = 0; 
 whichIt = null; 
 lastScrollX = 0; lastScrollY = 0;
 NS = (document.layers) ? 1 : 0;
 IE = (document.all) ? 1: 0;
<!-- STALKER CODE -->
 function heartBeat() {
  if(IE) { 
   diffY = document.body.scrollTop; 
   diffX = 0; 
  }
  if(NS) { diffY = self.pageYOffset; diffX = self.pageXOffset; }
  if(diffY != lastScrollY) {
   percent = .1 * (diffY - lastScrollY);
   if(percent > 0) percent = Math.ceil(percent);
   else percent = Math.floor(percent);
   if(IE) {
	document.all.floater2.style.pixelTop += percent;
   }
   if(NS) {
	document.floater2.top += percent;
   }
   lastScrollY = lastScrollY + percent;
  }
  if(diffX != lastScrollX) {
   percent = .1 * (diffX - lastScrollX);
   if(percent > 0) percent = Math.ceil(percent);
   else percent = Math.floor(percent);
   if(IE) {
	document.all.floater2.style.pixelLeft += percent;
   }
   if(NS) {
	document.floater2.top += percent;
   }
   lastScrollY = lastScrollY + percent;
  } 
 } 
 if(NS || IE) action = window.setInterval("heartBeat()",50);

  /**
	Name    :   topMenuPopupLocation
	param   :   String htmlUrl : 扑诀芒 Url沥焊
	Explain :   扑诀
*/
function topMenuPopupLocation(htmlUrl, left, top, height, width, scrollbars){
	browsing_window = window.open(htmlUrl, "idchkwin","left=" + left + ",top=" + top + ",height=" + height + ",width=" + width + ",menubar=no,directories=no,resizable=no,status=no,scrollbars=" + scrollbars);
	browsing_window.focus();
	return;
}

function topMenuPopupLocation1(htmlUrl, height, width, scrollbars){
	browsing_window = window.open(htmlUrl, "idchkwin", "left=0,top=0,height=" + height + ",width=" + width + ",menubar=no,directories=no,resizable=no,status=no,scrollbars=" + scrollbars);
	browsing_window.focus();
	return;
}

function topMenuPopupLocation2(htmlUrl){
	browsing_window = window.open(htmlUrl, "idchkwin");
	browsing_window.focus();
	return;
}

