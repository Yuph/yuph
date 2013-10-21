//$(document).ready(function(){
//	$('.reply-button').click(function(){
//		$('.reply-post').toggle(300);
//	})
//})

$('.submit-idea-button').click(function(){
	document.getElementById("idea_description").value = ideaDescription;
	var text = ideaDescription.text();
   	document.getElementById("idea_description").value = text;
})
