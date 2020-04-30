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
	
	<script src="resource/jquery/js/jquery-1.9.1.min.js"></script>
	<script src="resource/svg/jquery.mousewheel.min.js"></script>
	<script src="resource/svg/snap.svg-min.js"></script>
	<script src="resource/js/common.js"></script>
	<script src="resource/svg/snap.svg.zpd.js"></script>
	<script src="resource/anime/anime.min.js"></script>
	
	<script src="resource/vue/vue.min.js"></script>
    <script src="resource/element-ui/index.js"></script>
    
    <script src="resource/js/hammer.js"></script>
    <script src="resource/js/jquery.drag.js"></script>
    <script src="resource/js/jquery.imgZoom.js"></script>
    
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
   			height:100%; 
   		}
   		.uppath{
			stroke-dasharray:5;
			animation:dash 200s linear both infinite;
		}
		
		.downpath{
			stroke-dasharray:5;
			animation:dash 500s linear both infinite;
			/*animation-direction:normal;
			animation-direction:reverse;*/
		}
		
		@keyframes dash {
		  to {
		    stroke-dashoffset: 2000;
		  }
		}
		
		text{
			font-family:'SimHei';
		}
		
		.titleCla{
			height:28px;
			width:100%;
		}
		.btmWarming{
			height:30px;
			width:70%;
			position:absolute;
			bottom:5px;
			margin:0 auto;
			left:15%;
			display:block;
			background: rgba(35,50,67,0.8);
			border:1px solid #646F7B;
			border-radius:5px;
		}
		.btmWarming .titleCls{
			height:100%;
			width:80px;
			background:#013557;
			color:#fff;
			line-height:30px;
			text-align:center;
			border-radius:5px 0 0 5px;
			border-right:1px solid #646F7B;
			float:left;
		}
		.btmWarming .contentCls{
			height:100%;
			width:calc(100%-81px);
			line-height:30px;
			color:#259F3A;
			font-size:19px;
			overflow:hidden;
			display: block;
			position: relative;
		}
		#moveTextId{
			position:absolute;
			top:0;
			left:100%;
			display:block;
			word-break:keep-all;
			text-overflow:ellipsis;
			white-space:nowrap;
		}
		.titleCla .el-checkbox {
	    	color: #fff;
	    }
		.el-dialog--small {
		    width: 70%;
		}
    </style>
  </head>
  
  <body>
  	
  	  <div class="titleCla">
  	  	 <div id="titleId" style="float:left;">
			 <el-form :inline="true" class="demo-form-inline">
	  	  	 	<!--  
	  	  	 	<el-form-item>
					 <el-select v-model="value4" clearable placeholder="-单线高亮-" style="width:120px;" size="mini">
					    <el-option v-for="item in lines" :key="item.value" :label="item.label" :value="item.value"></el-option>
					 </el-select>
					 <el-button-group>
					   <el-button type="primary" size="small" style="width:40px;" @click="svgScaling(0.5)">+</el-button>
					   <el-button type="primary" size="small" style="width:40px;" @click="svgScaling(-0.5)">-</el-button>
					 </el-button-group>
	  	  	 	</el-form-item>
	  	  	 	-->
	  	  	 	<el-form-item>
	  	  	 		 <el-checkbox-group v-model="showCameraFlag" size="small" @change="addCameraImgBtn">
				       <el-checkbox label="摄像头" border="true"></el-checkbox>
				     </el-checkbox-group>
	  	  	 	</el-form-item>
	  	  	 	<el-form-item>
	  	  	 		 <el-checkbox-group v-model="showFlag" size="small" @change="addStationImgBtn('station')">
				       <el-checkbox label="站层图" border="true"></el-checkbox>
				     </el-checkbox-group>
	  	  	 	</el-form-item>
	  	  	 	<el-form-item>
	  	  	 		 <el-checkbox-group v-model="showStreetFlag" size="small" @change="addStationImgBtn('street')">
				       <el-checkbox label="街区图" border="true"></el-checkbox>
				     </el-checkbox-group>
	  	  	 	</el-form-item>
	  	  	 	<el-form-item>
	  	  	 		<el-button type="primary" size="small" @click="optOd">设置</el-button>
	  	  	 	</el-form-item>
	  	  	 </el-form>
  	  	 </div>
  	  	 <div style="float:right;margin-right:49%;color:#fff;font-size:18px;">上海地铁客流实时显示系统</div>
  	  </div>
  	  <div class="btmWarming">
  	  	 <div class="titleCls">交通信息</div>
  	  	 <div class="contentCls">
  	  	 	<div id="moveTextId"></div>
  	  	 </div>
  	  </div>
  	  
  	  
  	  <div id="cameraId">
	  	  <el-dialog :title="cameraTitle" :visible.sync="dialogVisible" :before-close="handleClose" @open="startPlay()" @close="pausePlay()">
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
			  <!--  
			  <span slot="footer" class="dialog-footer">
			    <el-button type="primary" @click="pausePlay()">关闭</el-button>
			  </span>
			  -->
		 </el-dialog>
		 
		 
		 <!-- 大客流设置 -->
		 <el-dialog title="大客流设置" :visible.sync="faultDialogVisible" :before-close="handleClose" @close="faultDialogClose">
			  <el-row type="flex" justify="space-around">
			  	 <el-col :span="11">
				    <el-card>
				      <el-form :model="formData" label-width="60px">
						  <el-form-item label="线路">
						    <el-select v-model="formData.selLine" placeholder="请选择线路" @change="selectLine">
						      <el-option v-for="item in formData.lines" :key="item.lineId" :label="item.lineNm" :value="item.lineId"></el-option>
						    </el-select>
						  </el-form-item>
						  <el-form-item label="起始站">
						    <el-select v-model="formData.selStartStation" placeholder="请选择车站">
						      <el-option v-for="item in formData.startStation" :key="item.stationId" :label="item.stationNm" :value="item.stationId"></el-option>
						    </el-select>
						  </el-form-item>
						  <el-form-item label="结束站">
						    <el-select v-model="formData.selEndStation" placeholder="请选择车站">
						      <el-option v-for="item in formData.endStation" :key="item.stationId" :label="item.stationNm" :value="item.stationId"></el-option>
						    </el-select>
						  </el-form-item>
						  <el-form-item label="类型">
						    <el-radio-group v-model="formData.ctype">
						      <el-radio :label="2">拥堵</el-radio>
						      <el-radio :label="3">故障</el-radio>
						      <el-radio :label="4">停运</el-radio>
						    </el-radio-group>
						  </el-form-item>
					 </el-form>
					 <el-button type="primary" @click="saveOd">保存</el-button>
				    </el-card>
				  </el-col>
				  
				  <el-col :span="12">
				    <el-card>
				      <div style="height:230px;overflow-y:scroll;margin-bottom:5px;">
				      	<el-checkbox-group v-model="selOdId">
					      	<div v-for="od in odIds">
					      		<el-checkbox :label="od.startStation+od.endStation" name="odId">
					      			{{od.startStationNm}}~{{od.endStationNm}}
					      			<span v-if="od.ctype=='2'">(拥堵)</span><span v-else-if="od.ctype=='3'">(故障)</span><span v-else-if="od.ctype=='4'">(停运)</span>
					      		</el-checkbox>
					      	</div>
					   	</el-checkbox-group>
					  </div>
					  <el-button type="primary" @click="clearOd">清空</el-button>
					  <el-button type="primary" @click="deleteOd">删除</el-button>
				    </el-card>
				  </el-col>
				  
			  </el-row>
			  
			  <span slot="footer" class="dialog-footer">
			    <el-button type="primary" @click="faultDialogClose">关闭</el-button>
			  </span>
		 </el-dialog>
		 
  	 </div>
  	 
      <script type="text/javascript">
        //控制级别要显示的车站
      	var show_statons=["巨峰路","耀华路","陕西南路","隆德路","虹桥火车站","曹杨路","长寿路","曲阜路","上海南站","宜山路","蓝村路","大木桥路","新天地","高科西路",
      		"人民广场","静安寺","世纪大道","龙漕路","镇坪路","中潭路","虹口足球场","大连路","西藏南路","东方体育中心","嘉善路","马当路",
      		"龙华中路","陆家浜路","南京东路","天潼路","漕宝路","徐家汇","汉中路","老西门","莘庄","虹桥路","东安路","罗山路","肇嘉浜路","嘉定新城",
      		"江苏路","龙阳路","海伦路","四平路","上海体育馆","常熟路","中山公园","延安西路","金沙江路","上海火车站","宝山路","交通大学","龙华","沈杜公路","长清路","成山路","东明路","华夏中路"];
        
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
				value4:'',
				showFlag:false,
				stationImgCir:[],
				showStreetFlag:false,
				showCameraFlag:false
			}
		  },
		  methods:{
			  //按钮点击放缩
			  svgScaling:function(nm){
				  var tp_g=$("svg g:first");
		    	  var trs=$(tp_g).attr("transform").toString().replace("matrix(","").replace(")","").split(",");
		    	  $(tp_g).attr("transform","matrix("+trs[0]*(1+nm)+","+trs[1]+","+trs[2]+","+trs[3]*(1+nm)+","+trs[4]+","+trs[5]+")");
			  },
			  //点击按钮
			  addStationImgBtn:function(flag){
				  var _this=this;
				  if(flag=="station"){
					  _this.showStreetFlag=false;
				  }else{
					  _this.showFlag=false;
				  }
				  if(_this.showFlag||_this.showStreetFlag){
					  if(_this.stationImgCir.length>0){//初始化清空“站层图”或“街区图”图标
						  $.each(_this.stationImgCir,function(i,v){
							 $(v).remove();
						  });
						  _this.stationImgCir.length=0;
					  }
					  
					  var g=$("g g g");
					  $.each(g,function(i,v){
						  var tp=$(v).find("circle");
						  var tp_cir=tp.clone();
						  
						  var loadImg=function(){
							  var imgNm=$(this).attr("stationName").split("-");
							  if(_this.showStreetFlag){
								  $(this).imgZoom("resource/streetImg/"+imgNm[1]+".jpg");
							  }else{
								  $(this).imgZoom("resource/stationImg/"+imgNm[0]+"/"+imgNm[1]+".jpg");
							  }
						  };
						  tp_cir.attr({"fill":"rgba(255,255,255,0.1)","r":"4"}).click(loadImg)[0].addEventListener('touchstart',loadImg,false);  
						  
						  _this.stationImgCir.push(tp_cir);
						  $(v).after(tp_cir);
					  });
				  }else{
					  //未在选中状态，清除“站层图”或“街区图”图标
					  $.each(_this.stationImgCir,function(i,v){
						 $(v).remove();
					  });
					  _this.stationImgCir.length=0;
				  }
			  },
			  addCameraImgBtn:function(){
				  //$(".el-dialog,.el-dialog--small").attr("style","top:10%;width:70%;");
				  showCamera(false,this.showCameraFlag);
			  },
			  optOd:function(){
				  ve.faultDialogVisible=true;
			  }
		  }
      	});
      
		ve=new Vue({
		  el: '#cameraId',
		  data:function(){
			return {
				dialogVisible: false,
				faultDialogVisible:false,
				cameraTitle:'',
				cameras:[],
				imgUrl:'',
				showImg:false,
				cameraData:[],
				cameraImg:[],
				formData:{
					selLine:"",
					selStartStation:"",
					selEndStation:"",
					lines:[],
					startStation:[],
					endStation:[],
					ctype:2//2-拥堵，3-故障，4-停运
				},
				stationsData:[],
				selOdId:[],
				odIds:[],
				isControl:true
			}
		  },
		  mounted:function(){
		 	this.initData();
		 	this.initOd();
		  },
		  methods: {
		      handleClose:function(done) {
		    	 this.dialogVisible=false;
		    	 this.faultDialogVisible=false;
		      },
		      startPlay:function () {
		    	  setTimeout(()=>{
			  	 	  $.each(ve.cameras,function(i,v){
		    			  videojs(v.camera_name).play();
		    		  });
		    	  },0);
			  },
			  pausePlay:function () {
				  this.dialogVisible = false;
		    	  $.each(ve.cameras,function(i,v){
	    			  videojs(v.camera_name).pause();
	    		  });
			  },
			  faultDialogClose:function(){
				  this.faultDialogVisible=false;
				  window.location.reload();
				  //loadDataAddAnime();
			  },
			  //初始化页面线路和车站数据
			  initData:function(){
				  var that=this;
				  $.post("tos/get_stations.action",{"flag":"station"},function(data){
					  this.stationsData=data;
					  $.each(data,function(i,v){
						  if(this.formData.lines.length==0||this.formData.lines[this.formData.lines.length-1].lineId!=v.LINE_ID){
							  this.formData.lines.push({lineId:v.LINE_ID,lineNm:v.LINE_ID+"号线"});
						  }
					  }.bind(that));
				  }.bind(that));
			  },
			  //选择线路，显示对应的车站事件
			  selectLine:function(p){
				  var that=this;
				  this.formData.startStation.length=0;
				  this.formData.endStation.length=0;
				  this.formData.selStartStation="";
				  this.formData.selEndStation="";
				  $.each(this.stationsData,function(i,v){
					  if(p==v.LINE_ID){
						  this.formData.startStation.push({stationId:v.STATION_ID,stationNm:v.STATION_NM});
				  		  this.formData.endStation.push({stationId:v.STATION_ID,stationNm:v.STATION_NM});
					  }
				  }.bind(that));
			  },
			  //初始化选择的故障断面
			  initOd:function(){
				  var that=this;
				  $.post("tos/get_stations.action",{"flag":"selOd"},function(data){
					  this.odIds=[];
					  $.each(data,function(i,v){
						  this.odIds.push(v);
					  }.bind(that));
				  }.bind(that));
			  },
			  //保存选择的故障od
			  saveOd:function(){
				  var that=this;
				  var param={
					  flag:"addOd",
					  lineId:this.formData.selLine,
				  	  startStation:this.formData.selStartStation,
				  	  endStation:this.formData.selEndStation,
				  	  startStationNm:"",
				  	  endStationNm:"",
				  	  ctype:this.formData.ctype
				  };
				  
				  $.each(this.formData.startStation,function(i,v){
					  if(v.stationId==this.formData.selStartStation){
						  param.startStationNm=v.stationNm;
						  return false;
					  }
				  }.bind(that));
				  
				  $.each(this.formData.endStation,function(i,v){
					  if(v.stationId==this.formData.selEndStation){
						  param.endStationNm=v.stationNm;
						  return false;
					  }
				  }.bind(that));
				  
				  if(param.lineId==""){
					  alert("请选择线路！");
					  return;
				  }
				  if(param.startStation==""){
					  alert("请选择起始车站！");
					  return;
				  }
				  if(param.endStation==""){
					  alert("请选择结束车站！");
					  return;
				  }
				  
				  doAjax({url:"tos/get_stations.action",data:param,successCallback:function(data){
	        	  	  if(data&&data.root=="success"){
						  that.initOd();
						  //alert("保存成功！"); 
					  }
				  }});
				  
			  },
			  deleteOd:function(){
				  if(this.selOdId.length<1){
					  alert("请选择删除选项！");
					  return;
				  }
				  doAjax({url:"tos/get_stations.action",data:{"flag":"delOd","odIds":this.selOdId},successCallback:function(data){
	        	  	  if(data&&data.root=="success"){
						  ve.initOd();
						  alert("删除成功！"); 
					  }
				  }});
			  },
			  clearOd:function(){
				  this.$confirm('确定要清空故障信息吗?', '提示', {
		            confirmButtonText: '确定',
		            cancelButtonText: '取消',
		            type: 'warning'
		          }).then(() => {
		        	  doAjax({url:"tos/get_stations.action",data:{"flag":"clearOd"},successCallback:function(data){
		        	  	  if(data&&data.root=="success"){
							  ve.initOd();
							  alert("清空成功！"); 
						  }
					  }});
		          }).catch(() => {});
				  
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
      		$.post("tos/get_tosstate.action",{"flag":"selOd"},function(dt){
      			if(dt.data&&dt.data.length>0){
      				ve.isControl=false;
      				svg.selectAll("circle").attr({opacity:".1",fillOpacity:"1",strokeWidth:"0",r:"2"});
				    svg.selectAll("path").attr({opacity:".4",fillOpacity:".1"});
				    svg.selectAll("text").attr({opacity:".1",fillOpacity:".1"});
				    svg.selectAll("image").attr({opacity:".1",fillOpacity:".1"});
				svg.selectAll("g g g>path").attr({opacity:".1",fillOpacity:".1"});
	      			
	      			$.each(dt.data,function(i,v){
	      				var tp_stations=v.ID.toString().split("-");
	      				
	      				//断面
	  					var tp1=$("#p"+v.ID).css({"opacity":"1","fill-opacity":"1","stroke-opacity":"1"});
	  					var tp2=$("#p"+v.RID).css({"opacity":"1","fill-opacity":"1","stroke-opacity":"1"});
	  					//车站
	  					$("#s"+tp_stations[0]).css({"opacity":"1","fill-opacity":"1","stroke-opacity":"1",strokeWidth:"2",r:"4"});
	  					$("#s"+tp_stations[1]).css({"opacity":"1","fill-opacity":"1","stroke-opacity":"1",strokeWidth:"2",r:"4"});
	  					$("#s"+tp_stations[0]).parent().children().css({"opacity":"1","fill-opacity":"1","stroke-opacity":"1",strokeWidth:"2",r:"4"});
	  					$("#s"+tp_stations[1]).parent().children().css({"opacity":"1","fill-opacity":"1","stroke-opacity":"1",strokeWidth:"2",r:"4"});
	  					
	  					//车站名称
	  					$("#"+v.STATION_NM_START).css({"opacity":"1","fill-opacity":"1","stroke-opacity":"1"});
	  					$("#"+v.STATION_NM_END).css({"opacity":"1","fill-opacity":"1","stroke-opacity":"1"});
	  					
	  					var tp_color="rgba(19,37,56,1)";
	  					if(v.CTYPE=="2"||v.CTYPE=="3"){
	   						tp_color="#FFF100";
	      				}else if(v.CTYPE=="4"){
	      					tp_color="#FF0000";
	      				}
	  					
	  					var tp3;
	  					if(tp1.attr("od")){
	  						tp3=tp1.clone().attr({"d":tp1.attr("od"),"stroke-width":"3","stroke":tp_color,"id":"od"+v.ID}).css({"opacity":"1","fill-opacity":"1","stroke-opacity":"1"});
	  					}else{
	  						tp3=tp1.clone().attr({"d":tp2.attr("od"),"stroke-width":"3","stroke":tp_color,"id":"od"+v.ID}).css({"opacity":"1","fill-opacity":"1","stroke-opacity":"1","animation-direction":"reverse"});
	  					}
	  					tp1.after(tp3);
	      					
	   					if(v.CTYPE=="2"){
	   						tp3.attr("class","downpath");
	      				}else if(v.CTYPE=="3"||v.CTYPE=="4"){
	      					addAnime("#od"+v.ID,tp_color);
	      					if(tp_stations[0]==tp_stations[1]){
	      						$("#s"+tp_stations[0]).attr({"stroke":tp_color});
	      						addAnime1("#s"+tp_stations[0],tp_color);
	      					}
	      				}
	      				
	      			});
      			}
      			
      			//下方提示信息，字幕滚动
      			$('#moveTextId').html(dt.title);
      			var scrollWidth = $('.contentCls').width();
		        var textWidth = $('#moveTextId').width();
		        var i = scrollWidth;
		        setInterval(function() {
		            i--;
		            if(i < -textWidth ) {
		                i = scrollWidth;
		            }
		            $('#moveTextId').css({"left":i+"px"});
		        }, 20);
      			
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
      	function addAnime1(pid,cor){
      		anime({
			  targets:pid,
			  stroke: [
    			{value: 'rgba(19,37,56,1)'},
    			{value:cor}
			  ],
			  easing: 'linear',
  			  direction: 'alternate',
              duration: 500,
              loop: true
		   });
      	}
      	
      	//初始化“摄像头”信息，控制显示和隐藏“摄像头”图标
      	function showCamera(initFlag,showFlag){
      		if(initFlag){
				cameraImg:[]
      			//加载“摄像头”信息
	      		$.post("tos/get_camera.action",function(data){
	      			ve.cameraData=data;
				});
      		}
      		if(showFlag){
      			addCameraImg(ve.cameraData);
      		}else{
      			$.each(ve.cameraImg,function(i,v){
      				$(v).remove();
      			});
      			ve.cameraImg.length=0;
      		}
      	}
      	
      	//添加“摄像头”图标
      	function addCameraImg(data){
      		$.each(data,function(i,v){
				var tp1=$("#s罗山路");
				var tp2=tp1.clone().attr({"id":v.group_name,"xlink:href":"style/images/camera.png","x":v.x,"y":v.y,"width":"10","height":"10"}).css({"opacity":"1","fill-opacity":"1","stroke-opacity":"1"});
				var showCamera=function(){
					ve.cameraTitle=v.group_name;
	   				ve.cameras=v.cameras;
	   				ve.showImg=false;
	   				ve.dialogVisible = true;
				};
				tp2.click(showCamera)[0].addEventListener('touchstart',showCamera,false);
				ve.cameraImg.push(tp2);
	   			tp1.after(tp2);
			});
      	}
      	
      	//控制字体放缩，和车站移动
      	function cslTextAndCircle(){
		    //点击车站，让车站移动到屏幕中央
		    var screenWidth=$(document.body).width()/2;
		    var screenHeight=$(document.body).height()/2;
		    var mvToCenter=function(){
		    	var cx_old=$(this).attr("mx");
		    	var cy_old=$(this).attr("my");
		    	var tp_g=$("svg g:first");
		    	var trs=$(tp_g).attr("transform").toString().replace("matrix(","").replace(")","").split(",");
		    	var cx_new=screenWidth-cx_old*trs[0];
		    	var cy_new=screenHeight-cy_old*trs[3];
		    	$(tp_g).attr("transform","matrix("+trs[0]+","+trs[1]+","+trs[2]+","+trs[3]+","+cx_new+","+cy_new+")");
		    };
		    $("g g g").click(mvToCenter);
			$.each($("g g g"),function(i,v){
				v.addEventListener('touchstart',mvToCenter,false);
			});
      	}
      	
      	//加载svg文件
      	function loadSvg(){
			if($("svg")){
      			$("svg").remove();
      		}
      		s = Snap();
      		//加载svg文件
      		Snap.load("pages/tosnew/line_updown4.svg", function (f) {
			    svg = f.select("svg").select("g");
			    s.append(svg);
			    //设置鼠标拖拽、滚动图像进行放大和缩小
			    s.zpd();
			    s.panTo('140', '-150');
			    
			    if(ve.isControl){
			    	svg.selectAll("text").attr({opacity:".1",fillOpacity:".1"});
	        		$.each(show_statons,function(i,v){
	        			Snap.select("#"+v).attr({opacity:"1",fillOpacity:"1"});
	        		});
				    $('body').mousewheel(function(event,da) {
				    	if(ve.isControl){
				    		ctlTxt();
				    	}
				    });

				var ctlTxt=function(){
			var trs=$("svg g:first").attr("transform").toString().replace("matrix(","").replace(")","").split(",");
		    	if(trs[0]>1.7){
		    		svg.selectAll("text").attr({opacity:"1",fillOpacity:"1"});
		    	}else{
		    		svg.selectAll("text").attr({opacity:".1",fillOpacity:".1"});
	        		$.each(show_statons,function(i,v){
	        			Snap.select("#"+v).attr({opacity:"1",fillOpacity:"1"});
	        		});
		    	}
		}
		   

		var hammertime = new Hammer(document);
        	hammertime.get('pinch').set({ enable: true });
        	hammertime.on("pinchin", function(){
			if(ve.isControl){
				    		ctlTxt();
				    	}
		});
        	hammertime.on("pinchout", function(){
			if(ve.isControl){
				    		ctlTxt();
				    	}
		});

			    }
			    
			    //控制字体放缩，和车站移动
      			cslTextAndCircle();
			    
			    //加载数据并添加动画
			    loadDataAddAnime();
			    
			    //setInterval('loadDataAddAnime()',1000);
			    
			    showCamera(true,false);
			    
			    //线路及图标添加点击事件，点击时跳转相关线路的车站客流排名
			    $(".lineIcon").click(function(){
			    	window.parent.clickChart('2',null);
			    	$("#l"+$(this).attr("lineNm"),window.parent.document).click();
			    });
			    
		    });
      		
      	}
      	
      	
      </script>
  </body>
</html>