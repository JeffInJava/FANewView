var iconIndex = 0;
function windowHeight() {
    var de = document.documentElement;
    return self.innerHeight||(de && de.clientHeight)||document.body.clientHeight;
}
window.onload=window.onresize=function(){
 	var wh=windowHeight();
	document.getElementById("leftWrap").style.height = document.getElementById("rightCon").style.height = (wh-document.getElementById("header").offsetHeight)+"px";
	document.getElementById("iframeCon").style.height = (wh-document.getElementById("header").offsetHeight-document.getElementById("rightWz").offsetHeight)+"px";
	var browserName = navigator.appName;
    if (browserName=="Microsoft Internet Explorer")
    {
        isMSIE = true;
    }
    else
    {
        isMSIE = false;
    }
    typeof efform_onload == 'function' && efform_onload();
}
/**
*/
var buildSeat = function(tree_id, node){
	var cc = "";
	(function(tree_id, node){
		var parentNode;
		parentNode = node && node.target;
		if(!parentNode)
			return "";
		parentNode = $('#' + tree_id).tree('getParent', parentNode);
		if(parentNode && parentNode.target) arguments.callee(tree_id,parentNode);
		
		cc +=((node && node.text && "<li>" + node.text + "</li>") || "");
	})(tree_id, node);
	if(cc){
		//cc = cc.substr(0,cc.lastIndexOf('<li>'))
	}
	return cc;
}
$(function(){
	var treeName = "RD";
	$('#tree_1').tree({
		method : 'get',
		animate : true,  
	    //url: './RD/tree.jsp?userId=' + $('#userId').val() + '&treeName=' + treeName + '&' + new Date().getTime(), 
	    onClick : function(node){
	    	var divId = node.target.getAttribute("id");
	    	var img = $("#"+divId).find("img");
	    	var id = img.attr("id");
	    	if(id=='a'){
	    		$("img[id='a']").attr({id:'0',src:'resource/images/san.png'});
	    	}
	    	if(id=='0'){
	    		$("img[id='a']").attr({id:'0',src:'resource/images/san.png'});
	    	}
	    	if(id=='2'){
	    		$("img[id='b']").attr({id:'1',src:'resource/images/san.png'});
	    	}
	    	
			$(this).tree('toggle',node.target);
			if(node.attributes && node.attributes.url)
				//$('#iframeCon').attr('src',node.attributes.url)//,$('#iframeContent').html($('#iframeCon')[0].contentWindow.document.body.innerHTML);
				//window.open(node.attributes.url);
			$('#iframeCon').attr('src',node.attributes.url)
			$(this).tree('isLeaf',node.target) && $('#rightWz ul').empty().append(buildSeat('tree_1',node));
			setIconGap(this);
	    },
	    onBeforeExpand : function(node){
	    	/*
	    	* 确保打开的树节点只有一个
	    	*/
	    	var $roots = $(this).tree('getRoots', node);
	    	var isRoot = false;
	    	for(var _r in $roots){
	    		if($roots[_r] && $roots[_r].domId == node.domId){
	    			var _ids = $('#'+node.domId).find("img").attr("id");
	    			if(_ids=='0'){
	    				$('#'+node.domId).find("img").attr({src:"resource/images/xia.png",id:"a"})
	    			}
	    			isRoot = true;
	    			break;
	    		}else{
	    			var _ids = $('#'+node.domId).find("img").attr("id");
	    			if(_ids=='2'){
	    				$('#'+node.domId).find("span[id='span']").find("img").attr({src:"resource/images/xia.png",id:"b"});
	    				$('#'+node.domId).next().find("span[class='tree-title']").find("img").remove();
	    				$('#'+node.domId).next().find("span[class='tree-title']").prepend("<img src='resource/images/heng.png' style='margin-left:-22px;vertical-align:middle;'></img>");
	    				$('#'+node.domId).next().find("span[id='span']").remove();
	    				$('#'+node.domId).find("img[id='1']").remove();
	    				$('#'+node.domId).next().find("div[class='tree-node']").attr("class","tree-node tree-leve3");
	    				$('#'+node.domId).next().find("div[class='tree-node tree-leve2']").attr("class","tree-node tree-leve3");
	    			}
	    		}
	    	}
	    	
	    	if(isRoot){
	    		$(this).tree('collapseAll');
	    	}else{
	    		var collapses = [];
	    		var $parent = $(this).tree('getParent', node.target);
		    	$parent && $parent.children && $($parent.children).each(function(i,v){
		    		if(!$(this).tree('isLeaf',v.target) && v.domId != node.domId && v.state=='open'){
		    			collapses.push(v.target);
		    		}
		    	});
		    	for(var i,_target, i = collapses.length-1;_target= collapses[i],i >=0; i--){
		    		$(this).tree('collapse', _target);
		    	}
	    	}
	    	/**
	    	* 子节点样式
	    	*/
	    	
	    	$(node.children).each(function(i,v){
	    		$('#'+v.domId).find('.tree-indent,.tree-title,.tree-file').andSelf().removeClass('tree-file').removeClass('tree-leve2').addClass('tree-leve2');
	    	});
	    },
	    onLoadSuccess : function(node, data){
	    	/**
	    	* 考虑到根节点存在子节点时的样式
	    	*/
	     	var $roots = $(this).tree('getRoots',node)
	     	for(var _r in $roots){
	     		_r = $roots[_r];
			   //-------------------------------------------------
				var icons =[{id:""+_r.id+"",icon:"<i class=\"fa "+_r.imagePath+"\"></i>"}];
				
				//if(_r.imagePath =="" || _r.imagePath == " " || _r.imagePath == "undefined"){
				if(typeof _r.imagePath == 'undefined' || /^\s*$/i.test(_r.imagePath) || _r.imagePath=='undefined'){
					iconStyle(_r,{id:""+_r.id+"",icon:"<i class=\"fa fa-ban\"></i>"}); 
				}else{
					iconStyle(_r,icons);
				}
	     		//------------------------------------------------------------		     		
				var _t = _r.target;
				if($(this).tree('isLeaf',_t)){
					$('#' + _t.id).find('.tree-file').removeClass('tree-file').addClass('tree-leaf');
				}
				var _g = _t.getAttribute("id");
				var img = "<img id='0' src='resource/images/san.png' style='float:right;margin-right:30px;vertical-align:middle;padding:12px 0 0 0'></img>";
				$('#'+_g).append(img);
	     	}
	    },
	    loadFilter: function(data){  
	    	/**
	    	* 对url进行构建
	    	*/ 
	        if (data.d){  
	            return data.d;    
	        } else {
	        	buildUrl(data)
	            return data;    
	        }    
	    }    
	});
});

