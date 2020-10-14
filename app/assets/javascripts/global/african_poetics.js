// Function to replicate the old jquery toggle behaviour
$.fn.clicktoggle = function(a, b) {
  return this.each(function() {
    var clicked = false;
    $(this).bind("click", function() {
      if (clicked) {
        clicked = false;
        return b.apply(this, arguments);
      } else {
        clicked = true;
        return a.apply(this, arguments);
      }
    });
  });
};

$(function() {
  
	$( ".item_data" ).each(function( index ) {
	  var t = $(this);
	  var heightoft = t.height();
	  if (heightoft > 150) {
	  	$( this ).addClass("expandable");
	  };
	});

	$(".item_data.expandable").addClass('item_data_hide');
	$('.item_data.expandable').append( " <span class=\"more_container\"><a class=\"show_more\"></a></span" );
	$('.show_more').html('Show More');

	$(".show_more").clicktoggle(
    function() {
      $( this ).parents(".item_data").removeClass('item_data_hide');
      $( this ).html('Show Less');
      return false;
    },
    function() {
      $( this ).parents(".item_data").addClass('item_data_hide');
      $( this ).html('Show More');
      return false;
    }
  );


});