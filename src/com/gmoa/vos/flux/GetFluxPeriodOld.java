package com.gmoa.vos.flux;


import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import jsontag.annotation.JsonTagAnnotation;
import jsontag.dao.JsonTagTemplateDaoImpl;
import jsontag.interf.IDoService;


/**
 * 根据日期、进出换类型、线路查询分时客流
 * 日期格式：yyyymmdd
 *
 */    
@JsonTagAnnotation(actionValue="/get_fluxperiod.action",namespace="/station",isJsonReturn=true)
public class GetFluxPeriodOld extends JsonTagTemplateDaoImpl implements IDoService {
	private String start_date;
	private String com_date;
	private String sel_flag;
	private String flux_flag;
	private String line_id;
	private String station_id;
	
	@Override
	public Object doService() throws Exception {
		if("1".equals(sel_flag)){
			return findLineAndStations();
		}else{
			return findFluxPeriod();
		}
	}

	//查询线路和车站信息
	public List findLineAndStations(){
		String sql="select line_id,to_number(line_id)||'号线' line_nm,station_id,trim(station_nm_cn) station_nm from viw_metro_station_name "+
				" where to_char(sysdate,'yyyyMMdd') between start_time and end_time order by station_id";
		return jsonTagJdbcDao.getJdbcTemplate().queryForList(sql);
	}
	
