
//var showtree = {tree:'个人消费中心',sets:'纸板书',subtree:'购买过的图书'};
jQuery(function($){
	$(".level1 h3").click(function(){
		if(this.className == 'h3o')
		{
			$(this).next().hide('slow');
			$(this).removeClass('h3o');
			$(this).addClass('h3c');
		}
		else
		{
			$(this).next().show("slow");
			$(this).removeClass('h3c');
			$(this).addClass('h3o');
		}
	});
	$(".level2 h4").click(function(){
		if(this.className == 'h4o')
		{
			$(this).removeClass('h4o');
			$(this).next().hide('slow');
		}
		else
		{
			$(this).addClass('h4o');
			$(this).next().show("slow");
		}
	});
	
	
	if (showtree.tree != ''){
		//$("h3:contains('"+showtree.tree+"')").click();
		$("h3:contains('"+showtree.tree+"')").next().show();
		$("h3:contains('"+showtree.tree+"')").removeClass('h3c');
		$("h3:contains('"+showtree.tree+"')").addClass('h3o');
		if (showtree.subtree != ''){
			$("h3:contains('"+showtree.tree+"')").next().find("h4:contains('"+showtree.sets+"')").addClass('h4o');
			$("h3:contains('"+showtree.tree+"')").next().find("h4:contains('"+showtree.sets+"')").next().show("slow");
			$("h3:contains('"+showtree.tree+"')").next().find("h4:contains('"+showtree.sets+"')").next().find("li:contains('"+showtree.subtree+"')").addClass("arrow");
		}else{
			$("h3:contains('"+showtree.tree+"')").next().find("li:contains('"+showtree.sets+"')").addClass("arrow");
		}
	}

});
