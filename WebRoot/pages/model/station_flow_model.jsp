<%@ page language="java" import="java.util.*,java.lang.*,net.sf.json.*,java.sql.*,com.util.*,java.io.*,java.text.*" pageEncoding="UTF-8"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<%
	String total_times1="0";
	String total_times2="0";

	String fir_date=request.getParameter("start_date2");
  	String sec_date=request.getParameter("start_date1");
  	String[] enter_flag=request.getParameterValues("flag");//1:进站、2：出站、3：换乘
  	String model_id=request.getParameter("model_id");//模板id
  	String addr_id=request.getParameter("addr_id");//子模板id
  	
  	String model_name=request.getParameter("model_name");
  	String addr_name=request.getParameter("addr_name");
  	if(model_name!=null&&addr_name!=null){
  		model_name=new String(model_name.getBytes("iso-8859-1"),"utf-8");
  		addr_name=new String(addr_name.getBytes("iso-8859-1"),"utf-8");
  	}
  	if(addr_name!=null&&!addr_name.trim().equals("全部")){
  		model_name+="--"+addr_name;
  	}
  	
  	String fir_hour=request.getParameter("fir_hour");
  	String sec_hour=request.getParameter("sec_hour");
  	String fir_min=request.getParameter("fir_min");
  	String sec_min=request.getParameter("sec_min");
  	if("00".equals(fir_hour)||"00".equals(sec_hour)){
  		fir_hour="00";
  		fir_min="00";
  		sec_hour="23";
  		sec_min="59";
  	}
  	
	if(addr_id!=null){
		addr_id=new String(addr_id.getBytes("iso-8859-1"),"utf-8");
	}
  	
	if(fir_date!=null&&fir_date.trim().length()>0&&sec_date!=null&&sec_date.trim().length()>0&&enter_flag!=null&&enter_flag.length>0){
    	for(String tp:enter_flag){
			 if("1".equals(tp.trim())){
				 total_times1+="+nvl(a.enter_times,0)";
				 total_times2+="+nvl(b.enter_times,0)";
			 }else if("2".equals(tp.trim())){
				 total_times1+="+nvl(a.exit_times,0)";
				 total_times2+="+nvl(b.exit_times,0)";
			 }else if("3".equals(tp.trim())){
				 total_times1+="+nvl(a.change_times,0)";
				 total_times2+="+nvl(b.change_times,0)";
			 }
		}
	}
	
