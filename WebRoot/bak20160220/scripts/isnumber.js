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
            if (getPosition(el)>0 || el.value.indexOf("-")>=0)
                if (window.event)                       //IE
                    event.returnValue=false;                 //e.returnValue = false;效果相同.
                else                                    //Firefox
                    event.preventDefault();
        } else
        if (currentKey!=8 &&currentKey!=9 && currentKey != 46 && (currentKey<37 || currentKey>40) && (currentKey<48 || currentKey>57) && (currentKey<96 || currentKey>105))
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
    if(obj.selectionStart){ //非IE浏览器
        result = obj.selectionStart
    }else{                  //IE
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
