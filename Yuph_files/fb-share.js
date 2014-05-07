$(document).ready(function(){
	//changes facebook share button's url
	var url = $(location).attr('href');
	$('#fb-like').attr('data-href', url);
});
