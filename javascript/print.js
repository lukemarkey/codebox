// HTML FOR PRINTING IMAGE
<div class="col-sm-4 col-xs-6">
	<div class="single-item" onclick="VoucherPrint('{% static "website/img/promotions/promotion1.png" %}')">
		<a href="javascript:void(0);" class="tran3s">
			<img src="{% static "website/img/promotions/promotion1.png" %}" alt="">
			<h5><a href="javascript:void(0);" class="tran3s">20% Off Wood Stains</a></h5>
		</a>
	</div>
</div>

// PRINT IMAGE PASSED TO SCRIPT FROM HTML
<script type="text/javascript">
	function VoucherSourcetoPrint(source) {
		return "<html><head><script>function step1(){\n" +
				"setTimeout('step2()', 10);}\n" +
				"function step2(){window.print();window.close()}\n" +
				"</scri" + "pt></head><body onload='step1()'>\n" +
				"<img src='" + source + "' /></body></html>";
	}
	function VoucherPrint(source) {
		Pagelink = "about:blank";
		var pwa = window.open(Pagelink, "_new");
		pwa.document.open();
		pwa.document.write(VoucherSourcetoPrint(source));
		pwa.document.close();
	}
</script>
