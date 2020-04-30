<%@ page language="java" import="java.util.*,java.lang.*,net.sf.json.*,java.sql.*,java.text.*,java.io.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<% 
	
  	
	String fir_date="";
  	String sec_date="";
  	String week_date="";
  	SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
  	Calendar calendar = Calendar.getInstance(); 
    calendar.setTime(new java.util.Date());
    
		calendar.add(Calendar.DAY_OF_MONTH, -2);  
		sec_date=df.format(calendar.getTime());
	
    
        calendar.add(Calendar.DAY_OF_MONTH, -1);  
        fir_date=df.format(calendar.getTime());
        
        calendar.add(Calendar.DAY_OF_MONTH, -3);  
        week_date=df.format(calendar.getTime());
	
	
	
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

		.tabs {
            float: left;
            margin-top:15px;
            margin-left: 10px;
            height: 45px;
            width: 1500px;
            margin-left: 45px;
            color: #fff;
            background-size: 80% 90%;
            background-repeat: no-repeat;

            color: #fff;
        }
         .searchbtns {
  
            width: 71px;
            height: 30px;
            color: #fff;
            text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25);
            background-color: #1134A8;
            text-align: center;
            border-radius: 9px;
            padding: 2px 15px;
            margin-left: 3px;
            margin-bottom: 0;
            font-size: 15px;
        }

</style>
  </head>
  
  <body>
  	  <div id="pfwd">
  	   <div style="padding:20px  10px">
  	 	<el-card class="box-card">
  	 		<el-row>
			  <el-col :span="4">
			  <div class="block">
			    <span class="demonstration">当前日期</span>
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
			  <el-col :span="4"><div class="block">
			    <span class="demonstration">对比日期</span>
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
			  <el-col :span="4"><el-button type="primary" @click="getOnlineFlow()">查询</el-button></el-col>
			  <el-col :span="12"></el-col>
			</el-row>
		 	<el-row>
		 		<div class="tabs">
		 					<input  id="l0" type="button" value="全路网" class="searchbtns" style="background-color:white;color:gray;text-align: center">
                            <input  id="l1" type="button" value="1" class="searchbtns" style="background-color: #ED3229">
                            <input id="l2" type="button" value="2" class="searchbtns" style="background-color: #36B854" @click="switchLine('02')">
                            <input id="l3" type="button" value="3" class="searchbtns" style="background-color: #FFD823">
                            <input id="l4" type="button" value="4" class="searchbtns" style="background-color: #320176">
                            <input id="l5" type="button" value="5" class="searchbtns" style="background-color: #823094">
                            <input id="l6" type="button" value="6" class="searchbtns" style="background-color: #CF047A">
                            <input id="l7" type="button" value="7" class="searchbtns" style="background-color: #F3560F">
                            <input id="l8" type="button" value="8" class="searchbtns" style="background-color: #008CC1">
                            <input id="l9" type="button" value="9" class="searchbtns" style="background-color: #91C5DB">
                            <input id="l10" type="button" value="10" class="searchbtns" style="background-color: #C7AFD3">
                            <input id="l11" type="button" value="11" class="searchbtns" style="background-color: #842223">
                            <input id="l12" type="button" value="12" class="searchbtns" style="margin-top: 5px;background-color: #007C64">
                            <input id="l13" type="button" value="13" class="searchbtns" style="background-color: #DC87C2">
                            <input id="l16" type="button" value="16" class="searchbtns" style="background-color: #33D4CC">
                            <input id="l17" type="button" value="17" class="searchbtns" style="background-color: #BC7970">
                            <input id="l18" type="button" value="浦江线" class="searchbtns" style="background-color: #DDDDDD">
                        </div>
			 </el-row> 
		</el-card>
		<el-card class="box-card" style="margin-top:15px">
			<el-row>
				<div id="olfc" style="width:97%;height:640px;padding:30px 20px"></div>
			</el-row>
		</el-card>
  	  	</div>
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
        olcharOption:''
			
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
		  	
		  	var data=vueThis.olflData;
		  	vueThis.olcharOption.series=[];
		  	if(val=='02'){
		  		vueThis.olcharOption.title.text="2号线在线客流";
		  		    vueThis.olcharOption.series.push(
		  		   	 {
				            name:vueThis.timeDt,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:data.lineT[1].times
				        }
		  		   );
		  		   vueThis.olcharOption.series.push(
		  		   	 {
				            name:vueThis.wktimeDt,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:data.lineT[1].cpTimes
				        }
		  		   );
		  		  
		  		   vueThis.olchar.setOption(vueThis.olcharOption);
		  	}
		  		
		  		
		  	
		  },
		  
		  	//获取图表数据
		  	getOnlineFlow:function(){
		  		 var vueThis=this;
		  		  vueThis.timeDt=moment(vueThis.temDate).format("YYYYMMDD");
		  		  vueThis.wktimeDt=moment(vueThis.compDate).format("YYYYMMDD");
		  		   vueThis.legen.push(vueThis.timeDt);
		  		   vueThis.legen.push(vueThis.wktimeDt); 
		  		  vueThis.initChart();
		  		$.post("lflw/GetonLineFlow.action",{"date":vueThis.timeDt,"compDate":vueThis.wktimeDt}, function(data){
		  		
		  				
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
		  		    vueThis.olcharOption.series.push(
		  		   	 {
				            name:vueThis.timeDt,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:data.lineT[0].times
				        }
		  		   );
		  		   vueThis.olcharOption.series.push(
		  		   	 {
				            name:vueThis.wktimeDt,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:data.lineT[0].cpTimes
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
				        textStyle: { fontStyle:'normal',fontWeight:'bold',fontSize:17}
				    },
				    tooltip: {
				        trigger: 'axis',
				        textStyle: {fontWeight:'bold',fontSize:15},
				        formatter:function (p){
				        	if(p.length==2){
				        	var tp_str = p[0].name + "<br/>" + p[0].seriesName + " "+p[0].value
				        		+"<br/>"+ p[1].seriesName + " "+p[1].value;
				        	}else{
				        		var tp_str = p[0].name + "<br/>" + p[0].seriesName + " "+p[0].value;
				        		
				        	}
				        	
				        	return tp_str;
				        }
				        
				    },
				    legend: {
				    	 orient: 'horizontal', // 'vertical'
					        x: 'center', // 'center' | 'left' | {number},
					        y: 'top', // 'center' | 'bottom' | {number}
				        data:vueThis.legen
				    },
				    grid: {
				        left: '3%',
				        right: '4%',
				        bottom: '3%',
				        containLabel: true
				    },
				   
				    xAxis: [{
				        type: 'category',
				        boundaryGap: false,
				        data: []
				    }],
				    yAxis: {
				        type: 'value',
				        name: '单位：人次',
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