<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'test.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" href="resource/font-awesome/css/font-awesome.min.css">
	<script src="resource/jquery/js/jquery-1.7.2.js"></script>
	<script src="resource/svg/jquery.mousewheel.min.js"></script>
	<script src="resource/svg/snap.svg-min.js"></script>
	<script src="resource/inesa/js/common.js"></script>
	<style type="text/css">
		#rangFlux{
			display:none;
			opacity: 0.7;
			filter:alpha(opacity=70);
			position:absolute;
			z-index:1;
			height:400px;
			width:205px;
    		top: 10px;
    		right: 5px;
    		font-family: '微软雅黑';
    		font-size: 14px;
    	}
    	.rangcon{
    		height:26px;
    		padding-left:47px;
    		background:url('resource/images/float2.png') no-repeat -25px 0px;
    		color:#FFFFFF;
    	}
    	.rangconlast{
    		height:20px;
    		background:url('resource/images/float3.png') no-repeat -25px -20px;
    		padding-left:47px;
    		color:#FFFFFF;
    	}
    	html {
      		padding: 0;
      		margin: 0;
      		height: 100%; 
   		}
   
    	body {
      		padding: 0;
      		margin: 0;
      		height: 100%; 
   		}
    </style>
  </head>
  
  <body style="height:100%;width:100%;">
  	  <!-- 图形 start -->
  	  <div id="svgDiv" style="height:99%;width:100%;z-index: 0;"></div>
  	  <!-- 图形 end -->
  	  
  	  <!-- 提示框 start -->
      <div id="myDialog" style="height:90px;width:180px;display:none;position:absolute;top:0px;left:0px;border:1px solid #dddddd;background:#FFFFFF;z-index:2;padding:5px;">
      	<div id="lineName" style="font-family: '微软雅黑';font-size:12px;color:#FFFFFF;background-color:#40e0d0;width:45px;text-align:center;"></div>
    	<div id="lineNameBg" style="height:2px;width:100%;background-color:#40e0d0;">&nbsp;</div>
    	<div id="odName" style="font-family: '微软雅黑';font-size:16px;font-weight: bold;margin-top:10px;"></div>
    	<div id="odFlux" style="font-family: '微软雅黑';font-size:16px;font-weight: bold;margin-top:5px;"></div>
      </div>
      <!-- 提示框 end -->
      
      <!-- 右侧悬浮框 start -->
      <div style="position:absolute;z-index:2;top:10px;left:5px;" onclick="showParam();">
      	<i class="fa fa-search fa-2x" style="color:#3388FF"></i>
      </div>
      <div id="rangFlux">
      	<img src="resource/images/metro.png" style="margin-left:20px;">
      	<div style="background:url('resource/images/float1.png') no-repeat -25px -25px;height:170px;">
      		<div style="font-size:14px;font-weight:bold;padding:10px 0px 0px 45px;height:50px;">
      			<div id="totalStation" style="font-size:25px;"></div>
      			<div id="totalContent"></div>
      		</div>
      		<div id="totalTitle" style="font-size:12px;font-weight:bold;text-align: right;padding-right:25px;"></div>
      		<div id="rankTitle" style="font-size:18px;font-weight: bold;margin-top: 57px;padding-left: 40px;">同线换乘客流排名</div>
      	</div>
      	<div id="rankStation"></div>
	  </div>
	  <!-- 右侧悬浮框 end -->
	  
	  <!-- 查询条件 start -->
	  <div id="paramId" style="display:none;position:absolute;z-index:1;top:10px;left:20%;background:none repeat scroll 0 0 #D0DFFB;height:60px;width:800px;font-family: '微软雅黑';">
	  	<table height="60px" width="100%">
	  		<tr>
	  			<td>线路:<select id="line" name="line" style="width:120px;"></select></td>
	  			<td>车站:<select id="stations" style="width:120px;"></select>
	  				<a class="btn btn-danger" href="javascript:add_station();"><i class="fa fa-plus-square"></i></a>
	  			</td>
	  			<td>日期:<input id="start_date" name="start_date" style="width:120px;"/></td>
	  			<td>结束时刻:<select id="hour" name="hour">
	  							<option value="04">04</option>
	  							<option value="05">05</option>
	  							<option value="06">06</option>
	  							<option value="07">07</option>
	  							<option value="08">08</option>
	  							<option value="09">09</option>
	  							<option value="10">10</option>
	  							<option value="11">11</option>
	  							<option value="12" selected="selected">12</option>
	  							<option value="13">13</option>
	  							<option value="14">14</option>
	  							<option value="15">15</option>
	  							<option value="16">16</option>
	  							<option value="17">17</option>
	  							<option value="18">18</option>
	  							<option value="19">19</option>
	  							<option value="20">20</option>
	  							<option value="21">21</option>
	  							<option value="22">22</option>
	  							<option value="23">23</option>
	  						</select>
	  				<input type="button" value="查询" onclick="sel_odflux()"/>
	  			</td>
	  		</tr>
	  		<tr>
	  			<td colspan="4" style="border-top:1px solid #FFFFFF;">
	  				已选车站：<span id="sel_stations"></span>
	  			</td>
	  		</tr>
	  	</table>
	  </div>
      <!-- 查询条件 end -->
      <script type="text/javascript">
      	//显示或隐藏查询条件
      	function showParam(){
      		if($("#paramId").is(":hidden")){
      			$("#paramId").show();
      		}else{
      			$("#paramId").hide();
      		}
      	}
      	
      	//添加车站
      	function add_station(){
      		if($("#stations").val()==null||$("#stations").val()==""){
      			alert("请选择车站！");
      			return;
      		}
      		var sel_station=$("#stations option:selected").text();
      		if($("#sel_stations").text().toString().indexOf(sel_station)>-1){
      			alert(sel_station+"已被选择！");
      			return;
      		}
      		$("#sel_stations").append("<span>&nbsp;&nbsp;"+sel_station+" <i class='fa fa-times' onclick='del_station(this);'></i><input type='hidden' name='stations' value='"+$("#stations").val()+"'/></span>");
      	}
      	//删除车站
      	function del_station(obj){
      		$(obj).parent().remove();
      	}
      	
      	var s = Snap("#svgDiv");
      	var svg;
      	$(function(){
      		//查询线路和车站信息
      		doPost("odflux/get_lineandstation.action",function(data){
      			var line_ht="<option value=''>--请选择线路--</option>";
      			var station_ht="<option value=''>--请选择车站--</option>";
      			$.each(data,function(i,v){
      				if(i==0){
      					$("#start_date").val(v.CUR_DATE);
      					line_ht+="<option  value='"+v.LINE_ID+"' selected='selected'>"+v.LINE_ID+"号线</option>";
      					station_ht+="<option  value='"+v.STATION_ID+"'>"+v.STATION_NM+"</option>";
      				}else if(v.LINE_ID=="01"){
      					station_ht+="<option  value='"+v.STATION_ID+"'>"+v.STATION_NM+"</option>";
      				}else if(v.LINE_ID!=data[i-1].LINE_ID){
      					line_ht+="<option  value='"+v.LINE_ID+"'>"+v.LINE_ID+"号线</option>";
      				}
      			});
      			
      			$("#line").html(line_ht).change(function(){
      				var line=$(this).val();
      				station_ht="<option value=''>--请选择车站--</option>";
      				$.each(data,function(i,v){
      					if(v.LINE_ID==line){
      						station_ht+="<option  value='"+v.STATION_ID+"'>"+v.STATION_NM+"</option>";
      					}
      				});
      				$("#stations").html(station_ht);
      			});
      			$("#stations").html(station_ht);
      		});
      		
      		//加载svg文件
      		Snap.load("pages/svg/stations.svg", function (f) {
			    svg = f.select("svg");
			    s.append(svg);
			    svg.select("g").drag();//设置拖拽
			    
			    if($(window).height()>700){
			    	svg.attr({viewBox:"-700, -300, 1500,820"});
			    }else{
			    	svg.attr({viewBox:"-700, -300, 1500,700"});
			    }
		    });
      		
      		//设置鼠标滚动图像进行放大和缩小
      		var m = new Snap.Matrix();
	        $('#svgDiv').bind('mousewheel', function(event, delta, deltaX, deltaY) {
	        	if (delta>0) {//鼠标向上滚动
			        m.scale(1.2, 1.2);
			    }else{//鼠标向下滚动
			    	m.scale(0.8, 0.8);
			    }
	        	svg.select("g").transform(m);
			});
      		
      	});
      	
      	var tp_num=0;
      	//查询断面和车站的相关数据，并设置图像显示效果
      	function sel_odflux(){
      		var sel_stations=$("input[name='stations']");
      		if(sel_stations.length<1){
      			alert("请选择车站！");
      			return;
      		}
      		var start_date=$("#start_date").val();
      		if(start_date==null||start_date==""){
      			alert("请填写日期！");
      			return;
      		}
      		var stations="";
      		$.each(sel_stations,function(i,v){
      			stations+=v.value+",";
      		});
      		
		    //将查询条件隐藏
		    $("#paramId").hide();
		    
      		//设置透明
		    svg.selectAll("circle").attr({opacity:".2",fillOpacity:"1"});
		    svg.selectAll("line").attr({opacity:".1",fillOpacity:".1"});
		    svg.selectAll("path").attr({opacity:".1",fillOpacity:".1"});
		    svg.selectAll("text").attr({opacity:".1",fillOpacity:".1"});
		    
		    //请求断面相关数据
		    doPost("odflux/get_enterodflux.action",{"flag":1,"startDate":start_date,"stations":stations.substring(0,stations.length-1),"hour":$("#hour").val()},function(data){
		    	//车站排名数据
		    	getRangStation(start_date,stations.substring(0,stations.length-1),$("#hour").val());
		    	//请求相关车站的出站、换乘客流数据
		    	getExitChgFlux();
		    	//车站出站总客流
      			getTotalStation(start_date,stations.substring(0,stations.length-1),$("#hour").val());
		    	
		    	$.each(data,function(i,v){
		    		var fragment;
		    		var tp_str;
		    		var tp=v.STATION1.toString().split("-");//将断面分割，获取车站
		    		//设置车站站点的透明度
		    		Snap.select("#"+tp[0]).attr({opacity:"1",fillOpacity:"1"});
		    		Snap.select("#"+tp[1]).attr({opacity:"1",fillOpacity:"1"});
		    		//设置车站名称的透明度
		    		Snap.select("#"+tp[0]+"t").attr({opacity:"1",fillOpacity:"1"});
		    		Snap.select("#"+tp[1]+"t").attr({opacity:"1",fillOpacity:"1"});
		    		
		    		var station1=Snap.select("#"+v.STATION1);
		    		//判断断面是否和线条的id相符
		    		if(station1){
		    			//设置线条的透明度和鼠标悬浮事件、鼠标移出事件
		    			station1.attr({strokeWidth:v.LV+"",opacity:"1",fillOpacity:"1"}).mouseover(function (e) {
			                //设置提示框的位置
		    				var xPos = parseInt(e.pageX+12) + "px";
			                var yPos = e.pageY + "px";
			                $("#myDialog").css("left", xPos).css("display","block");
			                $("#myDialog").css("top", yPos);
			                //设置提示框的标题和背景色
			                $("#lineName").css("background-color",this.attr().stroke).css("display","block").html(this.attr().lineid+"号线");
			                $("#lineNameBg").css("background-color",this.attr().stroke).css("display","block");
			                //填充断面名称
			                $("#odName").html(v.STATION1);
			                //填充客流数据
			                $("#odFlux").html("客流："+v.TIMES);
			            }).mouseout(function(){$("#myDialog").css("display","none");});
		    			
		    			//获取线条的坐标
		    			tp_str=Snap.parsePathString(Snap.select("#"+v.STATION1)).toString();
		    			//设置两个动画
		    			fragment = Snap.parse('<circle cx="0" cy="0" r="2" stroke="#FFFFFF" stroke-width="1" fill="#FFFFFF"><animateMotion path="'+tp_str.substring(0,tp_str.length-3)+'" begin="0s" dur="4s" rotate="auto" repeatCount="indefinite"/></circle>');
		    			svg.select("g").add(fragment);
		    			fragment = Snap.parse('<circle cx="0" cy="0" r="2" stroke="#FFFFFF" stroke-width="1" fill="#FFFFFF"><animateMotion path="'+tp_str.substring(0,tp_str.length-3)+'" begin="2s" dur="4s" rotate="auto" repeatCount="indefinite"/></circle>');
		    			svg.select("g").add(fragment);
		    		}
		    		
		    		var station2=Snap.select("#"+v.STATION2);
		    		//如果断面和线条不相符，把断面反向调整，再次判断是否存在
		    		if(station2){
		    			//设置线条的透明度和点击事件
		    			station2.attr({strokeWidth:v.LV+"",opacity:"1",fillOpacity:"1"}).mouseover(function (e) {
			                //设置提示框的位置
		    				var xPos = parseInt(e.pageX+12) + "px";
			                var yPos = e.pageY + "px";
			                $("#myDialog").css("left", xPos).css("display","block");
			                $("#myDialog").css("top", yPos);
			                //设置提示框的标题和背景色
			                $("#lineName").css("background-color",this.attr().stroke).css("display","block").html(this.attr().lineid+"号线");
			                $("#lineNameBg").css("background-color",this.attr().stroke).css("display","block");
			                //填充断面名称
			                $("#odName").html(v.STATION1);
			                //填充客流数据
			                $("#odFlux").html("客流："+v.TIMES);
			            }).mouseout(function(){$("#myDialog").css("display","none");});
		    			
		    			//获取线条的坐标
		    			var points=Snap.parsePathString(Snap.select("#"+v.STATION2));
		    			
		    			//把线条的坐标反向重取
		    			var tp_p="";
		    			for(var j=points.length-4;j>=0;j--){
	    					if(j==points.length-4){
	    						tp_p+="M "+points[j][1]+","+points[j][2]+" ";
	    					}else if(j==0){
	    						tp_p+=points[j][1]+","+points[j][2]+" ";
	    					}else{
	    						if(points[j][0]=="Q"){
	    							tp_p+=points[j][0]+points[j][1]+","+points[j][2]+" ";
	    						}else{
	    							tp_p+=points[j][1]+","+points[j][2]+" ";
	    						}
	    						
	    					}
	    				}
		    			
		    			//设置两个动画
		    			fragment = Snap.parse('<circle cx="0" cy="0" r="2" stroke="#FFFFFF" stroke-width="1" fill="#FFFFFF"><animateMotion path="'+tp_p+'" begin="0s" dur="4s" rotate="auto" repeatCount="indefinite"/></circle>');
	    				svg.select("g").add(fragment);
	    				fragment = Snap.parse('<circle cx="0" cy="0" r="2" stroke="#FFFFFF" stroke-width="1" fill="#FFFFFF"><animateMotion path="'+tp_p+'" begin="2s" dur="4s" rotate="auto" repeatCount="indefinite"/></circle>');
	    				svg.select("g").add(fragment);
		    		}
		    		
		    	});
		    });
      	}
      	
      	//车站出站总客流
      	var totalFlux;
      	function getTotalStation(start_date,stations,hour){
	        doPost("odflux/get_enterodflux.action",{"flag":4,"startDate":start_date,"stations":stations,"hour":hour},function(data){
	        	totalFlux=data;
	        	$("#totalTitle").html("截止"+hour+"点");
	        	if(data&&data.length>0){
	        		$("#totalStation").html(data[0].STATION_NM);
	        		$("#totalContent").html("总出站客流:"+data[0].EXIT_TIMES);
	        	}
	        });
      	}
      	
      	//车站排名数据
      	function getRangStation(start_date,stations,hour){
	        doPost("odflux/get_enterodflux.action",{"flag":2,"startDate":start_date,"stations":stations},function(data){
	        	var tp_ht="";
	        	$.each(data,function(i,v){
	        		if(v.FLAG=="1"){
	        			tp_ht+="<div class='rangcon'>"+v.STATION_NM+":"+v.TIMES+"</div>";
	        		}
	        	});
	        	tp_ht+="<div class='rangconlast'>&nbsp;</div>";
	        	$("#rankStation").html(tp_ht);
	        	
	        	setInterval(function(){changeFlux(data)},5000);
	        });
	        //将排名相关内容显示
		    $("#rangFlux").show();
      	}
      	
      	//请求相关车站的出站、换乘客流数据
      	function getExitChgFlux(){
		    doPost("odflux/get_enterodflux.action",{"flag":3},function(data){
		    	$.each(data,function(i,v){
		    		var station=Snap.select("#"+v.STATION_NM);
		    		if(station){
		    			//设置线条的透明度和点击事件
		    			station.mouseover(function (e) {
			                //设置提示框的位置
		    				var xPos = parseInt(e.pageX+12) + "px";
			                var yPos = e.pageY + "px";
			                $("#myDialog").css("left", xPos).css("display","block");
			                $("#myDialog").css("top", yPos);
			                //设置提示框的标题隐藏
			                $("#lineName").css("display","none");
			                $("#lineNameBg").css("display","none");
			                //填充车站名称
			                $("#odName").html(v.STATION_NM);
			                //填充客流数据
			                if(v.CHANGE_TIMES>0){
			                	$("#odFlux").html("出站客流："+v.EXIT_TIMES+"<br/>换出客流:"+v.CHANGE_TIMES);
			                }else{
			                	$("#odFlux").html("出站客流："+v.EXIT_TIMES);
			                }
			                
			                
			            }).mouseout(function(){$("#myDialog").css("display","none");});
		    		}
		    	});
		    });
      	}
      	
      	
        //切换客流数据
        function changeFlux(obj){
        	var tp_ht="";
        	tp_num++;
        	$.each(obj,function(i,v){
        		if(v.FLAG==(tp_num+"")&&v.FLAG=="1"){
        			tp_ht+="<div class='rangcon'>"+v.STATION_NM+":"+v.TIMES+"</div>";
        		}else if(v.FLAG==(tp_num+"")&&v.FLAG=="2"){
        			tp_ht+="<div class='rangcon'>"+v.STATION_NM+"号线:"+v.TIMES+"</div>";
        		}
        	});
        	if(tp_num==1){
        		$("#rankTitle").html("同线换乘客流排名");
        	}else if(tp_num==2){
        		$("#rankTitle").html("换出线路排名");
        	}
        	tp_ht+="<div class='rangconlast'>&nbsp;</div>";
        	$("#rankStation").html(tp_ht);
        	
        	if(totalFlux&&totalFlux.length>0&&totalFlux[tp_num-1]){
        		$("#totalStation").html(totalFlux[tp_num-1].STATION_NM);
        		$("#totalContent").html("总出站客流:"+totalFlux[tp_num-1].EXIT_TIMES);
        	}
        	if(tp_num>=2){tp_num=0;}
        }
      </script>
  </body>
</html>
