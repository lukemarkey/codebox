///////////////////////////////////////////////////////////////////////////
// HREF BY CLASS NAME
///////////////////////////////////////////////////////////////////////////

$('.class').click(function () {
	location.href = '/relative-path/';
});

$('.class').click(function () {
	window.open('https://website.com', '_blank');
});

document.getElementById('id').onclick = function(){ }

///////////////////////////////////////////////////////////////////////////
// REPLACE TEXT WITH HTML
///////////////////////////////////////////////////////////////////////////

(function($) {
	$("h1, h2, h3, h4, h5, h6, p").each(function() {
		var text = $(this).html();
		$(this).html(text.replace(/aim /gi, '<span class="aim-text">AIM </span>'));
	});
})(jQuery);

function changeElementText() {
	span = document.getElementById("spanID");
	text = document.createTextNode("Text to insert.");
	span.appendChild(text);
}
