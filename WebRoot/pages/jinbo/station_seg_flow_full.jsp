<%@ page language="java" import="java.util.*,java.lang.*,com.util.*,net.sf.json.*,java.text.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html>
<head>
<title>dashboard</title>
<base href="<%=basePath%>">
<%--	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">--%>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
<link rel="stylesheet" href="resource/element-ui/index.css" />
<script src="resource/jquery/js/jquery-1.7.2.js" type="text/javascript"></script>
<script src="resource/vue/vue.min.js"></script>
<script src="resource/element-ui/index.js"></script>
<script src="resource/inesa/js/common.js"></script>
<script src="resource/echarts3/echarts.min.js"></script>
<script src="resource/echarts3/d3.v4.min.js"></script>
<script src="resource/echarts3/highchartse.js"></script>
<!-- <script src="http://code.highcharts.com/highcharts.js"></script> -->
<style type="text/css">
.mainApp {
	position: absolute;
	height: 100%;
	width: 100%;
	color: #fff;
	overflow: hidden;
}

html,body,div,span,applet,object,iframe,h1,h2,h3,h4,h5,h6,p,blockquote,pre,a,abbr,acronym,address,big,cite,code,del,dfn,em,img,ins,kbd,q,s,samp,small,strike,strong,sub,sup,tt,var,b,u,i,center,dl,dt,dd,ol,ul,li,fieldset,form,label,legend,table,caption,tbody,tfoot,thead,article,aside,canvas,details,embed,figure,figcaption,footer,header,menu,nav,output,ruby,section,summary,time,mark,audio,video,input
	{
	margin: 0;
	padding: 0;
	border: 0;
	font-weight: normal;
	vertical-align: baseline;
}

table,th,tr,td {
	border-color: rgb(108, 167, 151);
	font-size: 20px;
}

div {
	display: block;
}

*[data-v-0b39df2e] {
	box-sizing: border-box;
}

.point[data-v-0b39df2e],.multipleColumn[data-v-0b39df2e],.columnChart[data-v-0b39df2e],.line[data-v-0b39df2e]
	{
	height: 100% !important;
	width: 100% !important;
	background: none !important;
}

.item[data-v-0b39df2e] {
	padding: 0px;
	margin: 0px;
	width: 62%;
	height: 100%;
	position: absolute;
	transform: scale(0.33);
	transition: all 0.8s;
}

#my {
	width: 100%;
	height: 100%;
	background-image: url("resource/images/ncbg.png");
	background-size: 100% 100%;
	position: absolute;
}

.dashboard[data-v-0b39df2e] {
	position: relative;
	width: 100%;
	height: 100%;
	margin: 0px;
	padding: 0px;
	padding: 2% 0;
	background-image: url("resource/images/ncbg.png");
	background-size: 100% 100%;
	background-repeat: no-repeat;
}

.flex-container.column[data-v-0b39df2e] {
	position: relative;
	height: 100%;
	width: 100%;
	overflow: hidden;
	margin: 0 auto;
	z-index: 10;
	box-sizing: content-box;
}

.active[data-v-0b39df2e] {
	height: 100%;
	width: 84%;
	line-height: 300px;
}

.filter {
	top: 0px;
	position: relative;
	width: 1500px;
	margin-left: -1%;
	position: relative;
	display: -ms-flexbox;
	display: flex;
	padding-left: 5px;
	line-height: 11px;
	color: #fff;
	z-index: 2;
	font-family: 'Open Sans';
	font-size: 13px;
}

.main {
	width: 100%;
	height: calc(100% - 30px);
}

.srank {
	margin-bottom: 12px;
	width: 470px;
	height: 260px;
}

.sranks {
	margin-left: 4%;
	margin-top: 15%;
	margin-bottom: 20px;
	width: 1600px;
	height: 700px;
}

.filters {
	top: 0px;
	margin-left: -3%;
	position: relative;
	display: -ms-flexbox;
	display: flex;
	padding-left: 5px;
	line-height: 11px;
	color: #fff;
	z-index: 2;
	font-family: 'Open Sans';
	font-size: 13px;
}

.btns {
	color: #fff;
	margin-left: 95px;
	width: 60px;
	height: 42px;
	text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25);
	background-color: #1134A8;
	text-align: center;
	border-radius: 4px;
	padding: 2px 10px;
	margin-bottom: 0;
	font-size: 14px;
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

