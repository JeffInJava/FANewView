<%@ page language="java" import="java.util.*,java.lang.*,com.util.*,net.sf.json.*,java.text.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
  <head>
  	<title>客流分时比较</title>
    <base href="<%=basePath%>">

	<script src="resource/jquery/js/jquery-1.7.2.js" type="text/javascript"></script>
    <link href="resource/jquery/css/jquery-ui-1.8.11.custom.css" rel="stylesheet" type="text/css" />
    <script src="resource/inesa/js/common.js"></script>
	<script src="resource/echarts3/echarts.min.js"></script>
	
	<style type="text/css">
    	.dashboard-nav {
		    cursor: pointer;
		    font-size:16px;
		    background-color: #F8F8F8;
		    border-radius: 1rem;
		    display: inline-block;
		    height: 20px;
		    width:260px;
		    vertical-align: middle;
		    
		}
		.dashboard-nav span.active {
		    background-color: #c7cbd6;
		}
		.dashboard-nav span {
		    border-radius: 1rem;
		    padding:3px 15px;
			line-height: 20px;
		}
    </style>
  </head>
  <%
    Calendar cal = Calendar.getInstance();
  	SimpleDateFormat fmt=new SimpleDateFormat("yyyyMMdd");
	String start_date = fmt.format(cal.getTime());
	cal.add(Calendar.DATE,-7);
	String com_date = fmt.format(cal.getTime());
	cal = Calendar.getInstance();
	cal.add(Calendar.YEAR,-1);
	String com_date1 = fmt.format(cal.getTime());
  %>
