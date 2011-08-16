// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

var App = {
		show_load : function(){
			$('.loading-area .loading-area-text').html('Loading...');
			$('.loading-area').show();
		},
		hide_load : function(){
			$('.loading-area').hide();
		},
		show_error : function(){
			$('.loading-area .loading-area-text').html('There was an error in the page request!');
			$('.loading-area').show();
		},
		
		roll_over : function (element){
			element.style.backgroundColor = '#E5F2FC';
			$(element).children('.content').children('.actions').children('.showOver').show();
			$(element).children('.content').children('.details').children('.more').show();
		},
		roll_out : function (element){
			element.style.backgroundColor = '';
			$('.showOver').hide();
		},
		tipsy : function(){
			$('img, div, span, a').tipsy({gravity: 'e'});
			
			$('input').tipsy({gravity: 'w', trigger: 'focus'});
		},
		
		
		
		load_page: function (url, target_selector){
			if (typeof iconAlert == 'undefined')
				target_selector = ''

			$.ajax({
				type: 'GET',
				url: url,
				data: null,
				cache: false,
				beforeSend: function(){
					App.show_load();
				},
				success: function(txt){
					App.hide_load();
					$(target_selector).html(txt);
				},
				error: function(){
					App.hideLoad();
					$(target_selector).html('');
					App.show_error();
				}
			});
		}
};