<%@ page language="java" import="java.util.*,java.lang.*,com.util.*,net.sf.json.*,java.text.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
  <head>
  	<title>站点客流增量排名</title>
    <base href="<%=basePath%>">

	<script src="resource/jquery/js/jquery-1.7.2.js" type="text/javascript"></script>
    <link href="resource/jquery/css/jquery-ui-1.8.11.custom.css" rel="stylesheet" type="text/css" />
    <script src="resource/inesa/js/common.js"></script>
	<script src="resource/echarts/build/dist/echarts.js"></script>
	
	<style type="text/css">
    	.dashboard-nav {
		    cursor: pointer;
		    font-size:16px;
		    background-color: #F8F8F8;
		    border-radius: 1rem;
		    display: inline-block;
		    height: 20px;
		    width:260px;
		    vertical-align: middle;
		    
		}
		.dashboard-nav span.active {
		    background-color: #c7cbd6;
		}
		.dashboard-nav span {
		    border-radius: 1rem;
		    padding:3px 15px;
			line-height: 20px;
		}
    </style>
  </head>
  <%
    Calendar cal = Calendar.getInstance();
  	SimpleDateFormat fmt=new SimpleDateFormat("yyyyMMdd");
	String start_date = fmt.format(cal.getTime());
	cal.add(Calendar.DATE,-7);
	String com_date = fmt.format(cal.getTime());
	cal = Calendar.getInstance();
	cal.add(Calendar.YEAR,-1);
	String com_date1 = fmt.format(cal.getTime());
  %>
<body style="margin:0px;padding:0px;">
	<div style="background-color:#c7cbd6;width:100%;">
	   <div style="background-color:#c7cbd6;width:100%;height:4%;display:block;text-align:center;position: relative;">
	   	<span class="dashboard-nav">
	   		<span id="tb" onclick="change('tb')">同&nbsp;比</span>
	   		<span class="active" class="" id="hb" onclick="change('hb')">环&nbsp;比</span>
			<span class="" id="zdy" onclick="change('zdy')">自定义</span>
	   	</span>
	   </div>
	   <div style="height:6%;display:block;position: relative;padding-left:50px;">
	   	<input type="hidden" id="hide_date1" value="<%=com_date %>">
	   	<input type="hidden" id="hide_date2" value="<%=com_date1 %>">
	   	 运营日期:<input type="text" name="start_date" id="start_date" value="<%=start_date %>">
	   	 对比日期:<input type="text" name="com_date" id="com_date" value="<%=com_date %>">
	   	 <input type="checkbox" name="flux_flag" value="1" checked="checked">进站
	   	 <input type="checkbox" name="flux_flag" value="2">出站
	   	 <input type="checkbox" name="flux_flag" value="3" checked="checked">换乘
	   	 <input type="button" value="查询" onclick="loadStationComData()">
	   </div>
   </div>
	<div style="width: 100%;">
		<div id="mainStationZL" style="height: 600px;width: 100%;"></div>
	</div>
	
    <script type="text/javascript">
    	function change(f){
	  		 if(f=="tb"){
	  			 $("#tb").addClass("active");
	  			 $("#hb").removeClass("active");
				 $("#zdy").removeClass("active");
				 $("#com_date").val($("#hide_date2").val());
	  		 }else if(f=="hb"){
	  			 $("#hb").addClass("active");
	  			 $("#tb").removeClass("active");
				 $("#zdy").removeClass("active");
				 $("#com_date").val($("#hide_date1").val());
	  		 }else{
				$("#zdy").addClass("active");
	  			 $("#tb").removeClass("active");
				 $("#hb").removeClass("active");
				 $("#com_date").val("");
			 }
	  	 }
    
    	//加载车站客流排名数据
    	function loadStationComData(){
		
    		var start_date=$("#start_date").val();//选择日期
    		var com_date=$("#com_date").val();//对比日期
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
    		
    		
    		doPost("station/get_station_fluxcompare.action", {"start_date":start_date,"com_date":com_date,"sel_flag":"zl","flux_flag":tp}, function(data){
    			var dateFt0=start_date.substring(0,4)+"/"+start_date.substring(4,6)+"/"+start_date.substring(6);
	    		var dateFt1=com_date.substring(0,4)+"/"+com_date.substring(4,6)+"/"+com_date.substring(6);
	    		var stations=[],times=[],add_times=[],null_times=[];
	    		
	    		stationZLOption.legend.data=[dateFt0,dateFt1,"对比增量"];
	    		stationZLOption.series[0].name=dateFt0;
	    		stationZLOption.series[1].name=dateFt1;
	    		
	    		$.each(data,function(i,v){
	    			if(v.TIMES>v.COM_TIMES){
		    			times.push({value:v.TIMES,itemStyle:{normal:{color:'rgba(155,201,99,1)'}},dataFlag:1,addrate:v.ADD_PER});
		    			add_times.push({value:v.ADD_TIMES,itemStyle:{normal:{color:'rgba(254,132,99,0.8)'}}});
		    		}else{
		    			times.push({value:v.TIMES,itemStyle:{normal:{color:'rgba(155,201,99,1)'}},dataFlag:-1,addrate:v.ADD_PER});
	    				add_times.push({value:v.ADD_TIMES,itemStyle:{normal:{color:'rgba(207,230,181,0.8)'}}});
		    		}
	    			null_times.push(0);
	    			stations.push(v.STATION_NM);
	    		});
	    		stationZLOption.series[0].data=times;
	    		stationZLOption.series[1].data=add_times;
	    		stationZLOption.series[2].data=null_times;
	    		stationZLOption.xAxis[0].data=stations;
	    		
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
			     	var chartStation = ec.init(document.getElementById('mainStationZL')); 
			     	chartStation.setOption(stationZLOption, true);
			     });
    			
    		});
    	}
    	
    	stationZLOption = {
	        title : {
		        text: '车站客流增量排名',
		        x:'center',
		        textStyle:{fontSize:20,fontWeight:'bolder'}
		    },
		    tooltip : {
		        trigger: 'axis',
		        textStyle: {fontWeight:'bold',fontSize:22},
		        formatter: function (param){
               	        var params=[];params.push(param[1]);params.push(param[2]);
               	        var tpstr=params[0].name;
               			if(params[1].data.dataFlag<0){
               				tpstr=tpstr+"<br/>增量："+params[0].value+"["+params[1].data.addrate+"%]<br/>"+params[1].seriesName+"："+params[1].value
               				+"<br/>"+params[0].seriesName+"："+((params[1].value*10-params[0].value*10)/10);
               			}else{
               				tpstr=tpstr+"<br/>增量：+"+params[0].value+"[+"+params[1].data.addrate+"%]<br/>"+params[1].seriesName+"："+params[1].value
			                +"<br/>"+params[0].seriesName+"："+((params[1].value*10-params[0].value*10)/10);
               			}
			            return tpstr;
			        }
		    },
		    legend: {
		    	selectedMode:false,
		    	x:'center',
		    	y:'30',
		    	textStyle: {fontWeight:'bold',fontSize:18},
		    	data:[]
		    },
		    calculable : true,
		    grid : {'y':50,'y2':30,'x':80,'x2':60},
		    xAxis : [
		        {
		            type:'category',
		            axisLabel:{interval:0,textStyle: {fontWeight:'bold',fontSize:18}},
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
		            name:'',
		            type:'bar',
		            stack: '增值',
		            data:[]
		        },
		    	{
		            name:'',
		            type:'bar',
		            stack: '增值',
		            data:[]
		        },
				{name:"对比增量",type:'bar',stack: '增值',data:[]}
		    ]
		};
    	
    </script>

  </body>
</html>