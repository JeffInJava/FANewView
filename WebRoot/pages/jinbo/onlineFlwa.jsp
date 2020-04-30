<%@ page language="java" import="java.util.*,java.lang.*,net.sf.json.*,java.sql.*,java.text.*,java.io.*" pageEncoding="UTF-8"%>
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
	
	<link rel="stylesheet" href="resource/element-ui/index.css" />
	<link rel="stylesheet" href="resource/b/css/style.css" />

	
	<script src="resource/anime/jquery-1.11.1.min.js"></script> 
	<script src="resource/fontactive/js/modernizr.js"></script>
	<script src="resource/fontactive/js/main.js"></script>
	
	<!-- <script src="resource/jquery/js/jquery-1.9.1.min.js"></script> -->
	<script src="resource/anime/anime.min.js"></script>
	
	<script src="resource/anime/countUp.min.js"></script> 
	<script src="resource/vue/vue.min.js"></script>
    <script src="resource/element-ui/index.js"></script>
    <script src="resource/js/common.js"></script>
    <script src="resource/js/moment.min.js"></script>
    
    <script src="resource/echarts3/echarts.min.js"></script>
    <script src="resource/js/hammer.js"></script>
    <script src="resource/js/jquery.drag.js"></script>
   
   
    
  
	<style type="text/css">
	
	body{
		background:#043735;
	}
	