.btn,.searchbtn {
	margin-left: 95px;
	width: 60px;
	height: 42px;
	color: #fff;
	text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25);
	background-color: #1134A8;
	text-align: center;
	border-radius: 8px;
	padding: 2px 15px;
	margin-bottom: 0;
	font-size: 15px;
}

.prm {
	width: 100%;
	font-size: 15px;
	vertical-align: bottom;
	margin-left: 15px;
	display: none;
	float: left;
}

.prm input,.prm select {
	border: 1px solid #2f96b4;
	font-size: 15px;
}

.tab {
	float: right;
	margin-left: 10px;
	height: 45px;
	width: 450px;
	background-image: url(resource/images/swchbg.png);
	color: #fff;
	background-size: 80% 90%;
	background-repeat: no-repeat;
	color: #fff;
}

.tabs {
	float: right;
	margin-left: 10px;
	height: 45px;
	width: 1500px;
	margin-left: 45px;
	color: #fff;
	background-size: 80% 90%;
	background-repeat: no-repeat;
	color: #fff;
}

.tab span {
	margin: 3px 30px 3px 30px;
	height: 35px;
	width: 60px;
	float: left;
	font-size: 15px;
	display: block;
	text-align: center;
	line-height: 36px;
	border-radius: 8px;
	background-color: #1134A8;
}

.tab .act {
	background: #3887FF;
}

div.tip-hill-div {
	position: relative;
	z-index: 999;
	opacity: 0.8;
	background: black;
	color: #fff;
	padding: 10px;
	border-radius: 5px;
	font-family: Microsoft Yahei;
}

div.tip-hill-div>h1 {
	padding-left: 7px;
	font-size: 15px;
}

div.tip-hill-div>h2 {
	padding-left: 7px;
	font-size: 16px;
}

.sranka {
	margin-left: 5%;
	margin-top: 15%;
	margin-bottom: 12px;
	width: 100%;
	height: calc(100% - 250px);
}
/*定义滚动条高宽及背景 高宽分别对应横竖滚动条的尺寸*/
::-webkit-scrollbar {
	width: 7px;
	height: 16px;
	background-color: rgba(29, 144, 230, 0);
}

/*定义滚动条轨道 内阴影+圆角*/
::-webkit-scrollbar-track {
	-webkit-box-shadow: inset 0 0 6px rgba(255, 255, 255, 0.1);
	border-radius: 10px;
	background-color: rgba(255, 255, 255, 0.1);
}

/*定义滑块 内阴影+圆角*/
::-webkit-scrollbar-thumb {
	border-radius: 10px;
	-webkit-box-shadow: inset 0 0 6px rgba(255, 255, 255, 0.1);
	background-color: rgba(0, 140, 111, 1);
}

.el-carousel__item h3 {
	color: #475669;
	font-size: 14px;
	opacity: 0.75;
	line-height: 150px;
	margin: 0;
}

.el-carousel__item:nth-child(2n) {
}

.el-carousel__item:nth-child(2n+1) {
}
.textCls1{
	height:60px;
	width:400px;
	font-size:22px;
	font-weight:bold;
	color:#FFF;
	float: left;
}

.textCls2{
	height:60px;
	width:780px;
	font-size:22px;
	font-weight:bold;
	text-align: right;
	color:#FFF;
	float: right;
}

