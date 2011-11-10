
App.contacts = {
	index: function(){
			var clicked_on_link = false;
			$('#list .item').click(function(){
				if(clicked_on_link == false){
					$.ajax({
						type: "GET",
						url: $(this).attr('href-contact'),
						data: '',
						cache: false,
						beforeSend: function(){
							App.show_load();
							$('#details .content').html('Loading...');
						},
						success: function(txt){
							App.hide_load();
							$('#details .content').html(txt);
						},
						error: function(){
							App.hide_load();
							App.show_error();
						},
						stop: function(){
							App.hide_load();
							App.show_error();
						}
					});
				}
			});
			$('a').click(function(){
				if($(this).attr('data') == 'no_ajax'){
					clicked_on_link = true;
				}else{
					clicked_on_link = false;
				}
			});

			$('.favorite').click(function(){
				App.load_page($(this).attr('href'));
				if($(this).attr('data-favorite') == 'true'){
					$(this).children('span').html('Favorite');
					$(this).removeClass('favorited');
					$(this).attr('data-favorite', 'false');
				}else{
					$(this).children('span').html('Unfavorite');
					$(this).addClass('favorited');
					$(this).attr('data-favorite', 'true');
				}
				clicked_on_link = false;
				return false;
			});
	}
}