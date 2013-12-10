$(document).ready(function(){
	var idCount = 1;
	var ideas = $('.show-all-ideas .min-idea')
	ideas.each(function() {
		$(this).attr('id', + idCount);
		if (idCount % 4 == 0) {
			$(this).addClass("omega");
		};
		idCount++;
 	});
 	$('.show-all-ideas .omega').after('<div class="clear"></div>')
});