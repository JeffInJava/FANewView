<%@ page language="java" import="java.util.*,java.lang.*,net.sf.json.*,java.sql.*,java.io.*,java.text.*" pageEncoding="UTF-8"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<%	
	String start_date1=request.getParameter("com_date1");
  	String start_date2=request.getParameter("com_date2");
  	String com_date1=request.getParameter("start_date1");
  	String com_date2=request.getParameter("start_date2");
  	String viewFlag=request.getParameter("viewFlag");
  	
  	SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
  	Calendar calendar = Calendar.getInstance(); 
	if(start_date1==null||start_date2==null){
		start_date1=df.format(new java.util.Date()); 
		start_date2=start_date1; 
	}   
	if(com_date1==null){
		calendar.setTime(new java.util.Date());
		calendar.add(Calendar.DAY_OF_MONTH, -7);  
		com_date1=df.format(calendar.getTime());
		com_date2=com_date1;
	}
%>
  <head>
	<base href="<%=basePath%>">
	<title>自定义车站客流</title>
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
	</style>
  </head>
  
  <body style="color:#FFFFFF;">
  	<div id="mainStationModel" <% if("true".equals(viewFlag)){ %>style="height:88%;width:100%;"<%}else{ %>style="height:500px;width:1200px;"<%} %>></div>
  	<div style="height:12%;width:100%;" id="selBtnId">
  		<div style="float: left;width:6%;">
  			<input type="button" value=">>" class="btn" style="font-weight: bold">
  		</div>
	  	<div id="paramsId" style="float:right;width:94%;display: none;">
	  		<form id="form1">
			   <table border="0">
				 <tr>
					<td>
						查询日期：
							<input type=text name="start_date1" id="start_date1" style="width:80px;">-<input type=text name="start_date2" id="start_date2" style="width:80px;">
					 </td>
					 <td >开始时间：
					              <select name="fir_hour" id="fir_hour">
										<option value="00">全天</option>
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
										<option value="a00">+00</option>
										<option value="a01">+01</option>
										<option value="a02">+02</option>
									</select>
									<select name="fir_min" id="fir_min">
										<option value="00">00</option>
										<option value="30">30</option>
									</select>
					 </td>
					  <td>
							模&nbsp;&nbsp;板：<select name="model_id" id="model_id"></select>
					  </td>
					  <td>
			                 <input type="checkbox" name="flag" value="1" checked="checked">进站</input>
							 <input type="checkbox" name="flag" value="2" >出站</input>
							 <input type="checkbox" name="flag" value="3" checked="checked">换乘</input> 
							 <select name="avg_total"  id="avg_total" >  
								  <option value="avg">均值</option>
								  <option value="total">总和</option>
							</select>
					</td>
			      </tr>
				  <tr>
				  	 <td>
						对比日期：
							<input type=text name="com_date1" id="com_date1" style="width:80px;">-<input type=text name="com_date2" id="com_date2" style="width:80px;">
					 </td>
					 <td >结束时间：
									<select name="sec_hour" id="sec_hour">
										<option value="24">全天</option>
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
										<option value="a00">+00</option>
										<option value="a01">+01</option>
										<option value="a02">+02</option>
									</select>
									<select name="sec_min" id="sec_min">
										<option value="00">00</option>
										<option value="30">30</option>
									</select>
					</td>
					<td>
							二级模板：<select name="addr_id"  id="addr_id" > 
								  <option value="全部">全部</option>
							</select>
					</td>
					<td>
						日期类型：<select name="date_flag"  id="date_flag" >  
								  <option value="">全部</option>
								  <option value="1">工作日</option>
								  <option value="2">双休日</option>
							</select>	
						<input type="button" value="查询" onclick="search()">
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
	    	
	    	$("#start_date1").val("<%=start_date1%>");
			$("#start_date2").val("<%=start_date2%>");
			$("#com_date1").val("<%=com_date1%>");
			$("#com_date2").val("<%=com_date2%>");
		    makedate();
			var viewFlag="<%=viewFlag%>";
			if(viewFlag=="true"){
				$("#selBtnId").hide();
				$("#mainStationModel").css("height","100%");
			}
			
			initParam();//初始化模板参数
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
                		console.log('当前修改天：'+date);
                		 }
                var year = date.getFullYear();
               console.log('当前修改年：'+year); 
                var month = (date.getMonth() + 1).toString();;
                console.log('当前修改月：'+month); 
                var strDate = date.getDate().toString();
                 if(month >= 1 && month <= 9){
                    month = "0" + month;
                }
                 
                if (strDate >= 0 && strDate <= 9) {
                    strDate = "0" + strDate;
                }
                 console.log('当前修改ri：'+strDate); 
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
                
                console.log('对比日期修改ri：'+cpmonth); 
                var nowMin= new Date().getMinutes();     //获取当前分钟数(0-59)
                //var nowHours= new Date().getHours().toString();       //获取当前小时数(0-23)
                
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
                console.log('修改后日期：'+adate+'xiug'+aweekdate);
                
                  $("#start_date1").val(adate);
			$("#start_date2").val(adate);
			$("#com_date1").val(aweekdate);
			$("#com_date2").val(aweekdate); 
		  
		  }
		   function callparent(){
    	parent.notifyifram("gqz",$("#form1").serialize());
    }
    var dates={'sdate1':'','sdate2':'','cdate1':"",'cdate2':''};
    function upDate(param){
    	 //$("#start_date1").val(dates.sdate1);
			//$("#start_date2").val(dates.sdate2);
			//$("#com_date1").val(dates.cdate1);
			//$("#com_date2").val(dates.cdate2); 
    	if(myChart){
				myChart.clear();
			}
    	getData(param);
    };
		  function upData(gqzDate1,gqzDate2){
		  	 $("#start_date1").val(gqzDate1);
			$("#start_date2").val(gqzDate1);
			$("#com_date1").val(gqzDate2);
			$("#com_date2").val(gqzDate2); 
			if(myChart){
				myChart.clear();
			}
		  		initParam();
		  }
		  function  search(){
		  		  dates.sdate1=$("#start_date1").val();
			dates.sdate2=$("#start_date2").val();
			dates.cdate1=$("#com_date1").val();
			dates.cdate2=$("#com_date2").val(); 
		  		
		  		callparent();
		  		getData(false);
		  };
	    function pageZxd(){
	    	$("#selBtnId").show();
	    }
	    
	    function initParam(){
	    	$.post("sysmanage/search_modelall.action",function(data){
		    	$("#model_id").empty();
				var temp=true;
				$.each(data,function(i,v){//一级模板初始化值项
					var tp=i.toString().split("-");
					$("#model_id").append("<option value='"+tp[1]+"'>"+tp[0]+"</option>");
					if(temp){
						$("#addr_id").empty();
						$("#addr_id").append("<option value='全部'>全部</option>");
						$.each(v,function(j,l){//二级模板初始化值项
							$("#addr_id").append("<option value='"+l+"'>"+l+"</option>");
						});
					}
					temp=false;
				});
				
				//一级模板项添加change事件，实现联动
				$("#model_id").change(function(){
					$("#addr_id").empty();
					$("#addr_id").append("<option value='全部'>全部</option>");
					$.each(data[$(this).find("option:selected").text().toString()+"-"+$(this).val()],function(i,v){
						$("#addr_id").append("<option value='"+v+"'>"+v+"</option>");
					});
				});
				
				$("#model_id").val("104");
				//$("#addr_id").val("关注车站");
				
				getData(false);//请求数据并绘制图形
		    });
	    }
	    
	    
	    var low_times;
    	var top_times;
    	var null_time;
    	
    	var myChart;
	    function getData(param){
	    	var params=$("#form1").serialize();
	    	if(param){
	    		params=param;
	    	}
	    	
	    	$("#paramsId").hide();
            this.value = ">>";
            //callparent();
            low_times=[];
        	top_times=[];
        	null_time=[];
	    	$.post("station/getModelFlux.action",params,function(dt){
	    		var dates=dt.dates;
	    		var dateFt0=dates[0];
	       		var dateFt1=dates[1];
	       		
	       		var stations=dt.stations;
	        	var fir_times=dt.fir_times;
	        	var sec_times=dt.sec_times;
	        	var list=dt.list;
	        	
	        	for(var i=0;i<fir_times.length;i++){
	        		null_time.push(0);
	        		if(fir_times[i]>=sec_times[i]){
	        			low_times.push({value:sec_times[i],itemStyle:{normal:{color:'rgba(155,201,99,1)'}},dataFlag:1});
	        			top_times.push({value:(fir_times[i]*10-sec_times[i]*10)/10,itemStyle:{normal:{color:'rgba(254,132,99,0.8)'}}});
	        		}else{
	        			low_times.push({value:fir_times[i],itemStyle:{normal:{color:'rgba(155,201,99,1)'}},dataFlag:-1});
	        			top_times.push({value:(sec_times[i]*10-fir_times[i]*10)/10,itemStyle:{normal:{color:'rgba(207,230,181,0.2)'}}});
	        		}
	        	}
	        	
				var tplable;
		     	if(stations.length>10){
					tplable={interval:0,textStyle: {fontWeight:'bold',fontSize:10,color:'#fff'},rotate:40};
				}else{
					tplable={interval:0,textStyle: {fontWeight:'bold',fontSize:14,color:'#fff'}};
				}
		  	
		     	 myChart = echarts.init(document.getElementById('mainStationModel'));
	        	
		     	option = {
		     			title : {
    				        text:($("#addr_id").val()=="全部"?$("#model_id").find("option:selected").text():$("#addr_id").val())+'客流',
    		        		x:'left',
    		        		textStyle:{fontSize:12,color:'#fff'}
    				    },
		    		    tooltip : {
		    		        trigger: 'axis',
		    		        textStyle: {fontWeight:'bold',fontSize:20},
		    		        formatter: function (params){
		                  	    var tpstr=params[0].name;
		                  		if(params[0].data.dataFlag<0){
		                  				tpstr=tpstr+"<br/>增量：-"+params[1].value+"(万)[-"+(params[1].value/params[0].value*100).toFixed(2)+"%]<br/>"
		                  				+params[1].seriesName+"："+((params[1].value*10+params[0].value*10)/10)
		                  				+"(万)<br/>"+params[0].seriesName+"："+params[0].value+"(万)";
		                  		}else{
		                  				tpstr=tpstr+"<br/>增量：+"+params[1].value+"(万)[+"+(params[1].value/((params[1].value*10+params[0].value*10)/10)*100).toFixed(2)+"%]<br/>"+params[1].seriesName+"："+params[0].value
		                  				+"(万)<br/>"+params[0].seriesName+"："+((params[1].value*10+params[0].value*10)/10)+"(万)";
		                  		}
		    		            return tpstr;
		    		        }
		    		    },
		    		    grid: {
		    				x: 50,
		    				x2:0,
		    				y: 40,
		    				y2:50
		    			},
		    		    legend: {
		    		    	selectedMode:false,
		    		    	x:'center',
		    		    	y:'12',
		    		    	textStyle: {fontSize:12,color:'#fff'},
		    		        data:[
		    		        	    {
		    		  				  	name :dateFt1,
		    		  					icon:"image://resource/echarts/build/dist/img/green.png"
		    						},
		    						{
		    						   name :dateFt0,
		    						   icon:"image://resource/echarts/build/dist/img/greens.png"
		    						},
		    						{
		    						   name :"对比增幅",
		    						   icon:"image://resource/echarts/build/dist/img/red.png"
		    						}
		    					]
		    		    },
		    		    xAxis : [
		    		        {
		    		        	type : 'category',
		    		        	axisLabel:tplable,
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
		    		            data : stations
		    		        }
		    		    ],
		    		    yAxis : [
		    		        {
		    		            type : 'value',
		    		            axisLabel:{
		    		        		formatter:'{value}万',
		    		        		textStyle: {fontSize:12,color:'#fff'}
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
		    		            name:dateFt0,
		    		            type:'bar',
		    		            stack: '增值',
		    		            data:low_times
		    		        },
		    		    	{
		    		            name:dateFt1,
		    		            type:'bar',
		    		            stack: '增值',
		    		            data:top_times
		    		        },
		    				{name:"对比增幅",type:'bar',stack: '增值',data:null_time}
		    		    ]
		    		};
		                  
		    		myChart.setOption(option, true);
		    		
		    		if (!Array.prototype.indexOf)
		    			{
		    			  Array.prototype.indexOf = function(elt /*, from*/)
		    			  {
		    			    var len = this.length >>> 0;
		    			    var from = Number(arguments[1]) || 0;
		    			    from = (from < 0)
		    			         ? Math.ceil(from)
		    			         : Math.floor(from);
		    			    if (from < 0)
		    			      from += len;
		    			    for (; from < len; from++)
		    			    {
		    			      if (from in this &&
		    			          this[from] === elt)
		    			        return from;
		    			    }
		    			    return -1;
		    			  };
		    			}
		    		
		    		myChart.on('click', function (param) {
		    			if(stations.indexOf(param.name)>-1){
		    				var fir_period_times=[];
		    				var sec_period_times=[];
		    				var time_period=[];
		    				for(var i=0;i<list.length;i++){
		    					if(param.name==list[i].station_nm_cn){
		    						if(list[i].fir_times!=null){
			    						if(list[i].fir_times!='0'){
			    							fir_period_times.push(list[i].fir_times);
			    						}
		    						}
		    						if(list[i].sec_times!=null){
		    							if(list[i].sec_times!='0'){
		    								sec_period_times.push(list[i].sec_times);
		    							}
		    						}
		    						
		    						if(list[i].time_period.substring(3)=="00"){
		    							time_period.push(list[i].time_period);
		    						}else{
		    							time_period.push({
		    						        value:list[i].time_period,            
		    						        textStyle:{fontSize:0}
		    						     });
		    						}
		    						
		    					}
		    				}
		    				
		                    option1 = {
		                    	title : {
		    				        text:param.name+'车站客流',
		    		        		x:'left',
		    		        		textStyle:{fontSize:12,color:'#fff'}
		    				    },
		    				    grid: {
		    						x: 50,
		    						x2:0,
		    						y: 40,
		    						y2:50
		    					},
		    				    tooltip : {
		    				        trigger: 'axis',
		    				        textStyle: {fontWeight:'bold',fontSize:20}
		    				    },
		    				    legend: {
		    				    	selectedMode:false,
		    				    	x:'center',
		    				    	y:'12',
		    				    	textStyle: {fontWeight:'bold',fontSize:12,color:'#fff'},
		    				        data:[dateFt1,dateFt0]
		    				    },
		    				    xAxis : [
		    				        {
		    				            type : 'category',
		    				            axisLabel:{textStyle: {fontWeight:'bold',fontSize:12,color:'#fff'}},
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
		    				            data : time_period
		    				        }
		    				    ],
		    				    yAxis : [
		    				        {
		    				            type : 'value',
		    				            axisLabel:{formatter:'{value}万',textStyle: {fontWeight:'bold',fontSize:12,color:'#fff'}},
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
		    				            name:dateFt1,
		    				            type:'line',
		    				            symbolSize:function(param){
             								if(param!=null){
               									return 2;
             								}
             								return 0;
           						        },
		              					itemStyle:{normal: {color:'rgba(175,239,191,0.2)'}},
		    				            data:sec_period_times
		    				        },
		    				        {
		    				            name:dateFt0,
		    				            type:'line',
		    				            symbolSize:function(param){
               								if(param!=null){
                 								return 2;
               								}
               								return 0;
             						    },
		    				            itemStyle:{normal: {color:'rgba(155,201,99,1)'}},
		    				            data:fir_period_times
		    				        }
		    				    ]
		    				};
		                    myChart.setOption(option1, true);
		                   }else{
		                   	myChart.setOption(option, true);
		                   }
		               });
	        	
	    	});
	    }
	    
       	
        
    </script>
  </body>
</html>