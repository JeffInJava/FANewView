<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
  <head>
    <base href="<%=basePath%>">
    <title>返程客流走向图</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" href="resource/font-awesome/css/font-awesome.min.css">
	<script src="resource/jquery/js/jquery-1.7.2.js"></script>
	<script src="resource/svg/jquery.mousewheel.min.js"></script>
	<script src="resource/svg/snap.svg-min.js"></script>
	<script src="resource/anime/anime.min.js"></script>
	<script src="resource/inesa/js/common.js"></script>
	<style type="text/css">
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
   		.animecla {
   			width:50px;
   			height:20px;
   			background-color:#8C2222;
   			z-index:99;
   		}
		
		.up path{
			/*stroke-dasharray:5;*/
			/*animation:dash 200s linear both infinite;*/
		}
		
		.down path{
			/*stroke-dasharray:5;*/
			/*animation:dash 200s linear both infinite reverse;*/
		}
		
		@keyframes dash {
		  to {
		    stroke-dashoffset: 2000;
		  }
		}
    </style>
  </head>
  
  <body style="height:100%;width:100%;background-color:#0B122E;">
  	  <!-- 图形 start -->
  	  <div id="svgDiv" style="height:99%;width:100%;z-index: 0;"></div>
  	  <!-- 图形 end -->
  	  
      <!-- 查询条件 end -->
      <script type="text/javascript">
      	var show_statons_flag=true;
      	//控制级别要显示的车站
      	var show_statons=["巨峰路","耀华路","陕西南路","隆德路","虹桥火车站","曹杨路","长寿路","曲阜路","上海南站","宜山路","蓝村路","大木桥路","新天地","高科西路",
      		"人民广场","静安寺","世纪大道","龙漕路","镇坪路","中潭路","虹口足球场","大连路","西藏南路","东方体育中心","嘉善路","马当路",
      		"龙华中路","陆家浜路","南京东路","天潼路","漕宝路","徐家汇","汉中路","老西门","莘庄","虹桥路","东安路","罗山路","肇嘉浜路","嘉定新城",
      		"江苏路","龙阳路","海伦路","四平路","上海体育馆","常熟路","中山公园","延安西路","金沙江路","上海火车站","宝山路","交通大学","龙华"];
      	
      	var s;
      	var svg;
      	$(function(){
      		//加载svg文件
      		loadSvg();
      	});
      	
      	
      	function addAnime(){
      		var tp1=$("#江苏路-静安寺").attr("stroke");
      		var tp2=$("#静安寺-常熟路").attr("stroke");
      		$("#江苏路-静安寺").css("animation","");
      		$("#静安寺-常熟路").css("stroke-dasharray","0").css("animation","");
      		
      		anime({
			  targets: '#江苏路-静安寺',
			  stroke: [
    			{value: 'rgba(54,184,84,0.2)'},
    			{value: tp1}
			  ],
			  easing: 'linear',
  			  direction: 'alternate',
              duration: 1000,
              loop: true
			});
      		
      		anime({
			  targets: '#静安寺-常熟路',
			  stroke: [
    			{value: 'rgba(243,86,15,0.2)'},
    			{value: tp2}
			  ],
			  easing: 'linear',
  			  direction: 'alternate',
              duration: 1000,
              loop: true
			});
      	}
      	
      	var is_first=true;
      	//加载svg文件
      	function loadSvg(){
			$("#svgDiv").html("");
      		s = Snap("#svgDiv");
      		//加载svg文件
      		Snap.load("pages/test/line_updown2.svg", function (f) {
			    svg = f.select("svg");
			    s.append(svg);
			    svg.select("g").drag();//设置拖拽
				if(!is_first){
					svg.selectAll("circle").attr({opacity:".2",fillOpacity:"1"});
			    	svg.selectAll("path").attr({opacity:".1",fillOpacity:".1"});
			    	svg.selectAll("text").attr({opacity:".1",fillOpacity:".1"});
				}
				addAnime();
		    });
      		
      		//设置鼠标滚动图像进行放大和缩小
      		var m = new Snap.Matrix();
	        $('#svgDiv').bind('mousewheel', function(event, delta, deltaX, deltaY) {
	        	if (delta>0) {//鼠标向上滚动
			        m.scale(1.2, 1.2);
			    }else{//鼠标向下滚动
			    	if(m.a>0.5){
			    		m.scale(0.8, 0.8);
			    	}
			    }
	        	if(show_statons_flag){
	        		if(m.a<1){
		        		svg.selectAll("text").attr({opacity:".1",fillOpacity:".1"});
		        		$.each(show_statons,function(i,v){
		        			Snap.select("#"+v+"t").attr({opacity:"1",fillOpacity:"1"});
		        		});
		        	}else{
		        		svg.selectAll("text").attr({opacity:"1",fillOpacity:"1"});
		        	}
	        	}
	        	
	        	svg.select("g").transform(m);
			});
      		
      	}
      	
      </script>
  </body>
</html>