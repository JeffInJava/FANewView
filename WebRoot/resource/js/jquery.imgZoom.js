(function ($) {
    $.fn.imgZoom = function (obj) {
        var mask ="<div style = 'position: absolute;width: 100%;z-index: 5555;height: 100%;top: 0;left: 0;background: rgba(0,0,0,0.5);display:none;' id='imgZoomMask'></div>";
        mask+="<button type='button' style='z-index:7777;position:absolute;left:0;top:30px;' class='el-button el-button--primary el-button--small' id='imgZoomCloseId'><span>关闭</span></button>";
        
        $("html").append(mask);
        var windowWidth = $(window).width();
        var windowHeight = $(window).height();
        $(window).resize(function () {
            windowWidth = $(window).width();
            windowHeight = $(window).height();
        });
        this.each(function () {
            //$(this).click(function () {
                $("#imgZoomMask").show();
                
                //var src = $(this).data("src") == undefined ? $(this).attr("src") : $(this).data("src");
                var src=obj;
                var img = new Image();
                img.src = src;
                img.onload = function() {
                    var style = "z-index:6666;position:absolute;left:0;right:0;top:0;bottom:0;margin:auto;cursor:pointer;";
                    var dom = "<img draggable='true' src = '" +src +"' height = '"+windowHeight+"px' style='" +style +"' id='imgZoomImg'>";
                    $("body").append(dom);
                    $("#imgZoomImg").dragging({
                        move: "both", //拖动方向，x y both
                        randomPosition: false //初始位置是否随机
                    });
                    hideZoom();
                };
                img.onerror=function(){
                	hideZoom();
                };
            //});
        });
        
        //点击按钮和阴影层，让图层消失
        var hideZoom=function(){
            $(document).on("click", "#imgZoomMask,#imgZoomCloseId", function () {
	            $("#imgZoomCloseId").hide().remove();
	        	$("#imgZoomMask").hide().remove();
	            $("#imgZoomImg").fadeOut().remove();
	        });
	        $("#imgZoomMask")[0].addEventListener('touchstart',function () {
	            $("#imgZoomCloseId").hide().remove();
	        	$("#imgZoomMask").hide().remove();
	            $("#imgZoomImg").fadeOut().remove();
	        }, false);
	        $("#imgZoomCloseId")[0].addEventListener('touchstart',function () {
	            $("#imgZoomCloseId").hide().remove();
	        	$("#imgZoomMask").hide().remove();
	            $("#imgZoomImg").fadeOut().remove();
	        }, false);
        }
        
        var imgZoomFn=function(e,d) {
            //d 1 上 -1 下
            if (d === 1) {
                var width = $("#imgZoomImg").width();
                var height = $("#imgZoomImg").height();
                $("#imgZoomImg").css({ "width": width * 1.05, "height": height * 1.05 });
            }
            if (d === -1) {
                var width = $("#imgZoomImg").width();
                var height = $("#imgZoomImg").height();
                $("#imgZoomImg").css({ "width": width / 1.05, "height": height / 1.05 });
            }
        };
        $(document).on("mousewheel",imgZoomFn);
        var hammertime = new Hammer(document);
        hammertime.get('pinch').set({ enable: true });
        hammertime.on("pinchin", function (e) {
            var width = $("#imgZoomImg").width();
            var height = $("#imgZoomImg").height();
            $("#imgZoomImg").css({ "width": width / 1.05, "height": height / 1.05 });
        });
        hammertime.on("pinchout", function (e) {
        	var width = $("#imgZoomImg").width();
            var height = $("#imgZoomImg").height();
            $("#imgZoomImg").css({ "width": width * 1.05, "height": height * 1.05 });
        });
    }
})(window.jQuery)