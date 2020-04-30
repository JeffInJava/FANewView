<%@ page language="java" import="java.util.*,java.lang.*,com.util.*,net.sf.json.*,java.text.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>

<!DOCTYPE html>
<html>
<head>
	<!-- 主要调整早上7点无数据问题 -->
	<title>dashboard</title>
	<base href="<%=basePath%>">
<%--	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">--%>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;"/>
	
	<script src="resource/jquery/js/jquery-1.7.2.js" type="text/javascript"></script>
	<script src="resource/inesa/js/common.js"></script>
	<script src="resource/echarts3/echarts.min.js"></script>

	<style type="text/css">
		.mainApp {
		    position: absolute;
		    height: 100%;
		    width: 100%;
		    color:#fff;
		}
		html, body, div, span, applet, object, iframe, h1, h2, h3, h4, h5, h6, p, blockquote, pre, a, abbr, acronym, address, big, cite, code, del, dfn, em, img, ins, kbd, q, s, samp, small, strike, strong, sub, sup, tt, var, b, u, i, center, dl, dt, dd, ol, ul, li, fieldset, form, label, legend, table, caption, tbody, tfoot, thead, article, aside, canvas, details, embed, figure, figcaption, footer, header, menu, nav, output, ruby, section, summary, time, mark, audio, video, input {
		  margin: 0;
		  padding: 0;
		  border: 0;
		  font-weight: normal;
		  vertical-align: baseline;
		}
		div {
		    display: block;
		}
		
		
		*[data-v-0b39df2e] {
		  box-sizing: border-box;
		}
		.point[data-v-0b39df2e],
		.multipleColumn[data-v-0b39df2e],
		.columnChart[data-v-0b39df2e],
		.line[data-v-0b39df2e] {
		  height: 100% !important;
		  width: 100% !important;
		  background: none !important;
		}
		.item[data-v-0b39df2e] {
		  padding: 0px;
		  margin: 0px;
		  width: 72%;
		  height: 100%;
		  position: absolute;
		  transform: scale(0.33);
		  transition: all 0.8s;
		  background: rgba(32,32,35,0.6);
		}
		.dashboard[data-v-0b39df2e] {
		  position: relative;
		  width: 100%;
		  height: 100%;
		  margin: 0px;
		  padding: 0px;
		  padding:2% 0;
		  background: url("resource/images/bg.jpg");
		  background-size: 100% 100%;
		}
		.flex-container.column[data-v-0b39df2e] {
		  position: relative;
		  height: 100%;
		  width: 100%;
		  overflow: hidden;
		  margin: 0 auto;
		  box-sizing: content-box;
		}
		.active[data-v-0b39df2e] {
		  height: 100%;
		  width: 72%;
		  line-height: 300px;
		}
		
		.filter {
		  position: relative;
		  display: -ms-flexbox;
		  display: flex;
		  padding-left:5px;
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
		
		.btn,.searchbtn{
		  color: #fff;
    	  text-shadow: 0 -1px 0 rgba(0,0,0,0.25);
     	  background-color: #2f96b4;
     	  text-align: center;
     	  border-radius: 4px;
     	  padding: 2px 10px;
    	  margin-bottom: 0;
    	  font-size: 14px;
		}
		.prm{
		  vertical-align:bottom;
		  margin-left: 10px;
		  display: none;
		  float:left;
		}
		.prm input,.prm select{
		  border: 1px solid #2f96b4;
		}
		.tab{
		  float:right;
		  margin-left:10px;
		  height:24px;
		  width:228px;
		  background-color: rgb(50, 91, 105);
		  border-radius:10px;
		  color:#fff;
		}
		.tab span{
		  margin:2px 5px;
		  padding:3px 15px;
		  line-height: 24px;
		  border-radius:10px;
		  background: rgba(32,32,35,0.6);
		}
		.tab .act{
		  background: #2f96b4;
		}
	</style>
</head>
	<%
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
		
		String start_date = fmt.format(cal.getTime());//当前日期
		cal.add(Calendar.DATE, -7);
		String hb_date = fmt.format(cal.getTime());//环比日期
		
		cal = Calendar.getInstance();
		cal.add(Calendar.YEAR, -1);
		String tb_date = fmt.format(cal.getTime());//同比日期
		
		cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -1);
		String yesterday = fmt.format(cal.getTime());//昨天
	%>
