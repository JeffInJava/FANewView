﻿<%@ page language="java" import="java.util.*,java.lang.*,com.util.*,net.sf.json.*,java.text.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>

<!DOCTYPE html>
<html>
<head>
	<title>二维码客流监控</title>
	<base href="<%=basePath%>">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0"/>
	<script src="resource/jquery/js/jquery-1.7.2.js" type="text/javascript"></script>
	<script src="resource/inesa/js/common.js"></script>
	<script src="resource/echarts3/echarts.min.js"></script>
	<style type="text/css">
		html, body{
		  margin:0;
		  padding:0;
		  border:0;
		  width:1595px;
		  height:875px;
		  font-family:'Microsoft YaHei' ! important;
		  background-color: #0B112F;
		  color:white;
		}
		#stationDialog,#enterFluxCpDialog{
		  z-index:2;
		  background:url('resource/images/dialogbg.png') no-repeat;
		  background-size:100% 100%;  
    	  position:absolute; 
		  width:1000px;
		  height:500px;
		  top:10px;
		  right:20%;
		  display:none;
		}
		a:link {color:#FFFF00 !important;text-decoration:none}
		a:visited {color:#FFFF00 !important;text-decoration:none}
		a:hover {color:#FFFF00 !important;text-decoration:none} 
		a:active {color:#FFFF00 !important;text-decoration:none}
		
		.tab{
		  float:left;
		  margin-left:10px;
		  height:24px;
		  width:137px;
		  background-color: rgb(50, 91, 105);
		  border-radius:10px;
		  color:#fff;
		}
		.tab span{
		  margin:2px 5px;
		  padding:3px 15px;
		  line-height:24px;
		  border-radius:10px;
		  background: rgba(32,32,35,0.6);
		}
		.tab .act{
		  background:#3980E9;
		}
		.btn,.searchbtn{
		  color: #fff;
    	  text-shadow: 0 -1px 0 rgba(0,0,0,0.25);
     	  background-color:#3980E9;
     	  text-align: center;
     	  border-radius: 4px;
     	  padding: 2px 10px;
    	  margin:0;
    	  border:0;
    	  font-size: 12px;
		}
		.prm{
		  margin-left:5px;
		  float:left;
		  padding-left:10px;
		  display: none;
		}
		.prm input,.prm select{
		  border: 1px solid #3980E9;
		}
		#dayPmId{
		  float:left;
		  display:none;
		  margin-left:10px;
		}
	</style>
</head>
<body>
	<%
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
		
		String start_day = fmt.format(cal.getTime());//当前日期
		cal.add(Calendar.DATE, -1);
		
		String compare_day = fmt.format(cal.getTime());//环比日期
	%>
	<div style="height:100%;width:100%;background:url('resource/images/bgnew.png') no-repeat;background-size:cover;margin: 0;padding: 0;">
		<div style="height:50%;width:100%">
			<div style="float:left;height:100%;width:51%">
				<table style="position:absolute;left:80px;top:110px;text-align:center" id="qrcdTotalId">
					<tr style="font-weight:bold;font-size:16pt;color:white;" height="50">
						<td width="110">&nbsp;</td>
						<td width="104" class="enter">进站</td>
						<td width="104">出站</td>
						<td width="104">合计</td>
					</tr>
					<tr style="font-weight:bold;font-size:14pt;color:#FFFF00;" height="60">
						<td style="padding-left:10px;text-align:left;"><a href="javascript:loadQrcdAllLineFlux()">二&nbsp;维&nbsp;码</a></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr style="font-weight:bold;font-size:12pt;color:white;" height="60">
						<td>支付宝</td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr style="font-weight:bold;font-size:12pt;color:white;" height="60">
						<td>银&nbsp;&nbsp;联</td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr style="font-weight:bold;font-size:12pt;color:white;" height="60">
						<td>微&nbsp;&nbsp;信</td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
				</table>
				<div style="float:right;width:280px;height:300px;margin-top:90px;background:#0C1335;">
					<div id="qrcdFluxPerId" style="width:100%;height:100%;"></div>
				</div>
			</div>
			<div style="float:right;height:100%;width:49%">
				<div style="height:6%;width:92%;font-size:13px;margin:10% 0 0 7%;">
					<div class="tab">
				   		<span onclick="change(this,'fs')">分时</span>
					   	<span class="act" onclick="change(this,'lj')" style="margin-left:0px;">累计</span>
					   	<input type="hidden" id="cp_flag" value="lj">
				    </div>
				    <input type="button" value=">>" class="btn" style="float:left;margin:3px 0px 0px 2px;">
				    <div class="prm">
				    	 运营日期:<input type="text" name="start_day" id="start_day" value="<%=start_day %>" style="width:70px;">
						 对比日期:<input type="text" name="compare_day" id="compare_day" value="<%=compare_day %>" style="width:70px;">
						 时长:<select name="seg" id="seg">
							 	<option value="30" selected="selected">30分钟</option>
							 	<option value="60">60分钟</option>
							 </select>
						 <input type="button" value="查询" onclick="totalDeal()" class="searchbtn">
				    </div>
				</div>
				<div id="enterFluxCpId" style="height:75%;width:85%;margin-left:7%;"></div>
			</div>
		</div>
	
		<div style="height:50%;width:100%">
			<div style="float:left;height:100%;width:52%">
				<div id="lineFluxId" style="height:100%;width:100%"></div>
			</div>
			<div style="float:right;height:100%;width:48%">
				<div style="height:9%;width:89%;color:white;font-weight:bold;font-size:13px;text-align:right;padding-right:11%;padding-top:6%;" >
					<div style="vertical-align:top;" id="selImgId">
						<img alt="" src="resource/images/pressed.png" style="vertical-align:bottom;" onclick="chgImg(this,1)">进站&nbsp;<input type="hidden" name="flux_flag" id="flux_flag1" value="1">
						<img alt="" src="resource/images/pressed.png" style="vertical-align:bottom;" onclick="chgImg(this,2)">出站&nbsp;<input type="hidden" name="flux_flag" id="flux_flag2" value="2">
						<img alt="" src="resource/images/unselect.png" style="vertical-align:bottom;" onclick="chgImg(this,3)">换乘&nbsp;<input type="hidden" name="flux_flag" id="flux_flag3" value="">
						<input type="button" onclick="loadQrcdStationRank()" style="background:url('resource/images/refresh.png') no-repeat;border:0px;width:20px;height:20px;background-color:transparent;" value="">
					</div>
				</div>
				<div id="stationRankId" style="height:85%;width:100%"></div>
			</div>
		</div>
	</div>
	
	<div id="stationDialog">
		<div id="stationTitle" style="height:8%;width:100%;color:white;font-weight:bold;font-size:24px;text-align:center;vertical-align:middle;padding-top:5px;" >
			号线车站客流
		</div>
		<div id="linePeriodFluxId" style="height:40%;width:100%"></div>
		<div id="stationFluxId" style="height:50%;width:100%"></div>
	</div>
	

	<div id="enterFluxCpDialog">
		<div id="enterFluxCpTitle" style="height:8%;width:100%;color:white;font-weight:bold;font-size:24px;text-align:center;vertical-align:middle;padding-top:5px;" >
			进出站分时客流
		</div>
		<div id="allLinePeriodFluxId" style="height:87%;width:100%"></div>
	</div>

	<script type="text/javascript">
		
		qrcdFluxPerOption = {
			title:{
				text:"",
				x:100,
				y:0,
				textStyle:{color:'white',fontSize:18,fontWeight:'bold',fontFamily:'Microsoft YaHei'}
			},
		    legend:{
		        orient : 'vertical',
		        x:'5%',
		        y:'82%',
		        textStyle:{color:'white',fontSize:14,fontWeight:'bold',fontFamily:'Microsoft YaHei'},
		        itemGap:12,
		        data:['进站占比','进站占比','']
		    },
		    series : [
		        {
		            name:'1',
		            type:'pie',
		            center:['60%','49%'],
		            clockWise:false,
		            radius : [75,100],
		            itemStyle: {
			            normal: {
                			label: {show:false},
        					labelLine: {show:false}
			            }
			        },
		            data:[
		                {
		                    value:0,
		                    itemStyle: {
					            normal: {
					                color: 'rgba(207,107,91,1)'
					            }
					        },
		                    name:'进站占比--'
		                },
		                {
		                    value:0,
		                    name:'invisible',
		                    itemStyle: {
					            normal: {
					                color: 'rgba(29,50,118,0.6)'
					            }
					        }
		                }
		            ]
		        },
		        {
		            name:'2',
		            type:'pie',
		            center:['60%','49%'],
		            clockWise:false,
		            radius : [50,75],
		            itemStyle: {
			            normal: {
                			label: {show:false},
        					labelLine: {show:false}
			            }
			        },
		            data:[
		                {
		                    value:0,
		                    itemStyle: {
					            normal: {
					                color: 'rgba(242,176,64,1)'
					            }
					        },
		                    name:'出站占比--'
		                },
		                {
		                    value:0,
		                    name:'invisible',
		                    itemStyle: {
					            normal: {
					                color: 'rgba(51,76,159,0.7)'
					            }
					        }
		                }
		            ]
		        },
		        {
		            name:'3',
		            type:'pie',
		            center:['60%','49%'],
		            clockWise:false,
		            radius : [25,50],
		            itemStyle: {
			            normal: {
                			label: {show:false},
        					labelLine: {show:false}
			            }
			        },
		            data:[
		                {
		                    value:0, 
		                    itemStyle: {
					            normal: {
					                color: 'rgba(254,226,79,1)'
					            }
					        },
		                    name:''
		                },
		                {
		                    value:100,
		                    name:'invisible',
		                    itemStyle: {
					            normal: {
					                color: 'rgba(119,131,211,0.7)'
					            }
					        }
		                }
		            ]
		        }
		    ]
		};
		
    	lineFluxOption =  {
			grid: {
				x:140,x2:20,y:90,y2:80
			},
		    legend: {
				y:50,
				x:360,
				textStyle:{color:'white',fontSize:14,fontWeight:'bold',fontFamily:'Microsoft YaHei'},
		        data:['进站','出站']
		    },
		    tooltip:{
		    	formatter:function(pm){
		    		var tp=(lineFluxOption.xAxis[0].data[pm.dataIndex]*1)+"号线<br/>进站客流："+lineFluxOption.series[0].data[pm.dataIndex]+
		    			"<br/>出站客流："+lineFluxOption.series[1].data[pm.dataIndex];
		    		return tp;
		    	},
		    	textStyle:{fontSize:24,fontWeight:'bold'}
		    },
		    calculable : true,
		    xAxis : [
		        {
		            type : 'category',
		            axisLine:{lineStyle:{color:'#1A3679',width:2}},
		            axisLabel:{interval:0,textStyle:{color:'white',fontSize:14,fontWeight:'bold',fontFamily:'Microsoft YaHei'}},
					data:[]
		        }
		    ],
		    yAxis : [
		        {
		        	name:'客流/人次',
		        	nameTextStyle:{color:'white'},
		            type:'value',
		            axisLabel:{
		        		formatter:'{value}',
		        		textStyle:{color:'white',fontSize:14,fontWeight:'bold',fontFamily:'Microsoft YaHei'}
		        	},
					splitNumber:5,
					splitLine:{show:true,lineStyle:{type:'dashed',color:'#3980E9'}},
		            axisLine:{lineStyle:{color:'#1A3679',width:2}}
		        }
		    ],
		    series : [
		    	{
		            name:'进站',
		            type:'bar',
		            barWidth:10,
					itemStyle:{normal: {color:'#F2D800',label : {show: false}}},
					data:[]
		        },
		        {
		            name:'出站',
		            type:'bar',
		            barWidth:10,
		            itemStyle:{normal: {color:'#09A420',label : {show: false}}},
					data:[]
		        }
		    ]
		};
    	
    	
    	stationFluxOption =  {
			grid: {
				x:70,x2:10,y:30,y2:70
			},
		    legend: {
				y:5,
				x:"center",
				textStyle:{color:'white',fontSize:14,fontWeight:'bold',fontFamily:'Microsoft YaHei'},
		        data:['进站','出站']
		    },
		    tooltip:{
		    	formatter:function(pm){
		    		var tp=stationFluxOption.xAxis[0].data[pm.dataIndex].toString().trim()+"<br/>进站客流："+stationFluxOption.series[0].data[pm.dataIndex]+
		    			"<br/>出站客流："+stationFluxOption.series[1].data[pm.dataIndex];
		    		return tp;
		    	},
		    	textStyle:{fontSize:24,fontWeight:'bold'}
		    },
		    calculable : true,
		    xAxis : [
		        {
		            type : 'category',
		            axisLine:{lineStyle:{color:'#1A3679',width:2}},
		            axisLabel:{rotate:30,interval:0,textStyle:{color:'white',fontSize:12,fontWeight:'bold',fontFamily:'Microsoft YaHei'}},
					data:[]
		        }
		    ],
		    yAxis : [
		        {
		        	name:'客流/人次',
		        	nameTextStyle:{color:'white'},
		            type : 'value',
		            axisLabel:{
		        		formatter:'{value}',
		        		textStyle:{color:'white',fontSize:14,fontWeight:'bold',fontFamily:'Microsoft YaHei'}
		        	},
					splitLine:{lineStyle:{type:'dashed',color:'#3980E9'}},
		            axisLine:{lineStyle:{color:'#1A3679',width:2}}
		        }
		    ],
		    series : [
		    	{
		            name:'进站',
		            type:'bar',
		            barWidth:10,
					itemStyle:{normal: {color:'#F2D800',label : {show: false}}},
					data:[]
		        },
		        {
		            name:'出站',
		            type:'bar',
		            barWidth:10,
		            itemStyle:{normal: {color:'#09A420',label : {show: false}}},
					data:[]
		        }
		    ]
		};
    	
    	
    	linePeriodFluxOption =  {
			grid: {
				x:70,x2:10,y:30,y2:20
			},
		    legend: {
				y:5,
				x:"center",
				textStyle:{color:'white',fontSize:14,fontWeight:'bold',fontFamily:'Microsoft YaHei'},
		        data:['进站','出站']
		    },
		    tooltip:{
		    	formatter:function(pm){
		    		var tp="";
		    		if(linePeriodFluxOption.xAxis[0].data[pm.dataIndex].value){
		    			tp=linePeriodFluxOption.xAxis[0].data[pm.dataIndex].value.toString().trim()
		    		}else{
		    			tp=linePeriodFluxOption.xAxis[0].data[pm.dataIndex].toString().trim();
		    		}
		    		tp=tp+"<br/>进站客流："+linePeriodFluxOption.series[0].data[pm.dataIndex]+
		    			"<br/>出站客流："+linePeriodFluxOption.series[1].data[pm.dataIndex];
		    		return tp;
		    	},
		    	textStyle:{fontSize:24,fontWeight:'bold'}
		    },
		    calculable : true,
		    xAxis : [
		        {
		            type : 'category',
		            axisLine:{lineStyle:{color:'#1A3679',width:2}},
		            axisLabel:{interval:0,textStyle:{color:'white',fontSize:12,fontWeight:'bold',fontFamily:'Microsoft YaHei'}},
					data:[]
		        }
		    ],
		    yAxis : [
		        {
		        	name:'客流/人次',
		        	nameTextStyle:{color:'white'},
		            type : 'value',
		            axisLabel:{
		        		formatter:'{value}',
		        		textStyle:{color:'white',fontSize:14,fontWeight:'bold',fontFamily:'Microsoft YaHei'}
		        	},
					splitLine:{lineStyle:{type:'dashed',color:'#3980E9'}},
		            axisLine:{lineStyle:{color:'#1A3679',width:2}}
		        }
		    ],
		    series : [
		    	{
		            name:'进站',
		            type:'line',
		            smooth:true,
					itemStyle:{normal: {color:'#F2D800',label : {show: false}}},
					data:[]
		        },
		        {
		            name:'出站',
		            type:'line',
		            smooth:true,
		            itemStyle:{normal: {color:'#09A420',label : {show: false}}},
					data:[]
		        }
		    ]
		};
    	
    	allLinePeriodFluxOption =  {
			grid: {
				x:80,x2:20,y:40,y2:20
			},
		    legend: {
				y:10,
				x:"center",
				textStyle:{color:'white',fontSize:14,fontWeight:'bold',fontFamily:'Microsoft YaHei'},
		        data:['进站','出站']
		    },
		    tooltip:{
		    	//trigger:"axis",
		    	formatter:function(pm){
		    		var tp="";
		    		if(allLinePeriodFluxOption.xAxis[0].data[pm.dataIndex].value){
		    			tp=allLinePeriodFluxOption.xAxis[0].data[pm.dataIndex].value.toString().trim()
		    		}else{
		    			tp=allLinePeriodFluxOption.xAxis[0].data[pm.dataIndex].toString().trim();
		    		}
		    		tp=tp+"<br/>进站客流："+allLinePeriodFluxOption.series[0].data[pm.dataIndex]+
		    			"<br/>出站客流："+allLinePeriodFluxOption.series[1].data[pm.dataIndex];
		    		return tp;
		    	},
		    	textStyle:{fontSize:24,fontWeight:'bold'}
		    },
		    calculable : true,
		    xAxis : [
		        {
		            type : 'category',
		            axisLine:{lineStyle:{color:'#1A3679',width:2}},
		            axisLabel:{
		            	interval:0,
		            	textStyle:{
		            		color:'white',
		            		fontSize:12,
		            		fontWeight:'bold',
		            		fontFamily:'Microsoft YaHei'
		            	},
		            	formatter:function(v){
		            		return v.toString().substring(0,2);
		            	}
		            },
					data:[]
		        }
		    ],
		    yAxis : [
		        {
		        	name:'客流/人次',
		        	nameTextStyle:{color:'white'},
		            type : 'value',
		            axisLabel:{
		        		formatter:'{value}',
		        		textStyle:{color:'white',fontSize:14,fontWeight:'bold',fontFamily:'Microsoft YaHei'}
		        	},
					splitLine:{lineStyle:{type:'dashed',color:'#3980E9'}},
		            axisLine:{lineStyle:{color:'#1A3679',width:2}}
		        }
		    ],
		    series : [
		    	{
		            name:'进站',
		            type:'line',
		            smooth:true,
					itemStyle:{normal: {color:'#F2D800',label : {show: false}}},
					data:[]
		        },
		        {
		            name:'出站',
		            type:'line',
		            smooth:true,
		            itemStyle:{normal: {color:'#09A420',label : {show: false}}},
					data:[]
		        }
		    ]
		};
    	
    	
    	qrcdPeriodFluxCpOption =  {
			grid: {
				x:80,x2:10,y:50,y2:40
			},
		    legend: {
				y:5,
				x:"center",
				textStyle:{color:'white',fontSize:14,fontWeight:'bold',fontFamily:'Microsoft YaHei'},
		        data:[]
		    },
		    tooltip:{
		    	formatter:function(pm){
		    		var tp="";
		    		if(qrcdPeriodFluxCpOption.xAxis[0].data[pm.dataIndex].value){
		    			tp=qrcdPeriodFluxCpOption.xAxis[0].data[pm.dataIndex].value.toString().trim()
		    		}else{
		    			tp=qrcdPeriodFluxCpOption.xAxis[0].data[pm.dataIndex].toString().trim();
		    		}
		    		tp=tp+"<br/>"+qrcdPeriodFluxCpOption.legend.data[0]+"：";
		    		if(qrcdPeriodFluxCpOption.series[0].data[pm.dataIndex]){
		    			tp=tp+qrcdPeriodFluxCpOption.series[0].data[pm.dataIndex];
		    		}else{
		    			tp=tp+"--";
		    		}
		    		tp=tp+"<br/>"+qrcdPeriodFluxCpOption.legend.data[1]+"：";
		    		if(qrcdPeriodFluxCpOption.series[1].data[pm.dataIndex]){
		    			tp=tp+qrcdPeriodFluxCpOption.series[1].data[pm.dataIndex];
		    		}else{
		    			tp=tp+"--";
		    		}
		    		return tp;
		    	},
		    	textStyle:{fontSize:24,fontWeight:'bold'}
		    },
		    calculable : true,
		    xAxis : [
		        {
		            type : 'category',
		            axisLine:{lineStyle:{color:'#1A3679',width:2}},
		            axisLabel:{
		            	interval:0,
		            	textStyle:{color:'white',fontSize:12,fontWeight:'bold',fontFamily:'Microsoft YaHei'},
		            	formatter:function(v){
		            		return v.toString().substring(0,2);
		            	}
		            },
					data:[]
		        }
		    ],
		    yAxis : [
		        {
		        	name:'客流/人次',
		        	nameTextStyle:{color:'white'},
		            type : 'value',
		            axisLabel:{
		        		formatter:'{value}',
		        		textStyle:{color:'white',fontSize:14,fontWeight:'bold',fontFamily:'Microsoft YaHei'}
		        	},
					splitLine:{lineStyle:{type:'dashed',color:'#3980E9'}},
		            axisLine:{lineStyle:{color:'#1A3679',width:2}}
		        }
		    ],
		    series : [
		    	{
		            name:'运营日期',
		            type:'line',
		            smooth:true,
					itemStyle:{normal: {color:'#F2D800',label : {show: false}}},
					data:[]
		        },
		        {
		            name:'对比日期',
		            type:'line',
		            smooth:true,
		            itemStyle:{normal: {color:'#09A420',label : {show: false}}},
					data:[]
		        }
		    ]
		};
    	
    	stationRankOption= {
    		tooltip:{
		    	textStyle:{fontSize:18,fontWeight:'bold'}
		    },
		    grid: {
				x:140,x2:100,y:5,y2:95
			},
		    xAxis : [
		        {
		            type : 'value',
		            axisLabel:{formatter:'{value}'},
					splitNumber:4,
					axisLine:{lineStyle:{color:'#1A3679',width:2}},
		            axisLabel:{textStyle:{color:'white',fontSize:14,fontWeight:'bold',fontFamily:'Microsoft YaHei'}},
		            splitLine:{lineStyle:{type:'dashed',color:'#3980E9'}},
					scale:15,
					min:0
		        }
		    ],
		    yAxis : [
		        {
		            type : 'category',
		            axisLine:{lineStyle:{color:'#1A3679',width:2}},
		            axisLabel:{rotate:25,textStyle:{color:'white',fontSize:14,fontWeight:'bold',fontFamily:'Microsoft YaHei'}},
		            splitLine:{lineStyle:{type:'dashed',color:'#3980E9'}},
		            data : []
		        }
		    ],
		    series : [
		        {
		            name:'客流',
		            type:'bar',
		            itemStyle: {
		                normal: {
		                    color: new echarts.graphic.LinearGradient(
		                        0, 0, 1, 0,
		                        [
		                            {offset: 0, color: '#0E132E'},
		                            {offset: 1, color: '#E3E001'}
		                        ]
		                    )
		                }
		            },
		            data:[]
		        }
		    ]
		};
    	
    	
    	//加载“二维码总览”数据
    	function loadQrcdFluxIncome(){
    		var start_day=$("#start_day").val();
    		doPost("qrcd/get_qrcdfluxincome.action", {"sel_flag":"flux_new","start_day":start_day}, function(data){
    			if(data){
    				var trs=$("#qrcdTotalId").find("tr");
    				$.each(data,function(i,v){
    					if(i<4){
    						var tds=$(trs[i+1]).find("td");
			    			$(tds[1]).html(v.ENTER_TIMES);
			    			$(tds[2]).html(v.EXIT_TIMES);
			    			$(tds[3]).html(v.ENTER_TIMES+v.EXIT_TIMES);
    					}else{
    						$("#enter_total").html(v.ENTER_TIMES);
    						$("#exit_total").html(v.EXIT_TIMES);
    					}
		    		});
		    		
    				var enter_per=(data[0].ENTER_TIMES/data[4].ENTER_TIMES*100).toFixed(2);
    				var exit_per=(data[0].EXIT_TIMES/data[4].EXIT_TIMES*100).toFixed(2);
    				
    				var start_day_tp=start_day.substr(0,4)+"/"+start_day.substr(4,2)+"/"+start_day.substr(6,2);
   					
   					qrcdFluxPerOption.title.text=data[0].CURHOUR;
   					if(start_day_tp!=data[0].CURHOUR.substr(0,10)){
   						qrcdFluxPerOption.title.text=start_day_tp+" 23:59";
   					}
   					var nm1="进站占比:"+enter_per+"%",nm2="出站占比:"+exit_per+"%",nm3='';
   					qrcdFluxPerOption.legend.data=[nm1,nm2,nm3];
   					qrcdFluxPerOption.series[0].data[0].name=nm1;
   					qrcdFluxPerOption.series[0].data[0].value=enter_per;
   					qrcdFluxPerOption.series[0].data[1].value=(100-enter_per).toFixed(2);
   					
   					qrcdFluxPerOption.series[1].data[0].name=nm2;
   					qrcdFluxPerOption.series[1].data[0].value=exit_per;
   					qrcdFluxPerOption.series[1].data[1].value=(100-exit_per).toFixed(2);
   					
   					sysdateChart = echarts.init(document.getElementById('qrcdFluxPerId')); 
    				sysdateChart.setOption(qrcdFluxPerOption,true);
   					
   					
    			}
    		});
    	}
    	
    	//加载“线路客流和收益”数据
    	function loadQrcdLineFluxInc(){
    		var start_day=$("#start_day").val();
    		doPost("qrcd/get_qrcdlineflux.action", {"sel_flag":"line_new","start_day":start_day}, function(data){
    			if(data){
    				lineFluxOption.xAxis[0].data=[];
    				lineFluxOption.series[0].data=[];
    				lineFluxOption.series[1].data=[];
    				$.each(data,function(i,v){
		    			lineFluxOption.xAxis[0].data.push(v.LINE_ID);
		    			lineFluxOption.series[0].data.push(v.ENTER_TIMES);
		    			lineFluxOption.series[1].data.push(v.EXIT_TIMES);
		    		});
    				lineFluxChart = echarts.init(document.getElementById('lineFluxId')); 
    				lineFluxChart.setOption(lineFluxOption,true);
    				
    				lineFluxChart.on('click', function (pm) {
    					line_id=pm.name.toString().trim();
    					$("#enterFluxCpDialog").hide();
    					$("#stationDialog").show();
    					loadQrcdStationFlux(line_id);
					});
    			}
    		});
    	}
    	
    	var line_id;
    	//加载“线路分时客流”、“线路下车站客流”数据
    	function loadQrcdStationFlux(lineId){
    		var start_day=$("#start_day").val();
    		$("#stationTitle").html((lineId*1)+"号线客流");
    		//加载“线路分时客流”
    		doPost("qrcd/get_qrcdlineflux.action", {"sel_flag":"period_new","line_id":lineId,"start_day":start_day}, function(data){
    			if(data){
    				linePeriodFluxOption.xAxis[0].data=[];
    				linePeriodFluxOption.series[0].data=[];
    				linePeriodFluxOption.series[1].data=[];
    				$.each(data,function(i,v){
    					if(v.PERIOD.toString().indexOf("30")>-1){
							linePeriodFluxOption.xAxis[0].data.push({
			    				value:v.PERIOD,            
						        textStyle:{fontSize:0,fontWeight:0,color:'rgba(32,32,35,0)'}
			    			});
						}else{
							linePeriodFluxOption.xAxis[0].data.push(v.PERIOD);
						}
		    			linePeriodFluxOption.series[0].data.push(v.ENTER_TIMES);
		    			linePeriodFluxOption.series[1].data.push(v.EXIT_TIMES);
		    		});
    				linePeriodFluxChart = echarts.init(document.getElementById('linePeriodFluxId')); 
    				linePeriodFluxChart.setOption(linePeriodFluxOption,true);
    				
    				linePeriodFluxChart.on('click', function (pm) {
    					$("#stationDialog").hide();
					});
    			}
    		});
    		
    		//加载“线路的车站客流”
    		doPost("qrcd/get_qrcdlineflux.action", {"sel_flag":"station_new","line_id":lineId,"start_day":start_day}, function(data){
    			if(data){
    				stationFluxOption.xAxis[0].data=[];
    				stationFluxOption.series[0].data=[];
    				stationFluxOption.series[1].data=[];
    				$.each(data,function(i,v){
		    			stationFluxOption.xAxis[0].data.push(v.STATION_NM);
		    			stationFluxOption.series[0].data.push(v.ENTER_TIMES);
		    			stationFluxOption.series[1].data.push(v.EXIT_TIMES);
		    		});
    				stationFluxChart = echarts.init(document.getElementById('stationFluxId')); 
    				stationFluxChart.setOption(stationFluxOption,true);
    				
    				stationFluxChart.on('click', function (pm) {
    					$("#stationDialog").hide();
					});
    			}
    		});
    	}	
    	
    	//加载“二维码分时客流”数据
    	function loadQrcdAllLineFlux(){
    		$("#enterFluxCpDialog").show();
    		$("#stationDialog").hide();
    		var start_day=$("#start_day").val();
    		doPost("qrcd/get_qrcdalllineflux.action", {"sel_flag":"period_new","start_day":start_day}, function(data){
    			if(data){
    				allLinePeriodFluxOption.xAxis[0].data=[];
    				allLinePeriodFluxOption.series[0].data=[];
    				allLinePeriodFluxOption.series[1].data=[];
    				$.each(data,function(i,v){
    					if(v.PERIOD.toString().indexOf("30")>-1){
							allLinePeriodFluxOption.xAxis[0].data.push({
			    				value:v.PERIOD,            
						        textStyle:{fontSize:0,fontWeight:0,color:'rgba(32,32,35,0)'}
			    			});
						}else{
							allLinePeriodFluxOption.xAxis[0].data.push(v.PERIOD);
						}
		    			allLinePeriodFluxOption.series[0].data.push(v.ENTER_TIMES);
		    			allLinePeriodFluxOption.series[1].data.push(v.EXIT_TIMES);
		    		});
    				allLinePeriodFluxChart = echarts.init(document.getElementById('allLinePeriodFluxId')); 
    				allLinePeriodFluxChart.setOption(allLinePeriodFluxOption,true);
    				
    				allLinePeriodFluxChart.on('click', function (pm) {
    					$("#enterFluxCpDialog").hide();
					});
    			}
    		});
    	}
    	
    	//加载“进站分时对比”数据
    	var periodCpFluxData;
    	function loadQrcdPeriodCpFlux(){
    		var start_day=$("#start_day").val();
    		var compare_day=$("#compare_day").val();
    		var seg=$("#seg").val();
    		var cp_flag=$("#cp_flag").val();
    		doPost("qrcd/get_qrcdperiodcp.action", {"sel_flag":"period_cp_new","start_day":start_day,"compare_day":compare_day,"seg":seg}, function(data){
    			if(data){
    				periodCpFluxData=data;
    				qrcdPeriodFluxCpOption.legend.data=[start_day,compare_day];
    				qrcdPeriodFluxCpOption.xAxis[0].data=[];
    				qrcdPeriodFluxCpOption.series[0].data=[];
    				qrcdPeriodFluxCpOption.series[1].data=[];
    				$.each(data,function(i,v){
    					if(v.PERIOD.toString().indexOf("30")>-1){
							qrcdPeriodFluxCpOption.xAxis[0].data.push({
			    				value:v.PERIOD,            
						        textStyle:{fontSize:0,fontWeight:0,color:'rgba(32,32,35,0)'}
			    			});
						}else{
							qrcdPeriodFluxCpOption.xAxis[0].data.push(v.PERIOD);
						}
    					if(cp_flag=="lj"){
    						qrcdPeriodFluxCpOption.series[0].data.push(v.TOTAL_TIMES);
		    				qrcdPeriodFluxCpOption.series[1].data.push(v.CP_TOTAL_TIMES);
    					}else{
    						qrcdPeriodFluxCpOption.series[0].data.push(v.ENTER_TIMES);
		    				qrcdPeriodFluxCpOption.series[1].data.push(v.CP_ENTER_TIMES);
    					}
		    		});
    				qrcdPeriodFluxCpOption.series[0].name=start_day;
    				qrcdPeriodFluxCpOption.series[1].name=compare_day;
    				qrcdPeriodFluxCpChart = echarts.init(document.getElementById('enterFluxCpId')); 
    				qrcdPeriodFluxCpChart.setOption(qrcdPeriodFluxCpOption,true);
    			}
    		});
    	}
    	
    	
    	//加载“车站排名”数据
    	function loadQrcdStationRank(){
    		var flux_flags=$("input[name='flux_flag']");
    		var flux_flag="";
    		$.each(flux_flags,function(i,v){
    			if($(v).val()){flux_flag+=$(v).val();}
    		});
    		var start_day=$("#start_day").val();
    		doPost("qrcd/get_qrcdlineflux.action", {"sel_flag":"rank_new","flux_flag":flux_flag,"start_day":start_day}, function(data){
    			if(data){
    				stationRankOption.yAxis[0].data=[];
    				stationRankOption.series[0].data=[];
    				for (var i=9;i>=0;i--){
						stationRankOption.yAxis[0].data.push(data[i].STATION_NM);
			    		stationRankOption.series[0].data.push(data[i].TIMES);
					}
			    	stationRankChart = echarts.init(document.getElementById('stationRankId')); 
			    	stationRankChart.setOption(stationRankOption,true);
    			}
    		});
    	}
    	
    	//“车站排名”中图片点击切换
    	function chgImg(obj,v){
    		if($(obj).attr("src")=="resource/images/pressed.png"){
   				$(obj).attr("src","resource/images/unselect.png"); 
   				$("#flux_flag"+v).val("");
   			}else{
   				$(obj).attr("src","resource/images/pressed.png"); 
   				$("#flux_flag"+v).val(v);
   			}
    	}
    	
    	
    	function change(obj,pm){
    		$("#cp_flag").val(pm);
	  		$(obj).siblings().removeClass("act");
	  		$(obj).addClass("act");
	  		if(periodCpFluxData){
	  			qrcdPeriodFluxCpOption.series[0].data=[];
	  			qrcdPeriodFluxCpOption.series[1].data=[];
	  			$.each(periodCpFluxData,function(i,v){
	  				if(pm=="lj"){
	 					qrcdPeriodFluxCpOption.series[0].data.push(v.TOTAL_TIMES);
	   					qrcdPeriodFluxCpOption.series[1].data.push(v.CP_TOTAL_TIMES);
	 				}else{
	 					qrcdPeriodFluxCpOption.series[0].data.push(v.ENTER_TIMES);
	   					qrcdPeriodFluxCpOption.series[1].data.push(v.CP_ENTER_TIMES);
	 				}
	  			});
	  			qrcdPeriodFluxCpChart = echarts.init(document.getElementById('enterFluxCpId')); 
   				qrcdPeriodFluxCpChart.setOption(qrcdPeriodFluxCpOption,true);
   				
   				qrcdPeriodFluxCpChart.on('click', function (pm) {
   					$("#enterFluxCpDialog").hide();
				});
	  		}
	  		
	  	}
    	
    	//页面定时刷新
    	setInterval("totalDeal()",60000);
    	function totalDeal(){
    		//加载“二维码总览”数据
    		loadQrcdFluxIncome();
    		//加载“二维码进站分时累计比较”
    		loadQrcdPeriodCpFlux();
    		//加载“线路客流和收益”数据
    		loadQrcdLineFluxInc();
    		//加载“车站排名”数据
    		loadQrcdStationRank();
    		
    		$(".prm").hide();
			$(".btn")[0].value=">>";
    	}
    	$(function(){
    		//页面加载所有数据
    		totalDeal();
    		
    		//显示或隐藏查询条件
			$(".btn").click(function(){
				if(this.value==">>"){
					$("#dayPmId").show();
					$(".prm").show();
					this.value="<<";
				}else if(this.value=="<<"){
					$("#dayPmId").hide();
					$(".prm").hide();
					this.value=">>";
				}
			});
    	});
    	
	</script>
</body>
</html>