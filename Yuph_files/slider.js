$(document).ready( function($){
    var slider = $('.slider').find('ul');
    var transition = 500;
    $( slider ).find('li.active').show();

    window.slider = {
        previous: function(){
            var current = $( slider ).find( 'li.active' );
            var prevElement = $( current ).prev('li');

            if( prevElement.length != 0 ){
                $( current ).removeClass('active').fadeOut( transition );
                $( prevElement ).addClass('active').fadeIn( transition );
                }

            else {
                $( current ).removeClass('active').fadeOut( transition );
                $( slider ).find('li.last').addClass('active').fadeIn( 1000 );;
            }
        },
        next: function(){
        var current = $( slider ).find( 'li.active' );
        var nextElement = $( current ).next('li');

        if( nextElement.length != 0 ){
            $( current ).removeClass('active').fadeOut( transition );
            $( nextElement ).addClass('active').fadeIn( transition );
            }
        else {
                $( current ).removeClass('active').fadeOut( transition );
                $( slider ).find('li.first').addClass('active').fadeIn( 1000 );;
            }
        }
    }
});
