$(document).ready(function(){
	$('.login').click(function(e){
	    e.stopPropagation();
	    e.preventDefault();
		$('.new-login').toggle("fade");
	});
	$('.engine').click(function(e){
	    e.stopPropagation();
	    e.preventDefault();
		$('.navbar-dropdown').toggle("fade");
	});
});
//$(document).click(function(e) {
//    e.stopPropagation();
//    $('.new-login').fadeOut(300);
//});	
