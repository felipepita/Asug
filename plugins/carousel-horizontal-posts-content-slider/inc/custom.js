var $j = jQuery.noConflict();

jQuery(document).ready(function($j) {

$j("#foo1").carouFredSel({
	circular: true,
	responsive: true,
	infinite: true,
	auto 	: true,
	prev	: {
		button	: "#foo1_prev",
		key		: "left"
	},
	next	: {
		button	: "#foo1_next",
		key		: "right"
	},
	pagination	: "#foo1_pag",
scroll: {
items: 1,
easing : "linear",
duration : 600,
pauseOnHover	: true,
},
		items: {

					//	height: '30%',	//	optionally resize item-height
						visible: {
							min: 1,
							max: 100000
						}
					}
});

});