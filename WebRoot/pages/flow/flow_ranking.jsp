<%@ page language="java" import="java.util.*,java.lang.*,com.util.*,net.sf.json.*,java.text.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="zh-CN">
  <head>
  	<title>站点客流排名</title>
    <base href="<%=basePath%>">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="pages/dailysheet/css/bootstrap.css" rel="stylesheet">

	<script src="resource/jquery/js/jquery-1.7.2.js" type="text/javascript"></script>
    <link href="resource/jquery/css/jquery-ui-1.8.11.custom.css" rel="stylesheet" type="text/css" />
    <script src="resource/inesa/js/common.js"></script>
	<script src="resource/echarts/build/dist/echarts.js"></script>
  </head>
  <%
    Calendar cal = Calendar.getInstance();
	String start_date = new SimpleDateFormat("yyyyMMdd").format(cal.getTime());
  %>
  <body>
  	
  	<div class="navbar">
      <div class="navbar-inner">
        <div class="container">
          <form class="navbar-form pull-left">
          	<input class="span2" type="text" name="start_date" id="start_date" placeholder="选择日期" value="<%=start_date %>">
          	
		  	<label class="checkbox inline">
			  <input type="checkbox" name="flux_flag" value="1" checked="checked">进站
			</label>
			<label class="checkbox inline">
			  <input type="checkbox" name="flux_flag" value="2">出站
			</label>
			<label class="checkbox inline">
			  <input type="checkbox" name="flux_flag" value="3" checked="checked">换乘
			</label>
			<select class="span2" name="line_id" id="line_id">
			  <option value="00">全路网</option>
			 <option value="01">1号线</option>
			  <option value="02">2号线</option>
			  <option value="03">3号线</option>
			  <option value="04">4号线</option>
			  <option value="05">5号线</option>
			  <option value="06">6号线</option>
			  <option value="07">7号线</option>
			  <option value="08">8号线</option>
			  <option value="09">9号线</option>
			  <option value="10">10号线</option>
			  <option value="11">11号线</option>
			  <option value="12">12号线</option>
			  <option value="13">13号线</option>
			  <option value="16">16号线</option>
			</select>
			<select class="span2" name="ranking" id="ranking">
			  <option value="5">排名前5</option>
			  <option value="10" selected="selected">排名前10</option>
			  <option value="20">排名前20</option>
			</select>
  			<button class="btn" type="button" onclick="loadStationRankData()">查询</button>
		  </form>
        </div>
      </div>
    </div>
	
	<div style="margin:0px;padding:0px;width: 100%;">
		<div id="mainStationRank" style="height: 600px;width: 100%;"></div>
	</div>
	
    <script type="text/javascript">
    	//加载车站客流排名数据
    	function loadStationRankData(){
		
    		var start_date=$("#start_date").val();//选择日期
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
    		
    		var line_id=$("#line_id").val();//选择线路
    		var ranking=$("#ranking").val();//排名
    		doPost("station/get_station_fluxrank.action", {"start_date":start_date,"flux_flag":tp}, function(data){
    			makeStationReport(line_id,ranking,data);
    			
    			//添加chang事件
    			$("#line_id").change(function(){
					makeStationReport($("#line_id").val(),$("#ranking").val(),data);
				});
    			$("#ranking").change(function(){
					makeStationReport($("#line_id").val(),$("#ranking").val(),data);
				});
    		});
    	}
    	
    	stationRankOption = {
	        title : {
		        text: '车站客流排名',
		        x:'center',
		        textStyle:{fontSize:20,fontWeight:'bolder'}
		    },
		    tooltip : {
		        trigger: 'axis',
		        textStyle: {fontWeight:'bold',fontSize:22},
		        axisPointer : {            
		            type : 'shadow'  
		        }
		    },
		    calculable : true,
		    grid : {'y':40,'y2':80,'x':80,'x2':60},
		    xAxis : [
		        {
		            type:'category',
		            axisLabel:{},
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
		            name:'客流',
		            type:'bar',
		            itemStyle : { normal: {label : {show: true, position: 'top'}}},
		            data:[]
		        }
		    ]
		};
    	
    	//绘制图表
    	function makeStationReport(line_id,ranking,data){
    		stationRankOption.xAxis[0].data=[];
    		stationRankOption.series[0].data=[];
    		if(ranking=='20'){
				stationRankOption.xAxis[0].axisLabel={interval:0,textStyle: {fontWeight:'bold',fontSize:18},rotate:-30};
			}else{
				stationRankOption.xAxis[0].axisLabel={interval:0,textStyle: {fontWeight:'bold',fontSize:18}};
			}
    		$.each(data,function(i,v){
    			if(v.LINE_ID==line_id&&parseInt(v.RN)<=parseInt(ranking)){
    				stationRankOption.xAxis[0].data.push(v.STATION_NM);
    				stationRankOption.series[0].data.push(v.TIMES);
    			}
    		});
    		
	    	// 路径配置
	        require.config({
	            paths: {
	                echarts: 'resource/echarts/build/dist'
	            }
	        });
	    	//填充图表数据
		  	require(
		      [
		          'echarts',
		          'echarts/chart/bar'
		      ],
		     function (ec) {
		     	var chartStation = ec.init(document.getElementById('mainStationRank')); 
		     	chartStation.setOption(stationRankOption, true);
		     });
    	}
    </script>

  </body>
</html>