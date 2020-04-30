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
 * 车站客流分时比较
 * 日期格式：yyyymmdd
 *
 */    
@JsonTagAnnotation(actionValue="/get_station_periodflux.action",namespace="/station",isJsonReturn=true)
public class GetStationPeriodFlux extends JsonTagTemplateDaoImpl implements IDoService{
	private String startDate;
	private String comDate;
	private String lineId;
	private String stationId;
	private String ckflag;
	
	@Override
	public Object doService() throws Exception {
		
		List<Map<String,Object>> list=null;
		String sql_tp1="";
		String sql_tp2="";
		
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
   		Date f_date=df.parse(startDate);
   		Date s_date=df.parse(comDate);
   		GregorianCalendar calendar = new GregorianCalendar();
		calendar.add(GregorianCalendar.DAY_OF_MONTH, -60);
		Date tempDate = calendar.getTime();
		//查询日期和服务器的当前日期比较，如果查询日期是60天以前，则查询tbl_metro_fluxnew_history表
		if(f_date.compareTo(tempDate) > 0) {
			sql_tp1=" tbl_metro_fluxnew_"+startDate+" where ticket_type not in ('40','41','130','131','140','141') and line_id='"+lineId+"  '";
		}else{
			sql_tp1=" tbl_metro_fluxnew_history partition(V"+startDate+"_FLUXNEW_HISTORY) where line_id='"+lineId+"  '";
		}
		if(s_date.compareTo(tempDate) > 0) {
			sql_tp2=" tbl_metro_fluxnew_"+comDate+" where ticket_type not in ('40','41','130','131','140','141') and line_id='"+lineId+"  '";
		}else{
			sql_tp2=" tbl_metro_fluxnew_history partition(V"+comDate+"_FLUXNEW_HISTORY) where line_id='"+lineId+"  '";
		}
		if(StringUtils.isNotBlank(stationId)){
			sql_tp1+=" and station_id='"+stationId+" '";
			sql_tp2+=" and station_id='"+stationId+" '";
		}
		
		StringBuffer sql=new StringBuffer();
		sql.append("select cc.period,aa.times,bb.times cp_times from ");
		sql.append("( ");
		sql.append("  select substr(start_time,9,2)||':'||lpad(trunc(to_number(substr(start_time,11,2))/5,0)*5,2,'0') period,round(sum(enter_times+change_times)/100) times from ").append(sql_tp1); 
		sql.append("  group by substr(start_time,9,2)||':'||lpad(trunc(to_number(substr(start_time,11,2))/5,0)*5,2,'0') ");
		sql.append(") aa, ");
		sql.append("( ");
		sql.append("  select substr(start_time,9,2)||':'||lpad(trunc(to_number(substr(start_time,11,2))/5,0)*5,2,'0') period,round(sum(enter_times+change_times)/100) times from ").append(sql_tp2); 
		sql.append("  group by substr(start_time,9,2)||':'||lpad(trunc(to_number(substr(start_time,11,2))/5,0)*5,2,'0') ");
		sql.append(") bb, ");
		sql.append("(select to_char(to_date('20160201 0000','yyyyMMdd hh24:mi')-(level-1)/288,'hh24:mi') period from dual connect by level<=288) cc ");
		sql.append("where cc.period=aa.period(+) and cc.period=bb.period(+) and cc.period>='0500' order by cc.period ");
		list = jsonTagJdbcDao.getJdbcTemplate().queryForList(sql.toString());
		return list;
	}

	

	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getComDate() {
		return comDate;
	}
	public void setComDate(String comDate) {
		this.comDate = comDate;
	}
	public String getStationId() {
		return stationId;
	}
	public void setStationId(String stationId) {
		this.stationId = stationId;
	}
	public String getLineId() {
		return lineId;
	}
	public void setLineId(String lineId) {
		this.lineId = lineId;
	}
	public String getCkflag() {
		return ckflag;
	}
	public void setCkflag(String ckflag) {
		this.ckflag = ckflag;
	}

}
