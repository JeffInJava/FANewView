<%@ page language="java" import="java.util.*,java.lang.*,net.sf.json.*,java.sql.*,com.util.*,java.text.*,java.io.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePathHttp = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
String basePathHttps = request.getScheme()+"s://"+request.getServerName()+request.getContextPath()+"/";
String basePath=basePathHttp;

DateFormat df = new SimpleDateFormat("yyyyMMdd");
Calendar c = Calendar.getInstance();
String selMonth=df.format(c.getTime());
c.add(Calendar.DATE,-1);
String comMonth=df.format(c.getTime());

%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>无标题文档</title>
<link href="resource/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
<script src="resource/jquery/js/jquery-1.7.2.js"></script>
<script src="resource/echarts/build/dist/echarts.js"></script>
<script src="resource/inesa/js/common.js"></script>
<script src="resource/DatePicker/WdatePicker.js"></script>
<style type="text/css">
	html, body {
	    background-color: #000;
	    height: 100%;
	    line-height: 1.4;
	}
	body {
	    margin: 0;
	    display: block;
	    font-family: Arial,Helvetica,sans-serif;
	    color: #FFF;
	    font-size: .3rem;
	}
	#content {
	    height: 100%;
	    width: 100%;
	}
	div {
	    display: block;
	}
	.dashboard-title {
	    height:6%;
	    background-color: #30303b;
	    position: relative;
	    text-align: center;
	}
	.dashboard-title-clock {
	    font-size: 18px;
	    position: absolute;
	    top: 10px;
	    left:10px;
	}
	.dashboard-title-group{
		position: absolute;
	    top: 10px;
	    right:50px;
	}
	.dashboard-content,.dashboard-bottom{
		 padding:10px 10px;
		 padding-bottom:0px;
		 clear: both;
	}
	.dashboard-content > div,.dashboard-bottom > div{
	    background-color: #201f2a;
	    border: 3px solid transparent;
	    border-radius: 9px;
	}
	.dashboard-detail{
		width: 30%;
		height:400px;
		float: left;
	}
	.dashboard-fenshi{
		width: 68%;
		height:400px;
		float: right;
	}
	.dashboard-nav {
	    font-size:12px;
	    font-weight:bold;
	    background-color: #000;
		border-radius: 1rem;
	    width:40px;
	    height:100%;
	    float:left;
	    text-align: center;
	}
	.dashboard-nav div.active {
	    background-color: #464556;
	}
	.dashboard-nav div {
	    border-radius: 1rem;
	    padding:8px 0px;
	    width:30px;
	    height:35%;
	    margin:8px auto;
		
	}