var URL_PREFIX = "./DispatchAction.do?efFormEname=";
function buildUrl(obj){
	for(var k in obj){
		if(typeof obj[k] == 'object'){
			buildUrl(obj[k]);
		}
		if( 'url' == k){
			//obj[k] = URL_PREFIX + obj[k];
			obj[k] = obj[k];
		}
	}
}

function iconStyle(_r,icons){
	if(_r.text=="客流类"){
		setIconStyle("<i class=\"fa fa-user\"></i>")
	}else if(_r.text=="营收分析"){
		setIconStyle("<i class=\"fa fa-money\"></i>")
	}else if(_r.text=="票卡分析"){
		setIconStyle("<i class=\"fa fa-credit-card\"></i>")
	}else if(_r.text=="指标分析"){
		setIconStyle("<i class=\"fa fa-tasks\"></i>")
	}else{
		setIconStyle("<i class=\"fa fa-ban\"></i>");
	}
	     		//for(var icon in icons){
		     	//		if( (icons[icon].id == _r.id) ){
				//			setIconStyle(icons[icon].icon);
		     	//		}else{
		     	//			setIconStyle("<i class=\"fa fa-ban\"></i>");
		     	//		}
	     		//}
}

function setIconStyle(icon1){
		var index = parseInt(++iconIndex);
			//添加一级图标
			var levelIcon1 = "#tree_1 > li:nth-child("+index+") > div";
			var $levelIcon1 = $(levelIcon1).find("span.tree-icon");
			
			$levelIcon1.html(icon1);
					     			
			//给二级菜单设置背景色
			var strLeveUl = "#tree_1 > li:nth-child("+index+") > ul";
				$(strLeveUl).css({"background":"#313133"}) ;
				
			//二级目录
   			var length = $("#tree_1 > li:nth-child("+index+") > ul").find("span[class='tree-title']").length;
   			for(var p=0;p<length;p++){
   				var value = $("#tree_1 > li:nth-child("+index+") > ul").find("span[class='tree-title']")[p].innerHTML;
   				$("#tree_1 > li:nth-child("+index+") > ul").find("span[class='tree-title']")[p].innerHTML = "<img id='2' src='resource/images/fang.png' align='absmiddle' style='margin-left:-23px;'></img>"+"<font size='2' style='vertical-align: middle;margin-left:26px;'>"+value+"</font>";
   				var imags = "<span id='span'><img id='2' align='absmiddle' style='float:right;margin-right:35px;padding:12px 0 0 0;' src='resource/images/san.png'></img></span>";
   				var span = $("#tree_1 > li:nth-child("+index+") > ul").find("span[class='tree-title']")[p];
   				$(span).after(imags);
   				var ids = $("#tree_1 > li:nth-child("+index+") > ul>li").find("div")[p].getAttribute("id");
   				var len = $("#"+ids).next().length;
   				if(len<1){
   					$("#"+ids).find("span[id='span']").remove();
   				}
   			}
   			
   			//$("#tree_1 > li:nth-child("+index+") > ul").find("div").attr("class","tree-node2");
					     			
			//为图标i设置样式
			var $i = $(levelIcon1+" i");
				$i.css({"color":"#FFF","font-size":"20px"});
			//为标题设置样式
			//var title = "#tree_1 > li:nth-child("+index+") > div > span:nth-child(3)";
			  var title = "#tree_1 > li:nth-child("+index+") > div";
				 $title = $(title).find("span.tree-title");
				 
				 $title.css("font-size","15px");
}
function setIconGap(obj){
		var $isLeaf = $(obj).find("span");
		$isLeaf.each(function(){
			if($(this).attr("class") == "tree-title tree-leve2"){
				$(this).attr({"style":"padding:0 0 0 37px"});
			}			
		});
}