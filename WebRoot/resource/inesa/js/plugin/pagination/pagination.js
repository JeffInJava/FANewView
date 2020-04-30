/**
 * @author liuheng
 * 2011/12/2
 */
(function($){
	
	$.fn.pagination = function(options) {
		
		var defaults = {
				url:"",
				params:{},
				templateId:"",//需要替换成模板的Html段的id
				templateUrl:"",//模板路径
				templateOptions:{},//模板框架的属性
				linePageMaxNumber:5,//每行页数
				rowCheckField:null,//选中的属性
				allRowCheckField:false,//全选按钮
				
//				例子:rowCheckField='column0'
				columns:[]//列定义
//				         例子: columns= [{
//								field : 'column0',
//								type : 'text',//text,checkbox,custom
//				         		content: '',//与type=custom联合使用
//								displayName : '交易日期',
//								hide:false				         
//							}]

		};

		var settings = $.extend({},defaults,options);	
		var _currentPage=1;
		var callback=settings.callback;
		var clickRow=settings.clickRow;
		
		//得到记录
		$.fn.getResult=function(){
				var self=this;
				var url=settings.url;
				if(url.indexOf("?")>-1)url=url+"&";
				else url=url+"?";
				url=url+"currentPage="+_currentPage;
				$.post(
					url,
					settings.params,
					function(data) {
						if(data.exception){
							alert(data.exception);
							return;
						}
						
						var columns=settings.columns;
						
						if(settings.templateId.length>0&&settings.templateUrl.length>0){//模板渲染模式
							mstRender({
								"selector":"#"+settings.templateId, 
								"data": data,
								"url": settings.templateUrl, 
								"extend":settings.templateOptions
							},
							function(){
								$("#"+settings.templateId).append(self.getPagination(data));
							});
							
						}else{//bootstrap表格模式
							var $table=$("<table class=\"table table-bordered table-hover\"></table>");
							var $thead=$("<thead></thead>");
							var $theadTr=$("<tr></tr>");
							
							for(var j=0;j<columns.length;j=j+1){
								var th="<th>"+columns[j].displayName+"</th>\n";
								if(!columns[j].hide){
									$theadTr.append(th);
								}
							}
							$thead.append($theadTr);
							$table.append($thead);
							
							var $tbody=$("<tbody></tbody>");
							
							for(var i=0;i<data.rows.length;i=i+1){
								var $tr=$("<tr class=\"btsTr\"  ></tr>");
								if(settings.rowCheckField!=null){
									$tr.append("<input type=\"hidden\" name=\""+settings.rowCheckField+"\" value=\""+data.rows[i][settings.rowCheckField]+"\"  />\n");
								}
								for(var j=0;j<columns.length;j=j+1){
									var $td=$("<td class='"+columns[j].field+"TdClass' ></td>");
									if(columns[j].type=='text'){
										$td.append("<input type=\"text\" name=\""+columns[j].field+"\" value=\""+data.rows[i][columns[j].field]+"\" >");
									}else if(columns[j].type=='checkbox'){
										$td.append("<input type=\"checkbox\" name=\""+columns[j].field+"\" value=\""+data.rows[i][columns[j].field]+"\"/>");
									}else if(columns[j].type=='custom'){//自定义
										$td.append(columns[j].content);
									}else{
										if(!columns[j].hide){
											$td.append(data.rows[i][columns[j].field]);
										}
									}
									$tr.append($td);
								}
								//行点击回调方法
								if(clickRow){
									var rowsData=data.rows[i];
									$tr.css({"cursor":"pointer"});
									var $trObj=$tr;
									(function(pdata,trObj){
										$tr.click(function(){
											clickRow(pdata,trObj);
										});
									})(rowsData,$trObj);
								}
								$table.append($tr);
							}
							var $div=$("<div class=\"table-responsive\"></div>");
							
							$div.append($table);
							
							var $pag=$(self.getPagination(data));
							
							self.html($div.add($pag));
						}
						if(callback){
							callback(data);
						}
					});		
		};
		
		//改变当前页
		$.fn.changepage=function(currentPage){
			_currentPage=currentPage;
			$(this).getResult();
		};
		
		//得到分页栏
		$.fn.getPagination=function(data){
			var totalPages=data.pages;//总页数
			var totalRowSizes=data.total;//总记录条数

			//pre page
			var prePage="";
			if(_currentPage>1){
				prePage="<li><a href=\"javascript:\" onclick=\"javascript:$('#"+$(this).attr("id")+"').changepage("+(parseInt(_currentPage)-1)+");\" >&laquo;</a></li>";
			}

			//next page
			var nextPage="";
			if(_currentPage<totalPages){
				nextPage="<li><a href=\"javascript:\" onclick=\"javascript:$('#"+$(this).attr("id")+"').changepage("+(parseInt(_currentPage)+1)+");\" >&raquo;</a></li>";
			}

			//first page
			var  firstPage="";
			if(_currentPage>1){
				firstPage="<li><a href=\"javascript:\" onclick=\"javascript:$('#"+$(this).attr("id")+"').changepage(1);\" >首页</a></li>";
			}
			//last page
			var lastPage="";
			if(_currentPage<totalPages){
				lastPage="<li><a href=\"javascript:\" onclick=\"javascript:$('#"+$(this).attr("id")+"').changepage("+totalPages+");\"  >末页</a></li>";
			}
			//cv size 
			var listSizeLi="<li class=\"active\"><a>共:"+totalRowSizes+"条,"+totalPages+"页<span class=\"sr-only\">(current)</span></a></li>";

			var pageAll="";
			var pageCenter="";

			//开始起始的数
			var beginPageNumber=1;
			var linePageNumber=settings.linePageMaxNumber;
			
			if(_currentPage>=settings.linePageMaxNumber){
				if(_currentPage%settings.linePageMaxNumber==0){
					beginPageNumber=_currentPage;
				}else{
					beginPageNumber=(parseInt(_currentPage/settings.linePageMaxNumber))*settings.linePageMaxNumber;
				}
				if(totalPages-beginPageNumber<settings.linePageMaxNumber){
					beginPageNumber=totalPages-(settings.linePageMaxNumber-1);
				}
				linePageNumber=(parseInt(_currentPage/settings.linePageMaxNumber)+1)*settings.linePageMaxNumber;//显示的页数
			}
			
			if(linePageNumber>=totalPages){
				linePageNumber=totalPages;
			}
			for(var i=beginPageNumber;i<=linePageNumber;i=i+1){	
				if(_currentPage==i){
					pageCenter="<li class=\"active\"><a>"+i+"<span class=\"sr-only\">(current)</span></a></li>";
				}else{
					pageCenter="<li><a href=\"javascript:\" onclick=\"javascript:$('#"+$(this).attr("id")+"').changepage("+i+")\">"+i+"</a></li>";
				}
				pageAll=pageAll+pageCenter;
			}
			pageAll="<ul class=\"pagination\" style=\"margin-top:0px;\" >"+prePage+firstPage+pageAll+lastPage+nextPage+listSizeLi+"</ul>";
			return pageAll;
		};
		
		
		$(this).getResult();
	};
	
})(jQuery);