</style>
</head>
<body>
	<div id="content">
		<div class="dashboard-title">
			<div class="dashboard-title-clock">
				<span id="cur_time"></span>
			</div>
			<div class="dashboard-title-group">
				查询日期：<input type="text" name="sel_date" id="sel_date" style="width:120px;" value="<%=selMonth %>" onClick="WdatePicker({dateFmt:'yyyyMMdd'})">&nbsp;&nbsp;
				对比日期：<input type="text" name="com_date" id="com_date" style="width:120px;" value="<%=comMonth %>" onClick="WdatePicker({dateFmt:'yyyyMMdd'})">&nbsp;&nbsp;
				线路：<select name="line_id" id="line_id" style="width:120px;"></select>&nbsp;&nbsp;
				车站：<select name="station_id" id="station_id" style="width:120px;"></select>&nbsp;&nbsp;
				<input type="button" value="查询" onclick="selDatas()">
			</div>
		</div>
		<div class="dashboard-content">
			<div class="dashboard-detail">
				<div style="width: 100%;text-align:center;margin-top:10px;">
					<img src="resource/images/bgTu_03.png" width="20px" height="20px" style="border-radius:10px">
					<span style="font-size: 30px;">人民广场</span>
				</div>
				<div style="width:100%;text-align:center;font-size:40px;">客流:<span style="color: #ff6a00">49.60万</span></div>
				<div style="width:100%;text-align:center;font-size:20px;">
					<span>进站:<span style="color: #ffac00">130491</span></span>
					<span style="margin-left:15px;">出站:<span style="color: #ffac00">130491</span></span>
					<span style="margin-left:15px;">换乘:<span style="color: #ffac00">130491</span></span>
				</div>
				<div style="width:100%;">
					<table style="height:130px;width:92%;border:none;margin:0% 4%;" cellpadding="0px" cellspacing="0px">
		    			<tr>
		    				<td>
		    					<div style="font-family: '微软雅黑';font-size: 15px;">
		    						当前客流<span style="font-size:22px;">496012</span>人次
		    					</div>
		    					<div style="height:5px;width:40%;background-color: #1e90ff;float:left;">&nbsp;</div>
		    					<div style="height:5px;width:60%;background-color: #dddddd;float:left;">&nbsp;</div>
		    				</td>
		    			</tr>
		    			<tr>
		    				<td>
		    					<div style="font-family: '微软雅黑';font-size: 15px;">
		    						对比客流<span style="font-size:22px;">503595</span>人次
		    						<div style="float:right;padding-right:10px;"><span style="font-size:20px;"></span>2017/08/07</div>
		    					</div>
		    					<div style="height:5px;width:45%;background-color: #1e90ff;float:left;">&nbsp;</div>
		    					<div style="height:5px;width:55%;background-color: #dddddd;float:left;">&nbsp;</div>
		    				</td>
		    			</tr>
		    			<tr>
		    				<td>
		    					<div style="font-family: '微软雅黑';font-size: 15px;">
		    						历史最高客流<span style="font-size:22px;">803595</span>人次
		    						<div style="float:right;padding-right:10px;"><span style="font-size:20px;"></span>2017/04/17</div>
		    					</div>
		    					<div style="height:5px;width:80%;background-color: #D9534F;float:left;">&nbsp;</div>
		    					<div style="height:5px;width:20%;background-color: #dddddd;float:left;">&nbsp;</div>
		    				</td>
		    			</tr>
		    		</table>
				</div>
				
				<div id="mainCard" style="height:170px;width:100%;"></div>
			</div>
			
			<div class="dashboard-fenshi">
				<div id="main" style="height:60%;width: 100%"></div>
  				<div id="main1" style="height:40%;width: 100%"></div>
			</div>
			
		</div>
			
		<div class="dashboard-bottom">
			<div style="width:30%;height:190px;float:left;">
				<div id="distanceId" style="width:100%;height:100%;"></div>
			</div>
			<div style="width:68%;height:190px;float:right;">
				<div class="dashboard-nav">
					<div class="active" id="laiyuan" onclick="change('laiyuan')">客<br/>流<br/>来<br/>源</div>
    				<div id="quxiang" onclick="change('quxiang')">客<br/>流<br/>去<br/>向</div>
				</div>
				<div id="mainAreaFlux" style="width:50%;height:100%;float:left;"></div>
				<div id="mainStationFlux" style="width:45%;height:100%;float:right;"></div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(function(){
			//获取当前时间
			getCurTime();
			window.setInterval("getCurTime()",1000);
			
			//加载线路车站
			loadLineAndStation();
		});
	
		//获取当前时间
		function p(s) {
		    return s < 10 ? '0' + s: s;
		}
		function getCurTime(){
			var myDate = new Date();
			var year=myDate.getFullYear();//获取当前年
			var month=myDate.getMonth()+1;//获取当前月
			var date=myDate.getDate();//获取当前日
			var h=myDate.getHours();//获取当前小时数
			var m=myDate.getMinutes();//获取当前分钟数
			var now=year+"年"+p(month)+"月"+p(date)+"日&nbsp;"+p(h)+":"+p(m);
			$("#cur_time").html(now);
		}
	
		//加载线路车站
		function loadLineAndStation(){
			doPost("station/get_general_flux.action", {"sel_flag":"1"}, function(data){
				var line=eval(data);
				var tp_line="";
				var tp="";
				for(var i=0;i<line.length;i++){
					if(i==0){
						tp_line+="<option value='"+line[i].LINE_ID+"'>"+line[i].LINE_NM+"</option>";
					}else{
						if(line[i-1].LINE_ID!=line[i].LINE_ID){
							tp_line+="<option value='"+line[i].LINE_ID+"'>"+line[i].LINE_NM+"</option>";
						}
					}
					if("01"==line[i].LINE_ID){
						tp+="<option value='"+line[i].STATION_ID+"'>"+line[i].STATION_NM+"</option>";
					}
				}
				
				$("#line_id").html(tp_line);
				$("#station_id").html(tp);
				
				//添加事件
				$("#line_id").change(function(){
					var sel_line=$("#line_id").val();
					tp="";
					for(var i=0;i<line.length;i++){
						if(sel_line==line[i].LINE_ID){
							tp+="<option value='"+line[i].STATION_ID+"'>"+line[i].STATION_NM+"</option>";
						}
					}
					$("#station_id").html(tp);
				});
				
			});
		}
		
		//查询
		function selDatas(){
			var sel_date=$("#sel_date").val();
			var com_date=$("#com_date").val();
			var station_id=$("#station_id").val();
			
		}
		
		function change(f){
	  		 if(f=="laiyuan"){
	  			 $("#laiyuan").addClass("active");
	  			 $("#quxiang").removeClass("active");
	  		 }else{
	  			 $("#quxiang").addClass("active");
	  			 $("#laiyuan").removeClass("active");
	  		 }
	  	 }
	
	
        // 路径配置
        require.config({
            paths: {
                echarts: 'resource/echarts/build/dist'
            }
        });
        
        //票卡
        var card_data=[{"TZP_TIMES":406,"LRK_TIMES":29,"DCP_TIMES":2853,"JFK_TIMES":14282,"TZP_PER":2.3,"LRK_PER":0.2,"DCP_PER":16.1,"JFK_PER":81.3,"LOSS_PER":2.2}];
        var dataStyle = {
		    normal: {
		        label: {show:false},
		        labelLine: {show:false}
		    }
		};
		var placeHolderStyle = {
		    normal : {
		        color: 'rgba(0,0,0,0)',
		        label: {show:false},
		        labelLine: {show:false}
		    },
		    emphasis : {
		        color: 'rgba(0,0,0,0)'
		    }
		};
        optionCard={
			title: {
		        text: '票卡使用',
		        x:20,
		        y:10,
		        textStyle : {
		            color : '#FFF',
		            fontFamily : '微软雅黑',
		            fontSize : 20,
		            fontWeight : 'bolder'
		        }
		    },
		    tooltip : {
		        show: false
		    },
		    legend: {
		        orient : 'vertical',
		        x :20,
		        y :50,
		        itemGap:5,
		        textStyle:{color:'#FFF',fontSize:14},
		        data:['特种票','保通卡','单程票','公交卡'],
		        formatter:function(p){
		    		if(p=="公交卡"){
		    			return "公交卡:"+card_data[0].JFK_TIMES+"万张("+card_data[0].JFK_PER+"%)";
		    		}else if(p=="单程票"){
		    			return "单程票:"+card_data[0].DCP_TIMES+"万张("+card_data[0].DCP_PER+"%)";
		    		}else if(p=="敬老卡"){
		    			return "敬老卡:"+card_data[0].LRK_TIMES+"万张("+card_data[0].LRK_PER+"%)";
		    		}else if(p=="保通卡"){
		    			return "保通卡:"+card_data[0].LRK_TIMES+"万张("+card_data[0].LRK_PER+"%)";
		    		}else if(p=="特种票"){
		    			return "特种票:"+card_data[0].TZP_TIMES+"万张("+card_data[0].TZP_PER+"%)";
		    		}
		    		return p;
		        }
		    },
		    series : [
		        {
		            name:'票卡使用占比',
		            type:'pie',
		            clockWise:false,
		            center:[280, '42%'],
		            radius : [50, 60],
		            itemStyle : dataStyle,
		            data:[
		                {
		                    value:card_data[0].JFK_PER,
		                    name:'公交卡',
		                    itemStyle:{
							    normal : {
							        color: '#ff7f50',
							        label: {show:false},
							        labelLine: {show:false}
							    },
							    emphasis : {
							        color: '#ff7f50'
							    }
							}
		                },
		                {
		                    value:card_data[0].DCP_PER,
		                    name:'单程票',
		                    itemStyle:{
							    normal : {
							        color: '#87cefa',
							        label: {show:false},
							        labelLine: {show:false}
							    },
							    emphasis : {
							        color: '#87cefa'
							    }
							}
		                },
		                {
		                    value:card_data[0].LRK_PER,
		                    name:'保通卡',
		                    itemStyle:{
							    normal : {
							        color: '#da70d6',
							        label: {show:false},
							        labelLine: {show:false}
							    },
							    emphasis : {
							        color: '#da70d6'
							    }
							}
		                },
		                {
		                    value:card_data[0].TZP_PER,
		                    name:'特种票',
		                    itemStyle:{
							    normal : {
							        color: '#32cd32',
							        label: {show:false},
							        labelLine: {show:false}
							    },
							    emphasis : {
							        color: '#32cd32'
							    }
							}
		                }
		            ]
		        },
		        {
		            name:'票卡使用次数',
		            type:'pie',
		            clockWise:false,
		            center:[280, '42%'],
		            radius : [0, 40],
		            itemStyle : dataStyle,
		            data:[{value:card_data[0].JFK_TIMES,name:'公交卡'},{value:card_data[0].DCP_TIMES,name:'单程票'},{value:card_data[0].LRK_TIMES,name:'保通卡'},{value:card_data[0].TZP_TIMES,name:'特种票'}]
		        }
		    ]
		};
	  	require(
	      [
	          'echarts',
	          'echarts/chart/pie'
	      ],
	     function (ec) {
	     	var chartCard = ec.init(document.getElementById('mainCard')); 
	     	chartCard.setOption(optionCard, true);
	     });
        
        
	  	//分时客流
	  	var predict_time='14';
    	var time_period=["04", "04:30", "05", "05:30", "06", "06:30", "07", "07:30", "08", "08:30", "09", "09:30", "10", "10:30", "11", "11:30", "12", "12:30", "13", "13:30", "14", "14:30", "15", "15:30", "16", "16:30", "17", "17:30", "18", "18:30", "19", "19:30", "20", "20:30", "21", "21:30", "22", "22:30", "23", "23:30", "00", "00:30", "01", "01:30"];
    	var fir_times=[0, 0.1, 0.8, 4.1, 10.5, 20.9, 35.8, 55.5, 79.5, 105.9, 132.2, 157.8, 181.7, 203.9, 224.4, 244.7, 265.8, 287.2, 308.9, 330.4, 351.9, 374.2, 397, 420, 444.2, 469.5, 496.2, 522.5, 547.7, 570.5, 591.2, 610.3, 629.5, 648.3, 667.7, 685.8, 701.7, 711.5, 715.4, 716.3, 716.4, 716.5, 716.5, 716.5];
    	var sec_times=[0, 0.1, 0.6, 3.4, 8.5, 16.7, 28.2, 43.2, 62.3, 84, 106.1, 128.4, 150.2, 171.3, 192.1, 212.4, 232.9, 253.8, 275.3, 297.4, 319.6, 342.2, 364.9, 388.1, 412.8, 438.2, 465.1, 491.7, 517.8, 542, 564.6, 585.8, 606.8, 626.8, 646.5, 664.5, 679.7, 688.4, 691.3, 691.6, 691.6, 691.6, 691.6, 691.6];
    	var today_times=[0, 0.1, 0.7, 4.4, 12.9, 30.9, 65.8, 125.6, 203.7, 280.2, 332.2, 366.8, 391.4, 412.4, 432.2, 452, 472.4, 493.3, 513.9, 534.4, 553.7, 573.4, 593.7];
    	var fen_times=[0, 0, -0.7, -3.7, -8.5, -17.9, -34.9, -59.9, -78.1, -76.4, -52, -34.6, -24.6, -21, -19.7, -19.9, -20.4, -20.8, -20.7, -20.5, -19.3, -19.6, -20.3];
    	var pre_times=[0, 0.1, 0.7, 4.4, 12.9, 30.9, 65.8, 125.6, 203.7, 280.2, 332.2, 366.8, 391.4, 412.4, 432.2, 452, 472.4, 493.3, 513.9, 534.4, 553.7, 573.4, 593.7, 615.9, 641, 671.2, 714.8, 770.7, 834.3, 889.9, 934.3, 966.7, 993.1, 1016.5, 1039.8, 1060.8, 1078.8, 1089, 1092.4, 1092.9, 1092.9, 1093, 1093, 1093];
    	var dates=["2017/08/05(716.4)", "2017/08/06(691.4)", "2017/08/08(593.7)  14点预测(1093)"];
	
    	var fen_fir_times=[0,-0.1,-0.7,-3.3,-6.4,-10.4,-14.9,-19.7,-24,-26.5,-26.2,-25.6,-23.9,-22.2,-20.5,-20.3,-21.1,-21.3,-21.8,-21.5,-21.5,-22.3,-22.8,-23,-24.2,-25.3,-26.7,-26.2,-25.2,-22.8,-20.7,-19,-19.2,-18.8,-19.4,-18.1,-15.9,-9.8,-3.9,-0.9,-0.2,0,0,0];
    	var fen_sec_times=[0,-0.1,-0.6,-2.7,-5.1,-8.2,-11.5,-15,-19.1,-21.7,-22.1,-22.3,-21.7,-21.2,-20.8,-20.3,-20.5,-20.9,-21.5,-22.1,-22.3,-22.5,-22.8,-23.2,-24.7,-25.5,-26.9,-26.6,-26.1,-24.1,-22.6,-21.2,-21,-20,-19.7,-18,-15.2,-8.6,-2.9,-0.3,0,0,0,0];
    	
		for(var i=0;i<today_times.length;i++){pre_times[i]=today_times[i];}  
		
        require(
            [
                'echarts',
                'echarts/theme/dark1',
                'echarts/chart/bar',
                'echarts/chart/line'
            ],
            function (ec,theme) {
                var myChart = ec.init(document.getElementById('main'),theme); 
                var time_period_tp=[];
				for(var i=0;i<time_period.length;i++){
					if(time_period[i].toString().indexOf("30")>-1){
						time_period_tp.push({
					        value:time_period[i],            
					        textStyle:{fontSize:0}
					     });
					}else{
						time_period_tp.push({
					        value:time_period[i],            
					        textStyle:{fontSize:10}
					     });
					}
				}
				
				
                option = {
                	title : {
				        text:'车站分时客流累计(万人次)',
				        x:'center',
		        		textStyle:{fontSize:15,fontWeight:'bolder'}
				    },
				    tooltip : {
				        trigger: 'axis',
				        textStyle: {fontWeight:'bold',fontSize:15},
				        formatter:function (params){
				        	
							var tpstr=(params[0].name.toString().indexOf("30")>-1?params[0].name:params[0].name+":00")
							+"<br/>"+params[0].seriesName.substring(0,10)+":"+(params[0].value=="-"?params[1].value:params[0].value)+"万<br/>"
							+params[2].seriesName.substring(0,10)+":"+params[2].value+"万<br/>"
							+params[3].seriesName.substring(0,10)+":"+params[3].value+"万";
							return tpstr;
				        }
				    },
				    legend: {
				    	selectedMode:false,
				    	x:'center',
				    	y:'30',
				    	textStyle: {fontWeight:'bold',fontSize:15},
				        data:dates
				    },
				    calculable : true,
				    grid:{y2:25,x2:30},
				    xAxis : [
				        {
				            type : 'category',
				            axisLabel:{interval:0,textStyle: {fontWeight:'bold',fontSize:14}},
				            data : time_period_tp
				        }
				    ],
				    yAxis : [
				        {
				            type : 'value',
				            axisLabel:{formatter:'{value}万',textStyle: {fontWeight:'bold',fontSize:14}}
				        }
				    ],
				    series : [
				        {
				            name:dates[2],
				            type:'line',
				            symbolSize:function(param){if(param){return 2;}return 0;},
				            itemStyle:{normal: {color:'rgba(255,8,8,1)'}},
				            data:today_times
				        },
				        {
				            name:dates[2],
				            type:'line',
				            symbolSize:function(param){if(param){return 2;}return 0;},
				            itemStyle:{
				            	normal: {color:'rgba(255,8,8,1)',lineStyle:{width: 2,type: 'dashed'}},
				            	emphasis:{color:'rgba(255,8,8,1)',lineStyle:{width: 2,type: 'dashed'}}
				            },
				            data:pre_times
				        },
				        {
				            name:dates[0],
				            type:'line',
				            symbolSize:function(param){if(param){return 2;}return 0;},
				            itemStyle:{normal: {color:'rgba(255,253,55,1)'}},
				            data:fir_times
				        },
				    	{
				            name:dates[1],
				            type:'line',
				            symbolSize:function(param){if(param){return 2;}return 0;},
				            itemStyle:{normal: {color:'rgba(100,255,104,1)'}},
				            data:sec_times
				        }
				        
				    ]
				};
                
				myChart.setOption(option, true);
				
				
				
				option1 = {
                	title : {
				        text:'车站分时客流(万人次)',
				        x:'center',
				        y:'bottom',
		        		textStyle:{fontSize:15,fontWeight:'bolder'}
				    },
				    tooltip : {
				        trigger: 'axis',
				        textStyle: {fontWeight:'bold',fontSize:15},
				        formatter:function (params){
				        	if(params[0].value=="-"){
						return (params[0].name.toString().indexOf("30")>-1?params[0].name:params[0].name+":00")+"<br/>"+params[0].seriesName.substring(0,10)+":-万";
				        	}else{
				        		return (params[0].name.toString().indexOf("30")>-1?params[0].name:params[0].name+":00")+"<br/>"+params[0].seriesName.substring(0,10)+":"+(-params[0].value)+"万";
				        	}
							
				        }
				    },
				    calculable : true,
				    grid:{y:5,y2:30,x2:30},
				    xAxis : [
				        {
				            type : 'category',
				            axisLabel:{interval:0,show:false},
				            data : time_period_tp
				        }
				    ],
				    yAxis : [
				        {
				            type : 'value',
				            axisLabel:{
				        		textStyle: {fontWeight:'bold',fontSize:15},
				        		formatter: function(v){
									        return v==0?"":-v+"万";
						                }
				        	}
				        }
				    ],
				    series : [
				        {
				            name:dates[2],
				            type:'bar',
				            itemStyle:{normal: {color:'rgba(255,8,8,1)'}},
				            data:fen_times
				        },
				        {
				            name:dates[0],
				            type:'line',
				            symbolSize:function(param){if(param){return 2;}return 0;},
				            itemStyle:{normal: {color:'rgba(255,253,55,1)'}},
				            data:fen_fir_times
				        },
				    	{
				            name:dates[1],
				            type:'line',
				            symbolSize:function(param){if(param){return 2;}return 0;},
				            itemStyle:{normal: {color:'rgba(100,255,104,1)'}},
				            data:fen_sec_times
				        }
				    ]
				};
				
				
				var myChart1 = ec.init(document.getElementById('main1'),theme); 
				myChart1.setOption(option1, true);
            }
        );
        
        
        //客流旅行距离和时间分布
        optionDistance = {
        	title : {
		        text: '距离和时间分布',
		        x:'center',
		        y:-3,
		        textStyle : {
		            color : '#FFF',
		            fontFamily : '微软雅黑',
		            fontSize : 15,
		            fontWeight : 'bolder'
		        }
		    },
		    tooltip : {
		        trigger: 'axis',
		        showDelay : 0,
		        axisPointer:{
		            type : 'cross',
		            lineStyle: {
		                type : 'dashed',
		                width : 1
		            }
		        }
		    },
		    toolbox: {
		        show : false
		    },
		    grid:{
		    	x:30,
		    	y:17,
		    	x2:10,
		    	y2:20
		    },
		    xAxis : [
		        {
		            type : 'value',
		            axisLabel:{
		        		textStyle:{color: '#FFF'}
		        	},
		            scale : true
		        }
		    ],
		    yAxis : [
		        {
		            type : 'value',
		            axisLabel:{
		        		textStyle:{color: '#FFF'}
		        	},
		            scale : true
		        }
		    ],
		    animation: false,
		    series : [
		        {
		            name:'scatter1',
		            type:'scatter',
		            itemStyle:{normal: {color:'rgba(46,199,201,1)'}},
		            symbolSize:2,
		            data: (function () {
		                var d = [];
		                var len = 500;
		                var value;
		                while (len--) {
		                    value = (Math.random()*100).toFixed(2) - 0;
		                    d.push([
		                        (Math.random()*value + value).toFixed(2) - 0,
		                        (Math.random()*value).toFixed(2) - 0,
		                        value
		                    ]);
		                }
		                return d;
		            })()
		        }
		    ]
		};
        require(
	      [
	          'echarts',
	          'echarts/chart/scatter'
	      ],
	     function (ec) {
	     	var chartDistance = ec.init(document.getElementById('distanceId')); 
	     	chartDistance.setOption(optionDistance, true);
	     });
        
        
        //区域客流排名和环线客流占比
        optionAreaFlux =  {
			title: {
		        text: '行政区域客流排名',
		        x: 'center',
		        y:0,
		        textStyle : {
					color : '#FFF',
		            fontFamily : '微软雅黑',
		            fontSize : 15,
		            fontWeight : 'bolder'
		        }
		    },
		    tooltip : {
		        trigger: 'axis',
		        textStyle: {fontWeight:'bold',fontSize:15},
				formatter:'{b}<br>{a}:{c}万'
		    },
			grid: {x:50,x2:20,y:20,y2:35},
		    calculable : true,
		    xAxis : [
		        {
		            type : 'category',
		            axisLabel:{rotate:-25,textStyle:{color: '#FFF'}},
					data:[],
					splitLine: {show:false}
		        }
		    ],
		    yAxis : [
		        {
		            type : 'value',
		            axisLabel:{formatter:'{value}万',textStyle:{color: '#FFF'}},
					splitNumber:4,
					min:0,
					max:600,
					splitLine: {show:false}
		        }
		    ],
		    series : [
		    	{
		            name:'区域客流',
		            type:'bar',
		            barWidth:18,
					itemStyle:{normal: {color:'#87cefa',label : {show: true, position: 'top'}}},
					data:[]
		        },
		        {
		            name:'环线客流',
		            type:'pie',
		            tooltip : {
		                trigger: 'item',
		                formatter: '{a} <br/>{b} : {c} ({d}%)'
		            },
		            center: [350,70],
		            radius : [0,30],
		            itemStyle :　{
		                normal : {
		                    labelLine : {
		                        length : 10
		                    }
		                }
		            },
		            data:[
		                {value:1048, name:'内环内'},
		                {value:251, name:'中环内环间'},
		                {value:147, name:'外环中环间'},
		                {value:102, name:'外环外'}
		            ]
		        }
		    ]
		};
        
        var area_data=[{"DISTRICT_CODE":"浦东新区","TATALTIMES":376},{"DISTRICT_CODE":"徐汇区","TATALTIMES":214},{"DISTRICT_CODE":"闵行区","TATALTIMES":179},{"DISTRICT_CODE":"黄浦区","TATALTIMES":178},{"DISTRICT_CODE":"静安区","TATALTIMES":157},{"DISTRICT_CODE":"普陀区","TATALTIMES":113},{"DISTRICT_CODE":"宝山区","TATALTIMES":109},{"DISTRICT_CODE":"长宁区","TATALTIMES":107},{"DISTRICT_CODE":"杨浦区","TATALTIMES":86},{"DISTRICT_CODE":"虹口区","TATALTIMES":77},{"DISTRICT_CODE":"嘉定区","TATALTIMES":54},{"DISTRICT_CODE":"松江区","TATALTIMES":53},{"DISTRICT_CODE":"青浦区","TATALTIMES":14},{"DISTRICT_CODE":"昆山市","TATALTIMES":9}];
        var district_code=[];
		var tataltimes=[];
		var totalflux=0;//所有区域总客流
		$.each(area_data,function(i,v){
			district_code.push(v.DISTRICT_CODE);
			tataltimes.push(v.TATALTIMES);
			totalflux+=v.TATALTIMES;
		});
		optionAreaFlux.xAxis[0].data=district_code;
		optionAreaFlux.series[0].data=tataltimes;
		//设置label显示的值为区域占总客流的比例
		optionAreaFlux.series[0].itemStyle.normal.label.formatter=function(p){
			return (p.value/totalflux*100).toFixed(1)+"%";
		};
		
		//初始化报表--显示
		require(
	      [
	          'echarts',
	          'echarts/chart/bar'
	      ],
	     function (ec) {
	     	var chartAreaFlux = ec.init(document.getElementById('mainAreaFlux')); 
	     	chartAreaFlux.setOption(optionAreaFlux, true);
	     });
        
		
		
		//车站客流排名mainStationFlux
		stationOption = {
            title : {
		        text: '车站客流排名',
		        x: 'center',
		        y:0,
		        textStyle : {
					color : '#FFF',
		            fontFamily : '微软雅黑',
		            fontSize : 15,
		            fontWeight : 'bolder'
		        }
		    },
		    tooltip : {
		        trigger: 'axis',
		        textStyle: {fontWeight:'bold',fontSize:22},
		        axisPointer : {            
		            type : 'shadow'  
		        }
		    },
		    calculable : true,
		    grid: {x:40,x2:20,y:20,y2:35},
		    xAxis : [
		        {
		            type : 'category',
		            axisLabel:{rotate:-25,textStyle:{color: '#FFF'}},
		            splitLine: {show:false},
		            data : ['世纪大道','人民广场','徐家汇','龙阳路','汉中路','莘庄','南京东路','江苏路','老西门','陆家浜路']
		        }
		    ],
		    yAxis : [
		        {
		            type : 'value',
		            axisLabel:{
			        	textStyle: {color: '#FFF'}
			        },
			        splitLine: {show:false},
			        splitArea:{show : true}
		        }
		    ],
		    series : [
		    	{
		            name:'客流',
		            type:'bar',
		            itemStyle : { normal: {label : {show: true, position: 'insideTop'}}},
		            data:['43398','23618','22185','21771','19622','17669','16489','14107','10075','8854']
		    	}
		    ]
		};
		require(
	      [
	          'echarts',
	          'echarts/chart/bar'
	      ],
	     function (ec) {
	     	var chartStationFlux = ec.init(document.getElementById('mainStationFlux')); 
	     	chartStationFlux.setOption(stationOption, true);
	     });
	</script>
</body>
</html>
