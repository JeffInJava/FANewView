package com.gmoa.vos.pflw;

import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.mysql.jdbc.Statement;

import jsontag.annotation.JsonTagAnnotation;
import jsontag.dao.JsonTagTemplateDaoImpl;
import jsontag.interf.IDoService;

/**
 * 获取分时客流统计次数
 * @author Administrator
 *
 */
@JsonTagAnnotation(actionValue="/getime_paflws.action",namespace="/pasflw",isJsonReturn=true)
public class GetTimePFLl  extends JsonTagTemplateDaoImpl implements IDoService{
	
//	Statement st=null;
//    Statement st1=null;
//    Statement st2=null;
//    ResultSet rs=null;
//    ResultSet rs1=null;
//    ResultSet rs2=null;
     private String fir_date;//历史日期1
    public String getLineId() {
		return lineId;
	}

	public void setLineId(String lineId) {
		this.lineId = lineId;
	}





	String sec_date;//历史日期2
    String today;
    String  lineId;
    public String getFir_date() {
		return fir_date;
	}

	public void setFir_date(String fir_date) {
		this.fir_date = fir_date;
	}

	public String getSec_date() {
		return sec_date;
	}

	public void setSec_date(String sec_date) {
		this.sec_date = sec_date;
	}
	


	
   
