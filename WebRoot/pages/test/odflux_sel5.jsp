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
	<link rel="stylesheet" href="resource/element-ui/index.css" />
	<link href = "resource/videojs/video-js.css"  rel = "stylesheet" >
	
	<script src="resource/jquery/js/jquery-1.7.2.js"></script>
	<script src="resource/svg/jquery.mousewheel.min.js"></script>
	<script src="resource/svg/snap.svg-min.js"></script>
	<script src="resource/anime/anime.min.js"></script>
	<script src="resource/inesa/js/common.js"></script>
	<script src="resource/vue/vue.min.js"></script>
    <script src="resource/element-ui/index.js"></script>
    
    <script src ="resource/videojs/video.js"></script >
	<script src="resource/videojs/videojs-contrib-hls.js"></script>
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
   		.uppath{
			stroke-dasharray:5;
			animation:dash 200s linear both infinite;
		}
		
		.downpath{
			stroke-dasharray:5;
			animation:dash 500s linear both infinite reverse;
		}
		
		@keyframes dash {
		  to {
		    stroke-dashoffset: 2000;
		  }
		}
		
		text{
			font-size:8px;
			letter-spacing:0;
			font-family: 'SimHei';
		}
    </style>
  </head>
  
  <body style="height:100%;width:100%;background-color:#16171C;">
  	  <!-- 图形 start -->
  	  <div id="svgDiv" style="height:99%;width:100%;z-index: 0;"></div>
  	  <!-- 图形 end -->
  	  
  	  <div id="cameraId">
	  	  <el-dialog title="人民广场" :visible.sync="dialogVisible" width="30%" :before-close="handleClose" @open="startPlay()">
			  <el-row :gutter="20">
			  	<el-col :span="12" align="center">
			  		<el-card shadow="hover">
					  <video id="video1" width="210" height="120" class="video-js vjs-default-skin" controls>
						  <source src="http://10.2.128.82:8000/live/039.m3u8" type="application/x-mpegURL">
					  </video>
					    人民广场2号线
				   </el-card>
			  	</el-col>
			  	<el-col :span="12" align="center">
			  		<el-card shadow="hover">
					  <video id="video2" width="210" height="120" class="video-js vjs-default-skin" controls>
						  <source src="http://10.2.128.82:8000/live/045.m3u8" type="application/x-mpegURL">
					  </video>
					    人民广场20号屏蔽门
				   </el-card>
			  	</el-col>
			  </el-row>
			  <el-row :gutter="20" style="margin-top:20px;">	
			  	<el-col :span="12" align="center">
			  		<el-card shadow="hover">
					  <video id="video3" width="210" height="120" class="video-js vjs-default-skin" controls>
						  <source src="http://10.2.128.82:8000/live/056.m3u8" type="application/x-mpegURL">
					  </video>
					    人民广场1号线
				   </el-card>
			  	</el-col>
			  	<el-col :span="12" align="center">
			  		<el-card shadow="hover">
					  <video id="video4" width="210" height="120" class="video-js vjs-default-skin" controls>
						  <source src="http://10.2.128.82:8000/live/065.m3u8" type="application/x-mpegURL">
					  </video>
					    人民广场大三角
				   </el-card>
			  	</el-col>
			  </el-row>
			  
			  <span slot="footer" class="dialog-footer">
			    <el-button type="primary" @click="dialogVisible = false">关闭</el-button>
			  </span>
		 </el-dialog>
  	 </div>
      <script type="text/javascript">
      
		v=new Vue({
		  el: '#cameraId',
		  data:function(){
			return {
				dialogVisible: false
			}
		  },
		  methods: {
		      handleClose(done) {
		    	 this.dialogVisible=false;
		      },
		      startPlay: function () {
		    	  setTimeout(()=>{
		    		  //var player = videojs('video1');
			  	 	  //player.play();
			  	 	  videojs('video1').play();
			  	 	  videojs('video2').play();
			  	 	  videojs('video3').play();
			  	 	  videojs('video4').play();
		    	  },0);
			  }
		    }
		});
		
  
      	var s;
      	var svg;
      	$(function(){
      		//加载svg文件
      		loadSvg();
      	});
      	
      	//加载三色信息并添加动画
      	function loadDataAddAnime(){
      		$.post("tos/get_tosstate.action",function(data){
      			
      			svg.selectAll("circle").attr({opacity:".2",fillOpacity:"1"});
			    svg.selectAll("path").attr({opacity:".2",fillOpacity:".1"});
			    svg.selectAll("text").attr({opacity:".2",fillOpacity:".1"});
      			
      			$.each(data,function(i,v){
      				var tp_stations=v.id.toString().split("-");
      				if(tp_stations.length>1){
      					var tp1=$("#p"+v.id).css({"opacity":"1","fill-opacity":"1","stroke-opacity":"1"});
      					var tp2=$("#p"+tp_stations[1]+"-"+tp_stations[0]).css({"opacity":"1","fill-opacity":"1","stroke-opacity":"1"});
      					$("#p"+tp_stations[0]).css({"opacity":"1","fill-opacity":"1","stroke-opacity":"1"});
      					$("#p"+tp_stations[1]).css({"opacity":"1","fill-opacity":"1","stroke-opacity":"1"});
      					$("#c"+tp_stations[0]).css({"opacity":"1","fill-opacity":"1","stroke-opacity":"1"});
      					$("#c"+tp_stations[1]).css({"opacity":"1","fill-opacity":"1","stroke-opacity":"1"});
      					$("#"+v.bstid).css({"opacity":"1","fill-opacity":"1","stroke-opacity":"1"});
      					$("#"+v.estid).css({"opacity":"1","fill-opacity":"1","stroke-opacity":"1"});
      					
      					var tp3;
      					if(tp1.attr("od")){
      						tp3=tp1.clone().attr({"d":tp1.attr("od"),"stroke-width":"3","id":"od"+v.id}).css({"opacity":"1","fill-opacity":"1","stroke-opacity":"1"});
      					}else{
      						tp3=tp1.clone().attr({"d":tp2.attr("od"),"stroke-width":"3","id":"od"+v.id}).css({"opacity":"1","fill-opacity":"1","stroke-opacity":"1"});
      					}
      					tp1.after(tp3);
      					
      					if(v.cType=="2"){
      						tp3.attr("class","downpath");
	      				}else if(v.cType=="3"){
	      					addAnime("#od"+v.id,tp3.attr("stroke"));
	      				}
      				}
      			});
      			
      		});
      	}
      	
      	//添加动画
      	function addAnime(pid,cor){
      		anime({
			  targets:pid,
			  stroke: [
    			{value: 'rgba(19,37,56,1)'},
    			{value:cor}
			  ],
			  easing: 'linear',
  			  direction: 'alternate',
              duration: 1000,
              loop: true
		   });
      	}
      	
      	function showCamera(){
      		$("#c人民广场").click(function(){
      			v.dialogVisible = true;
      		});
      	}
      	
      	//加载svg文件
      	function loadSvg(){
			$("#svgDiv").html("");
      		s = Snap("#svgDiv");
      		//加载svg文件
      		Snap.load("pages/test/stations.svg", function (f) {
			    svg = f.select("svg");
			    s.append(svg);
			    svg.select("g").drag();//设置拖拽
			    
			    //loadDataAddAnime();//加载数据并添加动画
			    
			    //setInterval('loadDataAddAnime()',1000);
			    
			    //showCamera();
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
	        	svg.select("g").transform(m);
			});
      		
      	}
      	
      </script>
  </body>
</html>