.textCls1 span,.textCls2 span{
	font-size:32px;
	font-weight:bold;
	color:#FFFF00;
}
</style>
</head>
<%
Calendar cal = Calendar.getInstance();
SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
String startTime = fmt.format(cal.getTime());
cal.add(Calendar.DATE, -7);
String hb_time = fmt.format(cal.getTime());
%>
<body>
	<div id="segFlow" style="margin-left: 15px;">
		<el-row> <template>
		<div class="block">
			<el-carousel height="600px" width="100%" v-for="" @change="stationChange" autoplay="false" interval="120000"> 
				<el-carousel-item>
					<div>
						<div class="textCls1">
							截止当前客流<span>{{totalTimesSum}}</span>人次
						</div>
						<div class="textCls2">
							去年同期客流<span>{{vtData.XJD_EN_TIMES_CP+vtData.XJD_EX_TIMES_CP}}</span>人次&nbsp;&nbsp;&nbsp;&nbsp;
							预测今日客流<span>{{vtData.XJD_EN_TIMES+vtData.XJD_EX_TIMES}}</span>人次
						</div>
					</div>
					<div id="st1" style="height: 530px;width:1200px;"></div>
				</el-carousel-item>
				<el-carousel-item>
					<div>
						<div class="textCls1">
							截止当前客流<span>{{totalTimesSum}}</span>人次
						</div>
						<div class="textCls2">
							去年同期客流<span>{{vtData.ZGL_EN_TIMES_CP+vtData.ZGL_EX_TIMES_CP}}</span>人次&nbsp;&nbsp;&nbsp;&nbsp;
							预测今日客流<span>{{vtData.ZGL_EN_TIMES+vtData.ZGL_EX_TIMES}}</span>人次
						</div>
					</div>
					<div id="st2" style="height: 530px;width:1200px;"></div>
				</el-carousel-item> 
				<el-carousel-item>
					<div>
						<div class="textCls1">
							截止当前客流<span>{{totalTimesSum}}</span>人次
						</div>
						<div class="textCls2">
							去年同期客流<span>{{vtData.HQ_EN_TIMES_CP+vtData.HQ_EX_TIMES_CP}}</span>人次&nbsp;&nbsp;&nbsp;&nbsp;
							预测今日客流<span>{{vtData.HQ_EN_TIMES+vtData.HQ_EX_TIMES}}</span>人次
						</div>
					</div>
					<div id="st3" style="height: 530px;width:1200px;"></div>
				</el-carousel-item> 
				<el-carousel-item>
					<div>
						<div class="textCls1">
							截止当前客流<span>{{totalTimesSum}}</span>人次
						</div>
						<div class="textCls2">
							去年同期客流<span>{{vtData.XJD_EN_TIMES_CP+vtData.ZGL_EN_TIMES_CP+vtData.HQ_EN_TIMES_CP+vtData.XJD_EX_TIMES_CP+vtData.ZGL_EX_TIMES_CP+vtData.HQ_EX_TIMES_CP}}</span>人次&nbsp;&nbsp;&nbsp;&nbsp;
							预测今日客流<span>{{vtData.XJD_EN_TIMES+vtData.ZGL_EN_TIMES+vtData.HQ_EN_TIMES+vtData.XJD_EX_TIMES+vtData.ZGL_EX_TIMES+vtData.HQ_EX_TIMES}}</span>人次
						</div>
					</div>
					<div id="st4" style="height: 530px;width:1200px;"></div>
				</el-carousel-item> 
				<el-carousel-item>
				<div id="st5" style="height: 600px;width:auto;">
				<h2 style="text-align:center;color: white;margin-bottom: 20px;" >关注车站客流</h2>
				<div class="mainApp" id="cocc" style="height:500px;text-align:center">
				<div data-v-c5b8f8b4 data-v-0b39df2e class="point" id="zf"  style="height: 500px;width:auto;overflow-y:scroll;">
					<table id="coccTb" data-sort="sortDisabled" align="center" border="0" cellspacing="1" cellpadding="0" style="word-break:break-all;margin:auto;" hidden>
				<tbody>
					<tr class="firstRow">
						<td valign="middle" rowspan="2" colspan="1" align="right" style="word-break: break-all; border-width: 1px; border-style: solid;" width="104"></td>
						<td rowspan="1" valign="middle" align="center" width="136" style="word-break: break-all; border-width: 1px; border-style: solid;"><span style="text-align: -webkit-right;">车站</span></td>
						<td v-for="station in stationLst" valign="middle" rowspan="1" colspan="2" style="word-break: break-all; border-width: 1px; border-style: solid;" align="center">{{station}}<br />
						</td>
					</tr>
					<tr>
						<td rowspan="1" valign="top" align="null" width="104" style="border-width: 1px; border-style: solid;"></td>
						<template v-for="station in stationLst">
						<td valign="middle" colspan="1" rowspan="1" style="word-break: break-all; border-width: 1px; border-style: solid;" align="center">出</td>
						<td valign="middle" colspan="1" rowspan="1" style="word-break: break-all; border-width: 1px; border-style: solid;" align="center">进</td>
						</template>
					</tr>
				</tbody>
				<tbody v-for="times in timeSeg2">
					<tr>
						<td width="105" valign="middle" rowspan="2" colspan="1" style="word-break: break-all; border-width: 1px; border-style: solid;" align="center">{{times.startTime}}<br />
						</td>
						<td width="105" valign="middle" style="word-break: break-all; border-width: 1px; border-style: solid;" align="center">客流量</td>
						<template v-for="cc in chainCompare"> <template v-if="times.startTime == cc.startTime">
						<td width="105" valign="middle" align="center" style="border-width: 1px; border-style: solid;">{{cc.exitTimes}}</td>
						<td width="105" valign="middle" align="center" style="border-width: 1px; border-style: solid;">{{cc.enterTimes}}</td>
						</template> </template>
					</tr>
					<tr>
						<td width="105" valign="middle" style="word-break: break-all; border-width: 1px; border-style: solid;" align="center">增↑/减↓</td>
						<template v-for="cc in chainCompare"> <template v-if="times.startTime == cc.startTime">
						<td width="105" valign="middle" align="center" style="border-width: 1px; border-style: solid;"><span v-if="parseInt(cc.exitDvalue)>0"><span style="color: #c35656;"><b>{{cc.exitDvalue}}</b></span></span> <span v-else>{{cc.exitDvalue}}</span></td>
						<td width="105" valign="middle" align="center" style="border-width: 1px; border-style: solid;"><span v-if="parseInt(cc.enterDvalue)>0"><span style="color: #c35656;"><b>{{cc.enterDvalue}}</b></span></span> <span v-else>{{cc.enterDvalue}}</span></td>
						</template> </template>
					</tr>
				</tbody>
			</table>
			</div>
			</div>
				</div>
				</el-carousel-item>
			</el-carousel>
		</div>
		</template> </el-row>
	</div>
