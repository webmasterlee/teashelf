// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

var supportsTouch = 'ontouchstart' in window || navigator.msMaxTouchPoints;

//$(document).on('page:change', function() {
document.addEventListener("turbolinks:load", function() {
  ga('send', 'pageview', window.location.pathname);

});

document.addEventListener("turbolinks:load", function() {	
	if (supportsTouch) {
		$("html").addClass("touchevents");
	} else {
		$("html").addClass("no_touchevents");
	}
});	

$(document).on('click','.site_accordion_title', function() {  
	$this = $(this);
	if ($this.next(".site_accordion_desc").is(":hidden")) {	
		$this.next(".site_accordion_desc").slideDown();
		$this.addClass("site_accordion_title_open");
	} else {
		$this.next(".site_accordion_desc").removeClass("site_accordion_desc_open"); //just in case its there
		$this.next(".site_accordion_desc").slideUp();
		$this.removeClass("site_accordion_title_open");
	}

	/*
	<div class="site_accordion">
		<div class="site_accordion_title"></div>
		<div class="site_accordion_desc"></div>
	</div>
	*/
});	

$(document).on('click','.js_show_notes_info', function() {  
	$(".js_css_notes_info").show();
});	


$(document).on('click','.options_icon', function() {  
	if ($(".display_options").is(":hidden")) {	
		$(".display_options").slideDown();
	} else {
		$(".display_options").slideUp();
	}
});	

$(document).on('click','.js_css_msg_target', function() {  
	$(this).slideUp();
});	

$(document).on('click','.js_add_to_wishlist', function() { 

	var link = $(this); 

	$.ajax({
		type: 'POST',
		dataType: 'json',
		data: {
			'wishlist[name]': $(this).data("name"), 
			'wishlist[url]': $(this).data("url"),
			'wishlist[notes]': $(this).data("notes")
		},
		url: '/wishlists/save_suggestion',
		success: function(result, textStatus, XMLHttpRequest) {
			link.replaceWith("Saved to Wishlist");
		}
	});
});	

$(document).on('click','.js_change_password', function() { 
	$(".js_pw").css("display", "table-row");
});	

$(document).on('click','.js_add_exclusion', function() { 

	var link = $(this); 

	$.ajax({
		type: 'POST',
		dataType: 'json',
		data: {
			'exclusion[attr]': $(this).data("attr"), 
			'exclusion[value]': $(this).data("value")
		},
		url: '/exclusions/create',
		success: function(result, textStatus, XMLHttpRequest) {
			link.replaceWith("<span class='margin_left'>Preferences updated</span>");
		}
	});
});	

$(document).on('blur keyup','.js_username', function() {  
	if ($('.js_username').val().length > 3 && $(this).data("current_username") != $('.js_username').val()) {
		$.ajax({
			type: 'POST',
			dataType: 'json',
			data: {'username': $('.js_username').val() },
			url: '/account/found_username',
			success: function(result, textStatus, XMLHttpRequest) {
				
				if(result == 1){
					$('#username_error').show();
					$('#username_success').hide();
				} else {
					$('#username_error').hide();
					$('#username_success').show();
				}
			}
		});
	}
});

/*
$(document).on('click','.js_sort', function() {  
//$('.js_sort').click(function(){
	var sort_type = $('input[name=sort]:checked').val();
	var $divs = $(".list_item");

	if (sort_type == "name") {
		sortByDataAtt(".wrapper", $divs, "sort_name");
	} else if (sort_type == "tea_type") {
		sortByDataAtt(".wrapper", $divs, "sort_type");
	}
  
});
*/
$(document).on('click','.js_archives', function() {  
//$('.js_archives').click(function(){
	$('.archives_section').toggle();
});

$(document).on('change','.js_narrow_by_att', function() {  
//$('.js_narrow_by_att').change(function(){
	var checked = [];
	
	$("input[name=att]:checked").map(function() {
		checked.push(this.value);
	});
	
	//var $divs = $(".list_item");
	if (checked.length) {
		$('.list_item').each(function(i, obj) {
		    var thisAtts = $(this).data("atts");
		    var matches = [];

		    $.each(checked, function( index, value ) {
				if($.inArray(value, thisAtts) > -1){
					matches.push(value);
				}
			});

			if (checked.length == matches.length) {
				$(this).css("display","block");
			} else {
				$(this).css("display","none");
			}
		});
	} else {
		$('.list_item').each(function(i, obj) {
			$(this).css("display","block");
		});
	}
});

//$(document).on('page:change', function() {
document.addEventListener("turbolinks:load", function() {	
	/*$('.tea_form').submit(function(){
		console.log($('#tea_name').val());
		if ($('#tea_name').val() == '') {
			$('#tea_name-error').show();
			return false;
		}
		return false;
	});*/

	if ($(".typeahead").length) {
 
		var teas = new Bloodhound({
		  datumTokenizer: Bloodhound.tokenizers.whitespace,
		  queryTokenizer: Bloodhound.tokenizers.whitespace,
		  prefetch: '/teas/get_tea_names'
		});

		// passing in `null` for the `options` arguments will result in the default
		// options being used
		$('.typeahead').typeahead({
			minLength: 3
		}, 
		{
		  name: 'teas',
		  source: teas
		});
	}

	// the 'right' means error messages will appear to the right
	// can only be one of these on page
	$(".required_form_right").validate();	

	// the 'bottom' means error messages will appear to the bottom
	// can only be one of these on page
	$(".required_form_bottom").validate({errorElement: "div"});

	
});

/*
var sortByDataAtt = function(wrapperClass,objects,dataAtt) {
	var ordered = objects.sort(function (a, b) {
	    return $(a).data(dataAtt) > $(b).data(dataAtt);
	});
	$(wrapperClass).html(ordered);
}
*/