// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults




var App = {
		
		showLoad : function(){
			$('.loading-area .loading-area-text').html('Carregando...');
			$('.loading-area').show();
		},
		hideLoad : function(){
			$('.loading-area').hide();
		},
		showError : function(){
			$('.loading-area .loading-area-text').html('Houve um erro na aquisição da página!');
			$('.loading-area').show();
		},
		del: function() {
			var x = confirm("Tem certeza que deseja excluir?");
			return x;
		},
		rollOver : function (element){
			element.style.backgroundColor = '#E5F2FC';
			$(element).children('.content').children('.actions').children('.showOver').show();
			$(element).children('.content').children('.details').children('.more').show();
		},
		rollOut : function (element){
			element.style.backgroundColor = '';
			$('.showOver').hide();
		},
		tipsy : function(){
			$('img, div, span, a').tipsy({gravity: 'e'});
			
			$('input').tipsy({gravity: 'w', trigger: 'focus'});
		},
		onSubmit : function(){
			$(document.forms).submit(function(){
				App.showLoad();
			});
		},
		
		
		
		pageLoad: function (hash){
			if(!hash){
				hash = 'home';
			}
			var url = hash;
			var regExpHome = /^(home$)|(home\/$)|(home\/index)/;
			var regExpIndex = /^(index.php)/;
			if(regExpHome.test(url)){
				url = 'home';
			}else if(regExpIndex.test(url)){
				url = 'home';
			}
			$.ajax({
				type: 'GET',
				url: url,
				data: null,
				cache: false,
				beforeSend: function(){
					App.showLoad();
				},
				success: function(txt){
					App.hideLoad();
					$('#content').hide();
					$('#content').html(txt);
					$('#content').fadeIn();
				},
				error: function(){
					App.hideLoad();
					$('#content').html('');
					App.showError();
				}
			});
		}
};