%>
  <head>
	<base href="<%=basePath%>">
	<script src="resource/echarts/build/dist/echarts.js"></script>
	<title>区域客流分析</title>
  </head>
  
  <body>
	<div><jsp:include page="../../param/station_pass_show_halfhour_part.jsp" flush="true" /></div>
  	<div id="main" style="height:100%;width: 100%"></div>
  	<%
		
  	Connection con=null;
  	Statement st=null;
    Statement st1=null;
    Statement st2=null;
    ResultSet rs=null;
    ResultSet rs1=null;
    ResultSet rs2=null;
    List<String> stations=new ArrayList();
    List fir_times=new ArrayList();//第一天客流量
    List sec_times=new ArrayList();//第二天客流量
    List addnum=new ArrayList();//增值
    List addrate=new ArrayList();//增幅
    
    List<JSONObject> list=new ArrayList();//两天的客流量
    
    List dates=new ArrayList();
    dates.add(fir_date);
    dates.add(sec_date);
    
    String tpstations="";
    String today="";
    
    try{
    	if(fir_date!=null&&fir_date.trim().length()>0&&sec_date!=null&&sec_date.trim().length()>0&&enter_flag!=null&&enter_flag.length>0){
    		con=BaseDao.getJDBCConnection();
    		 
    		String sql1="select distinct to_char(sysdate,'yyyyMMdd') today,station_nm_cn from TBL_METRO_MODEL_STATION where view_flag='1' and model_id="+model_id;
    		
	   		 if((!"全部".equals(addr_id))&&addr_id!=null){
	   			 sql1+="  and sub_model_name='"+addr_id+"'";
	   		 }
   		 	 st2=con.createStatement();
			 rs2=st2.executeQuery(sql1);
			 while (rs2.next()){
			 	today=rs2.getString("today");
			 }
		
			 SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
	   		 java.util.Date s_date1=df.parse(fir_date);
	   		 java.util.Date s_date2=df.parse(sec_date);
		 	 GregorianCalendar calendar = new GregorianCalendar();
		 	 calendar.setTime(df.parse(today));
			 calendar.add(GregorianCalendar.DAY_OF_MONTH, -60);
			 java.util.Date tempDate = calendar.getTime();
			
			String tp_sql="";
			if((!"全部".equals(addr_id))&&addr_id!=null){
				tp_sql+="  and sub_model_name='"+addr_id+"'";
   		 	}
   		 	if(StringUtils.isNotBlank(today)){
				 st=con.createStatement();  
						 String sqlStr="select a.station_nm_cn,round(("+total_times1+")/10000,1) fir_times,round(("+total_times2+")/10000,1) sec_times from"+
								 " ( select trim(t1.station_nm_cn) station_nm_cn,sum(t2.enter_times) enter_times,sum(t2.exit_times) exit_times,sum(t2.change_times) change_times from "+
								 "  (select line_id,station_id,station_nm_cn from TBL_METRO_MODEL_STATION where view_flag='1' and model_id="+model_id+tp_sql+") t1 join"+
								 "	(select st_no,sum(in_pass_num_1) enter_times,sum(in_pass_num_2) change_times,sum(OUT_PASS_NUM_1) exit_times from tpfcm10 where '"+fir_date+fir_hour+fir_min+"00'<=time_period"+
								 "  and (case when ('"+fir_hour+"'='00' and '"+sec_date+"'=to_char(sysdate,'yyyyMMdd')) then '"+fir_date+"'||to_char(sysdate-30/(24*60),'hh24')||'0000' else '"+fir_date+sec_hour+sec_min+"59' end)>=time_period and '"+fir_date.substring(0, 6)+"' <=query_mon"+ 
								 "  group by st_no) t2 on t1.station_id=t2.st_no group by trim(t1.station_nm_cn) "+
								
								 " ) a, "+
								 " ( select trim(t1.station_nm_cn) station_nm_cn,sum(t2.enter_times) enter_times,sum(t2.exit_times) exit_times,sum(t2.change_times) change_times from "+
								 "  (select line_id,station_id,station_nm_cn from TBL_METRO_MODEL_STATION where view_flag='1' and model_id="+model_id+tp_sql+") t1 join "+
								 "	(select st_no,sum(in_pass_num_1) enter_times,sum(in_pass_num_2) change_times,sum(OUT_PASS_NUM_1) exit_times from tpfcm10 where '"+sec_date+fir_hour+fir_min+"00'<=time_period"+
								 "  and (case when ('"+fir_hour+"'='00' and '"+sec_date+"'=to_char(sysdate,'yyyyMMdd')) then '"+sec_date+"'||to_char(sysdate-30/(24*60),'hh24')||'0000' else '"+sec_date+sec_hour+sec_min+"59' end)>=time_period and '"+sec_date.substring(0, 6)+"' <=query_mon"+ 
								 "  group by st_no) t2 on t1.station_id=t2.st_no group by trim(t1.station_nm_cn) "+
								 
								 
								 " ) b where a.station_nm_cn=b.station_nm_cn order by fir_times desc";
	    		 
				 rs=st.executeQuery(sqlStr);
				 System.out.println("-------sqlStr------"+sqlStr);
				 while (rs.next()){
					 tpstations+="'"+rs.getString("station_nm_cn").trim()+"',";
					 stations.add(rs.getString("station_nm_cn").trim());
					 fir_times.add(rs.getObject("fir_times"));
					 sec_times.add(rs.getObject("sec_times"));
				 }
				 
				 if(tpstations.length()>0){
					 tpstations=tpstations.substring(0,tpstations.length()-1);
				 }
				 
				 String sql="select trim(a.station_nm_cn) station_nm_cn,trim(a.time_period) time_period,round(("+total_times1+")/10000,2) fir_times,round(("+total_times2+")/10000,2) sec_times from "+
					 		" (select t3.station_nm_cn,t1.time_period,sum(enter_times) enter_times,sum(exit_times) exit_times,sum(change_times) change_times from "+
					 		" ("+
							"  select st_no station_id,lpad(substr(time_period,9,2),2,'0')||':'||lpad(trunc(to_number(substr(time_period,11,2))/30,0)*30,2,'0') time_period,"+
							"  sum(in_pass_num_1) enter_times,sum(in_pass_num_2) change_times,sum(OUT_PASS_NUM_1) exit_times from tpfcm10 where query_date='"+fir_date+"' and query_mon='"+fir_date.substring(0, 6)+"'"+
							"  and st_no in (select station_id from TBL_METRO_MODEL_STATION where view_flag='1' and model_id="+model_id+tp_sql+") "+
							"  group by st_no,lpad(substr(time_period,9,2),2,'0')||':'||lpad(trunc(to_number(substr(time_period,11,2))/30,0)*30,2,'0')"+
							"  ) t1 left join"+
							"  ("+
							"   select station_id,trim(station_nm_cn) station_nm_cn from tbl_pw_station_info where station_ver=(select max(station_ver) from tbl_pw_station_info)"+
							"  ) t3 on t1.station_id=t3.station_id"+
							"  where t1.time_period>='05:00'"+
							" group by t3.station_nm_cn,t1.time_period) a left join"+
							" (select t3.station_nm_cn,t1.time_period,sum(enter_times) enter_times,sum(exit_times) exit_times,sum(change_times) change_times from "+
					 		" ("+
							"  select st_no station_id,lpad(substr(time_period,9,2),2,'0')||':'||lpad(trunc(to_number(substr(time_period,11,2))/30,0)*30,2,'0') time_period,"+
							"  sum(in_pass_num_1) enter_times,sum(in_pass_num_2) change_times,sum(OUT_PASS_NUM_1) exit_times from tpfcm10 where query_date='"+sec_date+"' and query_mon='"+sec_date.substring(0, 6)+"'"+
							"  and st_no in (select station_id from TBL_METRO_MODEL_STATION where view_flag='1' and model_id="+model_id+tp_sql+") "+
							"  group by st_no,lpad(substr(time_period,9,2),2,'0')||':'||lpad(trunc(to_number(substr(time_period,11,2))/30,0)*30,2,'0')"+
							"  ) t1 left join"+
							"  ("+
							"   select station_id,trim(station_nm_cn) station_nm_cn from tbl_pw_station_info where station_ver=(select max(station_ver) from tbl_pw_station_info)"+
							"  ) t3 on t1.station_id=t3.station_id"+
							"  where t1.time_period>='05:00'"+
							"  group by t3.station_nm_cn,t1.time_period) b "+
							" on (trim(a.time_period)=trim(b.time_period) and trim(a.station_nm_cn)=trim(b.station_nm_cn)) order by a.time_period";
				 	
				 
				 st1=con.createStatement();
				 rs1=st1.executeQuery(sql);
				 while (rs1.next()){
					JSONObject jsonObj=new JSONObject();
			 		jsonObj.put("station_nm_cn",rs1.getString("station_nm_cn"));
			 		jsonObj.put("time_period",rs1.getString("time_period"));
			 		if(rs1.getObject("fir_times")!=null){
					       jsonObj.put("fir_times",rs1.getObject("fir_times"));
					}
					if(rs1.getObject("sec_times")!=null){
					       jsonObj.put("sec_times",rs1.getObject("sec_times"));
					}
			 		list.add(jsonObj);
				 }
   		 	}
			 
    	}
    }catch(Exception e){
        e.printStackTrace();			 
    }finally{
    	BaseDao.closeAll(null,st2,rs2);
    	BaseDao.closeAll(null,st1,rs1);
    	BaseDao.closeAll(con,st,rs);
    }
	%>
    <script type="text/javascript">
    	var dates=eval('<%=JSONArray.fromObject(dates).toString()%>');
    	var today='<%=today%>';
    	if(today.toString()==""||today.toString()=="null"){
    		alert("当前模板中未有显示图表的车站");
    	}else if(today!=dates[0]){
    		var dateFt0=dates[0].substring(0,4)+"/"+dates[0].substring(4,6)+"/"+dates[0].substring(6);
    		var dateFt1=dates[1].substring(0,4)+"/"+dates[1].substring(4,6)+"/"+dates[1].substring(6);
    		
	    	var stations=eval('<%=JSONArray.fromObject(stations).toString()%>');
	    	var fir_times=eval('<%=JSONArray.fromObject(fir_times).toString()%>');
	    	var sec_times=eval('<%=JSONArray.fromObject(sec_times).toString()%>');
	    	var list=eval('<%=JSONArray.fromObject(list).toString()%>');
	    	
	    	var low_times=[];
	    	var top_times=[];
	    	var null_time=[];
	    	
	    	for(var i=0;i<fir_times.length;i++){
	    		null_time.push(0);
	    		if(fir_times[i]>sec_times[i]){
	    			low_times.push({value:sec_times[i],itemStyle:{normal:{color:'rgba(155,201,99,1)'}},dataFlag:-1});
	    			top_times.push({value:(fir_times[i]*10-sec_times[i]*10)/10,itemStyle:{normal:{color:'rgba(155,201,99,0.5)'}}});
	    		}else{
	    			low_times.push({value:fir_times[i],itemStyle:{normal:{color:'rgba(155,201,99,1)'}},dataFlag:1});
	    			top_times.push({value:(sec_times[i]*10-fir_times[i]*10)/10,itemStyle:{normal:{color:'rgba(254,132,99,0.8)'}}});
	    		}
	    	}
	    	
	    	var tempDate=[{
	    				  name :dateFt1,
						  icon:"image://resource/echarts/build/dist/img/greens.png"
						},{
						  name :dateFt0,
						  icon:"image://resource/echarts/build/dist/img/green.png"
						},{
						  name :"对比增幅",
						  icon:"image://resource/echarts/build/dist/img/red.png"
						}];
			var tplable;
        	if(stations.length>10){
				tplable={interval:0,textStyle: {fontWeight:'bold',fontSize:18},rotate:-30};
			}else{
				tplable={interval:0,textStyle: {fontWeight:'bold',fontSize:18}};
			}
	    	
	        // 路径配置
	        require.config({
	            paths: {
	                echarts: 'resource/echarts/build/dist'
	            }
	        });
	        
	        // 使用
	        require(
	            [
	                'echarts',
	                'echarts/chart/bar',
	                'echarts/chart/line'
	            ],
	            function (ec) {
	                var myChart = ec.init(document.getElementById('main')); 
	                option = {
	                	title : {
					        text: '<%=model_name%>分析',
					        x:'center',
					        textStyle:{fontSize:20,fontWeight:'bolder'}
					    },
					    tooltip : {
					        trigger: 'axis',
					        textStyle: {fontWeight:'bold',fontSize:20},
					        formatter: function (param){
	                	        var params=[];params.push(param[1]);params.push(param[2]);
	                	        var tpstr=params[0].name;
	                			if(params[1].data.dataFlag<0){
	                				tpstr=tpstr+"<br/>增量：-"+params[0].value+"(万)[-"+(params[0].value/((params[1].value*10+params[0].value*10)/10)*100).toFixed(2)+"%]<br/>"+params[1].seriesName+"："+((params[1].value*10+params[0].value*10)/10)
	                				+"(万)<br/>"+params[0].seriesName+"："+params[1].value+"(万)";
	                			}else{
	                				tpstr=tpstr+"<br/>增量：+"+params[0].value+"(万)[+"+(params[0].value/params[1].value*100).toFixed(2)+"%]<br/>"+params[1].seriesName+"："+params[1].value
	                				+"(万)<br/>"+params[0].seriesName+"："+((params[1].value*10+params[0].value*10)/10)+"(万)";
	                			}
					            return tpstr;
					        }
					    },
					    legend: {
					    	selectedMode:false,
					    	x:'center',
					    	y:'30',
					    	textStyle: {fontWeight:'bold',fontSize:18},
					        data:tempDate
					    },
					    calculable : true,
					    xAxis : [
					        {
					        	type : 'category',
					        	//axisLabel:tplable,
					        	axisLabel:{interval:0,textStyle: {fontWeight:'bold',fontSize:12}},
					            data : stations,
					            
					        }
					    ],
					    yAxis : [
					        {
					            type : 'value',
					            axisLabel:{
					        		formatter:'{value}万',
					        		textStyle: {fontWeight:'bold',fontSize:18}
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
					
					
					ecConfig = require('echarts/config');
					myChart.on(ecConfig.EVENT.CLICK, function (param) {
						if(stations.indexOf(param.name)>-1){
							var fir_period_times=[];
							var sec_period_times=[];
							var sec_period_tp=[];
							var time_period=[];
							for(var i=0;i<list.length;i++){
								if(param.name==list[i].station_nm_cn){
									if(list[i].fir_times!=null){fir_period_times.push(list[i].fir_times);}
									if(list[i].sec_times!=null){sec_period_times.push(list[i].sec_times);}
									
									if(list[i].time_period.indexOf("00")>-1){
										time_period.push(list[i].time_period.toString().substring(0, 2));
									}else{
										time_period.push({
									        value:list[i].time_period,            
									        textStyle:{fontSize:0}
									     });
									}
									
								}
							}
							if(today==dates[1]){
								for(var i=0;i<sec_period_times.length-2;i++){
									sec_period_tp.push(sec_period_times[i]);
								}
							}else{
							       sec_period_tp=sec_period_times;
							}
			                option1 = {
			                	title : {
							        text:param.name+'车站客流',
					        		x:'center',
					        		textStyle:{fontSize:20,fontWeight:'bolder'}
							    },
							    tooltip : {
							        trigger: 'axis',
							        textStyle: {fontWeight:'bold',fontSize:20},
							        formatter:function(param){
							        	var tpstr ="";
							        	if(param[0].name.toString().length==2){
							        		tpstr+=param[0].name+":00<br/>"
							        	}else{
							        		tpstr+=param[0].name+"<br/>"
							        	}
							        	tpstr += param[0].seriesName  + "：" +param[0].value+ "万<br/>";
							        	tpstr += param[1].seriesName  + "：" +param[1].value+ "万<br/>";
							        	return tpstr;
							        }
							    },
							    legend: {
							    	selectedMode:false,
							    	x:'center',
							    	y:'30',
							    	textStyle: {fontWeight:'bold',fontSize:18},
							        data:[dateFt1,dateFt0]
							    },
							    calculable : true,
							    xAxis : [
							        {
							            type : 'category',
							            axisLabel:{interval:0,textStyle: {fontWeight:'bold',fontSize:18}},
							            data : time_period,
							            name:'(时刻)'
							        }
							    ],
							    yAxis : [
							        {
							            type : 'value',
							            axisLabel:{formatter:'{value}万',textStyle: {fontWeight:'bold',fontSize:18}},
							            splitNumber:3
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
							            itemStyle:{normal: {color:'rgba(155,201,99,1)'}},
							            data:sec_period_tp
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
							            itemStyle:{normal: {color:'rgba(183,183,183,0.8)'}},
							            data:fir_period_times
							        }
							    ]
							};
			                myChart.setOption(option1, true);
		                }else{
		                	myChart.setOption(option, true);
		                }
		            });
					
					
	            }
	        );
        }else{
        	alert("对比日期不能为当天");
        }
    </script>
  </body>
</html>