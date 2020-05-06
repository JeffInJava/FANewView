<%@ page language="java" import="java.util.*,java.lang.*,net.sf.json.*,java.sql.*,java.text.*,java.io.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
Calendar cal = Calendar.getInstance();
String startDate=sdf.format(cal.getTime());
cal.add(Calendar.DATE, -7);
String comDate=sdf.format(cal.getTime());
%>

<!DOCTYPE html>
<html>
  <head>
  <base href="<%=basePath%>">
    <title>车站客流</title>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link rel="stylesheet" href="resource/element-ui/index.css" />
	<link rel="stylesheet" href="resource/b/css/style.css" />

	
	<script src="resource/anime/jquery-1.11.1.min.js"></script> 
	<script src="resource/fontactive/js/modernizr.js"></script>
	<script src="resource/fontactive/js/main.js"></script>
	
	<script src="resource/anime/anime.min.js"></script>
	
	<script src="resource/anime/countUp.min.js"></script> 
	<script src="resource/vue/vue.min.js"></script>
    <script src="resource/element-ui/index.js"></script>
    <script src="resource/js/common.js"></script>
    <script src="resource/js/moment.min.js"></script>
    
    <script src="resource/echarts3/echarts.min.js"></script>
    <script src="resource/js/hammer.js"></script>
    <script src="resource/js/jquery.drag.js"></script>
	<style>
		html,body{
			width:100%;
			height:100%;
			overflow:hidden;
			background-color:#393c48;
		}
	</style>
  </head>
  
  <body style="">
  	  <div id="app" style="width:100%;height:100%;">
  		<el-row style="padding-top:10px;padding-left:20px;">
		  <el-col :span="4">
			  <div class="block">
			    <span class="demonstration" style="font-size: 14px;color:#ffffff ">当前日期</span>
			    <el-date-picker style="width:130px;" v-model="startDate" type="date" placeholder="当前日期" format="yyyyMMdd" value-format="yyyyMMdd" size="small"></el-date-picker>
			  </div>
		  </el-col>
		  <el-col :span="4">
			  <div class="block">
			    <span class="demonstration" style="font-size: 14px;color:#ffffff ">对比日期</span>
			    <el-date-picker style="width:130px;" v-model="comDate" type="date" placeholder="对比日期" format="yyyyMMdd" value-format="yyyyMMdd" size="small"></el-date-picker>
			  </div>
		  </el-col>
		  <el-col :span="4">
		  	  <div class="block">
			    <span class="demonstration" style="font-size: 14px;color:#ffffff ">线路</span>
			    <el-select placeholder="请选择"  style="width:135px;" size="small" v-model="lineId" @change="changeLine">
				    <el-option v-for="item in lines" :key="item.value" :label="item.label" :value="item.value"></el-option>
				</el-select>
			  </div>
		  </el-col>
		  <el-col :span="4">
		  	  <div class="block">
				<span class="demonstration" style="font-size: 14px;color:#ffffff ">车站</span>
			    <el-select style="width:130px;" v-model="stationId" placeholder="请选择" size="small" @change="changeStation">
				    <el-option v-for="item in stations" :key="item.value" :label="item.label" :value="item.value"></el-option>
				</el-select>
			  </div>
		  </el-col>
		  <el-col :span="3">
		  	<div style="width:135px;">
			  	<input type="checkbox" checked class="demonstration" name="flag" value="1"><span style="font-size: 14px;color:#ffffff ">进站</span></input>
				<input type="checkbox" class="demonstration" name="flag" value="2"><span style="font-size: 14px;color:#ffffff ">出站</span></input>
				<input type="checkbox"  checked class="demonstration" name="flag" value="3"><span style="font-size: 14px;color:#ffffff ">换乘</span></input>
			</div>
		  </el-col>
		  <el-col :span="3"><el-button type="primary" @click="getStationFlow()" size="small">查询</el-button></el-col>
		</el-row>
	
		<el-row>
			<div id="stationFlow" style="width:100%;height:600px;margin-top:20px;padding:0px 20px"></div>
		</el-row>	
   </div>
  	  
      <script type="text/javascript">
		new Vue({
		  el: '#app',
		  data:function(){
			return {
				startDate:new Date("<%=startDate%>"),
		        comDate:new Date("<%=comDate%>"),
		        lines:[],
		        lineId:'01',
		        stations:[],
		        stationId:'',
		        stationAll:null,
		        option:null,
		        lineNm:'1号线',
		        stationNm:''
			};
		  },
		  mounted: function () {
		      this.initData();
          },
		  methods: {
			  initData:function(){
				  var _this=this;
				  $.post("sysmanage/search_linestationall.action",function(lineData){
					  $.each(lineData.line,function(i,v){
						  _this.lines.push({"value":v[0],"label":v[1]});
					  });
					  _this.stationAll=lineData.station;
					  _this.changeLine();
				  });
			  },
			  changeLine:function(val){
				  var _this=this;
				  _this.stations=[];
				  _this.stationId='';
				  _this.stations.push({"value":"","label":"------全线------"});
				  $.each(_this.stationAll,function(i,v){
					  if(v.lineId==_this.lineId){
						  _this.stations.push({"value":v.stationId,"label":v.stationName});
					  }
				  });
				  
				  let obj = _this.lines.find(item => {
			          return item.value === val;
			      });
				  if(obj){
					  _this.lineNm=obj.label.substr(4);
				  }else{
					  _this.lineNm=null;
				  }
			  },
			  changeStation:function(val){
				  let obj = this.stationAll.find(item => {
			          return item.stationId === val;
			      });
				  if(obj){
					  this.stationNm = obj.stationName;
				  }else{
					  this.stationNm=null;
				  }
			  },
			  getStationFlow:function(){
				  var _this=this;
				  var startDate=moment(_this.startDate).format("YYYYMMDD");
				  var comDate=moment(_this.comDate).format("YYYYMMDD");
				  var chkvalue = [];
				  $('input[name="flag"]:checked').each(function(){
					 　　　chkvalue.push($(this).val());
					});
				 var ckflag = chkvalue.join(",");
				  
				  $.post("station/get_station_periodflux.action",{"startDate":startDate,
				  "comDate":comDate,"lineId":_this.lineId,"stationId":_this.stationId,"ckflag":ckflag},function(data){
					  _this.initChart();
					  _this.option.legend.data=[startDate,comDate];
					  _this.option.series[0].name=comDate;
					  _this.option.series[1].name=startDate;
					  $.each(data,function(i,v){
						  _this.option.xAxis[0].data.push(v.PERIOD);
						  _this.option.series[0].data.push(v.CP_TIMES);
						  _this.option.series[1].data.push(v.TIMES);
					  });
					
					  var myChart = echarts.init(document.querySelector('#stationFlow'));
					  myChart.setOption(_this.option);
				  });
			  },
		  	  //绘制折线图
		  	  initChart:function(){
		  		 var vueThis=this;
		  		 var selfTitle="";
		  		 if(vueThis.stationNm){
		  			selfTitle=vueThis.stationNm+'分时客流';
		  		 }else{
		  			selfTitle=vueThis.lineNm+'分时客流';
		  		 }
				 vueThis.option = {
				    title: {
				        text: selfTitle,
				        textStyle: { fontStyle:'normal',fontWeight:'bold',fontSize:16,color:'#FFFfff'}
				    },
				    tooltip: {
				        trigger: 'axis',
				        textStyle: {fontWeight:'bold',fontSize:15}
				    },
				    legend: {
				    	 orient: 'horizontal', 
					     x: 'center', 
					     y: '10px', 
					     textStyle: {color: '#ffffff'},
				         data:[]
				    },
				    grid: {
				        x:'80px',
				        x1:'0',
				        y:'80px',
				        y1:'50px'
				    },
				    xAxis: [{
				        type: 'category',
				        boundaryGap: false,
				        axisLine: {lineStyle: {color: '#FFFfff', width: 2}},
				        data: []
				    }],
				    yAxis: {
				        type: 'value',
				        name: '单位：人次',
				        nameTextStyle:{
	                        color:"#FFF",
	                        fontSize:'15'
	                    },
                    	splitLine: {lineStyle: {type: 'dashed',color:'#FFFfff',width:0.7}},
                    	axisLine: {lineStyle: {color: '#FFFfff', width: 2}},
	                    axisLabel: {
	                        textStyle: {fontWeight: 'bold', fontSize: 13, color: '#FFFfff'}
	                    },
				        data: []
				    },
				    series: [
				        {
				        	name:"",
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#32d2ca'}},
				            areaStyle: {normal: {}},
				            data:[]
				        },
				        {
				        	name:"",
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#ED3229'}},
				            areaStyle: {normal: {}},
				            data:[]
				        }
				      ]
					};
		  		}
		  
		    }
		});
      </script>
  </body>
</html>