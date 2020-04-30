<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>返程客流走向图</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
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
	<script src="resource/svg/snap.svg.zpd.js"></script>
	<style type="text/css">
		#rangFlux{
			display:none;
			opacity: 0.7;
			filter:alpha(opacity=70);
			position:absolute;
			z-index:2;
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
      		background-color:#132537;
   		}
   		svg{
   			height:99%; 
   		}
   		#rankTitle{
   			font-size:18px;
   			font-weight:bold;
   			margin-top: 57px;
   			padding-left: 40px;
   		}
   		#rankTitle a,#rankTitle a:hover,#totalStation a,#totalStation a:hover{
   			color:black;
   			text-decoration:none;
   		}
   		#rangFlux a,#rangFlux a:hover{
   			text-decoration:none;
   		}
    </style>
  </head>
  
  <body>
  	  
  	  <!-- 提示框 start -->
      <div id="myDialog" style="display:none;position:absolute;top:0px;left:0px;border:1px solid #dddddd;background:#FFFFFF;z-index:2;padding:5px;min-height:60px;min-width:170px;">
      	<div id="lineName" style="font-family: '微软雅黑';font-size:12px;color:#FFFFFF;background-color:#40e0d0;width:45px;"></div>
    	<div id="lineNameBg" style="height:2px;width:100%;background-color:#40e0d0;">&nbsp;</div>
    	<div id="odFlux" style="font-family: '微软雅黑';font-size:16px;font-weight: bold;margin-top:10px;"></div>
    	<div id="odFlux1" style="font-family: '微软雅黑';font-size:16px;font-weight: bold;margin-top:5px;"></div>
      </div>
      <!-- 提示框 end -->
      
	  <div style="position:absolute;z-index:2;top:10px;left:5px;" onclick="showParam();">
      	<i class="fa fa-search fa-2x" style="color:#3388FF"></i>
      </div>
	  <!-- 查询条件 start -->
	  <div id="paramId" style="display:none;position:absolute;z-index:1;top:10px;left:20%;background:none repeat scroll 0 0 #D0DFFB;height:60px;width:600px;font-family: '微软雅黑';">
	  	<table height="60px" width="100%">
	  		<tr>
	  			<td>日期:<input id="start_date" name="start_date" style="width:100px;"></td>
	  			<td>参数类型:<select id="param_type" style="width:150px;"></select></td>
	  			<td>精度:<input id="scls" type="text" value="1" style="width:50px"/></td>
	  			<td><input type="button" value="查询" onclick="sel_odflux()"/></td>
	  		</tr>
	  	</table>
	  </div>
      <!-- 查询条件 end -->
      <script type="text/javascript">
      	var show_statons_flag=true;
      	//控制级别要显示的车站
      	var show_statons=["巨峰路","耀华路","陕西南路","隆德路","虹桥火车站","曹杨路","长寿路","曲阜路","上海南站","宜山路","蓝村路","大木桥路","新天地","高科西路",
      		"人民广场","静安寺","世纪大道","龙漕路","镇坪路","中潭路","虹口足球场","大连路","西藏南路","东方体育中心","嘉善路","马当路",
      		"龙华中路","陆家浜路","南京东路","天潼路","漕宝路","徐家汇","汉中路","老西门","莘庄","虹桥路","东安路","罗山路","肇嘉浜路","嘉定新城",
      		"江苏路","龙阳路","海伦路","四平路","上海体育馆","常熟路","中山公园","延安西路","金沙江路","上海火车站","宝山路","交通大学","龙华"];
      	
      	//显示或隐藏查询条件
      	function showParam(){
      		if($("#paramId").is(":hidden")){
      			$("#paramId").show();
      		}else{
      			$("#paramId").hide();
      		}
      	}
      	
      	
      	var s;
      	var svg;
      	$(function(){
      		//加载svg文件
      		loadSvg();
      	});
      	
      	
      	//加载svg文件
      	function loadSvg(){
      		if($("svg")){
      			$("svg").remove();
      		}
      		s = Snap();
      		//加载svg文件
      		Snap.load("pages/svg/line_updown.svg", function (f) {
			    svg = f.select("svg").select("g");
			    s.append(svg);
			    //svg.select("g").drag();//设置拖拽
			    //设置鼠标拖拽、滚动图像进行放大和缩小
			    s.zpd();
			    s.panTo('+630', '+260');
			    
				if(!is_first){
					svg.selectAll("circle").attr({opacity:".2",fillOpacity:"1"});
			    	svg.selectAll("path").attr({opacity:".1",fillOpacity:".1"});
			    	svg.selectAll("text").attr({opacity:".1",fillOpacity:".1"});
			    	svg.selectAll("polygon").attr({opacity:".1",fillOpacity:".1"});
				}
			    
		    });
      		
      	}
      	
      	var tp_num=0;
      	var is_first=true;
      	//查询断面和车站的相关数据，并设置图像显示效果
      	function sel_odflux(){
      		var start_date=$("#start_date").val();
      		if(start_date==null||start_date==""){
      			alert("参数为空，请先进行数据处理！");
      			return;
      		}
      		
		    //将查询条件隐藏
		    $("#paramId").hide();
		    
		    if(!is_first){
		    	loadSvg();
		    }
		    is_first=false;
		    show_statons_flag=false;
		    
      		//设置透明
		    svg.selectAll("circle").attr({opacity:".2",fillOpacity:"1"});
		    svg.selectAll("path").attr({opacity:".1",fillOpacity:".1"});
		    svg.selectAll("text").attr({opacity:".1",fillOpacity:".1"});
		    svg.selectAll("polygon").attr({opacity:".1",fillOpacity:".1"});
		    
		    
		    //请求断面相关数据
		    doPost("odflux/get_addlineodflux.action",{"flag":1,"startDate":start_date},function(data){
		    	var scls=$("#scls").val();
		    	Snap.select("#黄浦江").attr({opacity:"1",fillOpacity:"1"});
				Snap.select("#黄浦江1").attr({opacity:"1",fillOpacity:"1"});
				Snap.select("#黄浦江2").attr({opacity:"1",fillOpacity:"1"});
				Snap.select("#黄浦江3").attr({opacity:"1",fillOpacity:"1"});

				
		    	//请求相关车站的出站、换乘客流数据
		    	//getExitChgFlux(pid);
		    	
		    	
		    	var tp_arr=[];
		    	var colors=['#17BF00','#C0E582','#F0F91E','#FFD300','#FF9600','#FF4500'];
		    	$.each(data,function(i,v){
		    		
	    			var tp=v.SECTIONNAME.toString().split("-");//将断面分割，获取车站
		    		//设置车站站点的透明度
		    		Snap.select("#"+tp[0]).attr({opacity:"1",fillOpacity:"1"});
		    		Snap.select("#"+tp[1]).attr({opacity:"1",fillOpacity:"1"});
		    		//设置车站名称的透明度
		    		Snap.select("#"+tp[0]+"t").attr({opacity:"1",fillOpacity:"1"});
		    		Snap.select("#"+tp[1]+"t").attr({opacity:"1",fillOpacity:"1"});
		    		
		    		if(Snap.select("#"+tp[0]+"pt1")){
		    			Snap.select("#"+tp[0]+"pt1").attr({opacity:"1",fillOpacity:"1"});
		    			Snap.select("#"+tp[0]+"pt2").attr({opacity:"1",fillOpacity:"1"});
		    		}
		    		if(Snap.select("#"+tp[0]+"pn1")){
		    			Snap.select("#"+tp[0]+"pn1").attr({opacity:"1",fillOpacity:"1"});
		    			Snap.select("#"+tp[0]+"pn2").attr({opacity:"1",fillOpacity:"1"});
		    		}
		    		if(Snap.select("#"+tp[1]+"pt1")){
		    			Snap.select("#"+tp[1]+"pt1").attr({opacity:"1",fillOpacity:"1"});
		    			Snap.select("#"+tp[1]+"pt2").attr({opacity:"1",fillOpacity:"1"});
		    		}
		    		if(Snap.select("#"+tp[1]+"pn1")){
		    			Snap.select("#"+tp[1]+"pn1").attr({opacity:"1",fillOpacity:"1"});
		    			Snap.select("#"+tp[1]+"pn2").attr({opacity:"1",fillOpacity:"1"});
		    		}
	    			
		    		var sectionname=Snap.select("#"+v.SECTIONNAME);
		    		
		    		//判断断面是否和线条的id相符
		    		if(sectionname){
		    			//设置线条的透明度和鼠标悬浮事件、鼠标移出事件
		    			sectionname.attr({stroke:(colors[v.LV/2-1])+"",opacity:"1",fillOpacity:"1"}).mouseover(function (e) {
		    				showMyDialog(e,v,sectionname);
			            }).mouseout(function(){
			            	$("#myDialog").css("display","none");
			                $("#odFlux1").html("");
			            });
		    		}
		    		
		    		
		    		//if(v.SHOW_FLAG!='1'){
	    			//	add_animate(v.STATION1,v.STATION2);
	    			//}
	    			//if(v.D_TIMES>0&&v.SHOW_FLAG!='2'){
	    			//	add_animate(v.D_STATION1,v.D_STATION2);
	    			//}
	    			
		    		if(v.D_TIMES>0){
		    			tp_arr.push(v);
		    		}
		    		
		    	});
		    });
      	}
      	
      	//显示提示框
      	function showMyDialog(e,v,station){
      		var d_width=$("#myDialog").width();
      		var d_height=$("#myDialog").height();
      		var xPos;
      		var yPos;
      		//设置提示框的位置
      		if(d_width+e.pageX+15>=$(window).width()){
      			xPos = parseInt(e.pageX-15-d_width) + "px";
      		}else{
      			xPos = parseInt(e.pageX+12) + "px";
      		}
      		if(d_height+e.pageY+5>=$(window).height()){
      			yPos = parseInt(e.pageY-d_height-5) + "px";
      		}else{
      			yPos = e.pageY + "px";
      		}
      		
            $("#myDialog").css("left", xPos).css("top", yPos).show();
            //设置提示框的标题和背景色
            $("#lineName").css("background-color",station.attr().stroke).css("width","45px").html(station.attr().lineid+"号线").show();
            $("#lineNameBg").css("background-color",station.attr().stroke).show();
            //填充断面名称、客流数据
            $("#odFlux").html(v.SECTIONNAME+"："+v.TIMES);
            //if(v.D_TIMES>0){
            //	$("#odFlux1").show();
            //	$("#odFlux1").html(v.D_STATION1+"："+v.D_TIMES);
            //}
      	}
      	
      	//判断断面是否已存在
      	function is_exist(obj,arr){
      		if(arr.length>0){
      			$.each(arr,function(i,v){
      				if(v.STATION2==obj){
      					return true;
      				}
      			});
      			return false;
      		}else{
      			return false;
      		}
      	}
      	
      	//添加动画
      	function add_animate(obj1,obj2){
      		var fragment;
		    var tp_str;
		    
		    var station1=Snap.select("#"+obj1);
			var station2=Snap.select("#"+obj2);
		    if(station1){
		    	//获取线条的坐标
    			tp_str=Snap.parsePathString(Snap.select("#"+obj1)).toString();
    			//设置两个动画
    			fragment = Snap.parse('<circle cx="0" cy="0" r="2" stroke="#FFFFFF" stroke-width="1" fill="#FFFFFF"><animateMotion path="'+tp_str.substring(0,tp_str.length-3)+'" begin="0s" dur="4s" rotate="auto" repeatCount="indefinite"/></circle>');
    			svg.add(fragment);
    			fragment = Snap.parse('<circle cx="0" cy="0" r="2" stroke="#FFFFFF" stroke-width="1" fill="#FFFFFF"><animateMotion path="'+tp_str.substring(0,tp_str.length-3)+'" begin="2s" dur="4s" rotate="auto" repeatCount="indefinite"/></circle>');
    			svg.add(fragment);
		    }else if(station2){
		    	//获取线条的坐标
    			var points=Snap.parsePathString(Snap.select("#"+obj2));
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
   				svg.add(fragment);
   				fragment = Snap.parse('<circle cx="0" cy="0" r="2" stroke="#FFFFFF" stroke-width="1" fill="#FFFFFF"><animateMotion path="'+tp_p+'" begin="2s" dur="4s" rotate="auto" repeatCount="indefinite"/></circle>');
   				svg.add(fragment);
		    }
      	}
      	
      	//请求相关车站的出站、换乘客流数据
      	function getExitChgFlux(pid){
		    doPost("odflux/get_enterodfluxnewsel1.action",{"flag":3,"pid":pid},function(data){
		    	$.each(data,function(i,v){
		    		var station=Snap.select("#"+v.STATION_NM);
		    		if(station&&station.attr("opacity")>=1){
		    			station.mouseover(function (e) {
			                var d_width=$("#myDialog").width();
				      		var d_height=$("#myDialog").height();
				      		var xPos;
				      		var yPos;
				      		//设置提示框的位置
				      		if(d_width+e.pageX+15>=$(window).width()){
				      			xPos = parseInt(e.pageX-15-d_width) + "px";
				      		}else{
				      			xPos = parseInt(e.pageX+12) + "px";
				      		}
				      		if(d_height+e.pageY+5>=$(window).height()){
				      			yPos = parseInt(e.pageY-d_height-5) + "px";
				      		}else{
				      			yPos = e.pageY + "px";
				      		}
			                $("#myDialog").css("left", xPos).css("top", yPos).show();
			                
				            $("#odFlux1").hide();
			                //填充车站名称
			                $("#lineName").css("background-color","#5CB85C").css("width",(v.STATION_NM.toString().length*13)+"px").html(v.STATION_NM);
				            $("#lineNameBg").css("background-color","#5CB85C");
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
      	
      </script>
  </body>
</html>