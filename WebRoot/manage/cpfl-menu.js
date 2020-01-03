// JavaScript Document

$(document).ready(function() {
	
	$("#topnav li").hover(function() { //Hover over event on list item
		$(this).css({ 'background' : 'url(images/xian.jpg) right 4px no-repeat'}); //Add background color + image on hovered list item
		$(this).find("span").show(); //Show the subnav
	} , function() { //on hover out...
		$(this).css({ 'background' : 'url(images/xian.jpg) right 4px no-repeat'}); //Ditch the background
		$(this).find("span").hide(); //Hide the subnav
	});
	
});