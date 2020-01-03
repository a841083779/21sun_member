/* ------------------------------------------------------------------------
	prettyCheckboxes
	
	Developped By: Stephane Caron (http://www.no-margin-for-errors.com)
	Inspired By: All the non user friendly custom checkboxes solutions ;)
	Version: 1.1
	
	Copyright: Feel free to redistribute the script/modify it, as
			   long as you leave my infos at the top.
------------------------------------------------------------------------- */
jQuery.fn.prettyCheckboxes=function(A){A=jQuery.extend({checkboxWidth:17,checkboxHeight:17,className:"prettyCheckbox",display:"list"},A);$(this).each(function(){$label=$('label[for="'+$(this).attr("id")+'"]');$label.prepend("<span class='holderWrap'><span class='holder'></span></span>");if($(this).is(":checked")){$label.addClass("checked")}$label.addClass(A.className).addClass($(this).attr("type")).addClass(A.display);$label.find("span.holderWrap").width(A.checkboxWidth).height(A.checkboxHeight);$label.find("span.holder").width(A.checkboxWidth);$(this).addClass("hiddenCheckbox");$label.bind("click",function(){$("input#"+$(this).attr("for")).triggerHandler("click");if($("input#"+$(this).attr("for")).is(":checkbox")){$(this).toggleClass("checked");$("input#"+$(this).attr("for")).checked=true;$(this).find("span.holder").css("top",0)}else{$toCheck=$("input#"+$(this).attr("for"));$('input[name="'+$toCheck.attr("name")+'"]').each(function(){$('label[for="'+$(this).attr("id")+'"]').removeClass("checked")});$(this).addClass("checked");$toCheck.checked=true}});$("input#"+$label.attr("for")).bind("keypress",function(B){if(B.keyCode==32){if($.browser.msie){$('label[for="'+$(this).attr("id")+'"]').toggleClass("checked")}else{$(this).trigger("click")}return false}})})};checkAllPrettyCheckboxes=function(B,A){if($(B).is(":checked")){$(A).find("input[type=checkbox]:not(:checked)").each(function(){$('label[for="'+$(this).attr("id")+'"]').trigger("click");if($.browser.msie){$(this).attr("checked","checked")}else{$(this).trigger("click")}})}else{$(A).find("input[type=checkbox]:checked").each(function(){$('label[for="'+$(this).attr("id")+'"]').trigger("click");if($.browser.msie){$(this).attr("checked","")}else{$(this).trigger("click")}})}};
