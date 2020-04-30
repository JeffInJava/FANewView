<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html lang="zh-cn">
	<head>
		<%@ include file="/WEB-INF/common_inc/head.inc"%>
		<base href="<%=basePath%>">
	</head>

	<body>
		<div class="container" >
		<div class="row">
			<div class="col-xs-12">
				<!-- 查询条件 start -->
				<form class="well form-horizontal well-brand" id="form">
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="col-md-3 control-label">模板名称:</label>
								<div class="col-md-6">
									<select class="form-control input-xlarge" name="modelName" id="modelName">
										<option value=""></option>
									</select>
						        </div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label class="col-md-3 control-label">二级模板:</label>
								<div class="col-md-4">
									<select class="form-control" name="subModelName" id="subModelName">
										<option value=""></option>
									</select>
						        </div>
						        <div class="col-md-3">
									<button type="button" class="btn btn-sm btn-success" onclick="searchMenuinfo()">
										查找
										<i class="icon-search icon-on-right bigger-110"></i>
									</button>
								</div>	
							</div>
						</div>
					</div>
				</form>
				<!-- 查询条件 end -->
				
				<!-- grid列表 start -->
				<table id="grid-table"></table>
				<div id="grid-pager"></div>	
				<!-- grid列表 end -->
				
				<!-- 删除对话框 start -->
				<div class="modal fade" id="myModal">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				        <h4 class="modal-title text-primary">删除模板确认</h4>
				      </div>
				      <div class="modal-body">
				      	<div class="row">
		                    <div class="col-xs-12 text-center">
		                        <h3 class="blue">确定删除此模板信息吗？</h3>
		                    </div>
		                </div>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				        <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="delOpt()">确定</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!-- 删除对话框 end -->
				
				<!-- 添加对话框 start -->
				<div class="modal fade" id="addModal">
				  <div class="modal-dialog" style="width:80%;">
				    <div class="modal-content">
				      <div class="modal-header">
				        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				        <h4 class="modal-title text-primary">模板添加</h4>
				      </div>
				      <div class="modal-body" style="padding:0px">
				      	<div class="row">
		                    <div class="col-xs-12">
		                        <form class="form-horizontal well-brand" id="addform" style="margin:0px;">
			                        <div class="row">
										<div class="col-md-6">
											<div class="form-group">
												<label class="col-md-3 control-label">模板名称:</label>
												<div class="col-md-8">
													<div class="input-group">
												      	<input type="text" name="modelName" class="form-control input-xlarge" id="addModelName" readonly="readonly">
												        <label class="input-group-addon blue" style="padding:0px">
															<input name="optType" value="0" type="checkbox" class="ace" onclick="isAddModel(this)">
															<span class="lbl">添加</span>
														</label>
												    </div>
													<input type="hidden" name="modelId" id="modelId">
										        </div>
											</div>
										</div>
										<div class="col-md-6">
											<div class="form-group">
												<label class="col-md-3 control-label">二级模板:</label>
												<div class="col-md-8">
													<div class="input-group">
														<input type="text" name="subModelName" class="form-control input-xlarge" id="addSubModelName" readonly="readonly">
											        	<label class="input-group-addon blue" style="padding:0px">
															<input name="addFlag2" value="1" type="checkbox" class="ace" onclick="isAddModel(this)">
															<span class="lbl">添加</span>
														</label>
													</div>
										        </div>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-6">
											<div class="form-group">
												<label class="col-md-3 control-label">线路名称:</label>
												<div class="col-md-8">
													<select class="form-control input-xlarge" name="lineName" id="lineName"></select>
										        </div>
											</div>
										</div>
										<div class="col-md-6">
											<div class="form-group">
												<label class="col-md-3 control-label">图表显示:</label>
												<div class="col-md-8">
													<label class="blue">
														<input name="viewFlag" value="0" type="radio" class="ace">
														<span class="lbl">否</span>
													</label>&nbsp;&nbsp;
													<label class="blue">
														<input name="viewFlag" value="1" type="radio" class="ace" checked="checked">
														<span class="lbl">是</span>
													</label>
										        </div>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-6">
											<div class="form-group">
												<label class="col-md-3 control-label">车站名称:</label>
												<div class="col-md-8 well" id="stations_id" style="padding:0px 5px;margin:0px;overflow:auto;height:400px"></div>
												<div class="col-md-1">
													<br/><br/><br/><br/>
													<button type="button" class="btn btn-success glyphicon glyphicon-arrow-right" onclick="addCheckedStation()"></button>
													<br/><br/>
													<button type="button" class="btn btn-success glyphicon glyphicon-arrow-left" onclick="remCheckedStation()"></button>
												</div>
											</div>
										</div>
										<div class="col-md-6">
											<div class="form-group">
												<label class="col-md-3 control-label">已选车站:</label>
												<div class="col-md-8 well" id="add_stations_id" style="padding:0px 5px;margin:0px;overflow:auto;height:400px"></div>
											</div>
										</div>
									</div>
								</form>
		                    </div>
		                </div>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				        <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="addModel()">保存</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!-- 添加对话框 end -->
				
			</div>
		</div>					
		
		<%@ include file="/WEB-INF/common_inc/foot.inc"%>
		
		<script type="text/javascript">
			$(document).ready(function(){
				init();
		   });
			
			//初始化页面信息
			function init(modelNameTp,subModelNameTp){
				var gridTable = "#grid-table";
				var gridPaper = "#grid-pager";				
				
				//查询模板种类
				doPost("sysmanage/search_modelall.action",function(data){
					if(data){
						$("#modelName").empty();
						var temp=true;
						$.each(data,function(i,v){//一级模板初始化值项
							var tp=i.toString().split("-");
							$("#modelName").append("<option value='"+tp[1]+"'>"+tp[0]+"</option>");
							if(temp){
								$("#subModelName").empty();
								$.each(v,function(j,l){//二级模板初始化值项
									$("#subModelName").append("<option value='"+l+"'>"+l+"</option>");
								});
							}
							temp=false;
						});
						
						//一级模板项添加change事件，实现联动
						$("#modelName").change(function(){
							$("#subModelName").empty();
							//$.each(data[$(this).find("option:selected").text().toString().trim()+"-"+$(this).val()],function(i,v){
							$.each(data[$(this).find("option:selected").text().toString()+"-"+$(this).val()],function(i,v){
								$("#subModelName").append("<option value='"+v+"'>"+v+"</option>");
							});
						});
					}
					if(modelNameTp){
						$("#modelName option:contains('"+modelNameTp+"')").attr("selected", true);
					}
					if(subModelNameTp){
						$("#subModelName").empty();
						//$.each(data[$("#modelName").find("option:selected").text().toString().trim()+"-"+$("#modelName").val()],function(i,v){
						$.each(data[$("#modelName").find("option:selected").text().toString()+"-"+$("#modelName").val()],function(i,v){
							$("#subModelName").append("<option value='"+v+"'>"+v+"</option>");
						});
						$("#subModelName").val(subModelNameTp);
					}
					//初始查询模板信息
					var postForm=getFormParams($("#form").closest("form"));
					//postForm.modelName=$("#modelName").find("option:selected").text().toString().trim();
					postForm.modelName=$("#modelName").find("option:selected").text().toString();
					
					if(modelNameTp&&modelNameTp){
						jqGridQuery(gridTable,postForm);
					}else{
						$(gridTable).jqGrid(jqGridOption({
							url : 'sysmanage/search_modelpg.action',
							postData:postForm,
						   	colNames : ['操作','','模板编号','模板名称','二级模板名称','线路名称','车站名称','是否显示图表'],
						   	colModel : [
						   		{name:'myac',width:60,fixed:true, formatter: actionCellFmatter},
						   		{name:'verId',hidden:true},
						   		{name:'modelId'},
								{name:'modelName'},
								{name:'subModelName'},
						   		{name:'lineId'},
						   		{name:'stationNmCm'},
						   		{name:'viewFlag'}
						   	],
						   	pager: gridPaper,
						    caption:"模板信息列表",
						    height: "auto",
						    loadComplete : function(date) {
								var table = this;
								setTimeout(function(){
									updateJqGridPagerIcons(table);
									updateJqGridSubGridIcons(table);
								}, 0);
							}
						}));
					}
					
					//自定义“添加”按钮
					var gridTools = $(gridTable).jqGrid("navGrid",gridPaper, {edit:false,add:false,del:false,search:false, refresh: false, view:false});
					gridTools.jqGrid("navButtonAdd",gridPaper,{
						id: "addmenuinfo",
						caption: "<button id='addBtn' class='btn btn-xs btn-primary'>添加</button>&nbsp;<button id='exitAdd' class='btn btn-xs btn-primary'>退出编辑</button>",
						buttonicon: "none"
					});
					//添加按钮事件
					$("#addBtn").click(function(){
						$("#modelId").val($("#modelName").val());
						$("#addModelName").val($("#modelName").find("option:selected").text().toString().trim());
						$("#addSubModelName").val($("#subModelName").val());
						getJson("sysmanage/search_linestationall.action",function(lineData){
							$("#lineName").empty();
							$.each(lineData.line,function(i,v){
								$("#lineName").append("<option value='"+v[0]+"'>"+v[1]+"</option>");
								if(i==0){
									var stations_str="";
									$.each(lineData.station,function(j,l){
										if(v[0]==l.lineId){
											stations_str+="<label class='blue' style='width:150px'><input value='"+l.stationId +
										"' type='checkbox' class='ace'><span class='lbl'>"+l.stationName+"</span>&nbsp;&nbsp;</label>";
										}
									});
									$("#stations_id").html(stations_str);
								}
							});
							
							$("#lineName").change(function(){
								var tp=$(this).val();
								var stations_str="";
								$.each(lineData.station,function(j,l){
									if(tp==l.lineId){
										stations_str+="<label class='blue' style='width:150px'><input value='"+l.stationId +
										"' type='checkbox' class='ace'><span class='lbl'>"+l.stationName+"</span>&nbsp;&nbsp;</label>";
									}
								});
								$("#stations_id").html(stations_str);
							});
							
						});
						$("#addModelName,#addSubModelName").attr("readonly","readonly");
						$("input[type='checkbox']").attr("checked",false); 
						$("#add_stations_id").html("");
						$('#addModal').modal('show');
					});
					
					
					//退出编辑按钮事件
					$("#exitAdd").click(function(){history.go(-1);});
					
				});
				
				//按钮格式化
				function actionCellFmatter(cellvalue, options, rowObject){
					var actionsHtml="<div style='margin-left:5px;'>" + 
							"<div class='ui-pg-div' style='float:left; curosr: pointer; margin-left: 5px;'><a href=\"javascript:openNewPageByUrl(1,'"+rowObject.verId+"');\">删除</a></div>" +
						"</div>";
					return actionsHtml;
				}
				
			}
			
			//查询
			function searchMenuinfo(){
				var postData = getFormParams($("#form").closest("form"));
				postData.modelName=$("#modelName").find("option:selected").text().toString().trim();
				var gridTable = "#grid-table";
				var gridPaper = "#grid-pager";	
				jqGridQuery(gridTable,postData);
			}
			var postDate;		
			openNewPageByUrl = function (id,verId){
				if(id==1){
					postDate=verId;
					$('#myModal').modal('show');
				}else{
					alert("参数错误");
				}
			}
			
			//删除对应模板信息
			function delOpt(){
				if(postDate){
			 		getJson("sysmanage/del_model.action",{"verId":postDate},function(data){
						bootbox.dialog({
							message: "<div class='center'><h3 class='green'>"+data.root+"</h3></div>", 
							buttons: {
								"success" : {
									"label" : "OK",
									"className" : "btn-sm btn-primary"
								}
							}
						});
						if($("#grid-table").jqGrid().getDataIDs().length>1){
							searchMenuinfo();
						}else{
							location.reload();
						}
					});
				}
			}
			
			//添加模板信息
			function addModel(){
				var stations=$("#add_stations_id input[type='checkbox']");
				if(!(stations&&stations.length>0)){alert("请选择车站！");return false;}
				
				//获取表单
				var postData = getFormParams($("#addform").closest("form"));
				var stationId=[];
				var stationName=[];
				stations.each(function(i,v){
					stationId.push(v.value);
					stationName.push($(this).next().text());
				});
				postData.stationId=stationId;
				postData.stationName=stationName;
				
				doPost("sysmanage/add_model.action",postData,function(data){
					bootbox.dialog({
						message: "<div class='center'><h3 class='green'>"+data.root+"</h3></div>", 
						buttons: {
							"success" : {
								"label" : "OK",
								"className" : "btn-sm btn-primary"
							}
						}
					});
					//location.reload();
					init($("#addModelName").val(),$("#addSubModelName").val());
				});
			}
			
			//是否新增一级或二级模板
			function isAddModel(tp){
				if(tp.value=="0"){
					if(tp.checked){
						$("#modelId").val("");
						$("#addModelName").val("");
						$("#addModelName").removeAttr("readonly");
					}else{
						$("#modelId").val($("#modelName").val());
						$("#addModelName").val($("#modelName").find("option:selected").text().toString().trim());
						$("#addModelName").attr("readonly","readonly");
					}
				}else if(tp.value=="1"){
					if(tp.checked){
						$("#addSubModelName").val("");
						$("#addSubModelName").removeAttr("readonly");
					}else{
						$("#addSubModelName").val($("#subModelName").val());
						$("#addSubModelName").attr("readonly","readonly");
					}
				}
			}
			
			//添加选中的车站
			function addCheckedStation(){
				//获取选中的车站
				var stations=$("#stations_id input[type='checkbox']:checked");
				if(stations&&stations.length>0){
					//将选择的车站添加到id为add_stations_id的div中
					stations.each(function(i,v){
						var flag=true;
						$("#add_stations_id input[type='checkbox']").each(function(j,l){
							if(v.value==l.value){
								flag=false;
							}
						});
						if(flag){
							var tp="<label class='blue' style='width:150px'><input value='"+v.value+"' type='checkbox' class='ace'><span class='lbl'>"+$(this).next().text()+$("#lineName").val()+"</span>&nbsp;&nbsp;</label>";
							$("#add_stations_id").append(tp);
						}
					});
				}else{
					alert("请选择要添加的车站！");
				}
			}
			
			//移除选中的车站
			function remCheckedStation(){
				//获取选中的车站
				var stations=$("#add_stations_id input[type='checkbox']:checked");
				if(!(stations&&stations.length>0)){alert("请选择要移除的车站！");}
				stations.each(function(i,v){
					$(this).parent().remove();
				});
			}
		</script>
		</div>		
	</body>
</html>
