
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
    },
    _form: function(){
        $('div.contact.photo .photo_edit a.edit').click(function(){
            if($('div.contact.photo .photo_options').css('display') == 'block')
                $('div.contact.photo .photo_options').hide();
            else
                $('div.contact.photo .photo_options').show();
        });
        
        $('div.contact.photo .photo_options a.from_twitter').click(function(){
            if(!$('input#contact_twitter').val()){
                alert('Please enter a twitter name.');
            }else{
                $.ajax({
                    type: "GET",
                    url: $(this).attr('href'),
                    data: 'twitter='+$('input#contact_twitter').val(),
                    cache: false,
                    beforeSend: function(){
                        App.show_load();
                    },
                    success: function(obj){
                        App.hide_load();
                        if(obj.error){
                            alert("Was not found specified twitter user");
                        }else{
                            $('input#contact_img_url').val(obj.img_url)
                            $('div.contact.photo .img_photo').html('<img src="'+obj.img_url+'" width="100"/>');
                        }
                    },
                    error: function(e, a){
                        alert(e.status)
                        App.hide_load();
                        App.show_error();
                    },
                    stop: function(){
                        App.hide_load();
                        App.show_error();
                    }
                });
            }
            return false;
        });
        
        $('div.contact.photo .photo_options a.from_gravatar').click(function(){
            if(!$('input#contact_email').val()){
                alert('Please enter a email.');
            } else{
                $.ajax({
                    type: "GET",
                    url: $(this).attr('href'),
                    data: 'email='+$('input#contact_email').val(),
                    cache: false,
                    beforeSend: function(){
                        App.show_load();
                    },
                    success: function(obj){
                        App.hide_load();
                        if(obj.error){
                            alert("Was not found image");
                        }else{
                            $('input#contact_img_url').val(obj.img_url)
                            $('div.contact.photo .img_photo').html('<img src="'+obj.img_url+'" width="100"/>');
                        }
                    },
                    error: function(e, a){
                        alert(e.status)
                        App.hide_load();
                        App.show_error();
                    },
                    stop: function(){
                        App.hide_load();
                        App.show_error();
                    }
                });
            }
            return false;
        });
        $('div.contact.photo .photo_options a.remove').click(function(){
            $('input#contact_img_url').val(''),
            $('div.contact.photo .img_photo').html('<img src="'+$(this).attr('href')+'" width="100"/>');
            return false;
        });
        
    },
    new: function(){
        App.contacts._form();
    },
    edit: function(){
        App.contacts._form();
    }
}