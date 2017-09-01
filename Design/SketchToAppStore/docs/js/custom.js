// --------------------------------------------------------
// Pretty Photo for Lightbox Image
// --------------------------------------------------------
$(document).ready(function() {
    $("a[data-gal^='prettyPhoto']").prettyPhoto();
});

// --------------------------------------------------------
//	Navigation Bar
// --------------------------------------------------------
$(window).scroll(function(){
	"use strict";
	var scroll = $(window).scrollTop();
	if( scroll > 60 ){
		$(".navbar").addClass("scroll-fixed-navbar");
	} else {
		$(".navbar").removeClass("scroll-fixed-navbar");
	}
});

