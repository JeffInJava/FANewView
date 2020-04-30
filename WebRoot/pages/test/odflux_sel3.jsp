<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
  <head>
    <base href="<%=basePath%>">
    <title>上海地铁客流实时显示系统</title>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
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
	<script src="resource/inesa/js/common.js"></script>
	<script src="resource/svg/snap.svg.zpd.js"></script>
	<script src="resource/anime/anime.min.js"></script>
	
	<script src="resource/vue/vue.min.js"></script>
    <script src="resource/element-ui/index.js"></script>
    
    <script src ="resource/videojs/video.js"></script >
	<script src="resource/videojs/videojs-contrib-hls.js"></script>
	<style type="text/css">
    	html,body {
      		margin:0;
			padding:0;
			width: 100%;
    		height: 100%;
	 		overflow: hidden;
   		}
   		svg{
   			height:99%; 
   		}
   		.uppath{
			stroke-dasharray:5;
			animation:dash 200s linear both infinite;
		}
		
		.downpath{
			stroke-dasharray:5;
			animation:dash 200s linear both infinite reverse;
		}
		
		@keyframes dash {
		  to {
		    stroke-dashoffset: 2000;
		  }
		}
		
		text{
			font-size:8px;
			/*-webkit-transform-origin:0 0;
            -webkit-transform:scale(0.7);*/
			font-family:'SimHei';
		}
		
		.titleCla{
			height:55px;
			width:100%;
			top:0;
		    right:0;
		    bottom:0;
		    left: 0;
		    z-index:10;
			background: rgba(0,0,0,0.8);
			position: absolute;
		}
    </style>
  </head>
  
  <body style="background-color:rgba(20,38,56,1);">
  	  <div class="titleCla">
  	  	 <div style="float:left;margin-left:10%;color:#fff;font-size:18px;margin-top:15px;">上海地铁客流实时显示系统</div>
  	  	 <div id="titleId" style="float:left;margin-left:40px;margin-top:15px;">
	  	  	 <el-select v-model="value4" clearable placeholder="-单线高亮-" style="width:120px;" size="mini">
			    <el-option v-for="item in lines" :key="item.value" :label="item.label" :value="item.value"></el-option>
			 </el-select>
			 
			 <el-button-group>
			   <el-button type="primary" size="small" style="width:40px;">+</el-button>
			   <el-button type="primary" size="small" style="width:40px;">-</el-button>
			 </el-button-group>
			 
			 <el-button type="primary" size="small" >摄像头</el-button>
  	  	 </div>
  	  </div>
  	  
  	  
  	  <div id="cameraId">
	  	  <el-dialog :title="cameraTitle" :visible.sync="dialogVisible" width="30%" :before-close="handleClose" @open="startPlay()" @close="pausePlay()">
			  <template v-for="(item,index) in cameras">
				  <el-row :gutter="20" v-if="index % 2 == 0" style="margin-top:10px;">
				  	<el-col :span="12" align="center">
				  		<el-card shadow="hover">
						  <video :id="cameras[index].camera_name" width="210" height="120" class="video-js vjs-default-skin" controls>
							  <source :src="cameras[index].url1" type="application/x-mpegURL">
						  </video>
						  {{cameras[index].camera_name}}
					   </el-card>
				  	</el-col>
				  	<el-col :span="12" align="center" v-if="index+1 < cameras.length">
				  		<el-card shadow="hover">
						  <video :id="cameras[index+1].camera_name" width="210" height="120" class="video-js vjs-default-skin" controls>
							  <source :src="cameras[index+1].url1" type="application/x-mpegURL">
						  </video>
						  {{cameras[index+1].camera_name}}
					   </el-card>
				  	</el-col>
				  </el-row>
			  </template>
			  <span slot="footer" class="dialog-footer">
			    <el-button type="primary" @click="pausePlay()">关闭</el-button>
			  </span>
		 </el-dialog>
  	 </div>
      <script type="text/javascript">
        
        new Vue({
      	  el: '#titleId',
		  data:function(){
			return {
				lines:[
					{value: '00',label: '全路网'},
					{value: '01',label: '1号线'},
					{value: '02',label: '2号线'},
					{value: '03',label: '3号线'},
					{value: '04',label: '4号线'},
					{value: '05',label: '5号线'},
					{value: '06',label: '6号线'},
					{value: '07',label: '7号线'},
					{value: '08',label: '8号线'},
					{value: '09',label: '9号线'},
					{value: '10',label: '10号线'},
					{value: '11',label: '11号线'},
					{value: '12',label: '12号线'},
					{value: '13',label: '13号线'},
					{value: '16',label: '16号线'},
					{value: '17',label: '17号线'},
					{value: '41',label: '浦江线'}
					],
				value4:''
			}
		  }
      	});
      
		ve=new Vue({
		  el: '#cameraId',
		  data:function(){
			return {
				dialogVisible: false,
				cameraTitle:'',
				cameras:[]
			}
		  },
		  methods: {
		      handleClose(done) {
		    	 this.dialogVisible=false;
		      },
		      startPlay: function () {
		    	  setTimeout(()=>{
			  	 	  $.each(ve.cameras,function(i,v){
		    			  videojs(v.camera_name).play();
		    		  });
		    	  },0);
			  },
			  pausePlay:function () {
				  dialogVisible = false;
		    	  $.each(ve.cameras,function(i,v){
	    			  videojs(v.camera_name).pause();
	    		  });
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
      		$.post("tos/get_tosstate.action",function(dt){
      			var yellowElements=[];
      			var redElements=[];
      			$.each(dt.data,function(i,v){
      				if(v.cType=="1"){
      					$("#p"+v.id).attr("stroke","#4DBA63");
      				}else if(v.cType=="2"){
      					yellowElements.push("#p"+v.id);
      					$("#p"+v.id).attr({"stroke":"rgba(255,241,0,1)","stroke-width":"3"});
      				}else if(v.cType=="3"){
      					redElements.push("#p"+v.id);
      					$("#p"+v.id).attr({"stroke":"#FF0000","stroke-width":"3"});
      				}
      			});
      			
      			if(yellowElements.length>0){
      				anime({
					  targets: yellowElements,
					  stroke: [
		    			{value: 'rgba(243,186,25,0.4)'},
		    			{value: 'rgba(255,241,0,1)'}
					  ],
					  easing: 'linear',
		  			  direction: 'alternate',
		              duration: 3000,
		              loop: true
					});
      			}
      			
      			if(redElements.length>0){
      				anime({
					  targets:redElements,
					  stroke: [
		    			{value: 'rgba(255,0,0,0.4)'},
		    			{value: '#FF0000'}
					  ],
					  easing: 'linear',
		  			  direction: 'alternate',
		              duration: 3000,
		              loop: true
					});
      			}
      		});
      	}
      	
      	//显示“摄像头”弹框
      	function showCamera(){
      		//加载“摄像头”信息
      		$.post("tos/get_camera.action",function(data){
				$.each(data,function(i,v){
					var tp1=$("#s罗山路");
					var tp2=tp1.clone().attr({"id":v.group_name,"xlink:href":"style/images/camera.png","x":v.x,"y":v.y,"width":"10","height":"10"}).css({"opacity":"1","fill-opacity":"1","stroke-opacity":"1"});
					tp2.click(function(){
		      			ve.cameraTitle=v.group_name;
     					ve.cameras=v.cameras;
     					ve.dialogVisible = true;
		      		});
     				tp1.after(tp2);
     				
				});	  
			});
      	}
      	
      	//加载svg文件
      	function loadSvg(){
			if($("svg")){
      			$("svg").remove();
      		}
      		s = Snap();
      		//加载svg文件
      		Snap.load("pages/test/line_updown3.svg", function (f) {
			    svg = f.select("svg").select("g");
			    s.append(svg);
			    //svg.select("g").drag();//设置拖拽
			    //设置鼠标拖拽、滚动图像进行放大和缩小
			    s.zpd();
			    s.panTo('+200', '-80');
			    
			    loadDataAddAnime();//加载数据并添加动画
			    
			    //setInterval('loadDataAddAnime()',1000);
			    
			    showCamera();
			    
			    if(navigator.userAgent.indexOf("Chrome") > -1){
			    	var txts=$("text");
			    	$.each(txts,function(i,v){
			    		$(v).attr("transform","matrix(0.7,0,0,0.7,"+($(v).attr("x")*0.3)+","+($(v).attr("y")*0.3)+")");
			    	});
			    }
			    
			    var screenWidth=$(document.body).width()/2;
			    var screenHeight=$(document.body).height()/2;
			    $("circle").click(function(){
			    	var cx_old=$(this).attr("cx");
			    	var cy_old=$(this).attr("cy");
			    	var tp_g=$("svg g:first");
			    	var trs=$(tp_g).attr("transform").toString().replace("matrix(","").replace(")","").split(",");
			    	var cx_new=screenWidth-cx_old*trs[0];
			    	var cy_new=screenHeight-cy_old*trs[3];
			    	$(tp_g).attr("transform","matrix("+trs[0]+","+trs[1]+","+trs[2]+","+trs[3]+","+cx_new+","+cy_new+")");
			    });
			    
		    });
      		
      	}
      	
      </script>
  </body>
</html>