<body>
	<div style="position: absolute;z-index:999;top:10px;right: 5px;">
		<img src="resource/images/shmetrologo4.png" width="154" height="40">
	</div>
	<div style="position: absolute;z-index:999;bottom:0px;right: 5px;">
		<img src="resource/images/shmetrologo2.png" width="50" height="50">
	</div>
	<div class="mainApp">
		<div data-v-0b39df2e class="dashboard router-view">
		   <div data-v-0b39df2e class="flex-container column">
		   
		      <div data-v-0b39df2e class="item one" data-order="1" onclick="clickChart('1',this)" style="transform: translate(-26.9%,-36.5%) scale(0.28)">
		         <div data-v-3e377044 data-v-0b39df2e class="multipleColumn">
		         	<div class="main" id="mainStationRank"></div>
		         	<div data-v-3e377044 class="filter">
		         		<input type="button" value=">>" class="btn">
		         		<div class="prm">
			         		日期:<input type="text" name="start_date" id="start_date1" value="<%=start_date %>" style="width:65px;">
			         		<input type="checkbox" name="flux_flag1" value="1" checked="checked">进
			         		<input type="checkbox" name="flux_flag1" value="2">出
			         		<input type="checkbox" name="flux_flag1" value="3" checked="checked">换
			         		<select name="line_id" id="line_id1">
							  <option value="00">全路网</option>
							</select>
							<select name="ranking" id="ranking1">
							  <option value="5">前5</option>
							  <option value="8" selected="selected">前8</option>
							</select>
				  			<input type="button" onclick="loadStationRankData()" value="查询" class="searchbtn"/>
			  			</div>
		         	</div>
		         </div>
		      </div>
		      
		      <div data-v-0b39df2e class="item two" data-order="2" onclick="clickChart('2',this)" style="transform: translate(-26.9%,0.5%) scale(0.28)">
		          <div data-v-6ba29944 data-v-0b39df2e class="columnChart">
		          	 <div class="main" id="mainStationZF"></div>
		          	 <div data-v-6ba29944 class="filter">
					   <input type="button" value=">>" class="btn">
		         		<div class="prm">
						   	 运营日期:<input type="text" name="start_date" id="start_date2" value="<%=start_date %>" style="width:65px;">
						   	 对比日期:<input type="text" name="com_date" id="com_date2" value="<%=yesterday %>" style="width:65px;">
						   	 <input type="checkbox" name="flux_flag2" value="1" checked="checked">进
						   	 <input type="checkbox" name="flux_flag2" value="2">出
						   	 <input type="checkbox" name="flux_flag2" value="3" checked="checked">换
						   	 <input type="button" value="查询" onclick="loadStationComData()" class="searchbtn">
					   </div>
					   <div class="tab">
					   		<span onclick="change(this,'zf_tb')">同&nbsp;比</span>
						   	<span class="act" onclick="change(this,'zf_hb')" id="zf_hb">环&nbsp;比</span>
							<span onclick="change(this,'zf_zdy')">自定义</span>
					   </div>
		          	 </div>
		          </div>
		      </div>
		      
		      <div data-v-0b39df2e class="item three" data-order="3" onclick="clickChart('3',this)" style="transform: translate(-26.9%,36.5%) scale(0.28)">
		          <div data-v-581634c4 data-v-0b39df2e class="line">
		         	 <div class="main" id="mainStationZL"></div>
		         	 <div data-v-581634c4 class="filter">
		         	 	<input type="button" value=">>" class="btn">
		         		<div class="prm">
						   	 运营日期:<input type="text" name="start_date" id="start_date3" value="<%=start_date %>" style="width:65px;">
						   	 对比日期:<input type="text" name="com_date" id="com_date3" value="<%=yesterday %>" style="width:65px;">
						   	 <input type="checkbox" name="flux_flag3" value="1" checked="checked">进
						   	 <input type="checkbox" name="flux_flag3" value="2">出
						   	 <input type="checkbox" name="flux_flag3" value="3" checked="checked">换
						   	 <input type="button" value="查询" onclick="loadStationTimeComData()" class="searchbtn">
						</div>
						<div class="tab">
					   		<span onclick="change(this,'zl_tb')">同&nbsp;比</span>
						   	<span class="act" onclick="change(this,'zl_hb')" id="zl_hb">环&nbsp;比</span>
							<span onclick="change(this,'zl_zdy')">自定义</span>
					    </div>
		         	 </div>
		          </div>
		      </div>
		      
		      <div data-v-0b39df2e class="item four active" data-order="4" onclick="clickChart('4',this)" style="transform: translate(38%, 0) scale(1)">
		          <div data-v-c5b8f8b4 data-v-0b39df2e class="point">
		          	 <div id="mainPeriond" class="main"></div>
		          	 <div data-v-c5b8f8b4 class="filter">
		          	 	<input type="button" value=">>" class="btn">
		         		<div class="prm">
						   	 运营日期:<input type="text" name="start_date" id="start_date4" value="<%=start_date %>" style="width:65px;">
						   	 对比日期:<input type="text" name="com_date" id="com_date4" value="<%=yesterday %>" style="width:65px;">
						   	 <input type="checkbox" name="flux_flag4" value="1" checked="checked">进
						   	 <input type="checkbox" name="flux_flag4" value="2">出
						   	 <input type="checkbox" name="flux_flag4" value="3" checked="checked">换
						   	 线路:<select name="line_id" id="line_id4" style="width:60px;"></select>
							车站:<select name="station_id" id="station_id4" style="width:100px;"></select>
						   	 <input type="button" value="查询" onclick="loadFluxPeriodData()" class="searchbtn">
					   	</div>
					   	<div class="tab">
					   		<span onclick="change(this,'period_tb')">同&nbsp;比</span>
						   	<span class="act" onclick="change(this,'period_hb')" id="period_hb">环&nbsp;比</span>
							<span onclick="change(this,'period_zdy')">自定义</span>
					    </div>
		          	 </div>
		          </div>
		      </div>
		   </div>
		</div>
	</div>
	
	<script type="text/javascript">
		var chartStationRank,chartZFRank,chartZLRank,chartPeriodCom;
		$(function(){
			
			 $('body').css('zoom', 'reset');
             $(document).keydown(function (event) {

               if ((event.ctrlKey === true || event.metaKey === true)
                 && (event.which === 61 || event.which === 107
                     || event.which === 173 || event.which === 109
                     || event.which === 187  || event.which === 189))
                {
                    event.preventDefault();
                }
             });

             $(window).bind('mousewheel DOMMouseScroll', function (event) {
                    if (event.ctrlKey === true || event.metaKey) {
                        event.preventDefault();
                    }

             });
			
             
             
<%--             var scrollFunc=function(e){ --%>
<%--			  e=e || window.event; --%>
<%--			  if(e.wheelDelta && event.ctrlKey){//IE/Opera/Chrome --%>
<%--			    event.returnValue=false;--%>
<%--			  }else if(e.detail){//Firefox --%>
<%--			    event.returnValue=false; --%>
<%--			  } --%>
<%--			 }  --%>
<%--			  --%>
<%--			 /*注册事件*/ --%>
<%--			 if(document.addEventListener){ --%>
<%--			 	document.addEventListener('DOMMouseScroll',scrollFunc,false); --%>
<%--			 }//W3C --%>
<%--			 window.onmousewheel=document.onmousewheel=scrollFunc;//IE/Opera/Chrome/Safari --%>
             
			
			
			//加载线路车站
			loadLineAndStation();
			
			loadStationRankData();
			loadStationComData();
			loadStationTimeComData();
			loadFluxPeriodData();
			
			//显示或隐藏查询条件
			$(".btn").click(function(){
				if(this.value==">>"){
					$(".prm").show();
					$(".tab").hide();
					this.value="<<";
				}else if(this.value=="<<"){
					$(".prm").hide();
					$(".tab").show();
					this.value=">>";
				}
			});
		});
		
		//同环比切换事件
		function change(obj,pm){
	  		 $(obj).siblings().removeClass("act");
	  		 $(obj).addClass("act");
	  		 if(pm=="zf_tb"){
	  			 stationZFOption.series[0].data=stationZFOption.tb_data.add_pers;
	    		 stationZFOption.xAxis[0].data=stationZFOption.tb_data.stations;
	  			 reloadChar(chartZFRank,stationZFOption,"mainStationZF");
	  		 }else if(pm=="zf_hb"){
	  			 stationZFOption.series[0].data=stationZFOption.hb_data.add_pers;
	    		 stationZFOption.xAxis[0].data=stationZFOption.hb_data.stations;
	  			 reloadChar(chartZFRank,stationZFOption,"mainStationZF");
	  		 }else if(pm=="zf_zdy"){
	  			 stationZFOption.series[0].data=stationZFOption.zdy_data.add_pers;
	    		 stationZFOption.xAxis[0].data=stationZFOption.zdy_data.stations;
	  			 reloadChar(chartZFRank,stationZFOption,"mainStationZF");
	  		 }else if(pm=="zl_tb"){
	    		stationZLRankOption.series[0].data=stationZLRankOption.tb_data.add_times;
	    		stationZLRankOption.xAxis[0].data=stationZLRankOption.tb_data.stations;
	    		reloadChar(chartZLRank,stationZLRankOption,"mainStationZL");
	  		 }else if(pm=="zl_hb"){
	    		stationZLRankOption.series[0].data=stationZLRankOption.hb_data.add_times;
	    		stationZLRankOption.xAxis[0].data=stationZLRankOption.hb_data.stations;
	    		reloadChar(chartZLRank,stationZLRankOption,"mainStationZL");
	  		 }else if(pm=="zl_zdy"){
	    		stationZLRankOption.series[0].data=stationZLRankOption.zdy_data.add_times;
	    		stationZLRankOption.xAxis[0].data=stationZLRankOption.zdy_data.stations;
	    		reloadChar(chartZLRank,stationZLRankOption,"mainStationZL");
	  		 }else if(pm=="period_tb"){
	  			 periodData=periodAllData.tb_data.periodData;
	  			 dt1=periodAllData.tb_data.start_date;
	  			 dt2=periodAllData.tb_data.com_date;
	  			 setPeriodOption(periodAllData.tb_data.periodData,periodAllData.tb_data.start_date,periodAllData.tb_data.com_date);
	  		 }else if(pm=="period_hb"){
	  			 periodData=periodAllData.hb_data.periodData;
	  			 dt1=periodAllData.hb_data.start_date;
	  			 dt2=periodAllData.hb_data.com_date;
	  			 setPeriodOption(periodAllData.hb_data.periodData,periodAllData.hb_data.start_date,periodAllData.hb_data.com_date);
	  		 }else if(pm=="period_zdy"){
	  			 periodData=periodAllData.zdy_data.periodData;
	  			 dt1=periodAllData.zdy_data.start_date;
	  			 dt2=periodAllData.zdy_data.com_date;
	  			 setPeriodOption(periodAllData.zdy_data.periodData,periodAllData.zdy_data.start_date,periodAllData.zdy_data.com_date);
	  		 }
	  	 }
		var dt1,dt2;
		//图表放大切换
	 	function clickChart(t,obj){
			//如果当前就是放大图表，不再刷新
			if($(obj).is('.active')){
				return;
			}
			var e = document.querySelector(".flex-container .active"),
				a = e.dataset.order,
				n=e.style.transform,
	 			m=obj.style.transform;
	 	
				e.classList.remove("active");
				obj.classList.add("active");
				
				e.style.transform=m;
				obj.style.transform=n;
				
			//图表切换时，重新加载
			if(t==1){
				reloadChar(chartStationRank,stationRankOption,"mainStationRank");
			}else if(t==2){
				reloadChar(chartZFRank,stationZFOption,"mainStationZF");
			}else if(t==3){
				reloadChar(chartZLRank,stationZLRankOption,"mainStationZL");
			}else if(t==4){
				setPeriodOption(periodData,dt1,dt2);
			}
		}
		
		//图表切换时，重新加载
		function reloadChar(char,option,id){
			if(char){
				char.clear();
				//char.dispose();
				
				setTimeout(function(){
			    	char = echarts.init(document.getElementById(id)); 
	   				char.setOption(option);
			    },500);
			}
		}
		
		stationRankOption = {
			title:[],
		    tooltip : {
		        trigger: 'axis',
		        textStyle: {fontWeight:'bold',fontSize:20},
		        formatter: function (p){
               	    return p[0].name+"<br/>客流："+p[0].value+"万";
			    }
		    },
		    grid : {'y':35,'y2':45,'x':80,'x2':10},
		    xAxis : [
		        {
		            type:'category',
		            axisLine:{lineStyle:{color:'#fff',width:2}},
		            axisLabel:{
		            	interval:0,
		            	textStyle: {fontWeight:'bold',fontSize:18,color: '#FFF'},
		            	formatter:function(p){return p.length>4?p.substring(0,4)+"\n"+p.substring(4,p.length):p;}
		            },
		            data:[]
		        }
		    ],
		    yAxis : [
		        {
		            type : 'value',
		            name:'人次',
		            splitLine:{lineStyle:{type:'dashed'}},
		            axisLine:{lineStyle:{color:'#fff',width:2}},
		            axisLabel:{
		            	textStyle: {fontWeight:'bold',fontSize:18,color: '#FFF'},
		            	formatter:'{value}万'
		            }
		        }
		    ],
		    series : [
		    	{
		            name:'客流',
		            type:'bar',
		            itemStyle:{
		    			normal:{
		    				color:'#31b0d5',
		    				label:{
		    					show:true, 
		    					position: 'top',
		    					formatter:function(p){return p.value+"万";},
		    					textStyle:{fontSize:14,fontWeight:'bolder',color:'#fff'}
		    				}
		    			}
		    		},
		            data:[]
		        }
		    ]
		};
	 	
	 	//加载车站客流排名数据
    	function loadStationRankData(){
			$(".prm").hide();
			$(".btn").val(">>");
			$(".tab").show();
			
    		var start_date=$("#start_date1").val();//选择日期
    		var flux_flag=$('input[name="flux_flag1"]:checked');//选择进出站方式
    		var tp="";
    		if(flux_flag&&flux_flag.length>0){
    			$(flux_flag).each(function(i,v){
    				tp+=$(v).val();
    			});
    		}else{
    			alert("请选择进出站方式！");
    			return;
    		}
    		
    		var line_id=$("#line_id1").val();//选择线路
    		var line_nm=$("#line_id1 option:selected").text();//选择线路
    		var ranking=$("#ranking1").val();//排名
    		doPost("station/get_station_fluxrank.action", {"start_date":start_date,"flux_flag":tp}, function(data){
    			makeStationReport(line_id,ranking,data,line_nm,tp);
    			
    			//添加chang事件
    			$("#line_id1").change(function(){
					makeStationReport($("#line_id1").val(),$("#ranking1").val(),data,$("#line_id1 option:selected").text(),tp);
				});
    			$("#ranking1").change(function(){
					makeStationReport($("#line_id1").val(),$("#ranking1").val(),data,$("#line_id1 option:selected").text(),tp);
				});
    		});
    	}
    	
    	//绘制图表--车站客流排名
    	function makeStationReport(line_id,ranking,data,line_nm,tp){
    		stationRankOption.title=[{
			        text: '车站客流排名',
			        x:'center',
			        textStyle:{fontSize:24,fontWeight:'bolder',color: '#FFF'}
			    }];
    		if(tp.indexOf("1")>-1&&tp.indexOf("3")>-1&&tp.length==2){
    			stationRankOption.title[0].text=line_nm+"客流排名";
    		}else if(tp.indexOf("1")>-1&&tp.length==1){
    			stationRankOption.title[0].text=line_nm+"进站客流排名";
    		}else if(tp.indexOf("2")>-1&&tp.length==1){
    			stationRankOption.title[0].text=line_nm+"出站客流排名";
    		}else if(tp.indexOf("3")>-1&&tp.length==1){
    			stationRankOption.title[0].text=line_nm+"换乘客流排名";
    		}else{
    			stationRankOption.title[0].text=line_nm+"客流排名";
    			var tp=(tp.indexOf("1")>-1?"进站+":"")+(tp.indexOf("2")>-1?"出站+":"")+(tp.indexOf("3")>-1?"换乘+":"");
    			stationRankOption.title.push({
			        text:"("+tp.substring(0,tp.length-1)+")",
			        x:'450',
			        y:'15',
			        textStyle:{fontSize:12,color: '#FFF'}
    			});
    		}
    		
    		stationRankOption.xAxis[0].data=[];
    		stationRankOption.series[0].data=[];
    		$.each(data,function(i,v){
    			if(v.LINE_ID==line_id&&parseInt(v.RN)<=parseInt(ranking)){
    				stationRankOption.xAxis[0].data.push(v.STATION_NM);
    				stationRankOption.series[0].data.push((v.TIMES/10000).toFixed(2));
    			}
    		});
    		
    		chartStationRank = echarts.init(document.getElementById('mainStationRank')); 
    		chartStationRank.setOption(stationRankOption,true);
    	}
	 	
    	
    	/////////////////////////////////////////////////////////////////////
    	//加载车站客流增幅排名数据
    	function loadStationComData(){
    		$(".prm").hide();
			$(".btn").val(">>");
			$(".tab").show();
			$("#zf_hb").siblings().removeClass("act");
	  		$("#zf_hb").addClass("act");
    		
    		var start_date=$("#start_date2").val();//选择日期
    		var com_date=$("#com_date2").val();//对比日期
    		var flux_flag=$('input[name="flux_flag2"]:checked');//选择进出站方式
    		var tp="";
    		if(flux_flag&&flux_flag.length>0){
    			$(flux_flag).each(function(i,v){
    				tp+=$(v).val();
    			});
    		}else{
    			alert("请选择进出站方式！");
    			return;
    		}
    		
    		stationZFOption.title=[{
			        text: '车站客流增幅排名',
			        x:'center',
			        textStyle:{fontSize:24,fontWeight:'bolder',color: '#FFF'}
		    	}];
    		if(tp.indexOf("1")>-1&&tp.indexOf("3")>-1&&tp.length==2){
    			stationZFOption.title[0].text="车站客流增幅排名";
    		}else if(tp.indexOf("1")>-1&&tp.length==1){
    			stationZFOption.title[0].text="进站客流增幅排名";
    		}else if(tp.indexOf("2")>-1&&tp.length==1){
    			stationZFOption.title[0].text="出站客流增幅排名";
    		}else if(tp.indexOf("3")>-1&&tp.length==1){
    			stationZFOption.title[0].text="换乘客流增幅排名";
    		}else{
    			stationZFOption.title[0].text="车站客流增幅排名";
    			var tp_str=(tp.indexOf("1")>-1?"进站+":"")+(tp.indexOf("2")>-1?"出站+":"")+(tp.indexOf("3")>-1?"换乘+":"");
    			stationZFOption.title.push({
			        text:"("+tp_str.substring(0,tp_str.length-1)+")",
			        x:'450',
			        y:'15',
			        textStyle:{fontSize:12,color: '#FFF'}
    			});
    		}
    		
    		//同比数据
    		doPost("station/get_station_fluxcompare.action", {"start_date":"<%=start_date %>","com_date":"<%=tb_date%>","sel_flag":"zf","flux_flag":tp}, function(data){
    			stationZFOption.tb_data={"add_pers":[],"stations":[]};
	    		$.each(data,function(i,v){
	    			if(i<8){
	    				stationZFOption.tb_data.add_pers.push(v.ADD_PER);
	    				stationZFOption.tb_data.stations.push(v.STATION_NM);
	    			}
	    		});
    		});
    		
    		//环比数据
    		doPost("station/get_station_fluxcompare.action", {"start_date":"<%=start_date %>","com_date":"<%=hb_date%>","sel_flag":"zf","flux_flag":tp}, function(data){
    			stationZFOption.hb_data={"add_pers":[],"stations":[]};
    			var stations=[],add_pers=[];
	    		$.each(data,function(i,v){
	    			if(i<8){
	    				add_pers.push(v.ADD_PER);
	    				stations.push(v.STATION_NM);
	    				stationZFOption.hb_data.add_pers.push(v.ADD_PER);
	    				stationZFOption.hb_data.stations.push(v.STATION_NM);
	    			}
	    		});
	    		stationZFOption.series[0].data=add_pers;
	    		stationZFOption.xAxis[0].data=stations;
	    		
		    	chartZFRank = echarts.init(document.getElementById('mainStationZF')); 
		     	chartZFRank.setOption(stationZFOption, true);
    		});
    		
    		//自定义日期数据
    		doPost("station/get_station_fluxcompare.action", {"start_date":start_date,"com_date":com_date,"sel_flag":"zf","flux_flag":tp}, function(data){
    			stationZFOption.zdy_data={"add_pers":[],"stations":[]};
	    		$.each(data,function(i,v){
	    			if(i<8){
	    				stationZFOption.zdy_data.add_pers.push(v.ADD_PER);
	    				stationZFOption.zdy_data.stations.push(v.STATION_NM);
	    			}
	    		});
    		});
    	}
    	
    	stationZFOption = {
	        title : [],
		    tooltip : {
		        trigger: 'axis',
		        textStyle: {fontWeight:'bold',fontSize:20},
		        formatter: function (p){
              	    return p[0].name+"<br/>增幅："+(p[0].value>0?"+"+p[0].value+"%":p[0].value+"%");
			    }
		    },
		    grid : {'y':35,'y2':45,'x':80,'x2':10},
		    xAxis : [
		        {
		            type:'category',
		            axisLine:{lineStyle:{color:'#fff',width:2}},
		            axisLabel:{
		            	interval:0,
		            	textStyle: {fontWeight:'bold',fontSize:18,color: '#FFF'},
		            	formatter:function(p){return p.length>4?p.substring(0,4)+"\n"+p.substring(4,p.length):p;}
		            },
		            data:[]
		        }
		    ],
		    yAxis : [
		        {
		            type : 'value',
		            splitLine:{lineStyle:{type:'dashed'}},
		            axisLine:{lineStyle:{color:'#fff',width:2}},
		            axisLabel:{
		        		formatter:'{value}%',
			        	textStyle: {fontWeight:'bold',fontSize:18,color: '#FFF'}
			        }
		        }
		    ],
		    series : [
		    	{
		            name:'对比增幅',
		            type:'bar',
		            itemStyle : {
		    			normal: {
		    				color:'rgba(26,188,156,1)',
		    				label : {show:true, position: 'top',formatter:function(p){return p.value+"%";},textStyle:{fontSize:14,fontWeight:'bolder',color:'#fff'}}
		    			}
		    		},
		            data:[]
		        }
		    ]
		};
    	
    	//////////////////////////////////////////////////////////////////////
    	//加载车站客流增量排名数据
    	function loadStationTimeComData(){
    		$(".prm").hide();
			$(".btn").val(">>");
			$(".tab").show();
			$("#zl_hb").siblings().removeClass("act");
	  		$("#zl_hb").addClass("act");
		
    		var start_date=$("#start_date3").val();//选择日期
    		var com_date=$("#com_date3").val();//对比日期
    		var flux_flag=$('input[name="flux_flag3"]:checked');//选择进出站方式
    		var tp="";
    		if(flux_flag&&flux_flag.length>0){
    			$(flux_flag).each(function(i,v){
    				tp+=$(v).val();
    			});
    		}else{
    			alert("请选择进出站方式！");
    			return;
    		}
    		
    		stationZLRankOption.title=[{
			        text: '车站客流增量排名',
			        x:'center',
			        textStyle:{fontSize:24,fontWeight:'bolder',color: '#FFF'}
		    	}];
    		if(tp.indexOf("1")>-1&&tp.indexOf("3")>-1&&tp.length==2){
    			stationZLRankOption.title[0].text="车站客流增量排名";
    		}else if(tp.indexOf("1")>-1&&tp.length==1){
    			stationZLRankOption.title[0].text="进站客流增量排名";
    		}else if(tp.indexOf("2")>-1&&tp.length==1){
    			stationZLRankOption.title[0].text="出站客流增量排名";
    		}else if(tp.indexOf("3")>-1&&tp.length==1){
    			stationZLRankOption.title[0].text="换乘客流增量排名";
    		}else{
    			stationZLRankOption.title[0].text="车站客流增量排名";
    			var tp_str=(tp.indexOf("1")>-1?"进站+":"")+(tp.indexOf("2")>-1?"出站+":"")+(tp.indexOf("3")>-1?"换乘+":"");
    			stationZLRankOption.title.push({
			        text:"("+tp_str.substring(0,tp_str.length-1)+")",
			        x:'450',
			        y:'15',
			        textStyle:{fontSize:12,color: '#FFF'}
    			});
    		}
    		
    		//同比数据
    		doPost("station/get_station_fluxcompare.action", {"start_date":"<%=start_date %>","com_date":"<%=tb_date%>","sel_flag":"zl","flux_flag":tp}, function(data){
    			stationZLRankOption.tb_data={"add_times":[],"stations":[]};
	    		$.each(data,function(i,v){
	    			if(i<8){
	    				stationZLRankOption.tb_data.add_times.push(v.ADD_TIMES);
	    				stationZLRankOption.tb_data.stations.push(v.STATION_NM);
	    			}
	    		});
    		});
    		
    		//环比数据
    		doPost("station/get_station_fluxcompare.action", {"start_date":"<%=start_date %>","com_date":"<%=hb_date%>","sel_flag":"zl","flux_flag":tp}, function(data){
    			var stations=[],add_times=[];
    			stationZLRankOption.hb_data={"add_times":[],"stations":[]};
	    		$.each(data,function(i,v){
	    			if(i<8){
	    				add_times.push(v.ADD_TIMES);
	    				stations.push(v.STATION_NM);
	    				
	    				stationZLRankOption.hb_data.add_times.push(v.ADD_TIMES);
	    				stationZLRankOption.hb_data.stations.push(v.STATION_NM);
	    			}
	    		});
	    		stationZLRankOption.series[0].data=add_times;
	    		stationZLRankOption.xAxis[0].data=stations;
	    		
		    	chartZLRank = echarts.init(document.getElementById('mainStationZL')); 
			    chartZLRank.setOption(stationZLRankOption, true);
    		});
    		
    		//自定义日期数据
    		doPost("station/get_station_fluxcompare.action", {"start_date":start_date,"com_date":com_date,"sel_flag":"zl","flux_flag":tp}, function(data){
    			stationZLRankOption.zdy_data={"add_times":[],"stations":[]};
	    		$.each(data,function(i,v){
	    			if(i<8){
	    				stationZLRankOption.zdy_data.add_times.push(v.ADD_TIMES);
	    				stationZLRankOption.zdy_data.stations.push(v.STATION_NM);
	    			}
	    		});
    		});
    	}
    	
    	stationZLRankOption = {
	        title : [],
		    tooltip : {
		        trigger: 'axis',
		        textStyle: {fontWeight:'bold',fontSize:20,color: '#FFF'},
		        formatter: function (p){
			            return p[0].name+"<br/>增量："+(p[0].value>0?"+"+p[0].value:p[0].value);
			        }
		    },
		    calculable : true,
		    grid : {'y':35,'y2':45,'x':80,'x2':10},
		    xAxis : [
		        {
		            type:'category',
		            axisLine:{lineStyle:{color:'#fff',width:2}},
		            axisLabel:{
		            	interval:0,
		            	textStyle: {fontWeight:'bold',fontSize:18,color: '#FFF'},
		            	formatter:function(p){return p.length>4?p.substring(0,4)+"\n"+p.substring(4,p.length):p;}
		            },
		            data:[]
		        }
		    ],
		    yAxis : [
		        {
		            type:'value',
		            name:'人次',
		            splitLine:{lineStyle:{type:'dashed'}},
		            axisLine:{lineStyle:{color:'#fff',width:2}},
		            axisLabel:{
			        	textStyle: {fontWeight:'bold',fontSize:18,color: '#FFF'}
			        }
		        }
		    ],
		    series : [
		    	{
		            name:'对比增量',
		            type:'bar',
		            itemStyle : {
		    			normal: {
		    				color:'rgba(155,201,99,1)',
		    				label : {show:true, position: 'top',textStyle:{fontSize:14,fontWeight:'bolder',color:'#fff'}}
		    			}
		    		},
		            data:[]
		        }
		    ]
		};
    	////////////////////////////////////////////////////////////
    	
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
				
				$("#line_id1").html(tp_line);
				$("#line_id4").html(tp_line);
				$("#station_id4").html(tp);
				
				//添加事件
				$("#line_id4").change(function(){
					var sel_line=$("#line_id4").val();
					tp="<option></option>";
					for(var i=0;i<line.length;i++){
						if(sel_line==line[i].LINE_ID){
							tp+="<option value='"+line[i].STATION_ID+"'>"+line[i].STATION_NM+"</option>";
						}
					}
					$("#station_id4").html(tp);
				});
				
			});
		}
    	
    	var flowPeriodOption;
		var periodData;
		var periodAllData;
    	//加载分时客流对比数据
    	function loadFluxPeriodData(){
    		$(".prm").hide();
			$(".btn").val(">>");
			$(".tab").show();
			$("#period_hb").siblings().removeClass("act");
	  		$("#period_hb").addClass("act");
		
    		var start_date=$("#start_date4").val();//选择日期
    		var com_date=$("#com_date4").val();//对比日期
    		var flux_flag=$('input[name="flux_flag4"]:checked');//选择进出站方式
    		var tp="";
    		if(flux_flag&&flux_flag.length>0){
    			$(flux_flag).each(function(i,v){
    				tp+=$(v).val();
    			});
    		}else{
    			alert("请选择进出站方式！");
    			return;
    		}
    		
    		var line_id=$("#line_id4").val();//线路
    		if(line_id==null||typeof(line_id)=="undefined"){
    			line_id="00";
    		}
    		var station_id=$("#station_id4").val();//车站
    		
    		var line_nm=$("#line_id4 option:selected").text();//选择线路名称
    		periodAllData={
    			title:[{
			        text: '客流分时比较',
			        x:'center',
			        textStyle:{fontSize:24,fontWeight:'bolder',color: '#FFF'}
		    	}]
		    };
    		var tp_title="";
    		if(station_id){
    			periodAllData.selectedStation=true;
    			tp_title=$("#station_id4 option:selected").text();
    		}else{
    			periodAllData.selectedStation=false;
    			tp_title=$("#line_id4 option:selected").text();
    		}
    		if(tp.indexOf("1")>-1&&tp.indexOf("3")>-1&&tp.length==2){
    			periodAllData.title[0].text=tp_title+"客流分时比较";
    		}else if(tp.indexOf("1")>-1&&tp.length==1){
    			periodAllData.title[0].text=tp_title+"进站客流分时比较";
    		}else if(tp.indexOf("2")>-1&&tp.length==1){
    			periodAllData.title[0].text=tp_title+"出站客流分时比较";
    		}else if(tp.indexOf("3")>-1&&tp.length==1){
    			periodAllData.title[0].text=tp_title+"换乘客流分时比较";
    		}else{
    			periodAllData.title[0].text=tp_title+"客流分时比较";
    			var tp_str=(tp.indexOf("1")>-1?"进站+":"")+(tp.indexOf("2")>-1?"出站+":"")+(tp.indexOf("3")>-1?"换乘+":"");
    			periodAllData.title.push({
			        text:"("+tp_str.substring(0,tp_str.length-1)+")",
			        x:'450',
			        y:'15',
			        textStyle:{fontSize:12,color: '#FFF'}
    			});
    		}
    		
    		
    		//同比数据
    		doPost("station/get_fluxperiod.action", {"start_date":"<%=start_date %>","com_date":"<%=tb_date%>","sel_flag":"3","flux_flag":tp,"line_id":line_id,"station_id":station_id}, function(data){
				periodAllData.tb_data={};
    			periodAllData.tb_data.periodData=data;
				periodAllData.tb_data.start_date="<%=start_date %>";
				periodAllData.tb_data.com_date="<%=tb_date%>";
    		});
    		
    		//环比数据
    		doPost("station/get_fluxperiod.action", {"start_date":"<%=start_date %>","com_date":"<%=hb_date%>","sel_flag":"3","flux_flag":tp,"line_id":line_id,"station_id":station_id}, function(data){
    			periodData=data;
				setPeriodOption(periodData,"<%=start_date %>","<%=hb_date%>");
				periodAllData.hb_data={};
				periodAllData.hb_data.periodData=data;
				periodAllData.hb_data.start_date="<%=start_date %>";
				periodAllData.hb_data.com_date="<%=hb_date%>";
				
				dt1=start_date;
	  			dt2="<%=hb_date%>";
    		});
    		
    		//自定义日期数据
    		doPost("station/get_fluxperiod.action", {"start_date":start_date,"com_date":com_date,"sel_flag":"3","flux_flag":tp,"line_id":line_id,"station_id":station_id}, function(data){
				periodAllData.zdy_data={};
    			periodAllData.zdy_data.periodData=data;
    			periodAllData.zdy_data.start_date=start_date;
				periodAllData.zdy_data.com_date=com_date;
    		});
    		
    	}
    	
    	
    	function setPeriodOption(data,start_date,com_date){
    		flowPeriodOption = {
		        title : periodAllData.title,
			    tooltip : {
			        trigger: 'axis',
			        textStyle: {fontWeight:'bold',fontSize:20},
			        formatter: function (p){
			        	var tp_str=p[0].name+"<br/>"+p[0].seriesName+"：";
			        	if(isNaN(p[0].value)||typeof(p[0].value)=="undefined"){
							tp_str+="--";
			        	}else{
			        		tp_str+=(periodAllData.selectedStation?p[0].value:p[0].value+"万");
			        	}
						tp_str+="<br/>"+p[1].seriesName+"："+(periodAllData.selectedStation?p[1].value:p[1].value)+"万";
			            return tp_str;
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
			    grid : {'y':55,'y2':30,'x':70,'x2':25},
			    xAxis : [
			        {
			            type:'category',
			            boundaryGap:false,
			            axisLine:{lineStyle:{color:'#fff',width:2}},
			            axisLabel:{interval:0,textStyle: {color: '#FFF'}},
			            data:[]
			        }
			    ],
			    yAxis : [
			        {
			            type:'value',
			            name:'人次',
			            splitLine:{lineStyle:{type:'dashed'}},
			            axisLine:{lineStyle:{color:'#fff',width:2}},
			            axisLabel:{
				        	textStyle: {fontWeight:'bold',fontSize:18,color: '#FFF'},
				        	formatter:periodAllData.selectedStation?'{value}':'{value}万'
				        }
			        }
			    ],
			    series : [
			    	{
			            name:'',
			            type:'line',
			            smooth:true,
			            itemStyle: {normal: {color: 'rgba(255,127,80,1)'}},
			            areaStyle: {normal: {}},
			            data:[]
			        }
			    ]
			};
   			
   			
   			var dateFt0=start_date.substring(0,4)+"/"+start_date.substring(4,6)+"/"+start_date.substring(6);
    		var dateFt1=com_date.substring(0,4)+"/"+com_date.substring(4,6)+"/"+com_date.substring(6);
    		
    		flowPeriodOption.legend.data=[{name:dateFt0,textStyle:{color: 'rgba(255,127,80,1)'}}];
    		flowPeriodOption.series[0].name=dateFt0;
    		
    		var times=[],com_times=[],period=[];
    		$.each(data,function(i,v){
    			//如果查询条件选择了车站，客流不用约等到万单位
    			if(periodAllData.selectedStation){
    				if(v.FLAG=="0"&&(typeof(v.TIMES)=="undefined"||v.TIMES<v.COM_TIMES)){
    					times.push(v.COM_TIMES);
    				}else{
    					times.push(v.TIMES);
    				}
	    			com_times.push(v.COM_TIMES);
    			}else{
    				if(v.FLAG=="0"&&(typeof(v.TIMES)=="undefined"||v.TIMES<v.COM_TIMES)){
    					times.push((v.COM_TIMES/10000).toFixed(2));
    				}else{
    					times.push((v.TIMES/10000).toFixed(2));
    				}
	    			com_times.push((v.COM_TIMES/10000).toFixed(2));
    			}
    			
	    		if(parseInt(v.TIME_PERIOD.toString().substr(3,2))%15==0){
	    			if(v.TIME_PERIOD.toString().substr(v.TIME_PERIOD.toString().length-1,1)=="5"){
	    				period.push({
		    				value:v.TIME_PERIOD,            
					        textStyle:{fontSize:12}
		    			});
	    			}else{
	    				period.push({
		    				value:v.TIME_PERIOD,            
					        textStyle:{fontSize:16,fontWeight:'bold'}
		    			});
	    			}
	    			
	    		}else{
	    			period.push({
	    				value:v.TIME_PERIOD,            
				        textStyle:{fontSize:0,fontWeight:0,color:'rgba(32,32,35,0)'}
	    			});
	    		}
    			
    		});
    		
    		//销毁图例
    		if(chartPeriodCom){
    			chartPeriodCom.dispose();
    		}
    		
	    	flowPeriodOption.series[0].data=times;
   			flowPeriodOption.xAxis[0].data=period;
    		
	    	chartPeriodCom = echarts.init(document.getElementById('mainPeriond')); 
		    chartPeriodCom.setOption(flowPeriodOption,true);
	    	
		    //延迟加载“运营日期”的数据
		    setTimeout(function(){
		    	secLoad(dateFt1,com_times);
		    },1000);
    	}
    	
    	
    	//延迟加载“运营日期”的数据
		function secLoad(dateFt1,com_times){
			flowPeriodOption.legend.data.push({name:dateFt1,textStyle:{color: 'rgba(46,199,201,1)'}});
			flowPeriodOption.series.push({
	            name:dateFt1,
	            type:'line',
	            smooth:true,
	            itemStyle: {normal: {color: 'rgba(46,199,201,1)'}},
	            areaStyle: {normal: {}},
	            data:com_times
	        });
		    chartPeriodCom = echarts.init(document.getElementById('mainPeriond')); 
			chartPeriodCom.setOption(flowPeriodOption,true);
		}
	</script>
</body>
</html>