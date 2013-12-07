$(document).ready(function(){
	$('.forum-content .post-content').first().addClass('post-first'); // show first post
	$('.sidebar-list li').first().addClass('post-list-active'); // highlight first post link

	var idCount = 1;
	var replyCount = 0;
	$('.post-comment').each(function() {
		$(this).attr('id', + replyCount);
		replyCount++;
	});

	// changes active post

	$('.forum-sidebar .a-post').click(function(){
		hidePosts();
		$('.post-list-active').removeClass('post-list-active');
		$(this).parent().addClass('post-list-active');
		var tmp_post = $(this).attr("id");
		$('.forum-content .post-content').eq(tmp_post - 1).fadeIn(300);
		document.getElementById("reply-post").value = replyCount + 1;
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