<body style="margin:0px;padding:0px;">
	<div style="background-color:#c7cbd6;width:100%;">
	   <div style="background-color:#c7cbd6;width:100%;height:4%;display:block;text-align:center;position: relative;">
	   	<span class="dashboard-nav">
	   		<span id="tb" onclick="change('tb')">同&nbsp;比</span>
	   		<span class="active" class="" id="hb" onclick="change('hb')">环&nbsp;比</span>
			<span class="" id="zdy" onclick="change('zdy')">自定义</span>
	   	</span>
	   </div>
	   <div style="height:6%;display:block;position: relative;padding-left:50px;">
	   	<input type="hidden" id="hide_date1" value="<%=com_date %>">
	   	<input type="hidden" id="hide_date2" value="<%=com_date1 %>">
	   	 运营日期:<input type="text" name="start_date" id="start_date" value="<%=start_date %>">
	   	 对比日期:<input type="text" name="com_date" id="com_date" value="<%=com_date %>">
	   	 <input type="checkbox" name="flux_flag" value="1" checked="checked">进站
	   	 <input type="checkbox" name="flux_flag" value="2">出站
	   	 <input type="checkbox" name="flux_flag" value="3" checked="checked">换乘
	   	 线路:<select name="line_id" id="line_id" style="width:120px;"></select>&nbsp;
		车站:<select name="station_id" id="station_id" style="width:120px;"></select>
	   	 <input type="button" value="查询" onclick="loadFluxPeriodData()">
	   </div>
   </div>
	<div style="width: 100%;">
		<div id="mainPeriond" style="height: 600px;width: 100%;"></div>
	</div>
	
    <script type="text/javascript">
    	$(function(){
			//加载线路车站
			loadLineAndStation();
		});
    	
    	function change(f){
	  		 if(f=="tb"){
	  			 $("#tb").addClass("active");
	  			 $("#hb").removeClass("active");
				 $("#zdy").removeClass("active");
				 $("#com_date").val($("#hide_date2").val());
	  		 }else if(f=="hb"){
	  			 $("#hb").addClass("active");
	  			 $("#tb").removeClass("active");
				 $("#zdy").removeClass("active");
				 $("#com_date").val($("#hide_date1").val());
	  		 }else{
				 $("#zdy").addClass("active");
	  			 $("#tb").removeClass("active");
				 $("#hb").removeClass("active");
				 $("#com_date").val("");
			 }
	  	 }
    	
    	//加载线路车站
		function loadLineAndStation(){
			doPost("station/get_fluxperiod.action", {"sel_flag":"1"}, function(data){
				var line=eval(data);
				var tp_line="<option value='00'>全路网</option>";
				var tp="";
				for(var i=0;i<line.length;i++){
					if(i==0){
						tp_line+="<option value='"+line[i].LINE_ID+"'>"+line[i].LINE_NM+"</option>";
					}else{
						if(line[i-1].LINE_ID!=line[i].LINE_ID){
							tp_line+="<option value='"+line[i].LINE_ID+"'>"+line[i].LINE_NM+"</option>";
						}
					}
				}
				
				$("#line_id").html(tp_line);
				$("#station_id").html(tp);
				
				//添加事件
				$("#line_id").change(function(){
					var sel_line=$("#line_id").val();
					tp="<option></option>";
					for(var i=0;i<line.length;i++){
						if(sel_line==line[i].LINE_ID){
							tp+="<option value='"+line[i].STATION_ID+"'>"+line[i].STATION_NM+"</option>";
						}
					}
					$("#station_id").html(tp);
				});
				
			});
		}
    	
    	var flowPeriodOption;
    	var chartStation;
    	var datas;
    	//加载分时客流对比数据
    	function loadFluxPeriodData(){
		
    		var start_date=$("#start_date").val();//选择日期
    		var com_date=$("#com_date").val();//对比日期
    		var flux_flag=$('input[name="flux_flag"]:checked');//选择进出站方式
    		var tp="";
    		if(flux_flag&&flux_flag.length>0){
    			$(flux_flag).each(function(i,v){
    				tp+=$(v).val();
    			});
    		}else{
    			alert("请选择进出站方式！");
    			return;
    		}
    		
    		var line_id=$("#line_id").val();//线路
    		var station_id=$("#station_id").val();//车站
    		doPost("station/get_fluxperiod.action", {"start_date":start_date,"com_date":com_date,"sel_flag":"2","flux_flag":tp,"line_id":line_id,"station_id":station_id}, function(data){
    			flowPeriodOption = {
			        title : {
				        text: '客流分时比较',
				        x:'center',
				        textStyle:{fontSize:20,fontWeight:'bolder'}
				    },
				    tooltip : {
				        trigger: 'axis',
				        textStyle: {fontWeight:'bold',fontSize:22},
				        formatter: function (p){
				            return p[0].name+"<br/>"+p[0].seriesName+":"+p[0].value+"<br/>"+p[1].seriesName+":"+p[1].value;
				        }
				    },
				    legend: {
				    	selectedMode:false,
				    	x:'center',
				    	y:'25',
				    	textStyle: {fontWeight:'bold',fontSize:18},
				    	data:[]
				    },
				    calculable : true,
				    grid : {'y':50,'y2':30,'x':80,'x2':60},
				    xAxis : [
				        {
				            type:'category',
				            axisLabel:{interval:0,textStyle: {fontWeight:'bold'}},
				            data:[]
				        }
				    ],
				    yAxis : [
				        {
				            type : 'value',
				            axisLabel:{
					        	textStyle: {fontWeight:'bold',fontSize:16}
					        }
				        }
				    ],
				    series : [
				    	{
				            name:'',
				            type:'line',
				            smooth:true,
				            itemStyle: {normal: {color: 'rgba(46,199,201,1)'}},
				            areaStyle: {
				                normal: {
				                    color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
				                        offset: 0,
				                        color: 'rgba(46,199,201,1)'
				                    }, {
				                        offset: 1,
				                        color: '#ffe'
				                    }])
				                }
				            },
				            data:[]
				        }
				    ]
				};
    			
    			
    			var dateFt0=start_date.substring(0,4)+"/"+start_date.substring(4,6)+"/"+start_date.substring(6);
	    		var dateFt1=com_date.substring(0,4)+"/"+com_date.substring(4,6)+"/"+com_date.substring(6);
	    		
	    		flowPeriodOption.legend.data=[dateFt1];
	    		flowPeriodOption.series[0].name=dateFt1;
	    		
	    		var times=[],com_times=[],period=[];
	    		datas=data;
	    		$.each(data,function(i,v){
	    			times.push(v.TIMES);
		    		com_times.push(v.COM_TIMES);
		    		if(v.TIME_PERIOD.toString().substr(v.TIME_PERIOD.toString().length-1,1)=="5"){
		    			period.push({
		    				value:v.TIME_PERIOD,            
					        textStyle:{fontSize:0}
		    			});
		    		}else{
		    			period.push({
		    				value:v.TIME_PERIOD,            
					        textStyle:{fontSize:18}
		    			});
		    		}
	    			
	    		});
	    		
	    		//销毁图例
	    		if(chartStation){
	    			chartStation.dispose();
	    		}
	    		
		    	flowPeriodOption.series[0].data=com_times;
    			flowPeriodOption.xAxis[0].data=period;
	    		
		    	chartStation = echarts.init(document.getElementById('mainPeriond')); 
			    chartStation.setOption(flowPeriodOption,true);
		    	
			    //延迟加载“运营日期”的数据
			    setTimeout(function(){
			    	secLoad(dateFt0,times);
			    },1000);
			    
    		});
    	}
    	
    	
		function secLoad(dateFt0,times){
			flowPeriodOption.legend.data.push(dateFt0);
			flowPeriodOption.series.push({
	            name:dateFt0,
	            type:'line',
	            smooth:true,
	            itemStyle: {normal: {color: 'rgba(255,127,80,1)'}},
	            areaStyle: {
	                normal: {
	                    color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
	                        offset: 0,
	                        color: 'rgba(255,127,80,1)'
	                    }, {
	                        offset: 1,
	                        color: '#ffe'
	                    }])
	                }
	            },
	            data:times
	        });
		    chartStation = echarts.init(document.getElementById('mainPeriond')); 
			chartStation.setOption(flowPeriodOption,true);
		}
    	
    	
    </script>

  </body>
</html>