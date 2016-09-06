$(document).ready(function(){

    // Burger menu

    $('.burger_menu').click(function(){
        $('.nav').slideToggle('fast');
    });

    var i = 0;
    setInterval(function() {
         if(i == 7) i=0;


         $('#logo').attr('src', '/logo2/' + (++i) + '.png' );
    }, 3000);

    $(window).scroll(function() {

        if ($(this).scrollTop()>0)
        {
            $('.pre_menu').fadeOut();
            $('nav').addClass('top-menu');
        }
        else
        {
            $('.pre_menu').fadeIn();
            $('nav').removeClass('top-menu');
        }
    });

});
