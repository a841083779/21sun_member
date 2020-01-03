jQuery(function(){
	jQuery(".guide").hover(function(){
		jQuery(this).toggleClass("ghover");
	},function(){
		jQuery(this).removeClass("ghover");
	});
})
function showImgDelay(imgObj,imgSrc,maxErrorNum){  
    //showSpan.innerHTML += "--" + maxErrorNum;  
    if(maxErrorNum>0){  
        imgObj.onerror=function(){  
            showImgDelay(imgObj,imgSrc,maxErrorNum-1);  
        };  
        setTimeout(function(){  
            imgObj.src=imgSrc;  
        },500);  
    }else{  
        imgObj.onerror=null;  
        imgObj.src="/images/nopic.gif";  
    }  
} 