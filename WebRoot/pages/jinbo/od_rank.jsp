<%@ page language="java" import="java.util.*,java.lang.*,net.sf.json.*,java.sql.*,java.io.*,java.text.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<%	
	String start_date=request.getParameter("start_date");
	String viewFlag=request.getParameter("viewFlag");

  	SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
	if(start_date==null){
		start_date=df.format(new java.util.Date()); 
	}   
%>
  <head>
	<base href="<%=basePath%>">
	<title>OD排名</title>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script src="resource/anime/jquery-1.11.1.min.js"></script> 
	<script src="resource/echarts3/echarts.min.js"></script>
	<style type="text/css">
		html, body {
			margin: 0;
			padding: 0;
			height: 100%;
		    width: 100%;
		    overflow: hidden;
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
        .tab{
		  margin:0 auto;
		  height:24px;
		  width:170px;
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
  
  <body style="color:#FFFFFF;">
  	<div style="height:8%;width:100%;display:none;" id="changId">
  		<div class="tab">
	   		<span id="stationId" onclick="odChange('station')" class="act">车&nbsp;&nbsp;站</span>
			<span id="lineId" onclick="odChange('line')">线&nbsp;&nbsp;路</span>
	    </div>
  	</div>
  	<div id="mainOdRank" <% if("true".equals(viewFlag)){ %>style="height:84%;width:100%;"<%}else{ %>style="height:500px;width:1200px;"<%} %>></div>
  	<div style="height:8%;width:100%;" id="selBtnId">
  		<div style="float: left;width:6%;">
  			<input type="button" value=">>" class="btn" style="font-weight: bold">
  		</div>
	  	<div id="paramsId" style="float:right;width:94%;display:none;">
	  		<form id="form1">
			   <table border="0">
				 <tr>
					<td>
						查询日期：<input type=text name="start_date" id="start_date" style="width:80px;">&nbsp;
						<select name="topnum" id="topnum">
							<option value="5">前5</option>
							<option value="10" selected="selected">前10</option>
							<option value="20">前20</option>
						</select>&nbsp;
						车站：
						<select name="station_id" id="station_id">
							<option value="0000">全部</option>
							<option value="0234" selected="selected">徐泾东</option>
							<option value="0235">虹桥火车站</option>
							<option value="1722">诸光路</option>
						</select>&nbsp;
						OD方向：
						<select name="odFlag" id="odFlag">
							<option value="od">O->D</option>
							<option value="do">D->O</option>
						</select>&nbsp;
						<input type="button" value="查询" onclick="getData(true)">
					</td>
			      </tr>
			  </table>
			</form>
	  	</div>
  	</div>
  	
    <script type="text/javascript">
	    initPage();
	    function initPage(){
	    	$(".btn").click(function () {
		        if (this.value == ">>") {
		            $("#paramsId").show();
	                this.value = "<<";
		        } else if (this.value == "<<") {
		        	$("#paramsId").hide();
		            this.value = ">>";
		        }
		    });
	    	
	    	$("#start_date").val("<%=start_date%>");
		    makedate();
		    var viewFlag="<%=viewFlag%>";
			if(viewFlag=="true"){
				$("#selBtnId").hide();
				$("#mainOdRank").css("height","100%");
			}
			getData(false);
	    }
	     function makedate(){
		  		var datesc =  Date.now();
		  		var date;
		  		date= new Date(parseInt(Date.now()));
                var nowHours= new Date().getHours().toString();       //获取当前小时数(0-23)
                if(nowHours >= 0 && nowHours <= 2){
                	this.hournow=nowHours;
                	var sed=datesc- 3600 * 1000 * 24;
                	date=new Date(parseInt(sed));
                }
                var year = date.getFullYear();
                var month = (date.getMonth() + 1).toString();;
                var strDate = date.getDate().toString();
                if(month >= 1 && month <= 9){
                    month = "0" + month;
                }
                 
                if (strDate >= 0 && strDate <= 9) {
                    strDate = "0" + strDate;
                }
                if(nowHours >= 0 && nowHours <= 2){
                 	var cpyear=new Date(parseInt(datesc- 3600 * 1000 * 24*8)).getFullYear();
                	var cpDate=new Date(parseInt(datesc- 3600 * 1000 * 24*8)).getDate().toString();
                	var cpmonth=(new Date(parseInt(datesc- 3600 * 1000 * 24*8)).getMonth() + 1).toString();
                }else{
                 	cpyear=new Date(parseInt(datesc- 3600 * 1000 * 24*7)).getFullYear();
                 	cpDate=new Date(parseInt(datesc- 3600 * 1000 * 24*7)).getDate().toString();
                 	cpmonth=(new Date(parseInt(datesc- 3600 * 1000 * 24*7)).getMonth() + 1).toString();
                }
                if(cpmonth >= 1 && cpmonth <= 9){
                    cpmonth = "0" + cpmonth;
                }
                if (cpDate >= 0 && cpDate <= 9) {
                    cpDate = "0" + cpDate;
                }
                if(nowHours >= 0 && nowHours <= 2){
                var secyear=new Date(parseInt(datesc- 3600 * 1000 * 24*3)).getFullYear();
                var secDate=new Date(parseInt(datesc- 3600 * 1000 * 24*3)).getDate().toString();
                var secmonth=(new Date(parseInt(datesc- 3600 * 1000 * 24*3)).getMonth() + 1).toString();
                
                }else{
                 	secyear=new Date(parseInt(datesc- 3600 * 1000 * 24*2)).getFullYear();
                	secDate=new Date(parseInt(datesc- 3600 * 1000 * 24*2)).getDate().toString();
                 	secmonth=(new Date(parseInt(datesc- 3600 * 1000 * 24*2)).getMonth() + 1).toString();
                }
                if(secmonth >= 1 && secmonth <= 9){
                    secmonth = "0" + secmonth;
                }
                if (secDate >= 0 && secDate <= 9) {
                    secDate = "0" + secDate;
                }
                if(nowHours >= 0 && nowHours <= 2){
                	var firyear=new Date(parseInt(datesc- 3600 * 1000 * 24*2)).getFullYear();
                	var firDate=new Date(parseInt(datesc- 3600 * 1000 * 24*2)).getDate().toString();
                	var firmonth=(new Date(parseInt(datesc- 3600 * 1000 * 24*2)).getMonth() + 1).toString();
                }else{
                  	firyear=new Date(parseInt(datesc- 3600 * 1000 * 24)).getFullYear();
                	firDate=new Date(parseInt(datesc- 3600 * 1000 * 24)).getDate().toString();
               		firmonth=(new Date(parseInt(datesc- 3600 * 1000 * 24)).getMonth() + 1).toString();
               	}
                if(firmonth >= 1 && firmonth <= 9){
                    firmonth = "0" + firmonth;
                }
                if (firDate >= 0 && firDate <= 9) {
                    firDate = "0" + firDate;
                }
                
                var nowMin= new Date().getMinutes();     //获取当前分钟数(0-59)
                
                if (nowHours >= 0 && nowHours <= 9) {
                    nowHours = "0" + nowHours;
                }
               
                if (nowMin >= 0 && nowMin <= 9) {
                    nowMin = "0" + nowMin;
                }
                this.adate=year + month + strDate;
                this.aweekdate=cpyear + cpmonth + cpDate;
                this.firdate=firyear + firmonth + firDate;
                this.secdate=secyear + secmonth + secDate;
                
                $("#start_date").val(adate);
		  
		  }
	    
	    var option = {
    		title : {
		        text:'OD客流排名',
        		x:'center',
        		textStyle:{fontSize:24,fontWeight:'bold',color:'#fff'}
		    },
   		    tooltip : {
   		        trigger: 'axis',
   		        textStyle: {fontWeight:'bold',fontSize:20}
   		    },
   		    grid: {x:100,x2:0,y:40,y2:90},
   		    xAxis : [
   		        {
   		        	type : 'category',
   		        	axisLabel:{interval:0,textStyle: {fontWeight:'bold',fontSize:14,color:'#fff'},rotate:20},
   		        	axisLine: {
                        lineStyle: {
                            type: 'solid',
                            color:'#01A47E',
                            width:'1'
                        }
                    },
                    splitLine:{
                        show: false
                    },
   		            data :[]
   		        }
   		    ],
   		    yAxis : [
   		        {
   		            type : 'value',
   		            axisLabel:{
   		        		textStyle: {fontSize:16,fontWeight:'bold',color:'#fff'}
   		        	},
   		        	axisLine: {
                        lineStyle: {
                            type: 'solid',
                            color:'#01A47E',
                            width:'1'
                        }
                    },
   		        	splitLine:{
                        show: true,
                        lineStyle: {
                            type: 'dashed',
                            color:'#008769',
                            width:'0.5'
                        }
                    }
   		        }
   		    ],
   		    series : [
   		    	{
   		            name:"OD排名",
   		            type:'bar',
   		         	barWidth:15,
	   		        itemStyle: {
	                     normal: {
	                        color: new echarts.graphic.LinearGradient(0, 0, 0, 1, 
	                       	[
								{offset: 0, color: '#E3E001'},
								{offset: 1, color: '#0E132E'}
	                       	 ])
	                     }
			        },
   		            data:[]
   		        }
   		    ]
   		};
	    
	    var myChart=echarts.init(document.getElementById('mainOdRank'));
	    var stationOd;
	    var lineOd;
	    function getData(flag){
	    	$("#changId").hide();
	    	$("#paramsId").hide();
            this.value = ">>";
            
            getLineOd(flag);//加载线路od
            getStationOd();//加载车站od
	    }
	    
	    function showParam(){
	    	$("#selBtnId").show();
	    }
	    var stationNm;
	    //加载车站od
	    function getStationOd(){
	    	stationNm=$("#station_id").val();
	    	
	    	var param={"start_date":$("#start_date").val(),"topnum":$("#topnum").val(),"station_id":stationNm,"selFlag":"station","odFlag":$("#odFlag").val()};
	    	$.post("od/get_odfluxrank.action",param,function(dt){
	    		stationOd=dt;
	    		option.xAxis[0].data=[];
	    		option.series[0].data=[];
	    		$.each(dt,function(i,v){
	    			option.xAxis[0].data.push(v.OD);
	    			option.series[0].data.push(v.TIMES);
	    		});
	    		
	    		if(stationNm=="0000"){
	    			option.title.text="进博会核心“三站”OD排名";
	    		}else if(stationNm=="0234"){
	    			option.title.text="徐泾东车站OD排名";
	    		}else if(stationNm=="0235"){
	    			option.title.text="虹桥火车站车站OD排名";
	    		}else if(stationNm=="1722"){
	    			option.title.text="诸光路车站OD排名";
	    		}
	    		
		    	myChart.setOption(option, true);
	    	});
	    }
	    
	  	//加载线路od
	    function getLineOd(flag){
	    	var param={"start_date":$("#start_date").val(),"topnum":$("#topnum").val(),"station_id":$("#station_id").val(),"selFlag":"line","odFlag":$("#odFlag").val()};
	    	$.post("od/get_odfluxrank.action",param,function(dt){
	    		$("#changId").show();
	    		lineOd=dt;
	    		
	    		if(flag){
	    			setTimeout(function(){
	    				parent.notifyifram("odrank",{"stationOd":stationOd,"lineOd":lineOd});
	     		  	},1000);
	    		}
	    	});
	    }
	  	function dataRefresh(param){
	  		stationOd=param.stationOd;
	  		lineOd=param.lineOd;
	  		odChange("station");
	  	}
	  	//切换车站和线路的od客流
	  	function odChange(flag){
	  		$("#"+flag+"Id").siblings().removeClass("act");
	  		$("#"+flag+"Id").addClass("act");
	  		
	  		option.xAxis[0].data=[];
    		option.series[0].data=[];
	  		if(flag=="station"){
	  			$.each(stationOd,function(i,v){
	    			option.xAxis[0].data.push(v.OD);
	    			option.series[0].data.push(v.TIMES);
	    		});
	  			if(stationNm=="0000"){
	    			option.title.text="进博会“三站”OD排名";
	    		}else if(stationNm=="0234"){
	    			option.title.text="徐泾东车站OD排名";
	    		}else if(stationNm=="0235"){
	    			option.title.text="虹桥火车站车站OD排名";
	    		}else if(stationNm=="1722"){
	    			option.title.text="诸光路车站OD排名";
	    		}
		    	myChart.setOption(option, true);
	  		}else if(flag=="line"){
	  			$.each(lineOd,function(i,v){
	    			option.xAxis[0].data.push(v.LINE_ID);
	    			option.series[0].data.push({
                   		value:v.TIMES,
                   		itemStyle:{normal:{color:v.LINE_COLOR}}
                   	});
	    		});
	    		option.title.text="线路OD排名";
		    	myChart.setOption(option, true);
	  		}
	  	}
    </script>
  </body>
</html>