// JavaScript Document
var dg = frameElement.lhgDG;
dg.addBtn( 'close', '关 闭',cancel);
dg.addBtn( 'save', '保 存', save);

function cancel(){
	parent.mainFrame.location.reload();
	dg.cancel();
}

function save()
{   
	//if (Validator.Validate(document.getElementById('theform'),1)){
		document.theform.submit();
	//}
}
