
/**
 * 公共的js,options等
 */


	/*******************************异步加载一个页面到指定元素上************************************/
	//打开内部页面,href表示内部页面的全限定路径
	function openInnerPage(href, param){
		href = setUrlParams(href, param);
		window.location.hash = href;
	}
	
	/*****************************jqgrid****************************/

	//应用默认的jqgrid配置
	var _defaultJqGridOptions = {
		datatype: "json",//从服务器端返回的数据类型
		mtype: 'POST',//提交方式
		height: 350,//表格高度
		autowidth: true,//默认值为false。如果设为true，则Grid的宽度会根据父容器的宽度自动重算。重算仅发生在Grid初始化的阶段；
		multiselect: true, //定义是否可以多选
        multiboxonly: true,	//只有当multiselect = true.起作用，当multiboxonly 为ture时只有选择checkbox才会起作用
		rowNum:10,//在grid上显示记录条数，这个参数是要被传递到后台
		rowList:[10,20,30],//一个下拉选择框，用来改变显示记录数，当选择时会覆盖rowNum参数传递到后台
		pager: '#grid-pager',//定义翻页用的导航栏，必须是有效的html元素。翻页工具栏可以放置在html页面任意位置
		viewrecords: true,//定义是否要显示总记录数
		caption:"查询表格",//表格名称
		
		jsonReader: {//用来设定如何解析从Server端发回来的json数据
			root: "rows", // json中代表实际模型数据的入口
			page: "page", // json中代表当前页码的数据
			total: "pages", // json中代表页码总数的数据
			records: "total", // json中代表数据行总数的数据
			repeatitems: false // 如果设为false，则jqGrid在解析json时，会根据name来搜索对应的数据元素（即可以json中元素可以不按顺序）；
			                   //而所使用的name是来自于colModel中的name设定。
		},
		
		prmNames : {//用于设置jqGrid将要向Server传递的参数名称
			page: "currentPage", // 表示请求页码的参数名称
			rows: "pageSize"  // 表示请求行数的参数名称
		},
		
		loadComplete : function() {//当从服务器返回响应时执行
			var table = this;
			setTimeout(function(){
				updateJqGridPagerIcons(table);
				updateJqGridSubGridIcons(table);
				//enableTooltips(table);
			}, 0);
		}
		
	};
	
	
	//replace icons with FontAwesome icons like above
	function updateJqGridPagerIcons(table) {
		
		var replacement = 
		{
			'ui-icon-seek-first' : 'icon-double-angle-left bigger-140',
			'ui-icon-seek-prev' : 'icon-angle-left bigger-140',
			'ui-icon-seek-next' : 'icon-angle-right bigger-140',
			'ui-icon-seek-end' : 'icon-double-angle-right bigger-140'
		};
		$('.ui-pg-table:not(.navtable) > tbody > tr > .ui-pg-button > .ui-icon').each(function(){
			var icon = $(this);
			var $class = $.trim(icon.attr('class').replace('ui-icon', ''));
			
			if($class in replacement) icon.attr('class', 'ui-icon '+replacement[$class]);
		});
	}	

	//replace icons with FontAwesome icons like above
	function updateJqGridSubGridIcons(table) {
		
		var replacement = 
		{
			'ui-icon-plus' : 'icon-plus',
			'ui-icon-minus' : 'icon-minus',
			'ui-icon-carat-1-sw' : 'icon-level-down icon-flip-horizontal'
		};
		$('.ui-jqgrid-btable > tbody > tr > .ui-sgcollapsed > a > .ui-icon').each(function(){
			$(this).css("position", "relative");
			var icon = $(this);
			var $class = $.trim(icon.attr('class').replace('ui-icon', ''));
			if($class in replacement) icon.attr('class', 'ui-icon '+replacement[$class]);
		});	
		
		$('.ui-jqgrid-btable > tbody > tr.ui-subgrid > td.subgrid-cell > .ui-icon').each(function(){
			$(this).css("position", "relative");
			$(this).css("left", "8px");
			var icon = $(this);
			var $class = $.trim(icon.attr('class').replace('ui-icon', ''));
			if($class in replacement) icon.attr('class', 'ui-icon '+replacement[$class]);
		});		
	}
	
	//改变删除dialog的样式
	function beforeDeleteCallback(e) {
		var form = $(e[0]);
		if(form.data('styled')){
			return false;
		}
		form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
		style_delete_form(form);
		form.data('styled', true);
	}
	
	//改变删除dialog的样式
	function style_delete_form(form) {
		var buttons = form.next().find('.EditButton .fm-button');
		buttons.addClass('btn btn-sm').find('[class*="-icon"]').remove();//ui-icon, s-icon
		buttons.eq(0).addClass('btn-danger').prepend('<i class="icon-trash"></i>');
		buttons.eq(1).prepend('<i class="icon-remove"></i>')
	}	
	
	
	//Tooltip控件
	function enableTooltips(table) {
		$('.navtable .ui-pg-button').tooltip({container:'body'});
		$(table).find('.ui-pg-div').tooltip({container:'body'});
	}
	
	
	//使返回的配置项继承于默认的jqgrid options
	function jqGridOption(options){
		
		return $.extend(true, {}, _defaultJqGridOptions, options);
	}
	
	//jqgrid查询方法
	function jqGridQuery(tableId, postData){
		
		$(tableId).jqGrid('setGridParam',{"postData": postData}).trigger("reloadGrid");
	}
	
	//jqgrid行按钮
	function initCustomAct(gridTable, actClick, actHtmls){
		if(!actHtmls){
			actHtmls =
				"<div style='margin-left: 8px;'>" + 
					"<div class='ui-pg-div' style='float:left; curosr: pointer;'><span class='ui-icon icon-pencil blue'></span></div>" + 
					"<div class='ui-pg-div' style='float:left; curosr: pointer; margin-left: 5px;'><span class='ui-icon icon-trash red'></span></div>" + 
				"</div>";			
		}
		var ids = $(gridTable).jqGrid('getDataIDs');
		for(var i = 0; i < ids.length; i++){
			var id = ids[i];//rowId
			$(gridTable).jqGrid('setRowData', ids[i], {'_act' : actHtmls});
			actClick(i, id);
		}		
	}
	
	
	
	
	
	
	
	
	
	/*****************************jquery-ui*************************************/
	
	//jquery-ui-dialog默认配置参数
	var _defaultDialogOptions = {
			autoOpen: false,
			width: 1200,
			height: 600,
			modal: true,
			title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-ok'></i> " + "</h4></div>",
			title_html: true,
			beforeClose: function(){
				$(this).empty();
				$(this).dialog("destroy"); 
			},
			buttons: [ 
				{
					text: "关闭",
					"class" : "btn btn-xs",
					click: function() {
						$( this ).dialog( "close" ); 
					} 
				}
			]			
	}
	
	//使返回的配置项继承于默认的jquery-ui-dialog options
	function dialogOption(options){
		
		return $.extend(true, {}, _defaultDialogOptions, options);
	}

	//override dialog's title function to allow for HTML titles
	(function(){
		if($.ui && $.ui.dialog){
			$.widget("ui.dialog", $.extend({}, $.ui.dialog.prototype, {
				_title: function(title) {
					var $title = this.options.title || '&nbsp;'
					if( ("title_html" in this.options) && this.options.title_html == true )
						title.html($title);
					else title.text($title);
				}
			}));
		}		
		
	})();
	

	/****************************gritter********************************/
	if($.gritter){
		$.gritter.options = {
			fade_in_speed: 'fast',
			fade_out_speed: 400,
			time: 3000
		};
	}
	
	//jquery-gritter消息框
	function addGritter(level, content, after_open, after_close){
		
		var title = 
		{
			"info" : '提示',
			"success" : '成功',
			"warning" : '警告',
			"error" : '错误'
		};
		
		var titleContent = "";
		if(level in title){
			titleContent = title[level];
		}
		
		$.gritter.add({
			title: titleContent,
			text: content,
			class_name: "gritter-" + level,
			after_open: after_open,
			after_close: after_close
		});		
		
	}
	
	
	/****************************overlay********************************/
	//打开遮罩层
	function showOverlay(selector, option){
		if(!selector){
			selector = $.page_content_name;
		}
		var $box = $(selector);
		if($box.css('position') == 'static') {
			$box.addClass('position-relative');
		}
		//var iconLoading = '<i class="icon-spinner icon-spin icon-2x orange"></i>';
		var iconLoading = '<i class="default_loading_icon"></i>';
		if(option && option.icon){
			iconLoading = '<i class="' + option.icon + '"></i>';
		}
		$box.append('<div class="box-overlay"><h1 class="text-center align-center">' + iconLoading + '</h1></div>');
		
	}
	
	//关闭遮罩层
	function closeOverlay(selector){
		if(!selector){
			selector = "body";
		}
		var $box = $(selector);
		$box.find('.box-overlay').remove();
		$box.removeClass('position-relative');
	}
	
	
	/****************************jquery-ui-datepicker********************************/
	var _defaultDatePickerOptions = {
		dateFormat: "yy-mm-dd",
		showOtherMonths: true,
		selectOtherMonths: true,
		beforeShow: function () { 
			setTimeout(function () { 
				$("#ui-datepicker-div").css("z-index", 9999);
			}, 100 ); 
		},
		onClose:function(){
			$(this).blur();
		}
	}	
	
	//使返回的配置项继承于默认的options
	function datePickerOption(options){
		
		return $.extend(true, {}, _defaultDatePickerOptions, options);
	}		
	
	
	
	/****************************jquery-validate********************************/
	
	if($.validator){
		$.validator.messages = {
			required: "此输入项为必填项",
			remote: "请检查此输入项",
			email: "请输入一个有效的邮件地址",
			url: "请输入一个有效的URL。",
			date: "请输入一个有效的日期",
			dateISO: "请输入一个有效的日期(ISO)",
			number: "请输入一个有效的数字",
			digits: "入一个有效的数字",
			creditcard: "请输入一个有效的身份证ID",
			equalTo: "请再次输入相同的内容",
			maxlength: $.validator.format("请输入一个不超过{0}位的字符"),
			minlength: $.validator.format("请输入一个不小于{0}位的字符"),
			rangelength: $.validator.format("请输入一个长度在 {0} 和 {1} 位之间的字符"),
			range: $.validator.format("请输入一个在 {0} 和 {1} 之间的字符"),
			max: $.validator.format("请输入一个小于等于 {0}的值"),
			min: $.validator.format("请输入一个大于等于 {0}的值")
		}
	}
	
	//默认的jquery-validate配置参数
	var _defaultValidateOptions = {
		onsubmit: false,//默认不在submit()事件时触发验证
		errorElement: 'div',
		errorClass: 'help-block',
		ignore: ".ignore",
		//错误信息摆放的位置
		errorPlacement: function ($error, element) {
			var controls = element.closest('div[class*="col-"]');
			controls.append($error);
		},
		//验证非法后的处理
		invalidHandler: function (event, validator) { 
			var errNum = validator.numberOfInvalids();
			if(errNum){
				addGritter("warning", "此表单中有" + errNum + "项输入非法，无法提交，请检查");
			}
		},
		//控件验证错误时如何高亮
		highlight: function (element, errorClass, validClass) {
			$(element).closest(".form-group").removeClass("has-info").addClass("has-error");
		},
		//控件验证成功时的处理
		success: function($error, element){
			$(element).closest('.form-group').removeClass('has-error').addClass('has-info');
			$error.remove();
		}
	}
	
	//使返回的配置项继承于默认的jquery-validate options
	function jValidateOption(options){
		
		return $.extend(true, {}, _defaultValidateOptions, options);
	}	
	
	
	/****************************mustache********************************/	
	
	/**
	 * 解析mustache模版
	 * 1.options: 参数
	 * selector: 目标节点,
	 * data: 模版数据(json对象),
	 * url: 模版路径,
	 * extend: 额外的数据扩展(json对象),
	 * partial: 子模版参数{json对象}
	 * 如下:
	 * {
	 * 	"selector": ".tabbable",
	 * 	"data": data,
	 * 	"url": "pages/mst/travelMg/ticket/ticket_list/ticket_list.mst",
	 * 	"extend": extend,
	 * 	"partial": {
	 * 		"ticket_date": "pages/mst/travelMg/ticket/ticket_list/ticket_date.mst",
	 * 		"ticket_list_body": "pages/mst/travelMg/ticket/ticket_list/ticket_list_body.mst"
	 * 	}
	 * }
	 * 2.callback: 回调函数
	 * 
	 */
	function mstRender(options, callback){
		
		if(options && typeof options === 'object'){
			var selector = options.selector;
			var data = options.data;
			var templeteUrl = options.url;
			var templeteSelector = options.templete;
			var extend = options.extend;
			var partial = options.partial;
			
			var d = new Date();
			var rendered = "";
			if(templeteSelector){
				var tempHtml = $(templeteSelector).html();
				$.extend(true, data, extend);
				data = data ? data : {};
				rendered = Mustache.render(tempHtml, data);
		    	if(selector){
		    		$(selector).html(rendered);
		    	}
		    	if(callback){//回调
		    		callback(rendered);
		    	}				
			}else{
				$.ajax({
					async: false,
					type: "GET",
					url: templeteUrl,
					data: "_t=" + d.getTime(),
					success: function(tpl){
						$.extend(true, data, extend);//深度拷贝是否需要?
						data = data ? data : {};//return {} if data is invalid
				    	Mustache.parse(tpl);
				    	//partial options 子模版
				    	if(partial && typeof partial === 'object'){
				    		$.each(partial, function(name, url){
					    		$.ajax({
					    			async: false,//由于在循环里，这里使用同步请求
					    			type: "GET",
					    			url: url,
					    			data: "_t=" + d.getTime(),
					    			success: function(pTpl){
					    				partial[name] = pTpl;
					    			}
					    		});		    			
				    		});
				    	}
				    	rendered = Mustache.render(tpl, data, partial);
				    	if(selector){
				    		$(selector).html(rendered);
				    	}
				    	if(callback){//回调
				    		callback(rendered);
				    	}
					}
				});				
			}
			return rendered;
		}
	}
	
	
	/****************************iframe相关********************************/	
	
	//iframe内部调用: iframe内部发生高度变化时(如form validate验证后),调用此方法来调整高度
	function adjustIframeHeight(){
		var $iframe = $("#page-content-iframe", parent.document);
		var pageContentHeight = $(document).find("body").height();
		$iframe.height(pageContentHeight);
	}	
	
	//iframe加载时,或parent发生resize事件时，调用此方法
	function adaptIframeHeight(){
		var $iframe = $("#page-content-iframe");
		if($iframe.size() > 0){
			var pageContentHeight = $iframe.contents().find("body").height();
			$iframe.height(pageContentHeight);
		}		
	}
	
	
	/****************************获取url后面拼接的参数********************************/	
	
	//获取url后面拼接的参数
	function getUrlParams(key, url){
		var params = {};
		var url = url ? url : window.location.href;
		var pos = url.lastIndexOf("?");
		if(pos > 0){
			var paraStr = url.substring(pos + 1);
			var params = _convertParaStrToObject(paraStr);
			if(params){
				return key ? params[key] : params;
			}
		}else{
			return "";
		}
	}	
	
	//设置url参数
	function setUrlParams(url, params){
		if(url && params){
			var str = "";
			if(typeof params === 'string'){
				str = params;
			}
			if(typeof params === 'object'){
				$.each(params, function(key, value){
					if(key && value){
						if(typeof value === 'object'){
							value = JSON.stringify(value);
						}
						str += key + "=" + encodeURI(value) + "&";
					}
				});
			}
			if(url.indexOf("?") != -1){
				url += "&" + str;
			}else{
				url += "?" + str;
			}
		}
		return url;
	}
	
	//将url参数(如：name=jack&age=18&sex=1)转换为json对象
	function _convertParaStrToObject(paraStr){
		if(paraStr){
			var params = {};
			var arr = paraStr.split("&");
			for(var i = 0; i < arr.length; i ++){
				if(arr[i]){
					var para = arr[i].split("=");
					if(para && para.length == 2){
						params[para[0]] = decodeURI(para[1]);
					}
				}
			}
			return params;		
		}
	}
	
	//得到表单参数,利用formSerialize()方法序列化表单，然后再次解析，转换成json对象
	function getFormParams($form){
		if($form){
			var paraStr = $form.formSerialize();
			return _convertParaStrToObject(paraStr);
		}
	}
	
	//与在浏览器点击后退按钮相同
	function goBack(){
		window.history.back();
	}
	
	
	/**************************城市popover*******************************/
	
	function cityPopover(options){
		
		if(options && typeof options === 'object'){
			var selector = options.selector;
			var title = options.title ? options.title : "<b>支持中文/拼音/简拼输入</b>";
			var template = options.template ? options.template : '<div class="popover cityPopover"><div class="arrow"></div><h3 class="popover-title"></h3><div class="popover-content"></div></div>';
			var placement = options.placement ? options.placement : "bottom";
			
			var cityBody = options.cityBody ? options.cityBody : "#cityBody";
			var cityContent = options.cityContent ? options.cityContent : "#cityContent";
			var mstUrl = options.mstUrl ? options.mstUrl : "pages/mst/common/city/city.mst";
			var convert = options.convert;
			var closeing = options.closeing;
			
			//城市popover
			$(selector).popover({
				"template": template,
				"html": true,
				"title": function(){
					return title;
				},
				"content": function(){
					var $body = $(cityBody).clone().removeClass("hide");
					var cityHtml = mstRender({"url": mstUrl});
					$body.find(cityContent).html(cityHtml);
					return $body;
				},
				"placement": placement
			});				
			
			//初始化:shown.bs.popover
			$(selector).on("shown.bs.popover", function(){
				$(cityBody).find(".cityNav li:first > a").trigger("click");
			});			
			
			//cityPopover事件
			$(selector).parent().on("click", ".cityNav li > a", function(){
				var actived = $(this).parent("li").is(".active");
				if(!actived){
					var params = $(this).data("params");
					var hot = $(this).data("hot");
					var d = new Date();
					//缓存数据
					//$.get("pages/mst/common/city/data/city_data.json", {"_t": d.getTime()},function(data){
					//	data = $.parseJSON(data);
					$.get("common_dict.dict?hqlKey=" + params, {"_t": d.getTime()}, function(data){
						if(data){
							//转为通用数据
							if(convert){
								convert(data);
							}
							//对数组进行整理和拆分,5个1行
							function getSortedList(list){
								var sortedList = [];
								if(list){
									var items = [];
									for(var i = 0; i < list.length; i ++){
										items.push(list[i]);
										if((i + 1) % 5 == 0){//5个为1组
											sortedList.push({"items": items});
											items = [];
										}
									}
									if(items.length != 0){//最后一组余下的
										sortedList.push({"items": items});
									}
									return sortedList;
								}
							}
							
							//是否是热门城市
							data["hot_city"] = hot == "1" ? true : false;
							
							var list = data.list;
							//如果点击的不是热门城市，则需要字母排序
							if(!data["hot_city"]){
								//alphList
								var alphList = [];
								$.each(list, function(index, listItem){
									var alphName = listItem.firstWord;
									if(alphName){
										var exist = false;
										$.each(alphList, function(index, alph){
											if(alph["alphName"] == alphName){
												exist = true;
												alph["sortedList"].push(listItem);
											}
										});
										if(!exist){
											alphList.push({"alphName": alphName, "sortedList": [listItem]});
										}
									}										
								});
								
								$.each(alphList, function(index, alph){
									alph["sortedList"] = getSortedList(alph["sortedList"]);
								});
								data["sortedAlphList"] =  alphList;//整理后的字母表数组
							}else{
								//否则，不需要字母排序数组
								data["sortedList"] =  getSortedList(list);
							}
							
							//log(data);
							
							//render #cityContent
							mstRender({"selector": cityContent, "data": data, "url": mstUrl}, function(){
								$(".cityTable td").click(function(){
									var itemObject = {};
									$(this).find("input[type='hidden']").each(function(){
										var name = $(this).attr("name");
										var value = $(this).val();
										itemObject[name] = value;
									});
									//log("itemObject");
									//log(itemObject);
									
									var $popoverInput = $(this).closest(".cityPopover").prev("input");
									//关闭popover之后执行的事件
									closeing($popoverInput, itemObject);
									$popoverInput.popover("hide");
									$(".cityPopover").remove();
								});
							});
							
						}
					});
				}
			});			
		}
	}
	
	
	/*************日志相关********************/
	function log(object){
		if($.devMode){
			if(window.console && window.console.log){
				//console.trace();
				console.log(object);
			}
		}
	}
	
	
	//获取用户session
	function getUserInfo(callback){
		if($._userInfo){
			if(callback){
				callback($._userInfo);
			}
			return;
		}
		getJson("get_gmoa_user.action", function(data){
			if(data){
				$._userInfo = data;
				if(callback){
					callback($._userInfo);
				}
			}
		});	
	}	
	
	//用户登出时删除用户session
	function removeUserInfo(){
		if($._userInfo){
			delete $._userInfo;
		}
	}
	
	
	/************doGet/doPost/doAjax/getJSON********************/
	function doGet(url, data, callback, dataType){
		return _doRequest(url, data, callback, dataType, "get");
	}
	
	function doPost(url, data, callback, dataType){
		return _doRequest(url, data, callback, dataType, "post");
	}
	
	function doAjax(options){
		return _doRequest(options);
	}
	
	function getJson(url, data, callback){
		if ($.isFunction(data)) {
			callback = data;
			data = undefined;
		}
		var options = {"url": url, "data": data, "success": callback, "overlay": false, "dataType": "json"};
		return doAjax(options);
	}
	
	//do request
	function _doRequest(url, data, callback, dataType, method){
		log("----------do request----------");
		var options = {};
		options["overlay"] = true;//遮罩开关，默认doGet/doPost请求都会开启、关闭遮罩
		options["checkError"] = true;//自动检查返回的错误信息，默认为true
		options["method"] = method ? method : "post";
		
		if(url && typeof url === 'object'){
			$.extend(options, url);
		}else if ( jQuery.isFunction( data ) ) {
			// shift arguments if data argument was omitted
			options["url"] = url;
			options["dataType"] = dataType || callback;
			options["success"] = data;
			options["data"] = undefined;
		}else{
			options["url"] = url;
			options["data"] = data;
			options["success"] = callback;
			options["dataType"] = dataType;
		}
		
		//requesting
		var jqxhr = _reqing(options);
		
		//success
		_reqDone(options, jqxhr);
		
		//fail
		_reqFail(options, jqxhr);

		//finally
		_reqAlways(options, jqxhr);
		
		return jqxhr;
	}
	
	//发送请求
	function _reqing(options){
		//开启遮罩
		if(options["overlay"]){
			showOverlay();
		}
		
		log("url:" + options["url"]);
		log("请求参数:");
		log(options["data"]);
		
		log("requesting...");
		return $.ajax({
			"url": options["url"],
			"type": options["method"],
			"dataType": options["dataType"],
			"data": options["data"]
		});		
	}
	
	//请求执行success
	function _reqDone(options, jqxhr){
		jqxhr.done(function(data){
			//checkError
			if(options["checkError"]){
				log("jqxhr.done, check if exists exception...");
				if(data){
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
					if(data.exception){
						addGritter("error", data.exception);
						return;
					}
				}
			}
			log(">>>>>>>do callback<<<<<<<");
			options["success"](data);
			log(">>>>>>>end callback<<<<<<<");	
		});				
	}
	
	//请求执行fail
	function _reqFail(options, jqxhr){
		jqxhr.fail(function(){
			addGritter("error", "系统发生异常，请联系管理员");
		});		
	}
	
	//请求执行最后finally
	function _reqAlways(options, jqxhr){
		jqxhr.always(function(){
			if(options["overlay"]){
				closeOverlay();
			}
			log("---------end request-----------");
		});		
	}
	
	
	//cookie相关
	function setCookie(name, value, expireDays){
		var exp  = new Date();  
		if(expireDays) {
			exp.setTime(exp.getTime() + expireDays*24*60*60*1000);
		} else {
			exp.setTime(exp.getTime() + 30*24*60*60*1000);//缺省30天
		}
		document.cookie = name + "=" + escape (value) + ";expires=" + exp.toGMTString();
	}
	
	function getCookie(name){
		var arr = document.cookie.match(new RegExp("(^| )"+name+"=([^;]*)(;|$)"));
		 if(arr != null) return unescape(arr[2]); return null;
	}
	
	function delCookie(name){
		var exp = new Date();
		exp.setTime(exp.getTime() - 1);
		var cval = getCookie(name);
		if(cval!=null) document.cookie = name + "=" + cval + ";expires=" + exp.toGMTString();
	}				
	
	
	//分页
	function pag(options){
		
		if(options && typeof options === 'object'){
			var container = options.container ? options.container : "body";
			var doPage = options.doPage;
			
			//当前页
			var currentPage = $(container).find("[name='currentPage']").val();
			currentPage = parseInt(currentPage);
			//最大页
			var maxPage = $(container).find("[name='pages']").val();
			maxPage = parseInt(maxPage);
			
			//上一页按钮
			var $previous = $(container).find(".pager .previous");
			if(currentPage > 1){
				$previous.click(function(){
					currentPage --;
					doPage(currentPage);
				});
			}else{
				$previous.addClass("disabled");
			}
			
			//下一页按钮
			var $next = $(container).find(".pager .next");
			if(currentPage < maxPage){
				$next.click(function(){
					currentPage ++;
					doPage(currentPage);
				});			
			}else{
				$next.addClass("disabled");
			}
			
		}
	}
	//分页插件
	(function($){
		
		function JPage(element, options){
			this.options = options;
			this.$element = $(element);
			this.path = this.options.path;
		}
		
		JPage.DEFAULTS = {
			"path": "pages/document/view/jpag/",
			"themes": [
	          {"name": "theme1", "mst": "theme1.html", "disabled-class": "disabled"},
	          {"name": "theme2", "mst": "theme2.html", "disabled-class": "disabled", "active-class": "active", "range": 5},
	          {"name": "theme3", "mst": "theme3.html", "disabled-class": "disabled"}
			],
			"style": "theme3"
		};
		
		JPage.prototype = {
			"setOptions": function(options){
				this.options = options;
			},
			//获取模版路径
			"getPagePath": function(){
				var theme = this.getCurrentTheme();
				return this.path + theme.mst;
			},
			//获取当前主题
			"getCurrentTheme": function(){
				var style = this.options["style"];
				var theme = null;
				$.each(this.options["themes"], function(i, item){
					if(item.name == style){
						theme = item;
					}
				});
				if(!theme){
					log("找不到主题名为[" + style + "]的主题,无法加载分页插件");
					return;
				}
				return theme;
			},
			//设置额外class
			"setAdditionalClass": function(){
				var cls = this.options["additional-class"];
				cls && this.$element.find(".jp-pag").addClass(cls);
			},
			//得到分页数据
			"getPagData": function(){
				var pagData = {};
				var $element = this.$element;
				var attributes = ["currentPage", "pages", "total", "pageSize"];
				$.each(attributes, function(i, key){
					var value = $element.find("[name='" + key + "']").val();
					value = value ? parseInt(value) : 0;
					pagData[key] = value;
				});
				return pagData;
			},
			//跳转事件
			"bindJumpEvent": function(selector, enabled, pageIndex, param, complete, afterEvent){
				if(!this.checkSelector(selector)){
					return;
				}
				var $selector = this.$element.find(selector);
				if($selector){
					if(enabled){
						var self = this;
						$selector.click(function(){
							param["currentPage"] = pageIndex;
							self.show(param, complete);
							typeof afterEvent === "function" && afterEvent.call($selector);
						});
					}else{
						$selector.addClass("jp-disabled");
						var theme = this.getCurrentTheme();
						var disabledClass = theme["disabled-class"];
						disabledClass && $selector.addClass(disabledClass);
					}	
				}
			},
			//页数按钮事件
			"bindPagEvent": function(selector, param, complete){
				if(!this.checkSelector(selector)){
					return;
				}
				var pagData = this.getPagData();
				var currentPage = pagData["currentPage"];
				var firstPage = 1;
				var lastPage = pagData["pages"];
				
				this.$element.find(selector + ":gt(0)").remove();
				var $pagBtn = this.$element.find(selector).addClass("jp-hidden");
				
				var theme = this.getCurrentTheme();
				var range = theme.range;
				var activeClass = theme["active-class"];
				
				var bg = firstPage, ed = lastPage;
				if(ed > range){
					bg = currentPage - parseInt(range / 2);
					if(bg < 1){
						bg = 1;
					}
					ed = bg + range - 1;
					if(ed > lastPage){
						ed = lastPage;
						bg = ed - range + 1;
					}
				}
				for(var i = bg; i <= ed; i ++){
					var $tmp = $pagBtn.clone().removeClass("jp-hidden");
					$tmp.find(".jp-paging-value").html(i);
					if(i == currentPage){
						$tmp.addClass("jp-current");
						activeClass && $tmp.addClass(activeClass);
					}
					this.$element.find(selector + ":last").after($tmp);
					this.bindJumpEvent($tmp, true, i, param, complete, function(){
						this.addClass("jp-current");
						activeClass && this.addClass(activeClass);
					});
				}
				$pagBtn.remove();
			},
			//输入控件
			"bindInputEvent": function(selector, param, complete){
				if(!this.checkSelector(selector)){
					return;
				}
				var $pageInput = this.$element.find(selector);
				$pageInput.keyup(function(event){
					var val = $(this).val();
					log(val/1);
					val = val/1 ? (val > lastPage ? lastPage : val) : (val == 0 ? "" : currentPage);
					$(this).val(val);
					if(event.keyCode == 13){
						param["currentPage"] = val;
						self.show(param, complete);
					}
				});				
			},
			//检查是否有此节点
			"checkSelector": function(selector){
				if(this.$element.find(selector).length > 0){
					return true;
				}
			},
			//初始化
			"show": function(param, complete){
				var self = this;
				var options = this.options;
				
				doPost(options.url, param, function(data){
					var containerOption = {"selector": options.container, "data": data, "extend": options.extend};
					var templete = options.templete.indexOf("#") == 0 ? {"templete": options.templete} : {"url": options.templete};
					$.extend(containerOption, templete);
					//container
					mstRender(containerOption, function(){
						//paper
						mstRender({"selector": self.$element, "data": data, "url": self.getPagePath()}, function(){
							
							//设置额外class
							self.setAdditionalClass();
							
							var pagData = self.getPagData();
							var currentPage = pagData["currentPage"];//当前页
							var firstPage = 1;//首页
							var lastPage = pagData["pages"];//末页
							
							//箭头按钮
							self.bindJumpEvent(".jp-previous", currentPage > firstPage, currentPage - 1, param, complete);//上一页
							self.bindJumpEvent(".jp-next", currentPage < lastPage, currentPage + 1, param, complete);//下一页
							self.bindJumpEvent(".jp-first", currentPage > firstPage, firstPage, param, complete);//首页
							self.bindJumpEvent(".jp-last", currentPage < lastPage, lastPage, param, complete);//末页
							
							//页数按钮
							self.bindPagEvent(".jp-paging-item", param, complete);
							
							//输入控件
							self.bindInputEvent("[name='jp-page-input']", param, complete);
							
							//complete
							typeof complete === "function" && complete(data);
						});
					});						
				}, "json");
			}
		};
		
		// JPage PLUGIN DEFINITION
		// =======================	
		var old = $.fn.JPage;
		
		$.fn.jPage = function(option, param, complete){
			return this.each(function(){
				var $this = $(this);
				var instance = $this.data("inesa.jPage");
				var options = $.extend(true, {}, JPage.DEFAULTS, typeof option == "object" && option);
				if(!instance){
					$this.data("inesa.jPage", (instance = new JPage(this, options)));
				}
				instance.show(param, complete);
			});
		};
		
	})(window.jQuery);
	
