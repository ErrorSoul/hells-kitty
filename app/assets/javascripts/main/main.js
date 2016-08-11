
$(document).ready(function(){

    $('.hovered-menu').hover(function(){
	console.log('ffff');
	$(this).parent()
	    .children()
	    .find('.before-style')
	    .toggleClass('hovered');
    })

    console.log('dssfsdafas')

 });
