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
 * 根据日期、进出换类型查询车站客流增幅、增量排名
 * 日期格式：yyyymmdd
 *
 */    
@JsonTagAnnotation(actionValue="/get_station_fluxcompare.action",namespace="/station",isJsonReturn=true)
public class GetStationFluxCompare extends JsonTagTemplateDaoImpl implements IDoService {
	private String start_date;
	private String com_date;
	private String sel_flag;
	private String flux_flag;
	private String stations;
	
	@Override
	public Object doService() throws Exception {
		
		List<Map<String,Object>> list=null;
		String sql="";
		String sql_tp1="";
		String sql_tp2="";
		
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
		String pm_stations="";
		if(StringUtils.isNotBlank(stations)){
			String[] station=stations.split(",");
			for(int i=0;i<station.length-1;i++){
				pm_stations+="'"+station[i]+"',";
			}
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
			sql_tp1=" tbl_metro_fluxnew_"+start_date+" where ticket_type not in ('40','41','130','131','140','141') "
			+(today.equals(start_date)||today.equals(com_date)?" and '"+start_date+"'||to_char(sysdate-30/(24*60),'hh24miss')>=end_time ":"");
		}else{
			sql_tp1=" tbl_metro_fluxnew_history partition(V"+start_date+"_FLUXNEW_HISTORY) "
			+(today.equals(com_date)?" where '"+start_date+"'||to_char(sysdate-30/(24*60),'hh24miss')>=end_time ":"");
		}
		if(s_date.compareTo(tempDate) > 0) {
			sql_tp2=" tbl_metro_fluxnew_"+com_date+" where ticket_type not in ('40','41','130','131','140','141') "
			+(today.equals(start_date)||today.equals(com_date)?" and '"+com_date+"'||to_char(sysdate-30/(24*60),'hh24miss')>=end_time ":"");
		}else{
			sql_tp2=" tbl_metro_fluxnew_history partition(V"+com_date+"_FLUXNEW_HISTORY) "
			+(today.equals(start_date)?" where '"+com_date+"'||to_char(sysdate-30/(24*60),'hh24miss')>=end_time ":"");
		}
		
		
		sql="select * from "+
			" ( "+
			"   select t1.*,t2.times com_times,round((t1.times-t2.times)/t2.times*100,2) add_per,t1.times-t2.times add_times from "+
			"   ( "+
			"     select round(sum(aa.times)/100) times,bb.station_nm from  "+
			"     (  "+
			"       select station_id,sum("+total_times+") times from "+sql_tp1+" group by station_id  "+
			"     ) aa,  "+
			"     (select station_id,trim(station_nm_cn) station_nm from viw_metro_station_name where ? between start_time and end_time) bb "+ 
			"     where aa.station_id=bb.station_id group by bb.station_nm "+ 
			"   ) t1, "+
			"   ( "+
			"     select round(sum(aa.times)/100) times,bb.station_nm from "+ 
			"     ( "+ 
			"       select station_id,sum("+total_times+") times from "+sql_tp2+" group by station_id "+ 
			"     ) aa, "+ 
			"     (select station_id,trim(station_nm_cn) station_nm from viw_metro_station_name where ? between start_time and end_time) bb "+ 
			"     where aa.station_id=bb.station_id group by bb.station_nm "+
			"   ) t2 where t2.times>0 and t1.station_nm=t2.station_nm "+(pm_stations.length()>0?" and t1.station_nm in ("+pm_stations.substring(0,pm_stations.length()-1)+")":"")+
			"   order by "+("zf".equals(sel_flag)?"add_per":"add_times")+" desc "+
			" ) where rownum<=10";
		list = jsonTagJdbcDao.getJdbcTemplate().queryForList(sql,start_date,com_date);
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

	public String getStations() {
		return stations;
	}

	public void setStations(String stations) {
		this.stations = stations;
	}


}