</style>
  </head>
  
  <body>
  	  <div id="pfwd" style="">
  		<el-row style="    padding-top: 1%;padding-left: 2%;">
			  <el-col :span="6">
			  <div class="block">
			    <span class="demonstration" style="font-size: 14px;color:#ffffff ">当前日期</span>
			    <el-date-picker
			      v-model="temDate"
			      align="right"
			      type="date"
			      placeholder="当前日期"
			      format="yyyyMMdd"
			      value-format="yyyyMMdd"
			      >
			    </el-date-picker>
			  </div></el-col>
			  <el-col :span="6"><div class="block">
			    <span class="demonstration" style="font-size: 14px;color:#ffffff ">对比日期</span>
			    <el-date-picker
			      v-model="compDate"
			      align="right"
			      type="date"
			      placeholder="对比日期"
			      format="yyyyMMdd"
			      value-format="yyyyMMdd"
			      >
			    </el-date-picker>
			  </div></el-col>
			  <el-col :span="3"><el-button type="primary" @click="getOnlineFlow()">查询</el-button></el-col>
			  <el-col :span="9"></el-col>
			</el-row>
			<el-row>
				<div style="width:100%;height:1px;margin-top: 15px;background-color: #ffffff;"></div>
			</el-row>
			<el-row>
				<ul id="lns" class="site_select_list" style="margin-left: 30px;    margin-top: 7px;">
				 	  <li class="color_00 " id="c00" @click="switchLine('00')"><div>全线</div><span>&nbsp;</span>
				 	  	<div v-show="l00" style="float: left;margin-top: 0px;margin-left: 0px;">
		                	<img src="resource/b/images/log/light-top.png" style="position: absolute;margin-left: -12px;margin-top: 16px;" alt=""/>
		                	<img src="resource/b/images/log/light.png" style="position: absolute;margin-left: -76px;margin-top: 22px;" alt=""/>
		           		 </div>
				 	  </li>
				      <li class="color_1" id="c01" @click="switchLine('01')"><div>1号线</div><span>&nbsp;</span>
				      	<div v-show="l01" style="float: left;margin-top: 0px;margin-left: 0px;">
		                	<img src="resource/b/images/log/light-top.png" style="position: absolute;margin-left: -12px;margin-top: 16px;" alt=""/>
		                	<img src="resource/b/images/log/light.png" style="position: absolute;margin-left: -76px;margin-top: 22px;" alt=""/>
		           		 </div>
				      </li>
				      <li class="color_2" id="c02" @click="switchLine('02')"><div>2号线</div><span>&nbsp;</span>
				      	<div v-show="l02" style="float: left;margin-top: 0px;margin-left: 0px;">
		                	<img src="resource/b/images/log/light-top.png" style="position: absolute;margin-left: -12px;margin-top: 16px;" alt=""/>
		                	<img src="resource/b/images/log/light.png" style="position: absolute;margin-left: -76px;margin-top: 22px;" alt=""/>
		           		 </div>
				      </li>
				      <li class="color_3" id="c03" @click="switchLine('03')"><div>3号线</div><span>&nbsp;</span>
				      	<div v-show="l03" style="float: left;margin-top: 0px;margin-left: 0px;">
		                	<img src="resource/b/images/log/light-top.png" style="position: absolute;margin-left: -12px;margin-top: 16px;" alt=""/>
		                	<img src="resource/b/images/log/light.png" style="position: absolute;margin-left: -76px;margin-top: 22px;" alt=""/>
		           		 </div>
				      </li>
				      <li class="color_4" id="c04" @click="switchLine('04')"><div>4号线</div><span>&nbsp;</span>
				      	<div v-show="l04" style="float: left;margin-top: 0px;margin-left: 0px;">
		                	<img src="resource/b/images/log/light-top.png" style="position: absolute;margin-left: -12px;margin-top: 16px;" alt=""/>
		                	<img src="resource/b/images/log/light.png" style="position: absolute;margin-left: -76px;margin-top: 22px;" alt=""/>
		           		 </div>
				      </li>
				      <li class="color_5" id="c05" @click="switchLine('05')"><div>5号线</div><span>&nbsp;</span>
				      	<div v-show="l05" style="float: left;margin-top: 0px;margin-left: 0px;">
		                	<img src="resource/b/images/log/light-top.png" style="position: absolute;margin-left: -12px;margin-top: 16px;" alt=""/>
		                	<img src="resource/b/images/log/light.png" style="position: absolute;margin-left: -76px;margin-top: 22px;" alt=""/>
		           		 </div>
				      </li>
				      <li class="color_6" id="c06" @click="switchLine('06')"><div>6号线</div><span>&nbsp;</span>
				      	<div v-show="l06" style="float: left;margin-top: 0px;margin-left: 0px;">
		                	<img src="resource/b/images/log/light-top.png" style="position: absolute;margin-left: -12px;margin-top: 16px;" alt=""/>
		                	<img src="resource/b/images/log/light.png" style="position: absolute;margin-left: -76px;margin-top: 22px;" alt=""/>
		           		 </div>
				      </li>
				      <li class="color_7" id="c07" @click="switchLine('07')"><div>7号线</div><span>&nbsp;</span>
				      	<div v-show="l07" style="float: left;margin-top: 0px;margin-left: 0px;">
		                	<img src="resource/b/images/log/light-top.png" style="position: absolute;margin-left: -12px;margin-top: 16px;" alt=""/>
		                	<img src="resource/b/images/log/light.png" style="position: absolute;margin-left: -76px;margin-top: 22px;" alt=""/>
		           		 </div>
				      </li>
				      <li class="color_8" id="c08" @click="switchLine('08')"><div>8号线</div><span>&nbsp;</span>
				      	<div v-show="l08" style="float: left;margin-top: 0px;margin-left: 0px;">
		                	<img src="resource/b/images/log/light-top.png" style="position: absolute;margin-left: -12px;margin-top: 16px;" alt=""/>
		                	<img src="resource/b/images/log/light.png" style="position: absolute;margin-left: -76px;margin-top: 22px;" alt=""/>
		           		 </div>
				      </li>
				      <li class="color_9" id="c09" @click="switchLine('09')"><div>9号线</div><span>&nbsp;</span>
				      	<div v-show="l09" style="float: left;margin-top: 0px;margin-left: 0px;">
		                	<img src="resource/b/images/log/light-top.png" style="position: absolute;margin-left: -12px;margin-top: 16px;" alt=""/>
		                	<img src="resource/b/images/log/light.png" style="position: absolute;margin-left: -76px;margin-top: 22px;" alt=""/>
		           		 </div>
				      </li>
				      <li class="color_10" id="c10" @click="switchLine('10')"><div>10号线</div><span>&nbsp;</span>
				      	<div v-show="l10" style="float: left;margin-top: 0px;margin-left: 0px;">
		                	<img src="resource/b/images/log/light-top.png" style="position: absolute;margin-left: -12px;margin-top: 16px;" alt=""/>
		                	<img src="resource/b/images/log/light.png" style="position: absolute;margin-left: -76px;margin-top: 22px;" alt=""/>
		           		 </div>
				      </li>
				      <li class="color_11" id="c11" @click="switchLine('11')"><div>11号线</div><span>&nbsp;</span>
				      	<div v-show="l11" style="float: left;margin-top: 0px;margin-left: 0px;">
		                	<img src="resource/b/images/log/light-top.png" style="position: absolute;margin-left: -12px;margin-top: 16px;" alt=""/>
		                	<img src="resource/b/images/log/light.png" style="position: absolute;margin-left: -76px;margin-top: 22px;" alt=""/>
		           		 </div>
				      </li>
				      <li class="color_12" id="c12" @click="switchLine('12')"><div>12号线</div><span>&nbsp;</span>
				      	<div v-show="l12" style="float: left;margin-top: 0px;margin-left: 0px;">
		                	<img src="resource/b/images/log/light-top.png" style="position: absolute;margin-left: -12px;margin-top: 16px;" alt=""/>
		                	<img src="resource/b/images/log/light.png" style="position: absolute;margin-left: -76px;margin-top: 22px;" alt=""/>
		           		 </div>
				      </li>
				      <li class="color_13" id="c13" @click="switchLine('13')"><div>13号线</div><span>&nbsp;</span>
				      	<div v-show="l13" style="float: left;margin-top: 0px;margin-left: 0px;">
		                	<img src="resource/b/images/log/light-top.png" style="position: absolute;margin-left: -12px;margin-top: 16px;" alt=""/>
		                	<img src="resource/b/images/log/light.png" style="position: absolute;margin-left: -76px;margin-top: 22px;" alt=""/>
		           		 </div>
				      </li>
				      <li class="color_16" id="c16" @click="switchLine('16')"><div>16号线</div><span>&nbsp;</span>
				      	<div v-show="l16" style="float: left;margin-top: 0px;margin-left: 0px;">
		                	<img src="resource/b/images/log/light-top.png" style="position: absolute;margin-left: -12px;margin-top: 16px;" alt=""/>
		                	<img src="resource/b/images/log/light.png" style="position: absolute;margin-left: -76px;margin-top: 22px;" alt=""/>
		           		 </div>
				      </li>
				 	  <li class="color_17" id="c17" @click="switchLine('17')"><div>17号线</div><span>&nbsp;</span>
				 	  	<div v-show="l17" style="float: left;margin-top: 0px;margin-left: 0px;">
		                	<img src="resource/b/images/log/light-top.png" style="position: absolute;margin-left: -12px;margin-top: 16px;" alt=""/>
		                	<img src="resource/b/images/log/light.png" style="position: absolute;margin-left: -76px;margin-top: 22px;" alt=""/>
		           		 </div>
				 	  </li>
				 	  <li class="color_41" id="c41" @click="switchLine('41')"><div>浦江线</div><span>&nbsp;</span>
				 	  	<div v-show="l41" style="float: left;margin-top: 0px;margin-left: 0px;">
		                	<img src="resource/b/images/log/light-top.png" style="position: absolute;margin-left: -12px;margin-top: 16px;" alt=""/>
		                	<img src="resource/b/images/log/light.png" style="position: absolute;margin-left: -76px;margin-top: 22px;" alt=""/>
		           		 </div>
				 	  </li>
				 </ul>
			</el-row>
			<el-row>
				<div style="width:100%;height:1px;margin-top: 8px;background-color: #ffffff;"></div>
			</el-row>
			
			<el-row>
				<div id="olfc" style="width:1200px;height:500px;margin-top: 36px;padding:30px 20px"></div>
			</el-row>	
  	  </div>
  	  
      <script type="text/javascript">
      //自定义一个过滤器，用于在页面上显示年月日格式
		/* 	Vue.filter('numFormat',function(num){
			
				var nums=parseInt(num);
				return nums;
			}); */
			       
		new Vue({
		  el: '#pfwd',
		  data:function(){
			return {
				
        temDate: Date.now(),
        compDate:'',
        todayda:'',
        timeDt:'',
        wktimeDt:'',
        legen:[],
        olchar:'',
        olflData:'',
        olcharOption:'',
        l00:false,
        l01:false,
        l02:false,
        l03:false,
        l04:false,
        l05:false,
        l06:false,
        l07:false,
        l08:false,
        l09:false,
        l10:false,
        l11:false,
        l12:false,
        l13:false,
        l17:false,
        l41:false,
        l16:false,
			
			}
		  },
		    mounted: function () {
		    
		    this.getDate();
		    
		  	
			this.getOnlineFlow();


        },
		  methods: {
		  
		  //获取日期
		  getDate:function(){
		  	var vueThis=this;
		  	var date = new Date();
		    var seperator1 = "-";
		    var seperator2 = ":";
		    var month = date.getMonth() + 1;
		    var strDate = date.getDate();
		    if (month >= 1 && month <= 9) {
		        month = "0" + month;
		    }
		    if (strDate >= 0 && strDate <= 9) {
		        strDate = "0" + strDate;
		    }
		    
		    
		    var currentdate = date.getFullYear() + month + strDate;
		    vueThis.todayda=currentdate;
		    var today = new Date();
		     today.setTime(today.getTime() - 3600 * 1000 * 24*7);
		    
		      var wkmonth = today.getMonth() + 1;
		    var wkDate = today.getDate();
		    if (wkmonth >= 1 && wkmonth <= 9) {
		        wkmonth = "0" + wkmonth;
		    }
		    if (wkDate >= 0 && wkDate <= 9) {
		        wkDate = "0" + wkDate;
		    }
		    var wda=today.getFullYear()+wkmonth+wkDate;
		    var wknow=today.getTime()- 3600 * 1000 * 24*7
		    vueThis.compDate=wknow;
		    
		         
		    return currentdate;
		  },
		  //线路切换
		  switchLine:function(val){
		  	var vueThis=this;
		  	vueThis.olchar.clear();
		  	var data=vueThis.olflData;
		  	vueThis.olcharOption.series=[];
		  	if(val=='01'){
		  		 
		  		$("#c"+val).addClass("c"+val);
		  		$("#c02").removeClass("c02");
		  		$("#c03").removeClass("c03");
		  		$("#c04").removeClass("c04");
		  		$("#c05").removeClass("c05");
		  		$("#c06").removeClass("c06");
		  		$("#c07").removeClass("c07");
		  		$("#c08").removeClass("c08");
		  		$("#c09").removeClass("c09");
		  		$("#c10").removeClass("c10");
		  		$("#c11").removeClass("c11");
		  		$("#c12").removeClass("c12");
		  		$("#c13").removeClass("c13");
		  		$("#c16").removeClass("c16");
		  		$("#c17").removeClass("c17");
		  		$("#c41").removeClass("c41");
		  		$("#c00").removeClass("c00");
		  		vueThis.l00=false;
		  		vueThis.l01=true;
		  		vueThis.l02=false;
		  		vueThis.l03=false;
		  		vueThis.l04=false;
		  		vueThis.l05=false;
		  		vueThis.l06=false;
		  		vueThis.l07=false;
		  		vueThis.l08=false;
		  		vueThis.l09=false;
		  		vueThis.l10=false;
		  		vueThis.l11=false;
		  		vueThis.l12=false;
		  		vueThis.l13=false;
		  		vueThis.l16=false;
		  		vueThis.l17=false;
		  		vueThis.l41=false;
		  		
		  		vueThis.olcharOption.title.text="1号线在线客流";
		  		  vueThis.olcharOption.series.push(
		  		   	 {
				            name:vueThis.wktimeDt,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#32d2ca'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:data.lineT[0].cpTimes
				        }
		  		   );
		  		    vueThis.olcharOption.series.push(
		  		   	 {
				            name:vueThis.timeDt,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#ED3229'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:data.lineT[0].times
				        }
		  		   );
		  		 
		  		  
		  		   vueThis.olchar.setOption(vueThis.olcharOption);
		  	}
		  	if(val=='02'){
		  		
		  		$("#c"+val).addClass("c"+val);
		  		$("#c01").removeClass("c01");
		  		$("#c03").removeClass("c03");
		  		$("#c04").removeClass("c04");
		  		$("#c05").removeClass("c05");
		  		$("#c06").removeClass("c06");
		  		$("#c07").removeClass("c07");
		  		$("#c08").removeClass("c08");
		  		$("#c09").removeClass("c09");
		  		$("#c10").removeClass("c10");
		  		$("#c11").removeClass("c11");
		  		$("#c12").removeClass("c12");
		  		$("#c13").removeClass("c13");
		  		$("#c16").removeClass("c16");
		  		$("#c17").removeClass("c17");
		  		$("#c41").removeClass("c41");
		  		$("#c00").removeClass("c00");
		  		vueThis.l00=false;
		  		vueThis.l02=true;
		  		vueThis.l01=false;
		  		vueThis.l03=false;
		  		vueThis.l04=false;
		  		vueThis.l05=false;
		  		vueThis.l06=false;
		  		vueThis.l07=false;
		  		vueThis.l08=false;
		  		vueThis.l09=false;
		  		vueThis.l10=false;
		  		vueThis.l11=false;
		  		vueThis.l12=false;
		  		vueThis.l13=false;
		  		vueThis.l16=false;
		  		vueThis.l17=false;
		  		vueThis.l41=false;
		  		vueThis.olcharOption.title.text="2号线在线客流";
		  		 vueThis.olcharOption.series.push(
		  		   	 {
				            name:vueThis.wktimeDt,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#32d2ca'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:data.lineT[1].cpTimes
				        }
		  		   );
		  		    vueThis.olcharOption.series.push(
		  		   	 {
				            name:vueThis.timeDt,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#ED3229'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:data.lineT[1].times
				        }
		  		   );
		  		  
		  		  
		  		   vueThis.olchar.setOption(vueThis.olcharOption);
		  	}
		  	if(val=='03'){
		  		
		  		$("#c"+val).addClass("c"+val);
		  		$("#c01").removeClass("c01");
		  		$("#c02").removeClass("c02");
		  		$("#c04").removeClass("c04");
		  		$("#c05").removeClass("c05");
		  		$("#c06").removeClass("c06");
		  		$("#c07").removeClass("c07");
		  		$("#c08").removeClass("c08");
		  		$("#c09").removeClass("c09");
		  		$("#c10").removeClass("c10");
		  		$("#c11").removeClass("c11");
		  		$("#c12").removeClass("c12");
		  		$("#c13").removeClass("c13");
		  		$("#c16").removeClass("c16");
		  		$("#c17").removeClass("c17");
		  		$("#c41").removeClass("c41");
		  		$("#c00").removeClass("c00");
		  		vueThis.l00=false;
		  		vueThis.l03=true;
		  		vueThis.l01=false;
		  		vueThis.l02=false;
		  		vueThis.l04=false;
		  		vueThis.l05=false;
		  		vueThis.l06=false;
		  		vueThis.l07=false;
		  		vueThis.l08=false;
		  		vueThis.l09=false;
		  		vueThis.l10=false;
		  		vueThis.l11=false;
		  		vueThis.l12=false;
		  		vueThis.l13=false;
		  		vueThis.l16=false;
		  		vueThis.l17=false;
		  		vueThis.l41=false;
		  		vueThis.olcharOption.title.text="3号线在线客流";
		  		vueThis.olcharOption.series.push(
		  		   	 {
				            name:vueThis.wktimeDt,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#32d2ca'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:data.lineT[2].cpTimes
				        }
		  		   );
		  		    vueThis.olcharOption.series.push(
		  		   	 {
				            name:vueThis.timeDt,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#ED3229'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:data.lineT[2].times
				        }
		  		   );
		  		   
		  		  
		  		   vueThis.olchar.setOption(vueThis.olcharOption);
		  	}	
		  	if(val=='04'){
		  		
		  		$("#c"+val).addClass("c"+val);
		  		$("#c01").removeClass("c01");
		  		$("#c02").removeClass("c02");
		  		$("#c03").removeClass("c03");
		  		$("#c05").removeClass("c05");
		  		$("#c06").removeClass("c06");
		  		$("#c07").removeClass("c07");
		  		$("#c08").removeClass("c08");
		  		$("#c09").removeClass("c09");
		  		$("#c10").removeClass("c10");
		  		$("#c11").removeClass("c11");
		  		$("#c12").removeClass("c12");
		  		$("#c13").removeClass("c13");
		  		$("#c16").removeClass("c16");
		  		$("#c17").removeClass("c17");
		  		$("#c41").removeClass("c41");
		  		$("#c00").removeClass("c00");
		  		vueThis.l00=false;
		  		vueThis.l04=true;
		  		vueThis.l01=false;
		  		vueThis.l02=false;
		  		vueThis.l03=false;
		  		vueThis.l05=false;
		  		vueThis.l06=false;
		  		vueThis.l07=false;
		  		vueThis.l08=false;
		  		vueThis.l09=false;
		  		vueThis.l10=false;
		  		vueThis.l11=false;
		  		vueThis.l12=false;
		  		vueThis.l13=false;
		  		vueThis.l16=false;
		  		vueThis.l17=false;
		  		vueThis.l41=false;
		  		vueThis.olcharOption.title.text="4号线在线客流";
		  		
		  		    
		  		   vueThis.olcharOption.series.push(
		  		   	 {
				            name:vueThis.wktimeDt,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#32d2ca'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:data.lineT[3].cpTimes
				        }
		  		   );
		  		   vueThis.olcharOption.series.push(
		  		   	 {
				            name:vueThis.timeDt,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#ED3229'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:data.lineT[3].times
				        }
		  		   );
		  		  
		  		   vueThis.olchar.setOption(vueThis.olcharOption);
		  	}	
		  	if(val=='05'){
		  		
		  		$("#c"+val).addClass("c"+val);
		  		$("#c01").removeClass("c01");
		  		$("#c02").removeClass("c02");
		  		$("#c03").removeClass("c03");
		  		$("#c04").removeClass("c04");
		  		$("#c06").removeClass("c06");
		  		$("#c07").removeClass("c07");
		  		$("#c08").removeClass("c08");
		  		$("#c09").removeClass("c09");
		  		$("#c10").removeClass("c10");
		  		$("#c11").removeClass("c11");
		  		$("#c12").removeClass("c12");
		  		$("#c13").removeClass("c13");
		  		$("#c16").removeClass("c16");
		  		$("#c17").removeClass("c17");
		  		$("#c41").removeClass("c41");
		  		$("#c00").removeClass("c00");
		  		vueThis.l00=false;
		  		vueThis.l05=true;
		  		vueThis.l01=false;
		  		vueThis.l02=false;
		  		vueThis.l03=false;
		  		vueThis.l04=false;
		  		vueThis.l06=false;
		  		vueThis.l07=false;
		  		vueThis.l08=false;
		  		vueThis.l09=false;
		  		vueThis.l10=false;
		  		vueThis.l11=false;
		  		vueThis.l12=false;
		  		vueThis.l13=false;
		  		vueThis.l16=false;
		  		vueThis.l17=false;
		  		vueThis.l41=false;
		  		vueThis.olcharOption.title.text="5号线在线客流";
		  		 vueThis.olcharOption.series.push(
		  		   	 {
				            name:vueThis.wktimeDt,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#32d2ca'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:data.lineT[4].cpTimes
				        }
		  		   );
		  		    vueThis.olcharOption.series.push(
		  		   	 {
				            name:vueThis.timeDt,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#ED3229'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:data.lineT[4].times
				        }
		  		   );
		  		  
		  		  
		  		   vueThis.olchar.setOption(vueThis.olcharOption);
		  	}
		  	if(val=='06'){
		  		
		  		$("#c"+val).addClass("c"+val);
		  		$("#c01").removeClass("c01");
		  		$("#c02").removeClass("c02");
		  		$("#c03").removeClass("c03");
		  		$("#c04").removeClass("c04");
		  		$("#c05").removeClass("c05");
		  		$("#c07").removeClass("c07");
		  		$("#c08").removeClass("c08");
		  		$("#c09").removeClass("c09");
		  		$("#c10").removeClass("c10");
		  		$("#c11").removeClass("c11");
		  		$("#c12").removeClass("c12");
		  		$("#c13").removeClass("c13");
		  		$("#c16").removeClass("c16");
		  		$("#c17").removeClass("c17");
		  		$("#c41").removeClass("c41");
		  		$("#c00").removeClass("c00");
		  		vueThis.l00=false;
		  		vueThis.l06=true;
		  		vueThis.l01=false;
		  		vueThis.l02=false;
		  		vueThis.l03=false;
		  		vueThis.l04=false;
		  		vueThis.l05=false;
		  		vueThis.l07=false;
		  		vueThis.l08=false;
		  		vueThis.l09=false;
		  		vueThis.l10=false;
		  		vueThis.l11=false;
		  		vueThis.l12=false;
		  		vueThis.l13=false;
		  		vueThis.l16=false;
		  		vueThis.l17=false;
		  		vueThis.l41=false;
		  		vueThis.olcharOption.title.text="6号线在线客流";
		  		 vueThis.olcharOption.series.push(
		  		   	 {
				            name:vueThis.wktimeDt,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#32d2ca'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:data.lineT[5].cpTimes
				        }
		  		   );
		  		    vueThis.olcharOption.series.push(
		  		   	 {
				            name:vueThis.timeDt,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#ED3229'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:data.lineT[5].times
				        }
		  		   );
		  		  
		  		  
		  		   vueThis.olchar.setOption(vueThis.olcharOption);
		  	}
		  	if(val=='07'){
		  		
		  		$("#c"+val).addClass("c"+val);
		  		$("#c01").removeClass("c01");
		  		$("#c02").removeClass("c02");
		  		$("#c03").removeClass("c03");
		  		$("#c04").removeClass("c04");
		  		$("#c05").removeClass("c05");
		  		$("#c06").removeClass("c06");
		  		$("#c08").removeClass("c08");
		  		$("#c09").removeClass("c09");
		  		$("#c10").removeClass("c10");
		  		$("#c11").removeClass("c11");
		  		$("#c12").removeClass("c12");
		  		$("#c13").removeClass("c13");
		  		$("#c16").removeClass("c16");
		  		$("#c17").removeClass("c17");
		  		$("#c41").removeClass("c41");
		  		$("#c00").removeClass("c00");
		  		vueThis.l00=false;
		  		vueThis.l07=true;
		  		vueThis.l01=false;
		  		vueThis.l02=false;
		  		vueThis.l03=false;
		  		vueThis.l04=false;
		  		vueThis.l05=false;
		  		vueThis.l06=false;
		  		vueThis.l08=false;
		  		vueThis.l09=false;
		  		vueThis.l10=false;
		  		vueThis.l11=false;
		  		vueThis.l12=false;
		  		vueThis.l13=false;
		  		vueThis.l16=false;
		  		vueThis.l17=false;
		  		vueThis.l41=false;
		  		vueThis.olcharOption.title.text="7号线在线客流";
		  		vueThis.olcharOption.series.push(
		  		   	 {
				            name:vueThis.wktimeDt,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#32d2ca'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:data.lineT[6].cpTimes
				        }
		  		   );
		  		    vueThis.olcharOption.series.push(
		  		   	 {
				            name:vueThis.timeDt,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#ED3229'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:data.lineT[6].times
				        }
		  		   );
		  		   
		  		  
		  		   vueThis.olchar.setOption(vueThis.olcharOption);
		  	}
		  	if(val=='08'){
		  		
		  		$("#c"+val).addClass("c"+val);
		  		$("#c01").removeClass("c01");
		  		$("#c02").removeClass("c02");
		  		$("#c03").removeClass("c03");
		  		$("#c04").removeClass("c04");
		  		$("#c05").removeClass("c05");
		  		$("#c06").removeClass("c06");
		  		$("#c07").removeClass("c07");
		  		$("#c09").removeClass("c09");
		  		$("#c10").removeClass("c10");
		  		$("#c11").removeClass("c11");
		  		$("#c12").removeClass("c12");
		  		$("#c13").removeClass("c13");
		  		$("#c16").removeClass("c16");
		  		$("#c17").removeClass("c17");
		  		$("#c41").removeClass("c41");
		  		$("#c00").removeClass("c00");
		  		vueThis.l00=false;
		  		vueThis.l08=true;
		  		vueThis.l01=false;
		  		vueThis.l02=false;
		  		vueThis.l03=false;
		  		vueThis.l04=false;
		  		vueThis.l05=false;
		  		vueThis.l06=false;
		  		vueThis.l07=false;
		  		vueThis.l09=false;
		  		vueThis.l10=false;
		  		vueThis.l11=false;
		  		vueThis.l12=false;
		  		vueThis.l13=false;
		  		vueThis.l16=false;
		  		vueThis.l17=false;
		  		vueThis.l41=false;
		  		vueThis.olcharOption.title.text="8号线在线客流";
		  		vueThis.olcharOption.series.push(
		  		   	 {
				            name:vueThis.wktimeDt,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#32d2ca'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:data.lineT[7].cpTimes
				        }
		  		   );
		  		    vueThis.olcharOption.series.push(
		  		   	 {
				            name:vueThis.timeDt,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#ED3229'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:data.lineT[7].times
				        }
		  		   );
		  		   
		  		  
		  		   vueThis.olchar.setOption(vueThis.olcharOption);
		  	}
		  	if(val=='09'){
		  		
		  		$("#c"+val).addClass("c"+val);
		  		$("#c01").removeClass("c01");
		  		$("#c02").removeClass("c02");
		  		$("#c03").removeClass("c03");
		  		$("#c04").removeClass("c04");
		  		$("#c05").removeClass("c05");
		  		$("#c06").removeClass("c06");
		  		$("#c07").removeClass("c07");
		  		$("#c08").removeClass("c08");
		  		$("#c10").removeClass("c10");
		  		$("#c11").removeClass("c11");
		  		$("#c12").removeClass("c12");
		  		$("#c13").removeClass("c13");
		  		$("#c16").removeClass("c16");
		  		$("#c17").removeClass("c17");
		  		$("#c41").removeClass("c41");
		  		$("#c00").removeClass("c00");
		  		vueThis.l00=false;
		  		vueThis.l09=true;
		  		vueThis.l01=false;
		  		vueThis.l02=false;
		  		vueThis.l03=false;
		  		vueThis.l04=false;
		  		vueThis.l05=false;
		  		vueThis.l06=false;
		  		vueThis.l07=false;
		  		vueThis.l08=false;
		  		vueThis.l10=false;
		  		vueThis.l11=false;
		  		vueThis.l12=false;
		  		vueThis.l13=false;
		  		vueThis.l16=false;
		  		vueThis.l17=false;
		  		vueThis.l41=false;
		  		vueThis.olcharOption.title.text="9号线在线客流";
		  		vueThis.olcharOption.series.push(
		  		   	 {
				            name:vueThis.wktimeDt,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {}},
                    		areaStyle: {normal: {color: '#32d2ca'}},
				            //stack: '总量',
				            data:data.lineT[8].cpTimes
				        }
		  		   );
		  		    vueThis.olcharOption.series.push(
		  		   	 {
				            name:vueThis.timeDt,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#ED3229'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:data.lineT[8].times
				        }
		  		   );
		  		   
		  		  
		  		   vueThis.olchar.setOption(vueThis.olcharOption);
		  	}
		  	if(val=='10'){
		  		
		  		$("#c"+val).addClass("c"+val);
		  		$("#c01").removeClass("c01");
		  		$("#c02").removeClass("c02");
		  		$("#c03").removeClass("c03");
		  		$("#c04").removeClass("c04");
		  		$("#c05").removeClass("c05");
		  		$("#c06").removeClass("c06");
		  		$("#c07").removeClass("c07");
		  		$("#c08").removeClass("c08");
		  		$("#c09").removeClass("c09");
		  		$("#c11").removeClass("c11");
		  		$("#c12").removeClass("c12");
		  		$("#c13").removeClass("c13");
		  		$("#c16").removeClass("c16");
		  		$("#c17").removeClass("c17");
		  		$("#c41").removeClass("c41");
		  		$("#c00").removeClass("c00");
		  		vueThis.l00=false;
		  		vueThis.l10=true;
		  		vueThis.l01=false;
		  		vueThis.l02=false;
		  		vueThis.l03=false;
		  		vueThis.l04=false;
		  		vueThis.l05=false;
		  		vueThis.l06=false;
		  		vueThis.l07=false;
		  		vueThis.l08=false;
		  		vueThis.l09=false;
		  		vueThis.l11=false;
		  		vueThis.l12=false;
		  		vueThis.l13=false;
		  		vueThis.l16=false;
		  		vueThis.l17=false;
		  		vueThis.l41=false;
		  		vueThis.olcharOption.title.text="10号线在线客流";
		  		vueThis.olcharOption.series.push(
		  		   	 {
				            name:vueThis.wktimeDt,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#32d2ca'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:data.lineT[9].cpTimes
				        }
		  		   );
		  		    vueThis.olcharOption.series.push(
		  		   	 {
				            name:vueThis.timeDt,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#ED3229'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:data.lineT[9].times
				        }
		  		   );
		  		   
		  		  
		  		   vueThis.olchar.setOption(vueThis.olcharOption);
		  	}
		  	if(val=='11'){
		  		
		  		$("#c"+val).addClass("c"+val);
		  		$("#c01").removeClass("c01");
		  		$("#c02").removeClass("c02");
		  		$("#c03").removeClass("c03");
		  		$("#c04").removeClass("c04");
		  		$("#c05").removeClass("c05");
		  		$("#c06").removeClass("c06");
		  		$("#c07").removeClass("c07");
		  		$("#c08").removeClass("c08");
		  		$("#c09").removeClass("c09");
		  		$("#c10").removeClass("c10");
		  		$("#c12").removeClass("c12");
		  		$("#c13").removeClass("c13");
		  		$("#c16").removeClass("c16");
		  		$("#c17").removeClass("c17");
		  		$("#c41").removeClass("c41");
		  		$("#c00").removeClass("c00");
		  		vueThis.l00=false;
		  		vueThis.l11=true;
		  		vueThis.l01=false;
		  		vueThis.l02=false;
		  		vueThis.l03=false;
		  		vueThis.l04=false;
		  		vueThis.l05=false;
		  		vueThis.l06=false;
		  		vueThis.l07=false;
		  		vueThis.l08=false;
		  		vueThis.l09=false;
		  		vueThis.l10=false;
		  		vueThis.l12=false;
		  		vueThis.l13=false;
		  		vueThis.l16=false;
		  		vueThis.l17=false;
		  		vueThis.l41=false;
		  		vueThis.olcharOption.title.text="11号线在线客流";
		  		vueThis.olcharOption.series.push(
		  		   	 {
				            name:vueThis.wktimeDt,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#32d2ca'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:data.lineT[10].cpTimes
				        }
		  		   );
		  		    vueThis.olcharOption.series.push(
		  		   	 {
				            name:vueThis.timeDt,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#ED3229'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:data.lineT[10].times
				        }
		  		   );
		  		   
		  		  
		  		   vueThis.olchar.setOption(vueThis.olcharOption);
		  	}
		  	if(val=='12'){
		  		
		  		$("#c"+val).addClass("c"+val);
		  		$("#c01").removeClass("c01");
		  		$("#c02").removeClass("c02");
		  		$("#c03").removeClass("c03");
		  		$("#c04").removeClass("c04");
		  		$("#c05").removeClass("c05");
		  		$("#c06").removeClass("c06");
		  		$("#c07").removeClass("c07");
		  		$("#c08").removeClass("c08");
		  		$("#c09").removeClass("c09");
		  		$("#c10").removeClass("c10");
		  		$("#c11").removeClass("c11");
		  		$("#c13").removeClass("c13");
		  		$("#c16").removeClass("c16");
		  		$("#c17").removeClass("c17");
		  		$("#c41").removeClass("c41");
		  		$("#c00").removeClass("c00");
		  		vueThis.l00=false;
		  		vueThis.l12=true;
		  		vueThis.l01=false;
		  		vueThis.l02=false;
		  		vueThis.l03=false;
		  		vueThis.l04=false;
		  		vueThis.l05=false;
		  		vueThis.l06=false;
		  		vueThis.l07=false;
		  		vueThis.l08=false;
		  		vueThis.l09=false;
		  		vueThis.l10=false;
		  		vueThis.l11=false;
		  		vueThis.l13=false;
		  		vueThis.l16=false;
		  		vueThis.l17=false;
		  		vueThis.l41=false;
		  		vueThis.olcharOption.title.text="12号线在线客流";
		  		 vueThis.olcharOption.series.push(
		  		   	 {
				            name:vueThis.wktimeDt,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#32d2ca'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:data.lineT[11].cpTimes
				        }
		  		   );
		  		    vueThis.olcharOption.series.push(
		  		   	 {
				            name:vueThis.timeDt,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#ED3229'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:data.lineT[11].times
				        }
		  		   );
		  		  
		  		  
		  		   vueThis.olchar.setOption(vueThis.olcharOption);
		  	}
		  	if(val=='13'){
		  		
		  		$("#c"+val).addClass("c"+val);
		  		$("#c01").removeClass("c01");
		  		$("#c02").removeClass("c02");
		  		$("#c03").removeClass("c03");
		  		$("#c04").removeClass("c04");
		  		$("#c05").removeClass("c05");
		  		$("#c06").removeClass("c06");
		  		$("#c07").removeClass("c07");
		  		$("#c08").removeClass("c08");
		  		$("#c09").removeClass("c09");
		  		$("#c10").removeClass("c10");
		  		$("#c11").removeClass("c11");
		  		$("#c12").removeClass("c12");
		  		$("#c16").removeClass("c16");
		  		$("#c17").removeClass("c17");
		  		$("#c41").removeClass("c41");
		  		$("#c00").removeClass("c00");
		  		vueThis.l00=false;
		  		vueThis.l13=true;
		  		vueThis.l01=false;
		  		vueThis.l02=false;
		  		vueThis.l03=false;
		  		vueThis.l04=false;
		  		vueThis.l05=false;
		  		vueThis.l06=false;
		  		vueThis.l07=false;
		  		vueThis.l08=false;
		  		vueThis.l09=false;
		  		vueThis.l10=false;
		  		vueThis.l11=false;
		  		vueThis.l12=false;
		  		vueThis.l16=false;
		  		vueThis.l17=false;
		  		vueThis.l41=false;
		  		vueThis.olcharOption.title.text="13号线在线客流";
		  		vueThis.olcharOption.series.push(
		  		   	 {
				            name:vueThis.wktimeDt,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#32d2ca'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:data.lineT[12].cpTimes
				        }
		  		   );
		  		    vueThis.olcharOption.series.push(
		  		   	 {
				            name:vueThis.timeDt,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#ED3229'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:data.lineT[12].times
				        }
		  		   );
		  		   
		  		  
		  		   vueThis.olchar.setOption(vueThis.olcharOption);
		  	}
		  	if(val=='16'){
		  		
		  		$("#c"+val).addClass("c"+val);
		  		$("#c01").removeClass("c01");
		  		$("#c02").removeClass("c02");
		  		$("#c03").removeClass("c03");
		  		$("#c04").removeClass("c04");
		  		$("#c05").removeClass("c05");
		  		$("#c06").removeClass("c06");
		  		$("#c07").removeClass("c07");
		  		$("#c08").removeClass("c08");
		  		$("#c09").removeClass("c09");
		  		$("#c10").removeClass("c10");
		  		$("#c11").removeClass("c11");
		  		$("#c12").removeClass("c12");
		  		$("#c13").removeClass("c13");
		  		$("#c17").removeClass("c17");
		  		$("#c41").removeClass("c41");
		  		$("#c00").removeClass("c00");
		  		vueThis.l00=false;
		  		vueThis.l16=true;
		  		vueThis.l01=false;
		  		vueThis.l02=false;
		  		vueThis.l03=false;
		  		vueThis.l04=false;
		  		vueThis.l05=false;
		  		vueThis.l06=false;
		  		vueThis.l07=false;
		  		vueThis.l08=false;
		  		vueThis.l09=false;
		  		vueThis.l10=false;
		  		vueThis.l11=false;
		  		vueThis.l12=false;
		  		vueThis.l13=false;
		  		vueThis.l17=false;
		  		vueThis.l41=false;
		  		vueThis.olcharOption.title.text="16号线在线客流";
		  		 vueThis.olcharOption.series.push(
		  		   	 {
				            name:vueThis.wktimeDt,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#32d2ca'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:data.lineT[13].cpTimes
				        }
		  		   );
		  		    vueThis.olcharOption.series.push(
		  		   	 {
				            name:vueThis.timeDt,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#ED3229'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:data.lineT[13].times
				        }
		  		   );
		  		  
		  		  
		  		   vueThis.olchar.setOption(vueThis.olcharOption);
		  	}
		  	if(val=='17'){
		  		
		  		$("#c"+val).addClass("c"+val);
		  		$("#c01").removeClass("c01");
		  		$("#c02").removeClass("c02");
		  		$("#c03").removeClass("c03");
		  		$("#c04").removeClass("c04");
		  		$("#c05").removeClass("c05");
		  		$("#c06").removeClass("c06");
		  		$("#c07").removeClass("c07");
		  		$("#c08").removeClass("c08");
		  		$("#c09").removeClass("c09");
		  		$("#c10").removeClass("c10");
		  		$("#c11").removeClass("c11");
		  		$("#c12").removeClass("c12");
		  		$("#c13").removeClass("c13");
		  		$("#c16").removeClass("c16");
		  		$("#c41").removeClass("c41");
		  		$("#c00").removeClass("c00");
		  		
		  		vueThis.l17=true;
		  		vueThis.l00=false;
		  		vueThis.l01=false;
		  		vueThis.l02=false;
		  		vueThis.l03=false;
		  		vueThis.l04=false;
		  		vueThis.l05=false;
		  		vueThis.l06=false;
		  		vueThis.l07=false;
		  		vueThis.l08=false;
		  		vueThis.l09=false;
		  		vueThis.l10=false;
		  		vueThis.l11=false;
		  		vueThis.l12=false;
		  		vueThis.l13=false;
		  		vueThis.l16=false;
		  		vueThis.l41=false;
		  		vueThis.olcharOption.title.text="17号线在线客流";
		  		 vueThis.olcharOption.series.push(
		  		   	 {
				            name:vueThis.wktimeDt,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#32d2ca'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:data.lineT[14].cpTimes
				        }
		  		   );
		  		    vueThis.olcharOption.series.push(
		  		   	 {
				            name:vueThis.timeDt,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#ED3229'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:data.lineT[14].times
				        }
		  		   );
		  		  
		  		  
		  		   vueThis.olchar.setOption(vueThis.olcharOption);
		  	}
		  	if(val=='41'){
		  		
		  		$("#c"+val).addClass("c"+val);
		  		$("#c01").removeClass("c01");
		  		$("#c02").removeClass("c02");
		  		$("#c03").removeClass("c03");
		  		$("#c04").removeClass("c04");
		  		$("#c05").removeClass("c05");
		  		$("#c06").removeClass("c06");
		  		$("#c07").removeClass("c07");
		  		$("#c08").removeClass("c08");
		  		$("#c09").removeClass("c09");
		  		$("#c10").removeClass("c10");
		  		$("#c11").removeClass("c11");
		  		$("#c12").removeClass("c12");
		  		$("#c13").removeClass("c13");
		  		$("#c16").removeClass("c16");
		  		$("#c17").removeClass("c17");
		  		$("#c00").removeClass("c00");
		  		
		  		vueThis.l41=true;
		  		vueThis.l01=false;
		  		vueThis.l02=false;
		  		vueThis.l03=false;
		  		vueThis.l04=false;
		  		vueThis.l05=false;
		  		vueThis.l06=false;
		  		vueThis.l07=false;
		  		vueThis.l08=false;
		  		vueThis.l09=false;
		  		vueThis.l10=false;
		  		vueThis.l11=false;
		  		vueThis.l12=false;
		  		vueThis.l13=false;
		  		vueThis.l16=false;
		  		vueThis.l17=false;
		  		vueThis.l00=false;
		  		vueThis.olcharOption.title.text="浦江线在线客流";
		  		vueThis.olcharOption.series.push(
		  		   	 {
				            name:vueThis.wktimeDt,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#32d2ca'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:data.lineT[15].cpTimes
				        }
		  		   );
		  		    vueThis.olcharOption.series.push(
		  		   	 {
				            name:vueThis.timeDt,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#ED3229'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:data.lineT[15].times
				        }
		  		   );
		  		   
		  		  
		  		   vueThis.olchar.setOption(vueThis.olcharOption);
		  	}
		  	if(val=='00'){
		  		vueThis.olcharOption.series=[];
		  		$("#c"+val).addClass("c"+val);
		  		$("#c01").removeClass("c01");
		  		$("#c02").removeClass("c02");
		  		$("#c03").removeClass("c03");
		  		$("#c04").removeClass("c04");
		  		$("#c05").removeClass("c05");
		  		$("#c06").removeClass("c06");
		  		$("#c07").removeClass("c07");
		  		$("#c08").removeClass("c08");
		  		$("#c09").removeClass("c09");
		  		$("#c10").removeClass("c10");
		  		$("#c11").removeClass("c11");
		  		$("#c12").removeClass("c12");
		  		$("#c13").removeClass("c13");
		  		$("#c16").removeClass("c16");
		  		$("#c17").removeClass("c17");
		  		$("#c41").removeClass("c41");
		  		
		  		vueThis.l41=false;
		  		vueThis.l01=false;
		  		vueThis.l02=false;
		  		vueThis.l03=false;
		  		vueThis.l04=false;
		  		vueThis.l05=false;
		  		vueThis.l06=false;
		  		vueThis.l07=false;
		  		vueThis.l08=false;
		  		vueThis.l09=false;
		  		vueThis.l10=false;
		  		vueThis.l11=false;
		  		vueThis.l12=false;
		  		vueThis.l13=false;
		  		vueThis.l16=false;
		  		vueThis.l41=false;
		  		vueThis.l00=true;
		  		vueThis.olcharOption.title.text="全路网在线客流";
		  		//vueThis.olcharOption.legend.data=[];
		  		
		  		var colors=['#ED3229','#36B854','#FFD823','#320176','#823094','#CF047A','#F3560F','#008CC1','#91C5DB','#C7AFD3','#8C2222','#007a61','#ec91cc','#32d2ca','#C37D75','#dddddd'];
		  			var ls=[];
		  				ls=data.lineT;
		  		for (var i=ls.length-1;i>=0;i--){
		  				var it=ls[i];
		  				 vueThis.olcharOption.series.push(
		  		   	 {
				            name:'',
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: colors[i]}},
                    		areaStyle: {normal: {}},
				            stack: '总量',
				            data:it.times
				        }
		  		   );
		  		}
		  		vueThis.olcharOption.tooltip={
				        trigger: 'axis',
				        textStyle: {fontWeight:'bold',fontSize:15},
				         formatter:function (p){
				         console.log(p);
				        	if(p.length==18){
				        	var tp_str = p[0].name + "<br/>" +p[0].marker+ p[0].seriesName + "浦江线： "+p[0].value
				        		+"<br/>"+p[1].marker+ p[1].seriesName + "17号线： "+p[1].value
				        		+"<br/>"+p[2].marker+ p[2].seriesName + "16号线： "+p[2].value
				        		+"<br/>"+p[3].marker+ p[3].seriesName + "13号线： "+p[3].value
				        		+"<br/>"+p[4].marker+ p[4].seriesName + "12号线： "+p[4].value
				        		+"<br/>"+p[5].marker+ p[5].seriesName + "11号线： "+p[5].value
				        		+"<br/>"+p[6].marker+ p[6].seriesName + "10号线： "+p[6].value
				        		+"<br/>"+p[7].marker+ p[7].seriesName + "9号线： "+p[7].value
				        		+"<br/>"+p[8].marker+ p[8].seriesName + "8号线： "+p[8].value
				        		+"<br/>"+p[9].marker+ p[9].seriesName + "7号线： "+p[9].value
				        		+"<br/>"+p[10].marker+ p[10].seriesName + "6号线： "+p[10].value
				        		+"<br/>"+p[11].marker+ p[11].seriesName + "5号线： "+p[11].value
				        		+"<br/>"+p[12].marker+ p[12].seriesName + "4号线： "+p[12].value
				        		+"<br/>"+p[13].marker+ p[13].seriesName + "3号线： "+p[13].value
				        		+"<br/>"+p[14].marker+ p[14].seriesName + "2号线： "+p[14].value
				        		+"<br/>"+p[15].marker+ p[15].seriesName + "1号线： "+p[15].value
				        		+"<br/>"+p[16].marker+ p[16].seriesName + "： "+p[16].value
				        		+"<br/>"+p[17].marker+ p[17].seriesName + "： "+p[17].value;
				        	}else if(p.length==2){
				        		var tp_str = p[0].name + "<br/>" + p[0].seriesName + "： "+p[0].value
				        					+ "<br/>" + p[1].seriesName + "： "+p[1].value;
				        	}else{
				        		var tp_str = p[0].name + "<br/>" + p[0].seriesName + "： "+p[0].value;
				        	}
				        	
				        	return tp_str;
				        } 
				        
				    };
		  		    vueThis.olcharOption.series.push(
		  		   	 {
				            name:vueThis.wktimeDt+"在线总客流  ",
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#808000',width: 4}},
                    		areaStyle: {normal: {color:'rgba(128,128,0,0)'}},
				            //stack: '总量',
				            data:data.lineT[16].cpalline
				        });
				        
				         vueThis.olcharOption.series.push(
		  		   	 {
				            name:vueThis.timeDt+"在线总客流",
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#ADFF2F',width: 4}},
                    		areaStyle: {normal: {color:'rgba(173,255,47,0)'}},
				            //stack: '总量',
				            data:data.lineT[16].alline
				        });  
		  		   
		  		  
		  		   vueThis.olchar.setOption(vueThis.olcharOption);
		  	}
		  },
		  
		  	//获取图表数据
		  	getOnlineFlow:function(){
		  	
		  			
		  		 var vueThis=this;
		  		 if(vueThis.olchar!=''){
		  		 	vueThis.olchar.clear();
		  		 }
		  		 
		  		  vueThis.timeDt=moment(vueThis.temDate).format("YYYYMMDD");
		  		  vueThis.wktimeDt=moment(vueThis.compDate).format("YYYYMMDD");
		  		   vueThis.legen.push(vueThis.timeDt);
		  		   vueThis.legen.push(vueThis.wktimeDt); 
		  		  vueThis.initChart();
		  		$.post("lflw/GetonLineFlow.action",{"date":vueThis.timeDt,"compDate":vueThis.wktimeDt}, function(data){
		  		
		  				vueThis.olchar.clear();
		  				vueThis.olflData=data;
		  		   var tim=[];
		  		   vueThis.olcharOption.series=[];
		  		   for (var i=0;i<=data.times.length-1;i++){
		  		   
		  		   	var  it=data.times[i];
		  		   	
		  		   	if(it.substr(3, 2)=='00'){
		  		   	
		  		   		 tim.push({
				                 value: it,
				                 textStyle: {fontSize: 12, color: 'rgba(168,168,168,1)'}
				             });
		  		   	}else{
		  		   		tim.push({
				                 value:it,
				                 textStyle: {fontSize: 12, color: 'rgba(168,168,168,0)'}
				             });
		  		   	}
		  		   	
		  		   }
		  		   
		  		   vueThis.olcharOption.xAxis[0].data=tim;
		  		   vueThis.olcharOption.title.text="1号线在线客流";
		  		    $("#c01").addClass("c01");
		  		    $("#c02").removeClass("c02");
			  		$("#c03").removeClass("c03");
			  		$("#c04").removeClass("c04");
			  		$("#c05").removeClass("c05");
			  		$("#c06").removeClass("c06");
			  		$("#c07").removeClass("c07");
			  		$("#c08").removeClass("c08");
			  		$("#c09").removeClass("c09");
			  		$("#c10").removeClass("c10");
			  		$("#c11").removeClass("c11");
			  		$("#c12").removeClass("c12");
			  		$("#c13").removeClass("c13");
			  		$("#c16").removeClass("c16");
			  		$("#c17").removeClass("c17");
			  		$("#c41").removeClass("c41");
			  		$("#c00").removeClass("c00");
			  		
			  		vueThis.l00=false;
		  		vueThis.l01=true;
		  		vueThis.l02=false;
		  		vueThis.l03=false;
		  		vueThis.l04=false;
		  		vueThis.l05=false;
		  		vueThis.l06=false;
		  		vueThis.l07=false;
		  		vueThis.l08=false;
		  		vueThis.l09=false;
		  		vueThis.l10=false;
		  		vueThis.l11=false;
		  		vueThis.l12=false;
		  		vueThis.l13=false;
		  		vueThis.l16=false;
		  		vueThis.l17=false;
		  		vueThis.l41=false;
		  		   vueThis.olcharOption.series.push(
		  		   	 {
				            name:vueThis.wktimeDt,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#32d2ca'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:data.lineT[0].cpTimes
				        }
		  		   );
		  		  vueThis.olcharOption.series.push(
		  		   	 {
				            name:vueThis.timeDt,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#ED3229'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:data.lineT[0].times
				        }
		  		   );
		  		   vueThis.olchar.setOption(vueThis.olcharOption);
		  			
		  		
		  		
		  		
		  		
		  			
		  		});
		  	},
		  	//绘制折线图
		  	initChart:function(){
		  		 var vueThis=this;
                //初始化echarts图表
                var myChart;
               myChart = echarts.init(document.querySelector('#olfc'));
				vueThis.olchar=myChart;
				option = {
				    title: {
				        text: '客流折线图',
				        textStyle: { fontStyle:'normal',fontWeight:'bold',fontSize:16,color:'#FFFfff'}
				    },
				    tooltip: {
				        trigger: 'axis',
				        textStyle: {fontWeight:'bold',fontSize:15},
				        formatter:function (p){
				        	if(p.length==2){
				        	var tp_str = p[0].name + "<br/>" + p[0].seriesName + "： "+p[0].value
				        		+"<br/>"+ p[1].seriesName + "： "+p[1].value;
				        	}else{
				        		var tp_str = p[0].name + "<br/>" + p[0].seriesName + "： "+p[0].value;
				        		
				        	}
				        	
				        	return tp_str;
				        }
				        
				    },
				    legend: {
				    	 orient: 'horizontal', // 'vertical'
					        x: 'center', // 'center' | 'left' | {number},
					        y: 'top', // 'center' | 'bottom' | {number}
					        textStyle: {color: '#ffffff'},
				        data:vueThis.legen
				    },
				    grid: {
				      
				        left: '5%',
				        right: '4%',
				        bottom: '3%'
				        //containLabel: true
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
				            name:'',
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {}},
                    		areaStyle: {normal: {}},
				           // stack: '总量',
				            data:[]
				        }
				        
				    ]
				};
				vueThis.olcharOption=option;
				vueThis.olchar.setOption(vueThis.olcharOption);
		  	}
		  
		    },
		  filters: {
		  	amendNum:function(value){
		  		var val=parseInt(value);
		  		return val;
		  	}
			
		}
		});
		

      </script>
  </body>
</html>