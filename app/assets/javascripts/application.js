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

$(document).on('click','.options_icon', function() {  
	if ($(".display_options").is(":hidden")) {	
		$(".display_options").slideDown();
	} else {
		$(".display_options").slideUp();
	}
});	

$(document).on('page:change', function() {
	
	$('.js_sort').click(function(){
		var sort_type = $('input[name=sort]:checked').val();
		var $divs = $(".list_item");

		if (sort_type == "name") {
			sortByDataAtt(".wrapper", $divs, "sort_name");
		} else if (sort_type == "tea_type") {
			sortByDataAtt(".wrapper", $divs, "sort_type");
		}
	  
	});

	$('.js_narrow_by_att').change(function(){
		var checked = [];
		
		$("input[name=att]:checked").map(function() {
    		checked.push(parseInt(this.value));
		});
		
		//console.log(checked);
		
		//var $divs = $(".list_item");
		if (checked.length) {
			$('.list_item').each(function(i, obj) {
			    var thisAtts = $(this).data("atts");
			    var matches = [];

			    $.each(checked, function( index, value ) {
					
					if($.inArray(value, thisAtts) > -1){
						//console.log("found " + value );
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
});

var sortByDataAtt = function(wrapperClass,objects,dataAtt) {
	var ordered = objects.sort(function (a, b) {
	    return $(a).data(dataAtt) > $(b).data(dataAtt);
	});
	$(wrapperClass).html(ordered);
}