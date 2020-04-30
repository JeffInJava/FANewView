(function($, root){

	var modal = {
		"DEFAULT": {
			"url": "view/sys/modal-view.html"	
		},
		"loadModal": function(option, callback){
			option = {"data": option};
			$.extend(option, this.DEFAULT);
			var data = option.data;
			var modalId = "#" + data.id;
			if($("body:has(" + modalId + ")").length > 0){
				$(modalId).remove();
			}
			mstRender(option, function(html){
				var $html = $(html);
				if(data.btns){
					$.each(data.btns, function(i, btn){
						var btnId = "#" + btn["id"];
						var click = btn["click"];
						if(click){
							$html.find(btnId).click(click);
						}
					});
				}
				$("body").append($html);
				$(modalId).modal();
				callback && callback();
			});
		}	
	};
	
	root.modal = modal;
	
})(jQuery, window);