	@Override
	public Object doService() throws Exception {
		// TODO Auto-generated method stub
		
		List<String> time_period=new ArrayList();//时刻
	    List fir_times=new ArrayList();//第一天客流量
	    List sec_times=new ArrayList();//第二天客流量
	    List today_times=new ArrayList();//当天客流量
	    List pre_times=new ArrayList();//预测客流量
	    List fir_fen_times=new ArrayList();//第一天分时客流量
	    List sec_fen_times=new ArrayList();//第二天分时客流量
	    List fen_times=new ArrayList();//当天客分时流量
	    JSONObject total_times=new JSONObject();//总客流量
	    String predict_time="";

	   HashMap<String, Object>  result=new  HashMap<String, Object>();
	   List dates=new ArrayList();
	   
	    
	    
	   
	    	
	    	if(fir_date!=null&&fir_date.trim().length()>0&&sec_date!=null&&sec_date.trim().length()>0){
	    		
	    		
	    		 
	    		dates.add(fir_date);
	    	    dates.add(sec_date);
	    		//读取数据库的配置信息
	    		/*Properties properties = new Properties(); 
	    		String paths = Thread.currentThread().getContextClassLoader().getResource("").toString();
	    		paths=paths.replace("classes/", "config.properties");
	    		paths=paths.replace("file:", "");
	    		InputStream inputStream = new FileInputStream(paths); 
	    		properties.load(inputStream); 
	    		inputStream.close();
				Class.forName(properties.getProperty("db.driver"));
	    		 con=DriverManager.getConnection(properties.getProperty("db.url"),properties.getProperty("db.user"),properties.getProperty("db.pass"));*/
	    		 
	    		 //查询数据库的当前时间
	    		 //st=con.createStatement();
	    	    
	    	    
	    		 String sqlStr="select case when to_char(sysdate-30/(24*60),'yyyyMMddhh24')<to_char(sysdate,'yyyyMMdd')||'02' then '1' else '0' end flag,to_char(sysdate,'yyyyMMdd') today,to_char(sysdate-1,'yyyyMMdd') yesterday from dual";
	    		 List<Map<String, Object>> res=jsonTagJdbcDao.getJdbcTemplate().queryForList(sqlStr);
				 String start_hour="04";
				 String end_hour="02";
				 String flag="";
				 String yesterday="";
				
					 
					 for (Map<String, Object>  mp:res) {
					
					 today=(String) mp.get("today");
					 
					 
					 flag=(String) mp.get("flag");
					 yesterday=(String) mp.get("yesterday");
					 }
				 SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
				  	Calendar calendar = Calendar.getInstance(); 
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
				String today_sql="";
				String pred_sql="";
				String pred_sqls="";
				//查询日期和服务器的当前日期比较，如果查询日期是60天以前，则查询tbl_metro_fluxnew_history表
				if(lineId.equals("all")){
					
				
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
				today_sql="   where ticket_type not in ('40','41','130','131','140','141') ";
				pred_sql="tbl_metro_prediction where";
				pred_sqls="tbl_metro_prediction a where";
				}
				
				else{
					if(s_date1.compareTo(tempDate) > 0) {
						fir_sql=" tbl_metro_fluxnew_"+fir_date+" where ticket_type not in ('40','41','130','131','140','141') and line_id="+"'"+lineId+"'";
						fir_sql1=" tbl_metro_fluxnew_"+fir_date1+" where ticket_type not in ('40','41','130','131','140','141') and line_id="+"'"+lineId+"'";
					}else{
						fir_sql=" tbl_metro_fluxnew_history partition(V"+fir_date+"_FLUXNEW_HISTORY) where line_id="+lineId;
						fir_sql1=" tbl_metro_fluxnew_history partition(V"+fir_date1+"_FLUXNEW_HISTORY) where line_id="+lineId;
					}
					if(s_date2.compareTo(tempDate) > 0) {
						sec_sql=" tbl_metro_fluxnew_"+sec_date+" where ticket_type not in ('40','41','130','131','140','141') and line_id="+"'"+lineId+"'";
						sec_sql1=" tbl_metro_fluxnew_"+sec_date1+" where ticket_type not in ('40','41','130','131','140','141') and line_id="+"'"+lineId+"'";
					}else{
						sec_sql=" tbl_metro_fluxnew_history partition(V"+sec_date+"_FLUXNEW_HISTORY) where 1=1 and line_id="+"'"+lineId+"'";
						sec_sql1=" tbl_metro_fluxnew_history partition(V"+sec_date1+"_FLUXNEW_HISTORY) where 1=1 and line_id="+"'"+lineId+"'";
					}
					today_sql="   where ticket_type not in ('40','41','130','131','140','141') and line_id="+"'"+lineId+"'";
					pred_sql="  tbl_metro_prediction_line where  line_id="+"'"+lineId+"'"+" and";
					pred_sqls="  tbl_metro_prediction_line a where  line_id="+"'"+lineId+"'"+" and";
				}
			 	//查询三个日期的累计客流量信息
				//st1=con.createStatement();
			 	
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
				 	today_sql+
				 	"   group by substr(start_time,1,10)||lpad(trunc(to_number(substr(start_time,11,2))/30,0)*30,2,'0')"+
				 	"   ) t1,"+
				 	"   (select '"+("1".equals(flag)?yesterday:today)+"'||to_char(to_date('20160201 0000','yyyyMMdd hh24:mi')-(level-1)/48,'hh24mi') halfhour from dual connect by level<=48) t2"+
				 	"   where t1.halfhour(+)=t2.halfhour and t2.halfhour>='"+("1".equals(flag)?yesterday:today)+start_hour+"00' and t2.halfhour<=to_char(sysdate-30/(24*60),'yyyyMMddhh24mi')";
		if("1".endsWith(flag)){
			operStr+="   union all"+
				 	"   select t2.halfhour,nvl(t1.total_times,0) from "+
				 	"   ("+
				 	"   select sum(enter_times+change_times) total_times,substr(start_time,1,10)||lpad(trunc(to_number(substr(start_time,11,2))/30,0)*30,2,'0') halfhour from tbl_metro_fluxnew_"+today+ 
				 	today_sql+
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
				 	today_sql+
				 	"   group by substr(start_time,1,10)||lpad(trunc(to_number(substr(start_time,11,2))/30,0)*30,2,'0')"+
				 	"   ) t1,"+
				 	"   (select '"+("1".equals(flag)?yesterday:today)+"'||to_char(to_date('20160201 0000','yyyyMMdd hh24:mi')-(level-1)/48,'hh24mi') halfhour from dual connect by level<=48) t2"+
				 	"   where t1.halfhour(+)=t2.halfhour and t2.halfhour>='"+("1".equals(flag)?yesterday:today)+start_hour+"00' and t2.halfhour<=to_char(sysdate-30/(24*60),'yyyyMMddhh24mi')";
	 	if("1".endsWith(flag)){
			operStr+="   union all"+
				 	"   select t2.halfhour,nvl(t1.total_times,0) total_times,'' predict_time from "+
				 	"   ("+
				 	"   select sum(enter_times+change_times) total_times,substr(start_time,1,10)||lpad(trunc(to_number(substr(start_time,11,2))/30,0)*30,2,'0') halfhour from tbl_metro_fluxnew_"+today+ 
				 	today_sql+
				 	"   group by substr(start_time,1,10)||lpad(trunc(to_number(substr(start_time,11,2))/30,0)*30,2,'0')"+
				 	"   ) t1,"+
				 	"   (select '"+today+"'||to_char(to_date('20160201 0000','yyyyMMdd hh24:mi')-(level-1)/48,'hh24mi') halfhour from dual connect by level<=48) t2"+
				 	"   where t1.halfhour(+)=t2.halfhour and t2.halfhour<'"+today+end_hour+"00' and t2.halfhour<=to_char(sysdate-30/(24*60),'yyyyMMddhh24mi')";
		}	 	
	 		operStr+="   union all"+
				 	"	select substr(start_time,1,12) halfhour,enter_change_times,predict_time from "+
				 	"	   (select rank() over(partition by pattern order by pattern desc) r,a.* from "+pred_sqls+" stmt_day='"+("1".equals(flag)?yesterday:today)+"'  "+
					"	      and predict_time=(select max(predict_time) from "+pred_sql+" stmt_day='"+("1".equals(flag)?yesterday:today)+"' ) "+
					"	      and start_time>to_char(sysdate-30/(24*60),'yyyyMMddhh24mi')"+
					"	    ) where r=1"+
				 	" )"+
				 	") dd"+
				 	" where substr(aa.halfhour,9,4)=substr(bb.halfhour,9,4) and substr(aa.halfhour,9,4)=substr(cc.halfhour(+),9,4) and substr(aa.halfhour,9,4)=substr(dd.halfhour(+),9,4) order by aa.halfhour";
	 	
	 		List<Map<String, Object>> res1=jsonTagJdbcDao.getJdbcTemplate().queryForList(operStr);
	 		
	 		for (Map<String, Object>  mp:res1) {
	 			
	 		
	 			predict_time=(String) mp.get("predict_time");
		 		time_period.add((String) mp.get("hour"));
		 		fir_times.add(mp.get("fir_times"));
				sec_times.add(mp.get("sec_times"));
				fir_fen_times.add(mp.get("fir_fen_times"));
				sec_fen_times.add(mp.get("sec_fen_times"));
				if(mp.get("today_times")!=null){
					today_times.add(mp.get("today_times"));
				}
				if(mp.get("pre_times")!=null){
					pre_times.add(mp.get("pre_times"));
				}
				if(mp.get("fen_times")!=null){
					fen_times.add(mp.get("fen_times"));
				}
	 		}
	 		
			 	/*rs1=st1.executeQuery(operStr);
			 	while (rs1.next()){
					predict_time=rs1.getString("predict_time");
			 		time_period.add(rs1.getString("hour"));
			 		fir_times.add(mp.get("fir_times"));
					sec_times.add(mp.get("sec_times"));
					fir_fen_times.add(mp.get("fir_fen_times"));
					sec_fen_times.add(mp.get("sec_fen_times"));
					if(mp.get("today_times")!=null){
						today_times.add(mp.get("today_times"));
					}
					if(mp.get("pre_times")!=null){
						pre_times.add(mp.get("pre_times"));
					}
					if(mp.get("fen_times")!=null){
						fen_times.add(mp.get("fen_times"));
					}
				 }*/
			 	
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
			 	//st2=con.createStatement();
			 	
			 	List<Map<String, Object>> res2=new ArrayList();
		 		res2=jsonTagJdbcDao.getJdbcTemplate().queryForList(sql);
		 		
		 		for (Map<String, Object>  mp:res2) {
		 			
			 		total_times.put((String) mp.get("dates"),mp.get("times"));

		 		}
			 	/*rs2=st2.executeQuery(sql);
			 	
			 	while(rs2.next()){
			 		total_times.put(rs2.getString("dates"),rs2.getObject("times"));
			 	}*/
	    	}
	    	/*List<String> time_period=new ArrayList();//时刻
		    List fir_times=new ArrayList();//第一天客流量
		    List sec_times=new ArrayList();//第二天客流量
		    List today_times=new ArrayList();//当天客流量
		    List pre_times=new ArrayList();//预测客流量
		    List fir_fen_times=new ArrayList();//第一天分时客流量
		    List sec_fen_times=new ArrayList();//第二天分时客流量
		    List fen_times=new ArrayList();//当天客分时流量
		    JSONObject total_times=new JSONObject();//总客流量
		    String predict_time="";*/
	    	result.put("time_period", time_period);
	    	result.put("fir_times", fir_times);
	    	result.put("sec_times", sec_times);
	    	result.put("today_times", today_times);
	    	result.put("pre_times", pre_times);
	    	result.put("fir_fen_times", fir_fen_times);
	    	result.put("sec_fen_times", sec_fen_times);
	    	result.put("fir_fen_times", fir_fen_times);
	    	result.put("fen_times", fen_times);
	    	result.put("total_times", total_times);
	    	result.put("predict_time", predict_time);
	    	result.put("dates", dates);
	    	
	    	
		
		return result;
	}
}


