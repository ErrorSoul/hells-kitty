$(document).ready(function(){

    // Logo
    var i = 0;
    setInterval(function() {
         if(i == 7) i=0;

         $('#logo').attr('src', '/logo2/' + (++i) + '.png' );
    }, 3000);

    // Scroll menu
    $(window).scroll(function() {

        if ($(this).scrollTop()>10)
        {
            $('.pre_menu').fadeOut();
            $('nav').addClass('top-menu');
            $('.navbar-brand a img').addClass('scroll-logo');
        }
        else
        {
            $('.pre_menu').fadeIn();
            $('nav').removeClass('top-menu');
            $('.navbar-brand a img').removeClass('scroll-logo');
        }
    });

    // Burger menu

    $('.burger_menu').click(function(){
        $('.burger_menu').addClass('burger_menu__active');
        $('.nav').slideToggle('fast');
    });

});
