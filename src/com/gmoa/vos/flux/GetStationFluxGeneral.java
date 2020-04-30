package com.gmoa.vos.flux;


import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import jsontag.annotation.JsonTagAnnotation;
import jsontag.interf.IDoService;
import jsontag.dao.JsonTagTemplateDaoImpl;


/**
 * 车站综合报表
 * 日期格式：yyyymmdd
 *
 */    
@JsonTagAnnotation(actionValue="/get_general_flux.action",namespace="/station",isJsonReturn=true)
public class GetStationFluxGeneral extends JsonTagTemplateDaoImpl implements IDoService {
	private String station_id;
	private String sel_date;
	private String com_date;
	private String sel_flag;
	
	

	@Override
	public Object doService() throws Exception {
		List<Map<String,Object>> list=null;
		String sql="";
		//查询线路和车站信息
		if("1".equals(sel_flag)){
			sql="select line_id,to_number(line_id)||'号线' line_nm,station_id,trim(station_nm_cn) station_nm from viw_metro_station_name "+
				" where to_char(sysdate,'yyyyMMdd') between start_time and end_time order by station_id";
			list=jsonTagJdbcDao.getJdbcTemplate().queryForList(sql);
		}
		return list;
	}

	//查询车站客流
	public List findStationFlux(){
		try{
			SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
			java.util.Date s_date1=df.parse(sel_date);
			java.util.Date s_date2=df.parse(com_date);
			
			Calendar calendar = Calendar.getInstance(); 
		    calendar.setTime(new java.util.Date());
			calendar.add(GregorianCalendar.DAY_OF_MONTH, -60);
			java.util.Date tempDate = calendar.getTime();
			String tp_sql1=" tbl_metro_fluxnew_"+sel_date+" where ticket_type not in ('40','41','130','131','140','141') ";
			String tp_sql2=" tbl_metro_fluxnew_"+com_date+" where ticket_type not in ('40','41','130','131','140','141') ";
			if(s_date1.compareTo(tempDate)<=0) {
				tp_sql1=" tbl_metro_fluxnew_history partition(V"+sel_date+"_FLUXNEW_HISTORY) where 1=1 ";
			}
			if(s_date2.compareTo(tempDate)<=0) {
				tp_sql2=" tbl_metro_fluxnew_history partition(V"+com_date+"_FLUXNEW_HISTORY) where 1=1 ";
			}
			
		}catch (Exception e) {
			
		}
		
		return null;
	}

	public String getStation_id() {
		return station_id;
	}
	public void setStation_id(String stationId) {
		station_id = stationId;
	}
	public String getSel_date() {
		return sel_date;
	}
	public void setSel_date(String selDate) {
		sel_date = selDate;
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
	
}
