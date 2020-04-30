<%@ page language="java" import="java.util.*,java.lang.*,com.util.*,net.sf.json.*,java.text.*" pageEncoding="UTF-8"%>
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
		  margin: 0;
		  padding: 0;
		  border: 0;
		  width:1595px;
		  height:875px;
		  font-family:'Microsoft YaHei' ! important;
		  background-color: #0B112F;
		  color:white;
		}
		#stationDialog,#allLineDialog,#enterFluxCpDialog{
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
		.enter a:link {color:#FFF !important;text-decoration:none}
		.enter a:visited {color:#FFF !important;text-decoration:none}
		.enter a:hover {color:#FFF !important;text-decoration:none}
		.enter a:active {color:#FFF !important;text-decoration:none}
		
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
		  margin-left: 10px;
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
		
		String start_date = fmt.format(cal.getTime());//当前日期
		cal.add(Calendar.DATE, -7);
		
		String compare_date = fmt.format(cal.getTime());//环比日期
	%>
	<div style="height:100%;width:100%;background:url('resource/images/bgnew.png') no-repeat;background-size:cover;margin: 0;padding: 0;">
		<div style="height:50%;width:100%">
			<div style="float:left;height:100%;width:50%">
				<div style="position:absolute;left:90px;top:90px;">
					<input type="button" value=">>" class="btn" style="float: left;margin:3px 0px 0px 5px;">
					<div id="dayPmId">
						运营日期:<input type="text" name="start_day" id="start_day" value="<%=start_date %>" style="width:80px;">
						<input type="button" value="查询" onclick="totalDeal()" class="searchbtn">
					</div>
				</div>
				<table style="position:absolute;left:70px;top:110px;text-align:center" id="qrcdTotalId">
					<tr style="font-weight:bold;font-size:16pt;color:white;" height="50">
						<td width="120">&nbsp;</td>
						<td width="104" class="enter"><a href="javascript:loadQrcdPeriodCpFlux()">进站</a></td>
						<td width="104">出站</td>
						<td width="102">更新</td>
						<td width="100">合计</td>
						<td width="100">其他</td>
						<td width="104">交易金额</td>
					</tr>
					<tr style="font-weight:bold;font-size:14pt;color:#FFFF00;" height="60">
						<td style="padding-left:20px;text-align:left;"><a href="javascript:loadQrcdAllLineFlux()">二&nbsp;维&nbsp;码</a></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td style="font-size:14pt;color:#FFFF00;"></td>
					</tr>
					<tr style="font-weight:bold;font-size:12pt;color:white;" height="60">
						<td>支付宝</td>
						<td></td>
						<td></td>
						<td></td>
						<td style="font-size:13pt;"></td>
						<td></td>
						<td style="font-size:14pt;color:#FFFF00;"></td>
					</tr>
					<tr style="font-weight:bold;font-size:12pt;color:white;" height="60">
						<td>银&nbsp;&nbsp;联</td>
						<td></td>
						<td></td>
						<td></td>
						<td style="font-size:13pt;"></td>
						<td></td>
						<td style="font-size:14pt;color:#FFFF00;"></td>
					</tr>
					<tr style="font-weight:bold;font-size:12pt;color:white;" height="60">
						<td>&nbsp;微&nbsp;信</td>
						<td></td>
						<td></td>
						<td></td>
						<td style="font-size:13pt;"></td>
						<td></td>
						<td style="font-size:14pt;color:#FFFF00;"></td>
					</tr>
				</table>
			</div>
			<div style="float:right;height:100%;width:50%">
				<div id="sysdataId" style="height:100%;width:55%;float:left"></div>
				<div style="height:100%;width:45%;float:right;font-size:13pt;color:white;">
					<table id="qrcdFluxPerId"  style="margin:120px 20% 0px 0px;text-align:center;width:80%;height:240px;border-collapse:collapse;">
						<tr style="font-weight:bold;font-size:16pt;color:white;">
							<td>&nbsp;</td>
							<td>进站</td>
							<td>出站</td>
<%--							<td style="font-size:12pt;">合计</td>--%>
						</tr>
						<tr style="border-top:1px dashed #3980E9;font-weight:bold;">
							<td>全路网</td>
							<td></td>
							<td></td>
<%--							<td style="font-size:12pt;"></td>--%>
						</tr>
						<tr style="border-top:1px dashed #3980E9;">
							<td style="font-weight:bold;">二维码</td>
							<td></td>
							<td></td>
<%--							<td style="font-size:12pt;"></td>--%>
						</tr>
						<tr style="font-size:14pt;color:#FFFF00;border-top:1px dashed #3980E9;font-weight:bold;">
							<td>占比</td>
							<td></td>
							<td></td>
<%--							<td></td>--%>
						</tr>
					</table>
				</div>
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
	
	<div id="allLineDialog">
		<div id="allLineTitle" style="height:8%;width:100%;color:white;font-weight:bold;font-size:24px;text-align:center;vertical-align:middle;padding-top:5px;" >
			全路网二维码客流
		</div>
		<div id="allLinePeriodFluxId" style="height:88%;width:100%"></div>
	</div>
	
	<div id="enterFluxCpDialog">
		<div id="enterFluxCpTitle" style="height:8%;width:100%;color:white;font-weight:bold;font-size:24px;text-align:center;vertical-align:middle;padding-top:5px;" >
			进站客流分时对比
		</div>
		<div style="height:5%;width:100%;font-size:14px">
			<div class="tab">
		   		<span onclick="change(this,'fs')">分时</span>
			   	<span class="act" onclick="change(this,'lj')" style="margin-left:0px;">累计</span>
			   	<input type="hidden" id="cp_flag" value="lj">
		    </div>
		    <input type="button" value=">>" class="btn" style="float: left;margin:3px 0px 0px 5px;">
		    <div class="prm">
		    	 运营日期:<input type="text" name="start_date" id="start_date" value="<%=start_date %>" style="width:70px;">
				 对比日期:<input type="text" name="compare_date" id="compare_date" value="<%=compare_date %>" style="width:70px;">
				 时长:<select name="seg" id="seg">
					 	<option value="30" selected="selected">30分钟</option>
					 	<option value="60">60分钟</option>
					 </select>
				 <input type="button" value="查询" onclick="loadQrcdPeriodCpFlux()" class="searchbtn">
		    </div>
		</div>
		<div id="enterFluxCpId" style="height:87%;width:100%"></div>
	</div>
	
	<script type="text/javascript">
		
		sysdataOption = {
			title:{
				text:"",
				x:85,
				y:80,
				textStyle:{color:'white',fontSize:18,fontWeight:'bold',fontFamily:'Microsoft YaHei'}
			},
		    legend:{
		        orient : 'vertical',
		        x:'20%',
		        y:'78%',
		        textStyle:{color:'white',fontSize:14,fontWeight:'bold',fontFamily:'Microsoft YaHei'},
		        itemGap:12,
		        data:['收到交易总数--','已处理交易数--','未处理交易数--']
		    },
		    series : [
		        {
		            name:'1',
		            type:'pie',
		            center:['65%','54%'],
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
		                    name:'收到交易总数--'
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
		            center:['65%','54%'],
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
		                    name:'已处理交易数--'
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
		            center:['65%','54%'],
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
		                    name:'未处理交易数--'
		                },
		                {
		                    value:0,
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
				x:140,x2:65,y:90,y2:80
			},
		    legend: {
				y:50,
				x:300,
				textStyle:{color:'white',fontSize:14,fontWeight:'bold',fontFamily:'Microsoft YaHei'},
		        data:['进站','出站','营收']
		    },
		    tooltip:{
		    	formatter:function(pm){
		    		var tp=(lineFluxOption.xAxis[0].data[pm.dataIndex]*1)+"号线<br/>进站客流："+lineFluxOption.series[0].data[pm.dataIndex]+
		    			"<br/>出站客流："+lineFluxOption.series[1].data[pm.dataIndex]+
		    			"<br/>线路营收："+lineFluxOption.series[2].data[pm.dataIndex]+"元";
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
		        },
				{
		        	name:'营收/元',
		        	nameTextStyle:{color:'white'},
		            type : 'value',
		            axisLabel:{
		        		formatter:'{value}',
		        		textStyle:{color:'white',fontSize:14,fontWeight:'bold',fontFamily:'Microsoft YaHei'}
		        	},
					splitNumber:5,
					splitLine:{show:false,lineStyle:{type:'dashed',color:'#3980E9'}},
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
		        },
		        {
		            name:'营收',
		            type:'line',
		            smooth:true,
		            yAxisIndex: 1,
		            itemStyle:{normal: {color:'#ff7f50',label : {show: false}}},
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
		    		tp=tp+"<br/>"+qrcdPeriodFluxCpOption.legend.data[0]+"："+qrcdPeriodFluxCpOption.series[0].data[pm.dataIndex]+
		    			"<br/>"+qrcdPeriodFluxCpOption.legend.data[1]+"："+qrcdPeriodFluxCpOption.series[1].data[pm.dataIndex];
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
    		doPost("qrcd/get_qrcdfluxincome.action", {"sel_flag":"flux","start_day":start_day}, function(data){
    			if(data){
    				var trs=$("#qrcdTotalId").find("tr");
    				$.each(data,function(i,v){
		    			var tds=$(trs[i+1]).find("td");
		    			$(tds[1]).html(v.ENTER_TIMES);
		    			$(tds[2]).html(v.EXIT_TIMES);
		    			$(tds[3]).html(v.UPDATE_TIMES);
		    			$(tds[4]).html(v.ENTER_TIMES+v.EXIT_TIMES+v.UPDATE_TIMES);
		    			$(tds[5]).html(v.OTHER_TIMES);
		    			$(tds[6]).html("￥"+v.INCOME_VALUE);
		    		});
    			}
    		});
    	}
    	
    	//加载“二维码与路网总客流”数据
    	function loadQrcdFluxPer(){
    		var start_day=$("#start_day").val();
    		doPost("qrcd/get_qrcdfluxincome.action", {"sel_flag":"qrcdper","start_day":start_day}, function(data){
    			if(data){
    				var trs=$("#qrcdFluxPerId").find("tr");
    				$.each(data,function(i,v){
		    			var tds=$(trs[i+1]).find("td");
		    			if(i==2){
		    				$(tds[1]).html(v.ENTER_TIMES+"%");
		    				$(tds[2]).html(v.EXIT_TIMES+"%");
		    			}else{
		    				$(tds[1]).html(v.ENTER_TIMES);
		    				$(tds[2]).html(v.EXIT_TIMES);
		    			}
		    			//$(tds[3]).html(v.TOTALS+"%");
		    		});
    			}
    		});
    	}
    	
    	//加载“二维码交易”数据
    	function loadQrcdTrans(){
    		var start_day=$("#start_day").val().toString();
    		doPost("qrcd/get_qrcdfluxincome.action", {"sel_flag":"jy","start_day":start_day}, function(data){
    			if(data){
    				var start_day_tp=start_day.substr(0,4)+"/"+start_day.substr(4,2)+"/"+start_day.substr(6,2);
    				$.each(data,function(i,v){
    					sysdataOption.title.text=v.CURHOUR;
    					if(start_day_tp!=v.CURHOUR.substr(0,10)){
    						sysdataOption.title.text=start_day_tp+" 23:59";
    					}
    					var nm1='收到交易总数：'+v.TOTALS,nm2='已处理交易数：'+v.DEALNUM,nm3='未处理交易数：'+v.UNDEALS;
    					sysdataOption.legend.data=[nm1,nm2,nm3];
    					sysdataOption.series[0].data[0].name=nm1;
    					sysdataOption.series[0].data[0].value=(v.TOTALS/24000).toFixed(3);
    					sysdataOption.series[0].data[1].value=(100-v.TOTALS/24000).toFixed(3);
    					
    					sysdataOption.series[1].data[0].name=nm2;
    					sysdataOption.series[1].data[0].value=(v.DEALNUM/24000).toFixed(3);
    					sysdataOption.series[1].data[1].value=(100-v.DEALNUM/24000).toFixed(3);
    					
    					sysdataOption.series[2].data[0].name=nm3;
    					sysdataOption.series[2].data[0].value=(v.UNDEALS/24000).toFixed(3);
    					sysdataOption.series[2].data[1].value=(100-v.UNDEALS/24000).toFixed(3);
		    		});
    				sysdateChart = echarts.init(document.getElementById('sysdataId')); 
    				sysdateChart.setOption(sysdataOption,true);
    			}
    		});
    	}
		
    	//加载“线路客流和收益”数据
    	function loadQrcdLineFluxInc(){
    		var start_day=$("#start_day").val();
    		doPost("qrcd/get_qrcdlineflux.action", {"sel_flag":"line","start_day":start_day}, function(data){
    			if(data){
    				lineFluxOption.xAxis[0].data=[];
    				lineFluxOption.series[0].data=[];
    				lineFluxOption.series[1].data=[];
    				lineFluxOption.series[2].data=[];
    				$.each(data,function(i,v){
		    			lineFluxOption.xAxis[0].data.push(v.LINE_ID);
		    			lineFluxOption.series[0].data.push(v.ENTER_TIMES);
		    			lineFluxOption.series[1].data.push(v.EXIT_TIMES);
		    			lineFluxOption.series[2].data.push(v.INCOME_VALUE);
		    		});
    				lineFluxChart = echarts.init(document.getElementById('lineFluxId')); 
    				lineFluxChart.setOption(lineFluxOption,true);
    				
    				lineFluxChart.on('click', function (pm) {
    					line_id=pm.name.toString().trim();
    					$("#allLineDialog").hide();
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
    		doPost("qrcd/get_qrcdlineflux.action", {"sel_flag":"period","line_id":lineId,"start_day":start_day}, function(data){
    			if(data){
    				linePeriodFluxOption.xAxis[0].data=[];
    				linePeriodFluxOption.series[0].data=[];
    				linePeriodFluxOption.series[1].data=[];
    				$.each(data,function(i,v){
		    			linePeriodFluxOption.xAxis[0].data.push(v.PERIOD);
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
    		
    		//加载“线路下车站客流”
    		doPost("qrcd/get_qrcdlineflux.action", {"sel_flag":"station","line_id":lineId,"start_day":start_day}, function(data){
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
    	
    	//加载“全路网分时客流”数据
    	function loadQrcdAllLineFlux(){
    		$("#stationDialog").hide();
    		$("#enterFluxCpDialog").hide();
    		$("#allLineDialog").show();
    		var start_day=$("#start_day").val();
    		doPost("qrcd/get_qrcdalllineflux.action", {"sel_flag":"period","start_day":start_day}, function(data){
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
    				linePeriodFluxChart = echarts.init(document.getElementById('allLinePeriodFluxId')); 
    				linePeriodFluxChart.setOption(linePeriodFluxOption,true);
    				
    				linePeriodFluxChart.on('click', function (pm) {
    					$("#allLineDialog").hide();
					});
    			}
    		});
    	}
    	
    	//加载“进站分时对比”数据
    	var periodCpFluxData;
    	function loadQrcdPeriodCpFlux(){
    		$("#stationDialog").hide();
    		$("#allLineDialog").hide();
    		$("#enterFluxCpDialog").show();
    		var start_date=$("#start_date").val();
    		var compare_date=$("#compare_date").val();
    		var seg=$("#seg").val();
    		var cp_flag=$("#cp_flag").val();
    		doPost("qrcd/get_qrcdperiodcp.action", {"sel_flag":"period_cp","start_day":start_date,"compare_day":compare_date,"seg":seg}, function(data){
    			if(data){
    				periodCpFluxData=data;
    				qrcdPeriodFluxCpOption.legend.data=[start_date,compare_date];
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
    				qrcdPeriodFluxCpOption.series[0].name=start_date;
    				qrcdPeriodFluxCpOption.series[1].name=compare_date;
    				qrcdPeriodFluxCpChart = echarts.init(document.getElementById('enterFluxCpId')); 
    				qrcdPeriodFluxCpChart.setOption(qrcdPeriodFluxCpOption,true);
    				
    				qrcdPeriodFluxCpChart.on('click', function (pm) {
    					$("#enterFluxCpDialog").hide();
					});
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
    		doPost("qrcd/get_qrcdlineflux.action", {"sel_flag":"rank","flux_flag":flux_flag,"start_day":start_day}, function(data){
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
    		//加载“二维码交易”数据
    		loadQrcdTrans();
    		//加载“二维码与路网总客流”数据
    		loadQrcdFluxPer();
    		//加载“线路客流和收益”数据
    		loadQrcdLineFluxInc();
    		//加载“车站排名”数据
    		loadQrcdStationRank();
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