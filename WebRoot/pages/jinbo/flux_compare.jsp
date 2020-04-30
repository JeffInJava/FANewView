<%@ page language="java" import="java.util.*,java.lang.*,net.sf.json.*,java.sql.*,java.io.*,java.text.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<%	
	String start_date=request.getParameter("start_date");
	String com_date=request.getParameter("com_date");
  	String viewFlag=request.getParameter("viewFlag");
  	
  	SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
	if(start_date==null){
		start_date=df.format(new java.util.Date()); 
		
		Calendar calendar = Calendar.getInstance(); 
		calendar.setTime(new java.util.Date());
		calendar.add(Calendar.DAY_OF_MONTH, -7);
		com_date=df.format(calendar.getTime());
	}   
%>
  <head>
	<base href="<%=basePath%>">
	<title>车站客流对比</title>
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
		.numText{
			font-size:32px;
			font-weight:bold;
			color:#FFFF00;
		}
		.numText1{
			font-weight:bold;
			color:#FFFF00;
		}
	</style>
  </head>
  
  <body style="color:#FFFFFF;">
  	<div style="height:8%;width:100%;" id="changId">
  		<div class="tab">
	   		<span onclick="odChange(this,'enter')" class="act">进&nbsp;&nbsp;站</span>
			<span onclick="odChange(this,'exit')">出&nbsp;&nbsp;站</span>
	    </div>
  	</div>
  	<div <% if("true".equals(viewFlag)){ %>style="height:87%;width:100%;"<%}else{ %>style="height:520px;width:1200px;"<%} %>>
  		<div id="mainFluxCompare" <% if("true".equals(viewFlag)){ %>style="height:100%;width:100%;"<%}else{ %>style="height:500px;width:900px;float:left;"<%} %>></div>
  		<div id="fluxCompareText" style="float:right;width:290px;height:500px;padding-bottom:100px;display:none;font-size:20px;">
  			截止 <span id="hoursId"></span>（不含通勤）<br>
  			输送<span id="totalTimesId" class="numText"></span>人次<br>
  			徐泾东:<span id="xjdTimesId" class="numText1"></span>人次<br>
  			诸光路:<span id="zglTimesId" class="numText1"></span>人次<br>
  			虹桥火车站:<span id="hqTimesId" class="numText1"></span>人次<br><br>
  			观展客流<span id="selfTimesId" class="numText"></span>人次<br>
  			地铁占比<span id="perTimesId" class="numText"></span>
  		</div>
  	</div>
  	<div style="height:5%;width:100%;" id="selBtnId">
  		<div style="float: left;width:10%;">
  			<input type="button" value=">>" class="btn" style="font-weight: bold"><input type="checkbox" onclick="showText(this)">
  		</div>
	  	<div id="paramsId" style="float:right;width:90%;display:none;">
	  		<form id="form1">
			   <table border="0">
				 <tr>
					<td>
						<input type="hidden" name="start_date" id="start_date" style="width:80px;">&nbsp;
						对比因子:
						<input type="radio" value="workday" name="selFlag">工作日日均&nbsp;
						<input type="radio" value="holiday" name="selFlag">休息日日均&nbsp;
						<input type="radio" value="self" name="selFlag" checked="checked">自定日期<input type="text" name="com_date" id="com_date" style="width:80px;">&nbsp;
						<input type="button" value="查询" onclick="getData()">
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
	    	$("#com_date").val("<%=com_date%>");
	    	
		    makedate();
			var viewFlag="<%=viewFlag%>";
			if(viewFlag=="true"){
				$("#selBtnId").hide();
				$("#mainFluxCompare").css("height","100%");
			}
			getData();
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
                $("#com_date").val(aweekdate);
		  }
	    
	    var option = {
		    legend: {
		        x : 'center',
		        y : 'bottom',
		        textStyle:{fontSize:16,fontWeight:'bold',color:'#fff'},
		        data:[]
		    },
	   		tooltip : {
	   	        trigger: 'item',
	   	     	textStyle: {fontWeight:'bold',fontSize:20},
	   	        formatter: "{a} <br/>{b} : {c} ({d}%)"
	   	    },
   		    series : [
   		    	{
   		            name:"客流",
	   		        type:'pie',
	   		     	radius : '75%',
	   	            center : ['50%','47%'],
	   	            //roseType : 'area',
	   	         	label: {
		               normal: {
							show: true,
							textStyle: {
								color:'#ffffff',
								fontWeight:'bold',
								fontSize:16 //文字的字体大小
							},
							position:'outer'
		                }
		            },
		            labelLine: {
		                normal: {
		                    lineStyle: {
		                        color: 'rgba(255, 255, 255, 0.3)'
		                    },
		                    smooth: 0.2,
		                    length: 5,
		                    length2:10
		                }
		            },
		             itemStyle: {
		                 normal: {
		                    color: function(params){  
		                        //自定义颜色
                      			var colorList = ['#ff7f50', '#87cefa', '#da70d6', '#32cd32', '#6495ed','#ff69b4', '#ba55d3', '#cd5c5c', '#ffa500', '#40e0d0','#1e90ff', '#ff6347', '#7b68ee', '#00fa9a', '#ffd700','#6b8e23'];
                          		return colorList[params.dataIndex]; 
		                    }  
		                } 
		            },  
   		            data:[]
   		        }
   		    ]
   		};
	    
	    var myChart=echarts.init(document.getElementById('mainFluxCompare'));
	    var times;
	    function getData(){
	    	$("#paramsId").hide();
            this.value = ">>";
            
            getStationFlux();//加载车站od
	    }
	    
	    //加载车站od
	    function getStationFlux(){
	    	$.post("station/get_fluxcompare.action",$("#form1").serialize(),function(dt){
	    		times=dt;
	    		changChart("enter");
	    		
	    		parent.notifyifram("fluxCom",times);
	    	});
	    }
	    
	    function dataRefresh(param){
	    	times=param;
	  		changChart("enter");
	  	}
	  	
	    function showText(obj){
	    	if($(obj).is(':checked')){
	    		$("#fluxCompareText").show();
	    	}else{
	    		$("#fluxCompareText").hide();
	    	}
	    }
	  	//切换车站和线路的od客流
	  	function odChange(obj,flag){
	  		$(obj).siblings().removeClass("act");
	  		$(obj).addClass("act");
	  		
	  		changChart(flag);
	  	}
	  	
	  	function changChart(flag){
	  		var total_times=0;
	  		var self_times=1;
	  		var hours="";
    		option.series[0].data=[];
    		option.legend.data=[];
	  		if(flag=="enter"){
	  			$.each(times,function(i,v){
	  				option.legend.data.push(v.STATION_NM_CN);
	  				option.series[0].name="进站";
	    			option.series[0].data.push({value:v.ENTER_TIMES, name:v.STATION_NM_CN});
	    			
	    			if(v.ENTER_TIMES>0){
	    				total_times+=v.ENTER_TIMES;
	    			}
	    			
	    			if(v.STATION_NM_CN=="徐泾东"){
	    				$("#xjdTimesId").html(v.ENTER_TIMES);
	    			}else if(v.STATION_NM_CN=="诸光路"){
	    				$("#zglTimesId").html(v.ENTER_TIMES);
	    			}else if(v.STATION_NM_CN=="虹桥火车站"){
	    				$("#hqTimesId").html(v.ENTER_TIMES);
	    			}
	    			
	    			self_times=v.SELF_TIMES;
	    			hours=v.HOURS;
	    		});
		    	myChart.setOption(option, true);
		    	
	  		}else if(flag=="exit"){
	  			$.each(times,function(i,v){
	  				option.legend.data.push(v.STATION_NM_CN);
	  				option.series[0].name="出站";
	    			option.series[0].data.push({value:v.EXIT_TIMES, name:v.STATION_NM_CN});
	    			
	    			if(v.EXIT_TIMES>0){
	    				total_times+=v.EXIT_TIMES;
	    			}
	    			if(v.STATION_NM_CN=="徐泾东"){
	    				$("#xjdTimesId").html(v.EXIT_TIMES);
	    			}else if(v.STATION_NM_CN=="诸光路"){
	    				$("#zglTimesId").html(v.EXIT_TIMES);
	    			}else if(v.STATION_NM_CN=="虹桥火车站"){
	    				$("#hqTimesId").html(v.EXIT_TIMES);
	    			}
	    			
	    			self_times=v.SELF_TIMES;
	    			hours=v.HOURS;
	    		});
		    	myChart.setOption(option, true);
	  		}
	  		
	  		$("#hoursId").html(hours);
	  		$("#totalTimesId").html(total_times);
	  		$("#selfTimesId").html(self_times);
	  		$("#perTimesId").html((total_times/self_times*100).toFixed(2)+"%");
	  	}
    </script>
  </body>
</html>