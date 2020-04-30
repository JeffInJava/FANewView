function windowHeight() {
    var de = document.documentElement;
    return self.innerHeight||(de && de.clientHeight)||document.body.clientHeight;
}
window.onload=window.onresize=function(){
 	var wh=windowHeight();
	document.getElementById("leftWrap").style.height = document.getElementById("rightCon").style.height = (wh-document.getElementById("header").offsetHeight)+"px";
	document.getElementById("iframeCon").style.height = (wh-document.getElementById("header").offsetHeight-document.getElementById("rightWz").offsetHeight)+"px";
}
var buildSeat = function(tree_id, node){
	var cc = "";
	(function(tree_id, node){
		var parentNode;
		parentNode = node && node.target;
		if(!parentNode)
			return "";
		parentNode = $('#' + tree_id).tree('getParent', parentNode);
		if(parentNode && parentNode.target) arguments.callee(tree_id,parentNode);
		
		//cc +=((node && node.text && "<li>" + node.text + "</li><li> ></li>") || "");
		var _txt = $(node.target).find('.tree-title').text();
		cc +=((_txt && "<li>" + _txt + "</li><li> ></li>") || "");
	})(tree_id, node);
	if(cc){
		cc = cc.substr(0,cc.lastIndexOf('<li>'))
	}
	return cc;
}
$(function(){
	$('#tree_1').tree({
		animate : true, 
	    onClick : function(node){
			$('#tree_1').tree('toggle',node.target);
			var _url = node.url || (node.attributes && node.attributes.url);
			if(_url)
				$('#iframeCon').attr('src',_url);
			if($('#tree_1').tree('isLeaf',node.target))
				$('#rightWz ul').empty().append(buildSeat('tree_1',node));		
			
			
	    },

	   onBeforeExpand : function(node){
	    	/*
	    	* 确保打开的树节点只有一个
	    	*/
	    	var $roots = $(this).tree('getRoots', node);
	    	var isRoot = false;
	    	for(var _r in $roots){
	    		if($roots[_r] && $roots[_r].domId == node.domId){
	    			isRoot = true;
	    			break;
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
	    		if( !v.children ){
	    			$('#'+v.domId).find('.tree-indent,.tree-title,.tree-file').andSelf().removeClass('tree-file').removeClass('tree-leve2').addClass('tree-leve2');
	    		}
	    	});
	    },
	    onLoadSuccess : function(node, data){
	    	/**
	    	* 考虑到根节点存在子节点时的样式
	    	*/
	     	var $roots = $(this).tree('getRoots',node)
	     	for(var _r in $roots){
	     		_r = $roots[_r];
				var _t = _r.target;
				if($(this).tree('isLeaf',_t)){
					$('#' + _t.id).find('.tree-file').removeClass('tree-file').addClass('tree-leaf');
				}
	     	}
	    }	      
	}); 
});