</body>
<script type="text/javascript">
	var vueSegFlow = new Vue({
		data : {
			stationName:"徐泾东",
			startTime:"<%=startTime%>",
			timeSeg:[],
			totalTimes:[],
			totalPkTimes:[],
			enterTimes:[],
			exitTimes:[],
			pkEnterTimes:[],
			pkExitTimes:[],
			timeSeg2 : [],
			asato:[],
			asatoData:[],
			stationLst:[],
			chainCompare:[],
			modelId:"103",
			subModelName:"关注车站",
			vtData:{},
			totalTimesSum:0
		},
		mounted: function () {
			this.getVisitpfw();
			this.initValTime();
	    },
		methods : {
			//查询设定的预测值和去年同期值
			initValTime:function(){
				vueThis=this;
				$.post("jinbo/updateParam.action",{"flag":"sel"},function(dt){
					vueThis.vtData=dt[0];
		    	});
			},
			stationChange : function(idx) {
				this.timeSeg=[];
				this.totalTimes=[];
				this.totalPkTimes=[];
				this.enterTimes=[];
				this.exitTimes=[];
				this.pkEnterTimes=[];
				this.pkExitTimes=[];
				var stationUrl = "station_seg_flow.action";
				if(idx==0){
					this.stationName='徐泾东';
					this.$options.methods.fetchDate("st1",stationUrl);
				}else if(idx==1){
					this.stationName='诸光路';
					this.$options.methods.fetchDate("st2",stationUrl);
				}else if(idx==2){
					this.stationName='虹桥火车站';
					this.$options.methods.fetchDate("st3",stationUrl);
				}else if(idx==3){
					this.stationName='总合';
					this.$options.methods.fetchDate("st4","total_station_seg_flow.action");
				}else{
					this.stationName='关注车站客流';
					this.$options.methods.getVisitpfw();
				}
			},
			initChart:function(st){
				var sta = echarts.init(document.getElementById(st));
				option = null;
				option = {
					tooltip : {
						trigger : 'axis',
						textStyle:{
							fontSize:20,
							fontWeight:'bold'
						},
						formatter:function(params){
							var res  = '<div>'+params[0].name+'</br></div>';
							res += '<div>峰值客流：'+params[0].value+'</br></div>';
							res += '<div>当天客流：'+params[1].value+'</div>';
							return res;
						}
					},
					legend: {
				        data:['进站客流','出站客流','总客流'],
				        selectedMode:'single',
				        textStyle:{
				        	fontSize: '18',
				        	fontWeight:'bold',
				        	color : '#fff'
				        },
				        backgroundColor :'#4996b4'
					},
					title : {
						text : vueSegFlow.stationName,
						textStyle : {
							color : '#fff',
							fontWeight : 'bolder',
							fontSize: '25'
						}
					},
					xAxis : {
						type : 'category',
						data : vueSegFlow.timeSeg,
						axisLine : {
							lineStyle : {
								color : '#fff'
							}
						},
						axisLabel:{
							fontSize:18,
							fontWeight:'bold',
							color : '#fff'
						}
					},
					yAxis : {
						type : 'value',
						axisLine : {
							lineStyle : {
								color : '#fff'
							}
						},
						splitLine : {
							show : false
						},
						axisLabel:{
							fontSize:18,
							fontWeight:'bold',
							color : '#fff'
						}
					},
					grid: {x:75,x2:40,y:50,y2:60},
					series : [ {
						name : '进站客流',
						data : vueSegFlow.pkEnterTimes,
						type : 'line',
						smooth : true,
						symbol : 'none',
						sampling : 'average',
						itemStyle : {  
                            normal : {  
                                color:'#D53A35',  //圈圈的颜色
                                lineStyle:{  
                                    color:'#D53A35'  //线的颜色
                                }  
                            }  
                        }
					},{
						name : '出站客流',
						data : vueSegFlow.pkExitTimes,
						type : 'line',
						smooth : true,
						symbol : 'none',
						sampling : 'average',
						itemStyle : {  
                            normal : {  
                                color:'#AADD6C',  //圈圈的颜色
                                lineStyle:{  
                                    color:'#AADD6C'  //线的颜色
                                }  
                            }  
                        }
					},{
						name : '总客流',
						data : vueSegFlow.totalPkTimes,
						type : 'line',
						smooth : true,
						symbol : 'none',
						sampling : 'average',
						itemStyle : {  
                            normal : {  
                                color:'#FF7F50',  //圈圈的颜色
                                lineStyle:{  
                                    color:'#FF7F50'  //线的颜色
                                }  
                            }  
                        }
					},{
						name : '进站客流',
						data : vueSegFlow.enterTimes,
						type : 'bar',
						itemStyle : {  
                            normal : {  
                                color:'#D53A35',  //圈圈的颜色
                                lineStyle:{  
                                    color:'#D53A35'  //线的颜色
                                }  
                            }  
                        }
					}, {
						name : '出站客流',
						data : vueSegFlow.exitTimes,
						type : 'bar',
						itemStyle : {  
                            normal : {  
                                color:'#AADD6C',  //圈圈的颜色
                                lineStyle:{  
                                    color:'#AADD6C'  //线的颜色
                                }  
                            }  
                        }
					},{
						name : '总客流',
						data : vueSegFlow.totalTimes,
						type : 'bar',
						itemStyle : {  
                            normal : {  
                                color:'#FF7F50',  //圈圈的颜色
                                lineStyle:{  
                                    color:'#FF7F50'  //线的颜色
                                }  
                            }  
                        }
					} ]
				};
				if (option && typeof option === "object") {
					sta.setOption(option, true);
				}
			},
			fetchDate:function(chartId,actionurl){
				$.post("jinbo/"+actionurl, {startTime : vueSegFlow.startTime,stationName : vueSegFlow.stationName}, function(data) {
					vueSegFlow.totalTimesSum=0;
					for (var i=0;i<=data.length-1;i++){
						vueSegFlow.timeSeg.push(data[i]['timeSeg']);
						vueSegFlow.totalTimes.push(data[i]['totalTimes']);
						vueSegFlow.totalPkTimes.push(data[i]['totalPkTimes']);
						
						vueSegFlow.enterTimes.push(data[i]['enterTimes']);
						vueSegFlow.exitTimes.push(data[i]['exitTimes']);
						vueSegFlow.pkEnterTimes.push(data[i]['pkEnterTimes']);
						vueSegFlow.pkExitTimes.push(data[i]['pkExitTimes']);
						
						vueSegFlow.totalTimesSum+=data[i]['totalTimes']*1;
					}
					vueSegFlow.$options.methods.initChart(chartId);
				});
			},
			getVisitpfw : function() {
				var startTime = "<%=startTime%>";
				var compareTime = "<%=hb_time%>";
				$.post("jinbo/get_time_seg_flow.action", {
					"startTime" : startTime,
					"chainTime" : compareTime,
					"modelId" : "103",
					"subModelName" : "关注车站"
				}, function(data) {
					vueSegFlow.timeSeg2 = data.timeSeg;
					vueSegFlow.stationLst = data.stationLst;
					vueSegFlow.chainCompare = data.chainCompare;
					$("#coccTb").show();
				});
			},
			dataRefresh : function(startTime, compareTime, modelId,
					subModelName) {
				$.post("jinbo/get_time_seg_flow.action", {
					"startTime" : startTime,
					"chainTime" : compareTime,
					"preview" : 1,
					"modelId" : modelId,
					"subModelName" : subModelName
				}, function(data) {
					vueStation.timeSeg2 = data.timeSeg;
					vueStation.stationLst = data.stationLst;
					vueStation.chainCompare = data.chainCompare;
					$("#coccTb").show();
				});
			}
		}
	}).$mount('#segFlow');
</script>
</html>