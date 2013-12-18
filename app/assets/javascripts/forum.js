$(document).ready(function(){
	$('.forum-content .post-content').first().addClass('post-first'); // show first post
	$('.sidebar-list li').first().addClass('post-list-active'); // highlight first post link
	var firstPost = $('.sidebar-list li a:first').attr("id");

	// test if forum exist and set default value to reply form
	if ($('.post-content').length && $('#reply-post').length ) {
		document.getElementById("reply-post").value = firstPost;
	};

	// changes active post

	$('.forum-sidebar .a-post').click(function(){
		hidePosts();
		$('.post-list-active').removeClass('post-list-active');
		$(this).parent().addClass('post-list-active');
		var post = $(this).attr("id")
		var tmp_post = 'post' + $(this).attr("id");
		$("#" + tmp_post ).fadeIn(300);
		document.getElementById("reply-post").value = post;
	});

	function hidePosts(){
		$('.forum-content .post-content').each(function(){
		$(this).hide();});
	};

	$('#new-category-button').click(function(){
		$('#fade').fadeIn();
		$('#new-category').dialog( {
			show: 'fade', 
			hide: 'fade',
			dialogClass: "no-close",
			dialogClass: "new-category-dialog",
			closeOnEscape: false,
			width: "510px",
			buttons: [{
				text: "x",
				"class": 'close-new-input',
				click: function() {
					$( this ).dialog( "close" );
					$('#fade').fadeOut();
				}
			}],
		});
	});

	$('#new-post-button').click(function(){
		$('#fade').fadeIn();
		$('#new-post').dialog({
			show: 'fade', 
			hide: 'fade',
			dialogClass: "no-close",
			dialogClass: "new-post-dialog",
			closeOnEscape: false,
			width: "510px",
			buttons: [{
				text: "x",
				"class": 'close-new-input',
				click: function() {
					$( this ).dialog( "close" );
					$('#fade').fadeOut();
				}
			}],
		});
	});

	if($('.forum-content .post-content').length) {
	    // there's at least one post
	    $('.help-forum').remove();
	}
	else {
		$('.reply-post-form').hide();
		$('.help-forum').show();
	}
});