<%@ page language="java" import="java.util.*,java.text.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

  	SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
  	Calendar calendar = Calendar.getInstance(); 
    calendar.setTime(new java.util.Date());
    
  	String start_date=df.format(calendar.getTime()); 
  	
  	calendar.add(Calendar.DAY_OF_MONTH, -7);
  	String com_date=df.format(calendar.getTime()); 
%>
<!DOCTYPE html>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>区域在网客流</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" href="resource/font-awesome/css/font-awesome.min.css">
	<script src="resource/jquery/js/jquery-1.7.2.js"></script>
	<script src="resource/svg/jquery.mousewheel.min.js"></script>
	<script src="resource/svg/snap.svg-min.js"></script>
	<script src="resource/inesa/js/common.js"></script>
	<style type="text/css">
    	html, body {
			margin: 0;
			padding: 0;
			height: 100%;
		    width: 100%;
		    overflow: hidden;
		    background-color:#132537;
		}
		.overlay{
			background-color: rgba(0, 0, 0, 0.3);
			position: absolute;
		    z-index: 10000;
		    margin: 0;
		    top: 0;
		    right: 0;
		    bottom: 0;
		    left: 0;
		    -webkit-transition: opacity .3s;
		    transition: opacity .3s;
		}
		
		.overlay div{
			top: 50%;
		    margin-top: -21px;
		    width: 100%;
		    text-align: center;
		    position: absolute;
		}
		#rangFlux{
			display:none;
			opacity: 0.7;
			filter:alpha(opacity=70);
			position:absolute;
			z-index:1;
			height:400px;
			width:205px;
    		top: 10px;
    		right: 5px;
    		font-family: '微软雅黑';
    		font-size: 14px;
    	}
    	.rangcon{
    		height:26px;
    		padding-left:47px;
    		background:url('resource/images/float2.png') no-repeat -25px 0px;
    		color:#FFFFFF;
    	}
    	.rangconlast{
    		height:20px;
    		background:url('resource/images/float3.png') no-repeat -25px -20px;
    		padding-left:47px;
    		color:#FFFFFF;
    	}
    </style>
  </head>
  
  <body>
  	  <!-- 图形 start -->
  	  <div id="svgDiv" style="height:100%;width:100%;z-index: 0;"></div>
  	  <!-- 图形 end -->
  	  
  	  <!-- 鼠标悬浮提示框 start -->
      <div id="myDialog" style="display:none;position:absolute;top:0px;left:0px;border:1px solid #dddddd;background:#FFFFFF;z-index:2;padding:5px;min-height:60px;min-width:170px;">
      	<div id="lineName" style="font-family: '微软雅黑';font-size:12px;color:#FFFFFF;background-color:#40e0d0;width:45px;"></div>
    	<div id="lineNameBg" style="height:2px;width:100%;background-color:#40e0d0;">&nbsp;</div>
    	<div id="odFlux" style="font-family: '微软雅黑';font-size:16px;font-weight: bold;margin-top:10px;"></div>
      </div>
      <!-- 鼠标悬浮提示框 end -->
      
      <div style="position:absolute;z-index:2;top:10px;left:5px;" onclick="showParam();">
      	<i class="fa fa-search fa-2x" style="color:#3388FF"></i>
      </div>
      <!-- 右侧悬浮框 start -->
      <div id="rangFlux">
      	<div style="background:url('resource/images/float1.png') no-repeat -25px -25px;height:170px;">
      		<div style="font-size:14px;font-weight:bold;padding:10px 0px 0px 45px;height:50px;">
      			<div id="totalStation" style="font-size:25px;">区域在网客流</div>
      			<div id="totalContent"></div>
      		</div>
      		<div id="totalTitle" style="font-size:12px;font-weight:bold;text-align: right;padding-right:25px;"></div>
      		<div id="rankTitle" style="font-size:12px;font-weight:bold;margin-top:77px;padding-left:40px;"></div>
      	</div>
      	<div id="rankStation"></div>
	  </div>
	  <!-- 右侧悬浮框 end -->
      
	  <!-- 查询条件 start -->
	  <div id="paramId" style="display:none;position:absolute;z-index:1;top:10px;left:20%;background:none repeat scroll 0 0 #D0DFFB;height:60px;width:800px;font-family: '微软雅黑';">
	  	<table height="60px" width="100%">
	  		<tr>
	  			<td>日期:<input id="start_date" style="width:130px;" value="<%=start_date %>"/></td>
	  			<td>
	  				对比日期:<input id="com_date" style="width:130px;" value="<%=com_date %>"/>&nbsp;&nbsp;
	  				起止时间:<select id="start_hour" style="width:40px;">
	  					<option value="00">00</option>
	  					<option value="01">01</option>
	  					<option value="02">02</option>
	  					<option value="03">03</option>
	  					<option value="04">04</option>
	  					<option value="05">05</option>
	  					<option value="06">06</option>
	  					<option value="07">07</option>
	  					<option value="08">08</option>
	  					<option value="09">09</option>
	  					<option value="10">10</option>
	  					<option value="11">11</option>
	  					<option value="12">12</option>
	  					<option value="13">13</option>
	  					<option value="14">14</option>
	  					<option value="15">15</option>
	  					<option value="16">16</option>
	  					<option value="17">17</option>
	  					<option value="18">18</option>
	  					<option value="19">19</option>
	  					<option value="20">20</option>
	  					<option value="21">21</option>
	  					<option value="22">22</option>
	  					<option value="23">23</option>
	  				</select>
	  				<select id="start_min" style="width:40px;">
	  					<option value="00">00</option>
	  					<option value="05">05</option>
	  					<option value="10">10</option>
	  					<option value="15">15</option>
	  					<option value="20">20</option>
	  					<option value="25">25</option>
	  					<option value="30">30</option>
	  					<option value="35">35</option>
	  					<option value="40">40</option>
	  					<option value="45">45</option>
	  					<option value="50">50</option>
	  					<option value="55">55</option>
	  				</select>
	  				--
	  				<select id="end_hour" style="width:40px;">
	  					<option value="00">00</option>
	  					<option value="01">01</option>
	  					<option value="02">02</option>
	  					<option value="03">03</option>
	  					<option value="04">04</option>
	  					<option value="05">05</option>
	  					<option value="06">06</option>
	  					<option value="07">07</option>
	  					<option value="08">08</option>
	  					<option value="09">09</option>
	  					<option value="10">10</option>
	  					<option value="11">11</option>
	  					<option value="12">12</option>
	  					<option value="13">13</option>
	  					<option value="14">14</option>
	  					<option value="15">15</option>
	  					<option value="16">16</option>
	  					<option value="17">17</option>
	  					<option value="18">18</option>
	  					<option value="19">19</option>
	  					<option value="20">20</option>
	  					<option value="21">21</option>
	  					<option value="22">22</option>
	  					<option value="23">23</option>
	  				</select>
	  				<select id="end_min" style="width:40px;">
	  					<option value="00">00</option>
	  					<option value="05">05</option>
	  					<option value="10">10</option>
	  					<option value="15">15</option>
	  					<option value="20">20</option>
	  					<option value="25">25</option>
	  					<option value="30">30</option>
	  					<option value="35">35</option>
	  					<option value="40">40</option>
	  					<option value="45">45</option>
	  					<option value="50">50</option>
	  					<option value="55">55</option>
	  				</select>
	  			</td>
	  		</tr>
	  		<tr>
	  			<td style="border-top:1px solid #FFFFFF;" >
	  				线路:<select id="line_id"></select>
	  			</td>
	  			<td style="border-top:1px solid #FFFFFF;">
	  				起止车站:<select id="station_id" style="width:160px;"></select> -- <select id="station_id2" style="width:160px;"></select>
	  				<input type="button" value="查询" onclick="sel_onflux()"/>
	  			</td>
	  		</tr>
	  	</table>
	  </div>
      <!-- 查询条件 end -->
      
      <div id="overlayId" style="display: none;" class="overlay">
      	 <div>
      	 	<img src="resource/images/loading.gif">
      	 	<p style="color: #409EFF;font-size:12px;">数据加载中......</p>
      	 </div>
      </div>
      
      <script type="text/javascript">
      	var show_statons_flag=true;
      	//控制级别要显示的车站
      	var show_statons=["巨峰路","耀华路","陕西南路","隆德路","虹桥火车站","曹杨路","长寿路","曲阜路","上海南站","宜山路","蓝村路","大木桥路","新天地","高科西路",
      		"人民广场","静安寺","世纪大道","龙漕路","镇坪路","中潭路","虹口足球场","大连路","西藏南路","东方体育中心","嘉善路","马当路",
      		"龙华中路","陆家浜路","南京东路","天潼路","漕宝路","徐家汇","汉中路","老西门","莘庄","虹桥路","东安路","罗山路","肇嘉浜路","嘉定新城",
      		"江苏路","龙阳路","海伦路","四平路","上海体育馆","常熟路","中山公园","延安西路","金沙江路","上海火车站","宝山路","交通大学","龙华"];
      	
      	//显示或隐藏查询条件
      	function showParam(){
      		if($("#paramId").is(":hidden")){
      			$("#paramId").show();
      		}else{
      			$("#paramId").hide();
      		}
      	}
      	
      	var s;
      	var svg;
      	$(function(){
      		//加载svg文件
      		loadSvg();
      		
      		getJson("sysmanage/search_linestationall.action",function(lineData){
				$("#line_id").empty();
				$.each(lineData.line,function(i,v){
					$("#line_id").append("<option value='"+v[0]+"'>"+v[1]+"</option>");
					if(i==0){
						var stations_str="";
						$.each(lineData.station,function(j,l){
							if(v[0]==l.lineId){
								stations_str+="<option value='"+l.stationId+"'>"+l.stationName+"</option>";
							}
						});
						$("#station_id").html(stations_str);
						$("#station_id2").html(stations_str);
					}
				});
				
				$("#line_id").change(function(){
					var tp=$(this).val();
					var stations_str="";
					$.each(lineData.station,function(j,l){
						if(tp==l.lineId){
							stations_str+="<option value='"+l.stationId+"'>"+l.stationName+"</option>";
						}
					});
					$("#station_id").html(stations_str);
					$("#station_id2").html(stations_str);
				});
			});
      		
      	});
      	
      	//加载svg文件
      	function loadSvg(){
			$("#svgDiv").html("");
      		s = Snap("#svgDiv");
      		//加载svg文件
      		Snap.load("pages/svg/stations.svg", function (f) {
			    svg = f.select("svg");
			    s.append(svg);
			    svg.select("g").drag();//设置拖拽
				if(!is_first){
					svg.selectAll("circle").attr({opacity:".2",fillOpacity:"1"});
			    	svg.selectAll("path").attr({opacity:".1",fillOpacity:".1"});
			    	svg.selectAll("text").attr({opacity:".1",fillOpacity:".1"});
				}
		    });
      		
      		//设置鼠标滚动图像进行放大和缩小
      		var m = new Snap.Matrix();
	        $('#svgDiv').bind('mousewheel', function(event, delta, deltaX, deltaY) {
	        	if (delta>0) {//鼠标向上滚动
			        m.scale(1.2, 1.2);
			    }else{//鼠标向下滚动
			    	if(m.a>0.5){
			    		m.scale(0.8, 0.8);
			    	}
			    }
	        	if(show_statons_flag){
	        		if(m.a<1){
		        		svg.selectAll("text").attr({opacity:".1",fillOpacity:".1"});
		        		$.each(show_statons,function(i,v){
		        			Snap.select("#"+v+"t").attr({opacity:"1",fillOpacity:"1"});
		        		});
		        	}else{
		        		svg.selectAll("text").attr({opacity:"1",fillOpacity:"1"});
		        	}
	        	}
	        	
	        	svg.select("g").transform(m);
			});
      	}
      	
      	var is_first=true;
      	var selOd,selTime,selDate,selComDate;
      	//查询在网客流和车站的相关数据，并设置图像显示效果
      	function sel_onflux(){
      		selOd=$("#station_id").find("option:selected").text()+"~"+$("#station_id2").find("option:selected").text();
      		selTime=$("#start_hour").val()+":"+$("#start_min").val()+"~"+$("#end_hour").val()+":"+$("#end_min").val();
      		var dt=$("#start_date").val();
      		var dt1=$("#com_date").val();
      		selDate=dt.substring(0,4)+"/"+dt.substring(4,6)+"/"+dt.substring(6,8);
      		selComDate=dt1.substring(0,4)+"/"+dt1.substring(4,6)+"/"+dt1.substring(6,8);
      		
      		$("#overlayId").show();
      		var params={
      			"start_date":dt,
      			"com_date":dt1,
      			"start_time":$("#start_hour").val()+$("#start_min").val()+"00",
      			"end_time":$("#end_hour").val()+$("#end_min").val()+"00",
      			"station_id":$("#station_id").val(),
      			"station_id2":$("#station_id2").val()
      		};
      		
		    //将查询条件隐藏
		    $("#paramId").hide();
		    
		    if(!is_first){
		    	loadSvg();
		    }
		    is_first=false;
		    show_statons_flag=false;
		    
      		//设置透明
		    svg.selectAll("circle").attr({opacity:".2",fillOpacity:"1"});
		    svg.selectAll("path").attr({opacity:".1",fillOpacity:".1"});
		    svg.selectAll("text").attr({opacity:".1",fillOpacity:".1"});
		    
		    //请求断面相关数据
		    doPost("station/get_online_flux.action",params,function(data){
		    	$("#overlayId").hide();
		    	//显示右侧悬浮框内容
		    	showOdContent(data);
		    	
		    	$.each(data,function(i,v){
	    			var tp=v.STATION1.toString().split("-");//将断面分割，获取车站
		    		//设置车站站点的透明度
		    		Snap.select("#"+tp[0]).attr({opacity:"1",fillOpacity:"1"});
		    		Snap.select("#"+tp[1]).attr({opacity:"1",fillOpacity:"1"});
		    		//设置车站名称的透明度
		    		Snap.select("#"+tp[0]+"t").attr({opacity:"1",fillOpacity:"1"});
		    		Snap.select("#"+tp[1]+"t").attr({opacity:"1",fillOpacity:"1"});
	    			
		    		var station1=Snap.select("#"+v.STATION1);
		    		var station2=Snap.select("#"+v.STATION2);
		    		
		    		//判断断面是否和线条的id相符
		    		if(station1){
		    			//设置线条的透明度和鼠标悬浮事件、鼠标移出事件
		    			station1.attr({strokeWidth:"5",opacity:"1",fillOpacity:"1"}).mouseover(function (e) {
		    				showMyDialog(e,v,station1);
			            }).mouseout(function(){
			            	$("#myDialog").css("display","none");
			            });
		    		}else if(station2){//如果断面和线条不相符，把断面反向调整，再次判断是否存在
		    			//设置线条的透明度和点击事件
		    			station2.attr({strokeWidth:"5",opacity:"1",fillOpacity:"1"}).mouseover(function (e) {
			                showMyDialog(e,v,station2);
			            }).mouseout(function(){
			            	$("#myDialog").css("display","none");
			            });
		    		}
		    		
		    		add_animate(v.STATION1,v.STATION2);
		    	});
		    });
      	}
      	
      	//显示右侧悬浮框内容
      	function showOdContent(data){
      		$("#totalContent").html("时间："+selTime);
      		$("#rankTitle").html(selOd);
      		
      		var tp_ht="";
      		tp_ht+="<div class='rangcon'>"+selDate+"："+data[0].TOTAL_TIMES+"</div>";
      		tp_ht+="<div class='rangcon'>"+selComDate+"："+data[0].COM_TOTAL_TIMES+"</div>";
        	tp_ht+="<div class='rangconlast'>&nbsp;</div>";
        	$("#rankStation").html(tp_ht);
      		
      		$("#rangFlux").show();
      	}
      	
      	//显示提示框
      	function showMyDialog(e,v,station){
      		var d_width=$("#myDialog").width();
      		var d_height=$("#myDialog").height();
      		var xPos;
      		var yPos;
      		//设置提示框的位置
      		if(d_width+e.pageX+15>=$(window).width()){
      			xPos = parseInt(e.pageX-15-d_width) + "px";
      		}else{
      			xPos = parseInt(e.pageX+12) + "px";
      		}
      		if(d_height+e.pageY+5>=$(window).height()){
      			yPos = parseInt(e.pageY-d_height-5) + "px";
      		}else{
      			yPos = e.pageY + "px";
      		}
      		
            $("#myDialog").css("left", xPos).css("top", yPos).show();
            //设置提示框的标题和背景色
            $("#lineName").css("background-color",station.attr().stroke).css("width","45px").html(station.attr().lineid+"号线").show();
            $("#lineNameBg").css("background-color",station.attr().stroke).show();
            
            var context="断面名称："+v.STATION1+"<br/>"+selDate+"："+v.TIMES+"<br/>"+selComDate+"："+v.COM_TIMES;
            
            $("#odFlux").html(context);
      	}
      	
      	
        //添加动画
      	function add_animate(obj1,obj2){
      		var fragment;
		    var tp_str;
		    
		    var station1=Snap.select("#"+obj1);
			var station2=Snap.select("#"+obj2);
		    if(station1){
		    	//获取线条的坐标
    			tp_str=Snap.parsePathString(Snap.select("#"+obj1)).toString();
    			//设置两个动画
    			fragment = Snap.parse('<circle cx="0" cy="0" r="2" stroke="#FFFFFF" stroke-width="1" fill="#FFFFFF"><animateMotion path="'+tp_str.substring(0,tp_str.length-3)+'" begin="0s" dur="4s" rotate="auto" repeatCount="indefinite"/></circle>');
    			svg.select("g").add(fragment);
    			fragment = Snap.parse('<circle cx="0" cy="0" r="2" stroke="#FFFFFF" stroke-width="1" fill="#FFFFFF"><animateMotion path="'+tp_str.substring(0,tp_str.length-3)+'" begin="2s" dur="4s" rotate="auto" repeatCount="indefinite"/></circle>');
    			svg.select("g").add(fragment);
		    }else if(station2){
		    	//获取线条的坐标
    			var points=Snap.parsePathString(Snap.select("#"+obj2));
    			//把线条的坐标反向重取
    			var tp_p="";
    			for(var j=points.length-4;j>=0;j--){
   					if(j==points.length-4){
   						tp_p+="M "+points[j][1]+","+points[j][2]+" ";
   					}else if(j==0){
   						tp_p+=points[j][1]+","+points[j][2]+" ";
   					}else{
   						if(points[j][0]=="Q"){
   							tp_p+=points[j][0]+points[j][1]+","+points[j][2]+" ";
   						}else{
   							tp_p+=points[j][1]+","+points[j][2]+" ";
   						}
   						
   					}
   				}
    			
    			//设置两个动画
    			fragment = Snap.parse('<circle cx="0" cy="0" r="2" stroke="#FFFFFF" stroke-width="1" fill="#FFFFFF"><animateMotion path="'+tp_p+'" begin="0s" dur="4s" rotate="auto" repeatCount="indefinite"/></circle>');
   				svg.select("g").add(fragment);
   				fragment = Snap.parse('<circle cx="0" cy="0" r="2" stroke="#FFFFFF" stroke-width="1" fill="#FFFFFF"><animateMotion path="'+tp_p+'" begin="2s" dur="4s" rotate="auto" repeatCount="indefinite"/></circle>');
   				svg.select("g").add(fragment);
		    }
      	}
      	
      </script>
  </body>
</html>