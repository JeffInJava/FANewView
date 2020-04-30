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
<script src="resource/inesa/js/common.js"></script>
<script src="resource/vue/vue.min.js"></script>
<script src="resource/element-ui/index.js"></script>
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
table,th,tr,td{
	border-color:rgb(108, 167, 151);
	font-size:12px;
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
.btn {
            width: 60px;
            height: 42px;
            color: #fff;
            text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25);
            background-color: #1134A8;
            text-align: center;
            border-radius: 8px;
            border:0px;
            padding: 2px 15px;
            margin-bottom: 0;
            font-size: 15px;
        }
        /*定义滚动条高宽及背景 高宽分别对应横竖滚动条的尺寸*/
        ::-webkit-scrollbar
        {
            width: 7px;
            height: 16px;
            background-color: rgba(29,144,230,0);
        }

        /*定义滚动条轨道 内阴影+圆角*/
        ::-webkit-scrollbar-track
        {
            -webkit-box-shadow: inset 0 0 6px rgba(255,255,255,0.1);
            border-radius: 10px;
            background-color:rgba(255,255,255,0.1);
        }

        /*定义滑块 内阴影+圆角*/
        ::-webkit-scrollbar-thumb
        {
            border-radius: 10px;
            -webkit-box-shadow: inset 0 0 6px rgba(255,255,255,0.1);
            background-color: rgba(0,140,111,1);
        }
.text-red {
	color: red;
}
</style>
</head>
<%
Calendar cal = Calendar.getInstance();
SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");

String start_time = fmt.format(cal.getTime());//当前日期
cal.add(Calendar.DATE, -7);
String hb_time = fmt.format(cal.getTime());//环比日期

String start_date = request.getParameter("start_date");
String com_date = request.getParameter("com_date");
String viewFlag = request.getParameter("viewFlag");

SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
Calendar calendar = Calendar.getInstance();
if (start_date == null || start_date == null) {
	start_date = df.format(new java.util.Date());
}
if (com_date == null) {
	calendar.setTime(new java.util.Date());
	calendar.add(Calendar.DAY_OF_MONTH, -7);
	com_date = df.format(calendar.getTime());
}
%>
<body>
	<div class="mainApp" id="cocc" style="width:auto;height:auto;">
		
		<div id="paramsId" v-show="slayer" style="height:12%;width:94%;display: none;" >
				<form id="form1">
					<table border="0">
						<tr>
							<td>查询日期： <input type=text name="start_date" id="start_date" style="width:80px;">
							</td>
							<td>对比日期： <input type=text name="com_date" id="com_date" style="width:80px;">
							</td>
							<td><el-button type="primary" @click="getVisitpfw">查询</el-button></td>
						</tr>
					</table>
				</form>
		</div>
		<div data-v-c5b8f8b4 data-v-0b39df2e class="point" id="zf">

			<table id="coccTb" data-sort="sortDisabled" align="center" border="0" cellspacing="1" cellpadding="0" hidden>
				<tbody>
					<tr class="firstRow">
						<td valign="middle" rowspan="2" colspan="1" align="right" style="word-break: break-all; border-width: 1px; border-style: solid;" width="104"></td>
						<td rowspan="1" valign="middle" align="center" width="104" style="word-break: break-all; border-width: 1px; border-style: solid;"><span style="text-align: -webkit-right;">时间</span></td>
						<td v-for="times in timeSeg" valign="middle" rowspan="1" colspan="2" style="word-break: break-all; border-width: 1px; border-style: solid;" align="center">{{times.startTime}}<br />
						</td>
					</tr>
					<tr>
						<td rowspan="1" valign="top" align="null" width="104" style="border-width: 1px; border-style: solid;"></td>
						<template  v-for="times in timeSeg">
							<td valign="middle" colspan="1" rowspan="1" style="word-break: break-all; border-width: 1px; border-style: solid;" align="center">客流量</td>
							<td valign="middle" colspan="1" rowspan="1" style="word-break: break-all; border-width: 1px; border-style: solid;" align="center">增↑/减↓</td>
						</template>
					</tr>
				</tbody>
				<tbody v-for="line in lineLst">
					<tr>
						<td width="105" valign="middle" rowspan="2" colspan="1" style="word-break: break-all; border-width: 1px; border-style: solid;" align="center">{{line.lineId}}<br />
						</td>
						<td width="105" valign="middle" style="word-break: break-all; border-width: 1px; border-style: solid;" align="center">出</td>
						<template v-for="cc in chainCompare">
						 <template v-if="line.lineId == cc.lineId">
							<td width="105" valign="middle" align="center" style="border-width: 1px; border-style: solid;">{{cc.exitTimes}}</td>
							<td width="105" valign="middle" align="center" style="border-width: 1px; border-style: solid;">
								<span v-if="parseInt(cc.exitDvalue)>0"><span style="color: #c35656;"><b>{{cc.exitDvalue}}</b></span></span>
								<span v-else>{{cc.exitDvalue}}</span>
							</td>
						 </template>
						</template>
					</tr>
					<tr>
						<td width="105" valign="middle" style="word-break: break-all; border-width: 1px; border-style: solid;" align="center">进</td>
						<template v-for="cc in chainCompare">
						 <template v-if="line.lineId == cc.lineId">
							<td width="105" valign="middle" align="center" style="border-width: 1px; border-style: solid;">{{cc.enterTimes}}</td>
							<td width="105" valign="middle" align="center" style="border-width: 1px; border-style: solid;">
								<span v-if="parseInt(cc.enterDvalue)>0"><span style="color: #c35656;"><b>{{cc.enterDvalue}}</b></span></span>
								<span v-else>{{cc.enterDvalue}}</span>
							</td>
						 </template>
						</template>
					</tr>
				</tbody>
			</table>
			</el-row>
		</div>
		<script type="text/javascript">
		
		var vueLine = new Vue({
				el : '#cocc',
				data : {
					timeSeg : [],
					asato:[],
					asatoData:[],
					lineLst:[],
					slayer:false,
					chainCompare:[],
					textRed:false
				},
			    mounted: function () {
					this.getVisitpfw();
					window.updateView=this.updateView;
					window.dataRefresh=this.dataRefresh;
			    },
				methods : {
					/* timeReload:function(){
					  	var vueThis=this;
					  	setInterval(function() {
			                  vueThis.getVisitpfw();
			                }, 300000);
					  }, */
					  updateView:function(startTime,compareTime){
							var vueThis = this;
							$('#start_date').val(startTime);
							$('#com_date').val(compareTime);
							vueThis.getVisitpfw();
						},
					getVisitpfw : function() {
						var vueThis = this;
						var cocc_view = window.parent.document.getElementById("cocc_view").value;
						if(cocc_view == '0'){
							vueThis.slayer = true;
						}
						var startTime = $('#start_date').val();
						var compareTime = $('#com_date').val();
						if(startTime==""){
							startTime = "<%=start_time%>";
						}
						if(compareTime == ""){
							compareTime = "<%=hb_time%>";
						}
						$.post("cocc/get_line_time_seg_flow.action", {
							"startTime" : startTime,
							"chainTime" : compareTime,
							"preview":cocc_view
						}, function(data) {
							vueThis.timeSeg = data.timeSeg;
							vueThis.lineLst = data.lineLst;
							vueThis.chainCompare = data.chainCompare;
							$("#coccTb").show();
						});
					},
					dataRefresh:function(startTime,compareTime){
						$.post("cocc/get_line_time_seg_flow.action", {
							"startTime" : startTime,
							"chainTime" : compareTime,
							"preview":1
						}, function(data) {
							vueLine.timeSeg = data.timeSeg;
							vueLine.lineLst = data.lineLst;
							vueLine.chainCompare = data.chainCompare;
							$("#coccTb").show();
						});
					}
				}

			})
		</script>
</body>
</html>