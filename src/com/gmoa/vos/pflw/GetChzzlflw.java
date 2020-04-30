package com.gmoa.vos.pflw;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Map;

import jsontag.JsonTagContext;
import jsontag.annotation.JsonTagAnnotation;
import jsontag.dao.JsonTagTemplateDaoImpl;
import jsontag.interf.IDoService;
/**
 * 获取车站客流
 * @author Administrator
 *
 */
@JsonTagAnnotation(actionValue="/get_all_passezl.action",namespace="/sheete",isJsonReturn=true)
public class GetChzzlflw extends JsonTagTemplateDaoImpl implements IDoService{
private String date;
private String today;
public String getToday() {
	return today;
}
public void setToday(String today) {
	this.today = today;
}
private String compDate;
	
	private String type;
	private String startTime;
	
	
	public String getCompDate() {
		return compDate;
	}
	public void setCompDate(String compDate) {
		this.compDate = compDate;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	private String id;
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getSize() {
		return size;
	}
	public void setSize(String size) {
		this.size = size;
	}
	private String size;
	
	
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	
	
	@Override
	public Object doService() throws Exception {
		String sql;
		List<Map<String,Object>> list=new  ArrayList<Map<String,Object>>();
		
			 String [] selType=JsonTagContext.getRequest().getParameterValues("selType[]");
			String tp_sql="0";
			if(selType!=null){
				for(String tp:selType){
					if("1".equals(tp)){
						tp_sql+="+enter_times";
					}else if("2".equals(tp)){
						tp_sql+="+exit_times";
					}else if("3".equals(tp)){
						tp_sql+="+change_times";
					}
				}
			}
			 SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
			 Calendar caldar = Calendar.getInstance(); 
			 String today = df.format(caldar.getTime());//当前日期
	   		 java.util.Date s_date1=df.parse(date);
	   		 java.util.Date s_date2=df.parse(compDate);
		 	 GregorianCalendar calendar = new GregorianCalendar();
		 	 calendar.setTime(df.parse(today));
			 calendar.add(GregorianCalendar.DAY_OF_MONTH, -60);
			 java.util.Date tempDate = calendar.getTime();
			
			String fir_sql="";
			String sec_sql="";
			//查询日期和服务器的当前日期比较，如果查询日期是60天以前，则查询tbl_metro_fluxnew_history表
			if(s_date1.compareTo(tempDate) > 0) {
				fir_sql=" tbl_metro_fluxnew_"+date+" where ticket_type not in ('40','41','130','131','140','141') ";
			}else{
				fir_sql=" tbl_metro_fluxnew_history partition(V"+date+"_FLUXNEW_HISTORY) where 1=1 ";
			}
			if(s_date2.compareTo(tempDate) > 0) {
				sec_sql=" tbl_metro_fluxnew_"+compDate+" where ticket_type not in ('40','41','130','131','140','141') ";
			}else{
				sec_sql=" tbl_metro_fluxnew_history partition(V"+compDate+"_FLUXNEW_HISTORY) where 1=1 ";
			}
			 
			//查询客流排名靠前的车站
   		 String sqls="select c.station_nm_cn,round(sum(a.total_times)/100,1) fir_times,round(sum(b.total_times)/100,1) sec_times, "+
					 "(round(sum(a.total_times)/1000000,1)-round(sum(b.total_times)/1000000,1)) addnum,round((sum(a.total_times)-sum(a.total_times))/sum(b.total_times)*100,2) addrate from"+
					 "(select station_id,sum("+tp_sql+") total_times from "+fir_sql+" and start_time<="+date+"||to_char(sysdate-30/(24*60),'hh24miss')"+
					 "  group by station_id) a, "+
					 "(select station_id,sum("+tp_sql+") total_times from "+sec_sql+" and start_time<="+compDate+"||to_char(sysdate-30/(24*60),'hh24miss')"+
					 " group by station_id) b, "+
					 "viw_metro_station_name c "+
					 "where '"+date+"' between c.start_time and c.end_time "+ 
					 "and trim(a.station_id)=trim(b.station_id(+)) and trim(a.station_id)=trim(c.station_id) group by c.station_nm_cn order by addnum ";
			list = jsonTagJdbcDao.getJdbcTemplate().queryForList(sqls,this.getSize());
			
		

		return list;
	}

}
