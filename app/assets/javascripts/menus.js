$(document).ready(function(){
	$('.engine').click(function(e){
	    e.stopPropagation();
		$('.navbar-dropdown').toggle();
	});
});
$(document).click(function(e) {
    e.stopPropagation();
    $('.navbar-dropdown').fadeOut(300);
});	
