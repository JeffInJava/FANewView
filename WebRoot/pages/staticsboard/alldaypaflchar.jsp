<%@ page language="java" import="java.util.*,java.lang.*,net.sf.json.*,java.sql.*,java.text.*,java.io.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<% 
	String fir_date=request.getParameter("start_date1");
  	String sec_date=request.getParameter("start_date2");
  	String today="";
	
  	SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
  	Calendar calendar = Calendar.getInstance(); 
    calendar.setTime(new java.util.Date());
    if(sec_date==null)
	{
		calendar.add(Calendar.DAY_OF_MONTH, -2);  
		sec_date=df.format(calendar.getTime());
	}
    if(fir_date==null)
	{
        calendar.add(Calendar.DAY_OF_MONTH, -1);  
        fir_date=df.format(calendar.getTime());
	}
	
	//String urlString="halfhour_sum_flux_proc.jsp?start_date1="+fir_date+"&start_date2="+sec_date;
	//response.setHeader("refresh","300;URL="+urlString);  
	%>
  <head>
  <base href="<%=basePath%>">
	<script src="resource/echarts/build/dist/echarts.js"></script>
	<script src="resource/jquery/js/jquery-1.7.2.js" type="text/javascript"></script>
    <script src="resource/jquery/js/jquery-ui-1.8.11.custom.min.js" type="text/javascript"></script>
    <link href="resource/jquery/css/jquery-ui-1.8.11.custom.css" rel="stylesheet" type="text/css" />
    <script src="resource/jquery/js/jquery.ui.datepicker-zh-CN.js" type="text/javascript"></script>
	<title>全日分时客流累计</title>
  </head>
  <body style="background-color:#000000;" ondblclick="formhidden()">
  	<form action="halfhour_sum_flux_proc.jsp" style="display:none;font-size: 48px;font-weight: bold;color:#FFFFFF" id="form1">
	     历史日期1：<input type=text name="start_date1" id="start_date1" class="datecla" style="font-size: 48px;font-weight: bold;color:#FFFFFF;background-color:#000000;width:300px;">
	     历史日期2：<input type=text name="start_date2" id="start_date2" class="datecla" style="font-size: 48px;font-weight: bold;color:#FFFFFF;background-color:#000000;width:300px;">
	 <input type="submit" name="submit" value="图表" style="font-size: 48px;font-weight: bold;">
	</form>
  	<div id="main" style="height:70%;width: 100%"></div>
  	<div id="main1" style="height:30%;width: 100%"></div>
  	<%
		
  	Connection con=null;
    Statement st=null;
    Statement st1=null;
    Statement st2=null;
    ResultSet rs=null;
    ResultSet rs1=null;
    ResultSet rs2=null;
    
    List<String> time_period=new ArrayList();//时刻
    List fir_times=new ArrayList();//第一天客流量
    List sec_times=new ArrayList();//第二天客流量
    List today_times=new ArrayList();//当天客流量
    List pre_times=new ArrayList();//预测客流量
    List fir_fen_times=new ArrayList();//第一天分时客流量
    List sec_fen_times=new ArrayList();//第二天分时客流量
    List fen_times=new ArrayList();//当天客分时流量
    JSONObject total_times=new JSONObject();//总客流量
    String predict_time=null;

    List dates=new ArrayList();
    dates.add(fir_date);
    dates.add(sec_date);
    
    try{
    	if(fir_date!=null&&fir_date.trim().length()>0&&sec_date!=null&&sec_date.trim().length()>0){
    		//读取数据库的配置信息
    		Properties properties = new Properties(); 
    		String paths = Thread.currentThread().getContextClassLoader().getResource("").toString();
    		paths=paths.replace("classes/", "config.properties");
    		paths=paths.replace("file:", "");
    		InputStream inputStream = new FileInputStream(paths); 
    		properties.load(inputStream); 
    		inputStream.close();
			Class.forName(properties.getProperty("db.driver"));
    		 con=DriverManager.getConnection(properties.getProperty("db.url"),properties.getProperty("db.user"),properties.getProperty("db.pass"));
    		 
    		 //查询数据库的当前时间
    		 st=con.createStatement();
    		 String sqlStr="select case when to_char(sysdate-30/(24*60),'yyyyMMddhh24')<to_char(sysdate,'yyyyMMdd')||'02' then '1' else '0' end flag,to_char(sysdate,'yyyyMMdd') today,to_char(sysdate-1,'yyyyMMdd') yesterday from dual";
			 rs=st.executeQuery(sqlStr);
			 String start_hour="04";
			 String end_hour="02";
			 String flag="";
			 String yesterday="";
			 while (rs.next()){
				 today=rs.getString("today");
				 flag=rs.getString("flag");
				 yesterday=rs.getString("yesterday");
			 }
			 
	   		 java.util.Date s_date1=df.parse(fir_date);
	   		 java.util.Date s_date2=df.parse(sec_date);
		 	 calendar.setTime(df.parse(today));
			 calendar.add(GregorianCalendar.DAY_OF_MONTH, -60);
			 java.util.Date tempDate = calendar.getTime();
			
			 calendar.setTime(s_date1);
			 calendar.add(GregorianCalendar.DAY_OF_MONTH,1);
			 String fir_date1=df.format(calendar.getTime());
			 
			 calendar.setTime(s_date2);
			 calendar.add(GregorianCalendar.DAY_OF_MONTH,1);
			 String sec_date1=df.format(calendar.getTime());
			 
			 
			String fir_sql="";
			String sec_sql="";
			String fir_sql1="";
			String sec_sql1="";
			//查询日期和服务器的当前日期比较，如果查询日期是60天以前，则查询tbl_metro_fluxnew_history表
			if(s_date1.compareTo(tempDate) > 0) {
				fir_sql=" tbl_metro_fluxnew_"+fir_date+" where ticket_type not in ('40','41','130','131','140','141') ";
				fir_sql1=" tbl_metro_fluxnew_"+fir_date1+" where ticket_type not in ('40','41','130','131','140','141') ";
			}else{
				fir_sql=" tbl_metro_fluxnew_history partition(V"+fir_date+"_FLUXNEW_HISTORY) ";
				fir_sql1=" tbl_metro_fluxnew_history partition(V"+fir_date1+"_FLUXNEW_HISTORY) ";
			}
			if(s_date2.compareTo(tempDate) > 0) {
				sec_sql=" tbl_metro_fluxnew_"+sec_date+" where ticket_type not in ('40','41','130','131','140','141') ";
				sec_sql1=" tbl_metro_fluxnew_"+sec_date1+" where ticket_type not in ('40','41','130','131','140','141') ";
			}else{
				sec_sql=" tbl_metro_fluxnew_history partition(V"+sec_date+"_FLUXNEW_HISTORY) where 1=1 ";
				sec_sql1=" tbl_metro_fluxnew_history partition(V"+sec_date1+"_FLUXNEW_HISTORY) where 1=1 ";
			}
			
		 	//查询三个日期的累计客流量信息
			st1=con.createStatement();
		 	
			if("1".endsWith(flag)){
				dates.add(yesterday);
			}else{
				dates.add(today);
			}
			
			
			
						
				String operStr="select aa.total_times fir_times,bb.total_times sec_times,cc.total_times today_times,dd.total_times pre_times,aa.fir_fen_times,bb.sec_fen_times,cc.fen_times,"+
				"case when substr(aa.halfhour,11,2)='00' then substr(aa.halfhour,9,2) else substr(aa.halfhour,9,2)||':'||substr(aa.halfhour,11,2) end hour,dd.predict_time from "+
	 			"(select halfhour,round((sum(total_times) over(order by halfhour))/1000000,1) total_times,round(-total_times/1000000,1) fir_fen_times from "+
		 		" ("+
			 	"   select t2.halfhour,nvl(t1.total_times,0) total_times from "+
			 	"   ("+
			 	"   select sum(enter_times+change_times) total_times,substr(start_time,1,10)||lpad(trunc(to_number(substr(start_time,11,2))/30,0)*30,2,'0') halfhour from "+fir_sql+
			 	"   group by substr(start_time,1,10)||lpad(trunc(to_number(substr(start_time,11,2))/30,0)*30,2,'0')"+
			 	"   ) t1,"+
			 	"   (select '"+fir_date+"'||to_char(to_date('20160201 0000','yyyyMMdd hh24:mi')-(level-1)/48,'hh24mi') halfhour from dual connect by level<=48) t2"+
			 	"   where t1.halfhour(+)=t2.halfhour and t2.halfhour>='"+fir_date+start_hour+"00'"+
			 	"   union all"+
			 	"   select t2.halfhour,nvl(t1.total_times,0) from "+
			 	"   ("+
			 	"   select sum(enter_times+change_times) total_times,substr(start_time,1,10)||lpad(trunc(to_number(substr(start_time,11,2))/30,0)*30,2,'0') halfhour from "+fir_sql1+ 
			 	"   group by substr(start_time,1,10)||lpad(trunc(to_number(substr(start_time,11,2))/30,0)*30,2,'0')"+
			 	"   ) t1,"+
			 	"   (select '"+fir_date1+"'||to_char(to_date('20160201 0000','yyyyMMdd hh24:mi')-(level-1)/48,'hh24mi') halfhour from dual connect by level<=48) t2"+
			 	"   where t1.halfhour(+)=t2.halfhour and t2.halfhour<'"+fir_date1+end_hour+"00'"+
			 	" )"+
			 	") aa,"+
			 	"(select halfhour,round((sum(total_times) over(order by halfhour))/1000000,1) total_times,round(-total_times/1000000,1) sec_fen_times from "+
		 		" ("+
			 	"   select t2.halfhour,nvl(t1.total_times,0) total_times from "+
			 	"   ("+
			 	"   select sum(enter_times+change_times) total_times,substr(start_time,1,10)||lpad(trunc(to_number(substr(start_time,11,2))/30,0)*30,2,'0') halfhour from "+sec_sql+
			 	"   group by substr(start_time,1,10)||lpad(trunc(to_number(substr(start_time,11,2))/30,0)*30,2,'0')"+
			 	"   ) t1,"+
			 	"   (select '"+sec_date+"'||to_char(to_date('20160201 0000','yyyyMMdd hh24:mi')-(level-1)/48,'hh24mi') halfhour from dual connect by level<=48) t2"+
			 	"   where t1.halfhour(+)=t2.halfhour and t2.halfhour>='"+sec_date+start_hour+"00'"+
			 	"   union all"+
			 	"   select t2.halfhour,nvl(t1.total_times,0) from "+
			 	"   ("+
			 	"   select sum(enter_times+change_times) total_times,substr(start_time,1,10)||lpad(trunc(to_number(substr(start_time,11,2))/30,0)*30,2,'0') halfhour from "+sec_sql1+ 
			 	"   group by substr(start_time,1,10)||lpad(trunc(to_number(substr(start_time,11,2))/30,0)*30,2,'0')"+
			 	"   ) t1,"+
			 	"   (select '"+sec_date1+"'||to_char(to_date('20160201 0000','yyyyMMdd hh24:mi')-(level-1)/48,'hh24mi') halfhour from dual connect by level<=48) t2"+
			 	"   where t1.halfhour(+)=t2.halfhour and t2.halfhour<'"+sec_date1+end_hour+"00'"+
			 	" )"+
			 	") bb,"+
			 	"(select halfhour,round((sum(total_times) over(order by halfhour))/1000000,1) total_times,round(-total_times/1000000,1) fen_times from "+
		 		" ("+
			 	"   select t2.halfhour,nvl(t1.total_times,0) total_times from "+
			 	"   ("+
			 	"   select sum(enter_times+change_times) total_times,substr(start_time,1,10)||lpad(trunc(to_number(substr(start_time,11,2))/30,0)*30,2,'0') halfhour from tbl_metro_fluxnew_"+("1".equals(flag)?yesterday:today)+
			 	"   where ticket_type not in ('40','41','130','131','140','141')"+
			 	"   group by substr(start_time,1,10)||lpad(trunc(to_number(substr(start_time,11,2))/30,0)*30,2,'0')"+
			 	"   ) t1,"+
			 	"   (select '"+("1".equals(flag)?yesterday:today)+"'||to_char(to_date('20160201 0000','yyyyMMdd hh24:mi')-(level-1)/48,'hh24mi') halfhour from dual connect by level<=48) t2"+
			 	"   where t1.halfhour(+)=t2.halfhour and t2.halfhour>='"+("1".equals(flag)?yesterday:today)+start_hour+"00' and t2.halfhour<=to_char(sysdate-30/(24*60),'yyyyMMddhh24mi')";
	if("1".endsWith(flag)){
		operStr+="   union all"+
			 	"   select t2.halfhour,nvl(t1.total_times,0) from "+
			 	"   ("+
			 	"   select sum(enter_times+change_times) total_times,substr(start_time,1,10)||lpad(trunc(to_number(substr(start_time,11,2))/30,0)*30,2,'0') halfhour from tbl_metro_fluxnew_"+today+ 
			 	"   where ticket_type not in ('40','41','130','131','140','141')"+
			 	"   group by substr(start_time,1,10)||lpad(trunc(to_number(substr(start_time,11,2))/30,0)*30,2,'0')"+
			 	"   ) t1,"+
			 	"   (select '"+today+"'||to_char(to_date('20160201 0000','yyyyMMdd hh24:mi')-(level-1)/48,'hh24mi') halfhour from dual connect by level<=48) t2"+
			 	"   where t1.halfhour(+)=t2.halfhour and t2.halfhour<'"+today+end_hour+"00' and t2.halfhour<=to_char(sysdate-30/(24*60),'yyyyMMddhh24mi')";
	}
		operStr+=" )"+
			 	") cc, "+
			 	"(select halfhour,round((sum(total_times) over(order by halfhour))/1000000,1) total_times,predict_time from "+
		 		" ("+
			 	"   select t2.halfhour,nvl(t1.total_times,0) total_times,'' predict_time from "+
			 	"   ("+
			 	"   select sum(enter_times+change_times) total_times,substr(start_time,1,10)||lpad(trunc(to_number(substr(start_time,11,2))/30,0)*30,2,'0') halfhour from tbl_metro_fluxnew_"+("1".equals(flag)?yesterday:today)+
			 	"   where ticket_type not in ('40','41','130','131','140','141')"+
			 	"   group by substr(start_time,1,10)||lpad(trunc(to_number(substr(start_time,11,2))/30,0)*30,2,'0')"+
			 	"   ) t1,"+
			 	"   (select '"+("1".equals(flag)?yesterday:today)+"'||to_char(to_date('20160201 0000','yyyyMMdd hh24:mi')-(level-1)/48,'hh24mi') halfhour from dual connect by level<=48) t2"+
			 	"   where t1.halfhour(+)=t2.halfhour and t2.halfhour>='"+("1".equals(flag)?yesterday:today)+start_hour+"00' and t2.halfhour<=to_char(sysdate-30/(24*60),'yyyyMMddhh24mi')";
 	if("1".endsWith(flag)){
		operStr+="   union all"+
			 	"   select t2.halfhour,nvl(t1.total_times,0) total_times,'' predict_time from "+
			 	"   ("+
			 	"   select sum(enter_times+change_times) total_times,substr(start_time,1,10)||lpad(trunc(to_number(substr(start_time,11,2))/30,0)*30,2,'0') halfhour from tbl_metro_fluxnew_"+today+ 
			 	"   where ticket_type not in ('40','41','130','131','140','141')"+
			 	"   group by substr(start_time,1,10)||lpad(trunc(to_number(substr(start_time,11,2))/30,0)*30,2,'0')"+
			 	"   ) t1,"+
			 	"   (select '"+today+"'||to_char(to_date('20160201 0000','yyyyMMdd hh24:mi')-(level-1)/48,'hh24mi') halfhour from dual connect by level<=48) t2"+
			 	"   where t1.halfhour(+)=t2.halfhour and t2.halfhour<'"+today+end_hour+"00' and t2.halfhour<=to_char(sysdate-30/(24*60),'yyyyMMddhh24mi')";
	}	 	
 		operStr+="   union all"+
			 	"	select substr(start_time,1,12) halfhour,enter_change_times,predict_time from "+
			 	"	   (select rank() over(partition by pattern order by pattern desc) r,a.* from tbl_metro_prediction a where stmt_day='"+("1".equals(flag)?yesterday:today)+"'  "+
				"	      and predict_time=(select max(predict_time) from tbl_metro_prediction where stmt_day='"+("1".equals(flag)?yesterday:today)+"' ) "+
				"	      and start_time>to_char(sysdate-30/(24*60),'yyyyMMddhh24mi')"+
				"	    ) where r=1"+
			 	" )"+
			 	") dd"+
			 	" where substr(aa.halfhour,9,4)=substr(bb.halfhour,9,4) and substr(aa.halfhour,9,4)=substr(cc.halfhour(+),9,4) and substr(aa.halfhour,9,4)=substr(dd.halfhour(+),9,4) order by aa.halfhour";
 	
			
		 	rs1=st1.executeQuery(operStr);
		 	while (rs1.next()){
				predict_time=rs1.getString("predict_time");
		 		time_period.add(rs1.getString("hour"));
		 		fir_times.add(rs1.getObject("fir_times"));
				sec_times.add(rs1.getObject("sec_times"));
				fir_fen_times.add(rs1.getObject("fir_fen_times"));
				sec_fen_times.add(rs1.getObject("sec_fen_times"));
				if(rs1.getObject("today_times")!=null){
					today_times.add(rs1.getObject("today_times"));
				}
				if(rs1.getObject("pre_times")!=null){
					pre_times.add(rs1.getObject("pre_times"));
				}
				if(rs1.getObject("fen_times")!=null){
					fen_times.add(rs1.getObject("fen_times"));
				}
			 }
		 	
		 	//查询查询日期的总客流量信息
		 	String sql="select * from (select round(sum(times) / 10000, 1) times,'"+fir_date+"' dates from (select floor(sum(dcp_sell_times))+floor(sum(jck_enter_times))+floor(sum(jfk_enter_times)) +"+
                       " floor(sum(YGK_ENTER_TIMES))+floor(sum(jcp_enter_times))+floor(sum(lrk_enter_times))+floor(sum(cmcc_enter_times))+nvl(floor(sum(qrcd_enter_times)),0) times"+
                   	   " from tbl_metro_report_save_flux where stmt_day = '"+fir_date+"' union all select round(sum(change_times_save)) times"+
                       " from tbl_metro_report_en_flux_day where stmt_day = '"+fir_date+"' union all select sum(sale_nubs - unsale_nubs) times"+
                       " from tbl_metro_ctcard_line_day where stmt_day = '"+fir_date+"')) union all"+
					   " (select round(sum(times) / 10000, 1) times,'"+sec_date+"' dates from (select floor(sum(dcp_sell_times))+floor(sum(jck_enter_times))+floor(sum(jfk_enter_times)) +"+
			            " floor(sum(YGK_ENTER_TIMES))+floor(sum(jcp_enter_times))+floor(sum(lrk_enter_times))+floor(sum(cmcc_enter_times))+nvl(floor(sum(qrcd_enter_times)),0) times"+
			        	   " from tbl_metro_report_save_flux where stmt_day = '"+sec_date+"' union all select round(sum(change_times_save)) times"+
			            " from tbl_metro_report_en_flux_day where stmt_day = '"+sec_date+"' union all select sum(sale_nubs - unsale_nubs) times"+
			            " from tbl_metro_ctcard_line_day where stmt_day = '"+sec_date+"')) ";
		 	st2=con.createStatement();
		 	rs2=st2.executeQuery(sql);
		 	
		 	while(rs2.next()){
		 		total_times.put(rs2.getString("dates"),rs2.getObject("times"));
		 	}
    	}
    }catch(Exception e){
        e.printStackTrace();			 
    }finally{
    	if(rs2!=null){
			try{
				rs2.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		if(st2!=null){
			try{
				st2.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
    	if(rs1!=null){
			try{
				rs1.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		if(st1!=null){
			try{
				st1.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
    	if(rs!=null){
			try{
				rs.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		if(st!=null){
			try{
				st.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		if(con!=null){
			try{
				con.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
    }
    
    if(time_period.size()>0){
	%>
    <script type="text/javascript">
    
	$('.datecla').datepicker();
   	$('.datecla').datepicker('option', 'dateFormat', 'yymmdd');
	
	var dbnum=0;
	function formhidden(){
		if(dbnum%2==0){
			document.getElementById("form1").style.display="";
		}else{
			document.getElementById("form1").style.display="none";	
		}
		dbnum=dbnum+1;
	}

	var start_date1="<%=fir_date%>"; 
	var start_date2="<%=sec_date%>"; 
	if(start_date1){
   			$('#start_date1').datepicker('setDate', start_date1);
   		}else{
   			$('#start_date1').datepicker('setDate','-1d');
   		}
	if(start_date2){
   			$('#start_date2').datepicker('setDate', start_date2);
   		}else{
   			$('#start_date2').datepicker('setDate', '-2d');
   		}
	var predict_time='<%=predict_time==null?"":predict_time%>';
    	var time_period=eval('<%=JSONArray.fromObject(time_period).toString()%>');
    	var fir_times=eval('<%=JSONArray.fromObject(fir_times).toString()%>');
    	var sec_times=eval('<%=JSONArray.fromObject(sec_times).toString()%>');
    	var today_times=eval('<%=JSONArray.fromObject(today_times).toString()%>');
    	var fir_fen_times=eval('<%=JSONArray.fromObject(fir_fen_times).toString()%>');
    	var sec_fen_times=eval('<%=JSONArray.fromObject(sec_fen_times).toString()%>');
    	var fen_times=eval('<%=JSONArray.fromObject(fen_times).toString()%>');
    	var pre_times=eval('<%=JSONArray.fromObject(pre_times).toString()%>');
    	var dates=eval('<%=JSONArray.fromObject(dates).toString()%>');
    	var total_times=eval('<%=JSONArray.fromObject(total_times).toString()%>');
    	for(var i=0;i<today_times.length;i++){pre_times[i]=today_times[i];}
	
	for(var i=0;i<fen_times.length;i++){
    		if(fen_times[i]<=-50){
    			fen_times[i]={
						        value :fen_times[i],
						        itemStyle:{normal: {color:'red'}}
						    }
    		}
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
                'echarts/theme/dark1',
                'echarts/chart/bar',
                'echarts/chart/line'
            ],
            function (ec,theme) {
                var myChart = ec.init(document.getElementById('main'),theme); 
                var time_period_tp=[];
				for(var i=0;i<time_period.length;i++){
					if(time_period[i].toString().indexOf("30")>-1){
						time_period_tp.push({
					        value:time_period[i],            
					        textStyle:{fontSize:0}
					     });
					}else{
						time_period_tp.push(time_period[i]);
					}
				}
				dates=[
						dates[0].substring(0,4)+"/"+dates[0].substring(4,6)+"/"+dates[0].substring(6)+"("+total_times[0][dates[0]]+")",
						dates[1].substring(0,4)+"/"+dates[1].substring(4,6)+"/"+dates[1].substring(6)+"("+total_times[0][dates[1]]+")",
						dates[2].substring(0,4)+"/"+dates[2].substring(4,6)+"/"+dates[2].substring(6)+"("+today_times[today_times.length-1]+")"
					  ];

				var x_s="center";
				if(predict_time){
					x_s="50";
					
					dates[2]=dates[2]+"  "+predict_time+"点预测("+pre_times[pre_times.length-1]+")";
					//dates[2]=dates[2]+"  12点预测(1023.1)";
				}
                				option = {
                				    title : {
				        text:'全日分时客流累计(万人次)',
				        x:'center',
		        		       y:60,
				        textStyle:{fontSize:50,fontWeight:'bold',color:'#FFFFFF'}
				    },
				    tooltip : {
				        trigger: 'axis',
				        textStyle: {fontWeight:'bold',fontSize:80,color:'#000000'},
				        formatter:function (params){
							var tpstr=(params[0].name.toString().indexOf("30")>-1?params[0].name:params[0].name+":00")
							+"<br/>"+params[0].seriesName.substring(0,10)+":"+(params[0].value=="-"?params[1].value:params[0].value)+"万<br/>"
							+params[2].seriesName.substring(0,10)+":"+params[2].value+"万<br/>"
							+params[3].seriesName.substring(0,10)+":"+params[3].value+"万";
							return tpstr;
				        }
				    },
				    legend: {
					
				    	selectedMode:false,
				    	x:x_s,
				    	y:'120',
					itemGap:100,
				    	itemWidth:60,
						itemHeight:40,
				    	textStyle: {fontWeight:'bold',fontSize:40,color:'#FFFFFF'},
				        data:dates
				    },
				    calculable : true,
				    grid:{y2:60,x:200,y:240,x2:40},	
				    xAxis : [
				        {
				            type : 'category',
				            axisLabel:{interval:0,rotate:-30,textStyle: {fontWeight:'bold',fontSize:36,color:'#FFFFFF'}},
				            data : time_period_tp
				        }
				    ],
				    yAxis : [
				        {
				            type : 'value',
				            axisLabel:{formatter:'{value}万',textStyle: {fontWeight:'bold',fontSize:45,color:'#FFFFFF'}}
				        }
				    ],
				    series : [
				        {
				            name:dates[2],
				            type:'line',
				            symbolSize:function(param){if(param){return 2;}return 0;},
				            itemStyle:{normal: {color:'red',lineStyle: {width: 8}}},
				            data:today_times
				        },
				        {
				            name:"预测",
				            type:'line',
				            symbolSize:function(param){if(param){return 4;}return 0;},
				            itemStyle:{
				            	normal: {color:'red',lineStyle:{width: 2,type: 'dashed'}},
				            	emphasis:{color:'red',lineStyle:{width: 2,type: 'dashed'}}
				            },
				            data:pre_times
				        },
				        {
				            name:dates[0],
				            type:'line',
				            symbolSize:function(param){if(param){return 2;}return 0;},
				            itemStyle:{normal: {color:'yellow',lineStyle: {width: 8}}},
				            data:fir_times
				        },
				    	{
				            name:dates[1],
				            type:'line',
				            symbolSize:function(param){if(param){return 2;}return 0;},
				            itemStyle:{normal: {color:'rgba(255,255,255,1)',lineStyle: {width: 8}}},
				            data:sec_times
				        }
				    ]
				};
                
				myChart.setOption(option, true);
				
				
				option1 = {
                				    title : {
				        text:'全日分时客流(万人次)',
				        x:'center',
				        y:'bottom',
		        		        textStyle:{fontSize:50,fontWeight:'bold',color:'#FFFFFF'}
				    },
				    legend: {
					show:false,
				    	selectedMode:false,
				    	x:x_s,
				    	y:'310',
					itemGap:100,
				    	itemWidth:80,
						itemHeight:40,
				    	textStyle: {fontWeight:'bold',fontSize:40,color:'#FFFFFF'},
				        data:dates
				    },
				    tooltip : {
				        show:false,
				        trigger: 'axis',
				        textStyle: {fontWeight:'bold',fontSize:80,color:'#000000'},
				        formatter:function (params){
				        	var tpstr=(params[0].name.toString().indexOf("30")>-1?params[0].name:params[0].name+":00")
				        	+"<br/>"+params[0].seriesName.substring(0,10)+":"+(params[0].value=="-"?"-":-params[0].value)+"万<br/>"
							+params[1].seriesName.substring(0,10)+":"+(-params[1].value)+"万<br/>"
							+params[2].seriesName.substring(0,10)+":"+(-params[2].value)+"万";
							return tpstr;
				        }
				    },
				    calculable : true,
				    grid:{y2:80,x:200,y:10,x2:40},	
				    xAxis : [
				        {
				            type : 'category',
				            axisLabel:{interval:0,show:false},
				            data : time_period_tp
				        }
				    ],
				    yAxis : [
				        {
				            type : 'value',
				            axisLabel:{
				        		textStyle: {fontWeight:'bold',fontSize:45,color:'#FFFFFF'},
				        		formatter: function(v){
									        return v==0?"":-v+"万";
						                }
				        	}
				        }
				    ],
				    series : [
				        {
				            name:"柱状",
				            type:'bar',
				            itemStyle:{normal: {color:'yellow'}},
				            data:fen_times
				        },
				        {
				            name:dates[0],
				            type:'line',
				            symbolSize:function(param){if(param){return 2;}return 0;},
				            itemStyle:{normal: {color:'rgba(255,255,255,0)',lineStyle: {width: 8}}},
				            data:[]
				        },
				    	{
				            name:dates[1],
				            type:'line',
				            symbolSize:function(param){if(param){return 2;}return 0;},
				            itemStyle:{normal: {color:'rgba(255,255,255,0)',lineStyle: {width: 8}}},
				            data:[]
				        }
				    ]
				};
				
				
				var myChart1 = ec.init(document.getElementById('main1'),theme); 
				myChart1.setOption(option1, true);
            }
        );
    </script>
    <%} %>
  </body>
</html>
