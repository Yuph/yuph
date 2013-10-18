$(document).ready(function(){
$("div.embed-video").each(function(){
var regex = /http:\/\/(www.)?youtube\.com\/watch\?v=([A-Za-z0-9._%-]*)(\&\S+)?/;
    var youtubeUrl = $(this).text();
    var regexYoutubeUrl = youtubeUrl.match(regex);
    if (regexYoutubeUrl) 
    {
         $(this).html("<iframe width=\"560\" height=\"315\" src=\"http://www.youtube.com/embed/"+regexYoutubeUrl[2]+"?&showinfo=0&rel=0\" frameborder=\"0\" allowfullscreen></iframe>");
    }
});
})