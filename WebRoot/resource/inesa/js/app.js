	/*
	 * APP CONFIGURATION
	 * Description: Enable / disable certain theme features here
	 */		
	$.navAsAjax = true; // Your left nav in your app will fire ajax calls
	
	$.devMode = true; //开发模式
	
	/*
	 * APP DOM REFERENCES
	 * Description: Obj DOM reference, please try to avoid changing these
	 */	
	$.page_content_name = "#page-content";
	$.page_content = $($.page_content_name);
	$.bread_crumb = $("#breadcrumbs ul.breadcrumb");
	
	
	/*
	 * DOCUMENT LOADED EVENT
	 * Description: Fire when DOM is ready
	 */
	$(document).ready(function(){
		
		//初始化菜单列表
		$.post("jkuser/my_menu_json_in_time.action", function(menus){
			initMenus(menus);
			 // fire this on page load if nav exists
			if($("#sidebar > .nav").length){
				checkURL();
			}			
		});
		
		bootbox.setDefaults({"locale": "zh_CN"});
	});
	
	
	/***************************菜单初始化************************************/
	/*
	* APP AJAX REQUEST SETUP
	* Description: Executes and fetches all ajax requests also updates naivgation elements to active
	*/
	if($.navAsAjax){
		
		
		/***
		 * 菜单事件绑定，基于hash实现的异步页面加载
		 * 点击菜单时，修改hash，再通过hashchange事件获取hash值，异步调用
		 */
		$("#sidebar").on("click", ".nav a[href!='#']", function(e){
			e.preventDefault();
			var $this = $(e.currentTarget);
			if (!$this.attr("target")) {
				 // update window with hash
				var menuNo = $this.data("m");
				var href = $this.attr("href");
				href = setUrlParams(href, {"_m": menuNo});
				if (window.location.search) {
					window.location.href = window.location.href.replace(window.location.search, "")
						.replace(window.location.hash, "") + "#" + href;
				}else{
					window.location.hash = href;
				}
			}
		});
		
	    // fire links with targets on different window
	    $("#sidebar").on("click", ".nav a[target='_blank']", function(e) {
		    e.preventDefault();
		    var $this = $(e.currentTarget);

		    window.open($this.attr("href"));
	    });

	    // fire links with targets on same window
	    $("#sidebar").on("click", ".nav a[target='_top']", function(e) {
		    e.preventDefault();
		    var $this = $(e.currentTarget);

		    window.location.href = $this.attr("href");
	    });

	    // all links with hash tags are ignored
	    $("#sidebar").on("click", ".nav a[href='#']", function(e) {
		    e.preventDefault();
	    });

	    // DO on hash change
	    $(window).on("hashchange", function() {
		    checkURL();
	    });		
	}
	
	// CHECK TO SEE IF URL EXISTS
	function checkURL() {

		//get the url by removing the hash
		var url = location.hash.replace(/^#/, "");

		var container = $.page_content;
		// Do this if url exists (for page refresh, etc...)
		if(url){
			// match the menuNo(or url) and add the active class
			var menuNo = getUrlParams("_m", url);
			var $a = null;
			if(menuNo){
				$a = $("#sidebar .nav a[data-m='" + menuNo + "']");
			}
			if(!$a || $a.size() == 0){
				var pos = url.indexOf("?");
				var href = pos > 0 ? url.substring(0, pos) : url;
				$a = $("#sidebar .nav a[href='" + href + "']");
			}
			
			/**
			 * 渲染菜单
			 * 判断是否存在此菜单，如存在，则重新定位选中菜单，如不存在，则不做任何事
			 */
			if($a && $a.size() > 0){
				// remove all active class
				$("#sidebar .nav li.active").removeClass("active").removeClass("open");
				$a.parents("li").addClass("active").not($a.closest("li")).addClass("open");
				var title = $a.attr("title");
				// change page title from global var
				document.title = (title || document.title);
			}

			// parse url to jquery
			loadURL(url, container);
		}else{
			// grab the first URL from nav
			//var $this = $('#sidebar > .nav > li:first-child > a[href!="#"]');
			//update hash
			//window.location.hash = $this.attr('href');
		}
	}	
	
	
	// LOAD AJAX PAGES
	function loadURL(url, container){

		$.ajax({
			type : "GET",
			url : url,
			//dataType : "html",
			beforeSend : function(){
				// cog placed
				container.html('<h1 class="text-center"><i class="icon-spinner icon-spin icon-2x red"></i> 处理中...</h1>');
			
				// Only draw breadcrumb if it is main content material
				if (container == $.page_content){
					drawBreadCrumb();
				} 
			},
			/*complete: function(){
		    	// Handle the complete event
		    	// alert("complete")
			},*/
			success : function(data){
				//无法找到用户对象
				if(data.exceptionCode == "80"){
					window.location.href = $("base").attr("href");
					return;
				}
				//权限错误
				if(data.exceptionCode == "89"){
					window.location.href = $("base").attr("href") + "pages/error/access_denied.jsp";
					return;
				}				
				// cog replaced here...
				container.css({
					opacity : '0.0'
				}).html(data).delay(50).animate({
					opacity : '1.0'
				}, 300);
			},
			error : function(xhr, ajaxOptions, thrownError){
				container.html('<h4 style="margin-top:10px; display:block; text-align:left"><i class="fa fa-warning txt-color-orangeDark"></i> Error 404! 页面未找到.</h4>');
			}
		});

	}	
	
	// UPDATE BREADCRUMB
	function drawBreadCrumb() {
		var nav_elems = $("#sidebar .nav li.active > a");
		var count = nav_elems.length;
		
		$.bread_crumb.empty();
		$.bread_crumb.append("<li><i class='icon-home home-icon'></i><a href='javascript:void(0);' onclick=" + "openInnerPage('pages/main/main.jsp');" + ">首页</a></li>");
		nav_elems.each(function(){
			$.bread_crumb.append($("<li></li>").html("<a href='javascript:void(0);'>" + $.trim($(this).clone().children(".badge").remove().end().text()) + "</a>"));
			// update title when breadcrumb is finished...
			if (!--count){
				var text = $.bread_crumb.find("li:last-child").text();
				$.bread_crumb.find("li:last-child").html(text);
				document.title = text;
			}
		});
	}	
	
	//init Menus
	function initMenus(menus){
		
		function getSubMenus(jItem, menu){
			//console.log("现在的jItem: " + jItem.get(0).outerHTML);
			var subMenus = menu["subMenu"];
			var menuNo = menu["menuNo"];
			if(subMenus && subMenus.length > 0){
				//给ul.submenu额外的再标记一个menuNo变量，来唯一标识它，这样所有子菜单在append的时候就能根据parentNo来找到对应的ul了
				var ul = "<ul class='submenu" + " n_" + menuNo + "'></ul>";
				var toggleClass = "dropdown-toggle";
				var iconDownHtml = "<b class='arrow icon-angle-down'></b>";
				var lastLi = jItem.find("li").size() == 0 ? jItem : jItem.find("li").slice(-1);//寻找到节点中最后一个li
				lastLi.append(ul);
				lastLi.find("a").addClass(toggleClass);
				lastLi.find("a").append(iconDownHtml);
				
				//console.log("现在的jItem: " + jItem.get(0).outerHTML);
				//console.log(jItem.text() + "存在子菜单," + "开始拼接第" + (jItem.find("ul").size() + 1) + "级菜单");
				for(var i = 0; i < subMenus.length; i ++){
					var subMenu = subMenus[i];
					var subMenuName = subMenu["menuName"];
					var parentNo = subMenu["parentNo"];
					var subMenuClass = subMenu["menuClass"] ? subMenu["menuClass"] : "icon-double-angle-right";
					jItem.find(".submenu" + ".n_" + parentNo).append(
						"<li>" +
							"<a href='javascript:void(0);'>" +
								"<i class='" + subMenuClass + "'></i>" + subMenuName + 
							"</a>" + 
						"</li>"
					);
					//console.log("现在的jItem: " + jItem.get(0).outerHTML);
					getSubMenus(jItem, subMenu);//递归
				}
			}else{
				//console.log(jItem.text() + "无子菜单");
				var menuUrl = menu["menuUrl"];
				var lastLi = jItem.find("li").size() == 0 ? jItem : jItem.find("li").slice(-1);//寻找到节点中最后一个li
				lastLi.find("a").attr("href", menuUrl);
				lastLi.find("a").attr("data-m", menuNo);
			}
		}
		
		if(menus){
			for(var i = 0; i < menus.length; i ++){
				var menu = menus[i];
				var menuName = menu["menuName"];
				var menuClass = menu["menuClass"] ? menu["menuClass"] : "icon-text-width";
				var jItem = $(
					"<li>" +
						"<a href='javascript:void(0);'>" + 
							"<i class='" + menuClass + "'></i>" + 
							"<span class='menu-text'> " + menuName + " </span>" + 
						"</a>" + 
					"</li>");
				//递归
				getSubMenus(jItem, menu);
				$(".nav.nav-list").append(jItem);
				
			}
		}		
		
	}	