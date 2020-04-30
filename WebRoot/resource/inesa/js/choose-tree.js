(function(){
	var tree={
		"data":{},
		"setting":{},
		"treeSetting":{
			check: {
				enable: true
			},
			data: {
				simpleData: {
					enable: true
				}
			},
			callback: {
				onCheck: function(event, treeId, treeNode)
				{
				    var treeObj = $.fn.zTree.getZTreeObj(tree.setting.chooseTreeId);
					var nodes = treeObj.getCheckedNodes(true);
					var resultNodes=[];
					for(var i=0;i<nodes.length;i++)
					{
						var obj={};
						obj.id=nodes[i].id;
						obj.pId=nodes[i].pId;
						obj.name=nodes[i].name;
						resultNodes.push(obj);
					}

					$.fn.zTree.init($("#"+tree.setting.displayTreeId), tree.treeDisplaySetting, resultNodes);
					var treeDis = $.fn.zTree.getZTreeObj(tree.setting.displayTreeId);
					treeDis.expandAll(true);
				}
			}
		},
		"treeDisplaySetting":{
			data: {
				simpleData: {
					enable: true
				}
			}
		},
		"init":function(setting){
			tree.setting=setting;
			 $.post("common/get_org_struct_tree.action",{type:tree.setting.dataType},function(data){
			 		tree.data=data;
					var zNodes = data;
					if(tree.setting.cancelCheckRelative)
						$.extend(tree.treeSetting.check, {chkboxType:{ "Y" : "", "N" : "" }});
					$.fn.zTree.init($("#"+tree.setting.chooseTreeId), tree.treeSetting, zNodes);
					var treeChoose = $.fn.zTree.getZTreeObj(tree.setting.chooseTreeId);
					if(tree.setting.expand)
					{
						treeChoose.expandAll(true);
					}
			 });
		},
		"CheckedData":function(){
		    var treeObj = $.fn.zTree.getZTreeObj(tree.setting.chooseTreeId);
			var nodes = treeObj.getCheckedNodes(true);
			var resultNodes=[];
			for(var i=0;i<nodes.length;i++)
			{
				if(!tree.setting.getNodeType || (tree.setting.getNodeType && tree.setting.getNodeType=="NonParent"))
				{
					if(!nodes[i].isParent)
					{
						var obj={};
						obj.id=nodes[i].id;
						obj.pId=nodes[i].pId;
						obj.name=nodes[i].name;
						obj.isParent=nodes[i].isParent;
						if($.trim(tree.getAttr(nodes[i].id)))
							obj.attr=tree.getAttr(nodes[i].id);
						resultNodes.push(obj);
					}
				}else
				{
					var obj={};
					obj.id=nodes[i].id;
					obj.pId=nodes[i].pId;
					obj.name=nodes[i].name;
					obj.isParent=nodes[i].isParent;
					if($.trim(tree.getAttr(nodes[i].id)))
						obj.attr=tree.getAttr(nodes[i].id);
					resultNodes.push(obj);
				}
			}
			return resultNodes;
		},
		"getAttr":function(id){
			var r=null;
			$.each(tree.data,function(i,item){
				if(item.id==id && item.attr)
					r = item.attr;
			});
			return r;
		}
	};
	$.fn.treeChoose=function(setting){
		tree.init(setting);
		return tree;
	}
})($);