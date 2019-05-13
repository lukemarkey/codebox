// JQUERY ON DOCUMENT LOAD

document.addEventListener("DOMContentLoaded", function(event) {
	(function($) {

	})(jQuery);
});

// HREF BY CLASS NAME

$('.class').click(function () {
	location.href = '/relative-path/';
});

$('.class').click(function () {
	window.open('https://website.com', '_blank');
});

document.getElementById('id').onclick = function(){ }

// REPLACE PAGE TEXT WITH AN HTML ELEMENT

(function($) {
	$("h1, h2, h3, h4, h5, h6, p").each(function() {
		var text = $(this).html();
		$(this).html(text.replace(/aim /gi, '<span class="aim-text">AIM </span>'));
	});
})(jQuery);

// DISABLE FORM SUBMIT BUTTON AFTER FIRST SUBMIT

$('form').submit(function() {
	$(this).find("button[id='submit-button']").prop('disabled',true);
});
