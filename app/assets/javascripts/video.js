$(document).ready(function(){
$("div.embed-video").each(function(){
    var regex = /(\?v=|\&v=|\/\d\/|\/embed\/|\/v\/|\.be\/)([a-zA-Z0-9\-\_]+)/;
    var youtubeUrl = $(this).text();
    var regexYoutubeUrl = youtubeUrl.match(regex);
    if (regexYoutubeUrl) 
    {
         $(this).html("<iframe width=\"560\" height=\"315\" src=\"http://www.youtube.com/embed/"+regexYoutubeUrl[2]+"?&showinfo=0&rel=0\" frameborder=\"0\" allowfullscreen></iframe>");
    }
});
})