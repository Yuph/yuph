$(document).ready(function(){
	$('.forum-content .post-content').first().addClass('post-first'); // show first post
	$('.sidebar-list li').first().addClass('post-list-active'); // highlight first post link

	// changes active post

	$('.forum-sidebar .a-post').click(function(){
		hidePosts();
		$('.post-list-active').removeClass('post-list-active');
		$(this).parent().addClass('post-list-active');
		var tmp_post = $(this).attr("id");
		$('.forum-content .post-content').eq(tmp_post - 1).fadeIn(300);
		document.getElementById("reply-post").value = tmp_post;
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

	var $object = $('.forum-content .post-content');
	if($object.length) {
	    // there's at least one post
	    $('.help-forum').remove();
	}
	else {
		$('.reply-post-form').hide();
		$('.help-forum').show();
	}
});