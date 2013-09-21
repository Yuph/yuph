$(document).ready(function(){
	$('.sidebar-list a').click(function(){
	     hidePosts();
	     var tmp_post = $(this).parent().index();
	     $('.forum-content .post-content').eq(tmp_post).show();
	  });

	function hidePosts(){
	    $('.forum-content .post-content').each(function(){
	    $(this).hide();});
	};

	$('#new-post-button').click(function(){
		$('#new-post').slideDown();
		$('#new-category').hide();
	});
	$('#new-category-button').click(function(){
		$('#new-category').slideDown();
		$('#new-post').hide();
	});
	$('.close-new-input').click(function(){
		$(this).parent().slideUp();
	});
});