	//查询客流分时比较
	public List findFluxPeriod() throws Exception{
		List<Map<String,Object>> list=null;
		String sql="";
		String sql_tp1="";
		String sql_tp2="";
		String sql_tp3="";
		
		String total_times="0";	
		if(flux_flag.indexOf("1")>-1){
			 total_times+="+nvl(enter_times,0)";
		}
		if(flux_flag.indexOf("2")>-1){
			 total_times+="+nvl(exit_times,0)";
		}
		if(flux_flag.indexOf("3")>-1){
			 total_times+="+nvl(change_times,0)";
		}
		
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
   		Date f_date=df.parse(start_date);
   		Date s_date=df.parse(com_date);
   		GregorianCalendar calendar = new GregorianCalendar();
		calendar.add(GregorianCalendar.DAY_OF_MONTH, -60);
		Date tempDate = calendar.getTime();
		String today=df.format(new Date());
		//查询日期和服务器的当前日期比较，如果查询日期是60天以前，则查询tbl_metro_fluxnew_history表
		if(f_date.compareTo(tempDate) > 0) {
			sql_tp1=" tbl_metro_fluxnew_"+start_date+" where ticket_type not in ('40','41','130','131','140','141') and substr(end_time,9,4) between '0600' and '0805' ";
			if("2".equals(sel_flag)){
				sql_tp1+=(today.equals(start_date)||today.equals(com_date)?" and '"+start_date+"'||to_char(sysdate-30/(24*60),'hh24miss')>=end_time ":"");
			}
		}else{
			sql_tp1=" tbl_metro_fluxnew_history partition(V"+start_date+"_FLUXNEW_HISTORY) where substr(end_time,9,4) between '0600' and '0805' ";
		}
		if(s_date.compareTo(tempDate) > 0) {
			sql_tp2=" tbl_metro_fluxnew_"+com_date+" where ticket_type not in ('40','41','130','131','140','141') and substr(end_time,9,4) between '0600' and '0805'";
		}else{
			sql_tp2=" tbl_metro_fluxnew_history partition(V"+com_date+"_FLUXNEW_HISTORY) where substr(end_time,9,4) between '0600' and '0805' ";
		}
		
		if(line_id==null||"00".equals(line_id)){
			sql="select bb.time_period,aa.times,bb.times com_times,case when '"+start_date+"'=to_char(sysdate,'yyyyMMdd') "+
			"and replace(bb.time_period,':','')<=to_char(sysdate-30/(24*60),'hh24miss') then '1' else '0' end flag from "+
			"( "+
			"  select substr(end_time,9,2)||':'||lpad(trunc(to_number(substr(end_time,11,2))/5,0)*5,2,'0') time_period,round(sum("+total_times+")/100) times from "+sql_tp1+
			"  group by substr(end_time,9,2)||':'||lpad(trunc(to_number(substr(end_time,11,2))/5,0)*5,2,'0') "+  
			") aa, "+
			"( "+
			"  select substr(end_time,9,2)||':'||lpad(trunc(to_number(substr(end_time,11,2))/5,0)*5,2,'0') time_period,round(sum("+total_times+")/100) times from "+sql_tp2+
			"  group by substr(end_time,9,2)||':'||lpad(trunc(to_number(substr(end_time,11,2))/5,0)*5,2,'0') "+  
			") bb where aa.time_period(+)=bb.time_period "+
			"order by bb.time_period";
		}else{
			if(station_id==null||"".equals(station_id.trim())){
				sql_tp3=" and line_id='"+line_id+"' ";
			}else{
				sql_tp3=" and station_id='"+station_id+"' ";
			}
			sql="select bb.time_period,aa.times,bb.times com_times,case when '"+start_date+"'=to_char(sysdate,'yyyyMMdd') "+
			"and replace(bb.time_period,':','')<=to_char(sysdate-30/(24*60),'hh24miss') then '1' else '0' end flag from "+
			"(  "+
			"  select t3.time_period,sum(times) times from "+
			"  ( "+
			"    select t2.station_nm,t1.time_period,sum(times) times from "+
			"    ( "+
			"      select station_id,substr(end_time,9,2)||':'||lpad(trunc(to_number(substr(end_time,11,2))/5,0)*5,2,'0') time_period,round(sum("+total_times+")/100) times from "+sql_tp1+ 
			"      group by station_id,substr(end_time,9,2)||':'||lpad(trunc(to_number(substr(end_time,11,2))/5,0)*5,2,'0') "+ 
			"    ) t1, "+
			"    (select station_id,trim(station_nm_cn) station_nm from viw_metro_station_name where '"+start_date+"' between start_time and end_time) t2 "+
			"    where t1.station_id=t2.station_id "+
			"    group by t2.station_nm,t1.time_period "+
			"  ) t3, "+
			"  (select trim(station_nm_cn) station_nm from viw_metro_station_name where '"+start_date+"' between start_time and end_time "+sql_tp3+") t4 "+
			"  where t3.station_nm=t4.station_nm group by t3.time_period "+
			") aa,  "+
			"(  "+
			"  select t3.time_period,sum(times) times from "+
			"  ( "+
			"    select t2.station_nm,t1.time_period,sum(times) times from "+
			"    ( "+
			"      select station_id,substr(end_time,9,2)||':'||lpad(trunc(to_number(substr(end_time,11,2))/5,0)*5,2,'0') time_period,round(sum("+total_times+")/100) times from "+sql_tp2+
			"      group by station_id,substr(end_time,9,2)||':'||lpad(trunc(to_number(substr(end_time,11,2))/5,0)*5,2,'0')  "+
			"    ) t1, "+
			"    (select station_id,trim(station_nm_cn) station_nm from viw_metro_station_name where '"+com_date+"' between start_time and end_time) t2 "+
			"    where t1.station_id=t2.station_id "+
			"    group by t2.station_nm,t1.time_period "+
			"  ) t3, "+
			"  (select trim(station_nm_cn) station_nm from viw_metro_station_name where '"+com_date+"' between start_time and end_time "+sql_tp3+") t4 "+
			"  where t3.station_nm=t4.station_nm group by t3.time_period "+
			") bb where aa.time_period(+)=bb.time_period  "+
			"order by bb.time_period ";
		}

		list = jsonTagJdbcDao.getJdbcTemplate().queryForList(sql);
		return list;
	}
	
	public String getStart_date() {
		return start_date;
	}

	public void setStart_date(String startDate) {
		start_date = startDate;
	}

	public String getFlux_flag() {
		return flux_flag;
	}

	public void setFlux_flag(String fluxFlag) {
		flux_flag = fluxFlag;
	}

	public String getCom_date() {
		return com_date;
	}

	public void setCom_date(String comDate) {
		com_date = comDate;
	}

	public String getSel_flag() {
		return sel_flag;
	}

	public void setSel_flag(String selFlag) {
		sel_flag = selFlag;
	}

	public String getLine_id() {
		return line_id;
	}

	public void setLine_id(String lineId) {
		line_id = lineId;
	}

	public String getStation_id() {
		return station_id;
	}

	public void setStation_id(String stationId) {
		station_id = stationId;
	}



}
