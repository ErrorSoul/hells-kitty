 $(document).ready(function() {
     $('body').click(function(){
	 var state = true;
	  if ( state ) {
        $( "body" ).animate({
          backgroundColor: "#aa0000"
        }, 1000 );
      } else {
        $( "body" ).animate({
          backgroundColor: "#fff",
          color: "#000"
        }, 1000 );
      }
      state = !state;

     })
 });
