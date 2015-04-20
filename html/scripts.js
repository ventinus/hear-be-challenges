console.log('loaded scripts');

$(document).on('ready page:load', function(){
	var emptyStyles = {
		"background-image": '',
		"width": "",
		"height": "",
		"background-repeat": "",
		"background-size": ""
	};

	var textProps = {
	  "position": "relative",
	  "top": "240px",
	  "width": "94%",
	  "color": "white",
	  "margin": "0 auto"
	};

	var removeText = {
		"display": "none"
	}

	$('.img-1').css({	
		"background-image": 'url("http://images.askmen.com/fine_living/wine_dine_archive/askmen-and-bespoke-post-1064722-flash.jpg")',
		"width": "100%",
		"height": "300px",
		"background-repeat": "no-repeat",
		"background-size": "cover"
	});

  $(window).on('scroll',function() {
    var scrolltop = $(this).scrollTop();
    if(scrolltop <= 485 || scrolltop >= 1311) {
			$('.float-box').slideUp(1000); 
    } else if (scrolltop >= 488) {
			$('.float-box').slideDown(1000); 
    }
  });

	$('.image-text-1').fadeIn(1000).css(textProps);

	$('#button-1')
		.on('change', function(e){
			console.log('number 1 clicked');
			$('.img-1').fadeIn(500).css({	
				"background-image": 'url("http://images.askmen.com/fine_living/wine_dine_archive/askmen-and-bespoke-post-1064722-flash.jpg")',
				"width": "100%",
				"height": "300px",
				"background-repeat": "no-repeat",
				"background-size": "cover"
			})
			$('.img-2').fadeOut(400).css( emptyStyles );
			$('.img-3').fadeOut(400).css( emptyStyles );
			$('.image-text-3').css(removeText)
			$('.image-text-2').css(removeText)
			$('.image-text-1').fadeIn(1000).css(textProps);
		})

	$('#button-2').on('change', function(e){
		console.log('number 2 clicked');
		$('.img-2').fadeIn(500).css({	
			"background-image": 'url("http://aandhmag.com/wp-content/uploads/2012/08/slideshow_5-e1346032266945.jpg")',
			"width": "100%",
			"height": "300px",
			"background-repeat": "no-repeat",
			"background-size": "cover"
		});
		$('.img-1').fadeOut(400).css( emptyStyles );
		$('.img-3').fadeOut(400).css( emptyStyles );
		$('.image-text-1').css(removeText)
		$('.image-text-3').css(removeText)
		$('.image-text-2').fadeIn(1000).css(textProps);
	});

	$('#button-3').on('change', function(e){
		$('.img-3').fadeIn(500).css({	
			"background-image": 'url("http://19fksc2tl6wc3kw1hb18la0p.wpengine.netdna-cdn.com/wp-content/uploads/2014/01/bespoke-post-heritage-items.jpg")',
			"width": "100%",
			"height": "300px",
			"background-repeat": "no-repeat",
			"background-size": "cover"
		})
		$('.img-1').fadeOut(400).css( emptyStyles );
		$('.img-2').fadeOut(400).css( emptyStyles );
		$('.image-text-1').css(removeText)
		$('.image-text-2').css(removeText)
		$('.image-text-3').fadeIn(1000).css(textProps);		
	});

})
