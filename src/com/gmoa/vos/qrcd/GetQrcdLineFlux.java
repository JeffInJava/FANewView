package com.gmoa.vos.qrcd;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import jsontag.annotation.JsonTagAnnotation;
import jsontag.dao.JsonTagTemplateDaoImpl;
import jsontag.interf.IDoService;


/**
 * 查询线路、车站的二维码客流、收益，车站的排名
 * 日期格式：yyyymmdd
 *
 */    
@JsonTagAnnotation(actionValue="/get_qrcdlineflux.action",namespace="/qrcd",isJsonReturn=true)
public class GetQrcdLineFlux extends JsonTagTemplateDaoImpl implements IDoService {
	private String sel_flag;
	private String flux_flag;
	private String line_id;
	private String start_day;
	
	@Override
	public Object doService() throws Exception {
		List list=null;
		
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
		String start_date=df.format(new Date());
		if(StringUtils.isNotBlank(start_day)){
			start_date=start_day;
		}
		
		StringBuffer sql=null;
		if("line".equals(sel_flag)){
			sql=new StringBuffer();
			sql.append("select aa.*,nvl(bb.income_value,0) income_value from ");
			sql.append("( ");
			sql.append("  select line_id,round(sum(enter_times)/100) enter_times,round(sum(exit_times)/100) exit_times from tbl_metro_fluxnew_").append(start_date);
			sql.append("  where ticket_type in ('210','212','211','213','214') group by line_id ");
			sql.append(") aa, ");
			sql.append("( ");
			sql.append("  select t2.line_id,round(sum(income_value)/100) income_value from ");
			sql.append("  ( ");
			sql.append("    select owner_id,sum(income_value) income_value from tbl_metro_sta_inc_day  ");
			sql.append("    where stmt_day=? and ticket_type in ('210','212','211','213','214') ");
			sql.append("    group by owner_id ");
			sql.append("  ) t1, ");
			sql.append("  (select * from viw_metro_benf_name where to_char(sysdate,'yyyymmdd') between start_time and end_time) t2 ");
			sql.append("  where t1.owner_id=t2.benf_id group by t2.line_id ");
			sql.append(") bb where aa.line_id=bb.line_id(+) order by aa.line_id");
			list = jsonTagJdbcDao.getJdbcTemplate().queryForList(sql.toString(),start_date);
		}else if("station".equals(sel_flag)){
			sql=new StringBuffer();
			sql.append("select bb.*,nvl(aa.enter_times,0) enter_times,nvl(aa.exit_times,0) exit_times from ");
			sql.append("( ");
			sql.append("  select trim(station_id) station_id,round(sum(enter_times)/100) enter_times,round(sum(exit_times)/100) exit_times from tbl_metro_fluxnew_").append(start_date);
			sql.append("  where trim(line_id)=? and ticket_type in ('210','212','211','213','214') group by station_id ");
			sql.append(") aa, ");
			sql.append("( ");
			sql.append("  select trim(station_id) station_id,trim(station_nm_cn) station_nm from tbl_metro_station_time ");
			sql.append(") bb where aa.station_id=bb.station_id order by bb.station_id ");
			list = jsonTagJdbcDao.getJdbcTemplate().queryForList(sql.toString(),line_id.trim());
		}else if("rank".equals(sel_flag)){
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
			
			sql=new StringBuffer();
			sql.append("select station_nm,times,rownum rn from ");
			sql.append("( ");
			sql.append("  select bb.station_nm,sum(times) times from ");
			sql.append("  ( ");
			sql.append("    select station_id,round(sum(").append(total_times).append(")/100) times from tbl_metro_fluxnew_").append(start_date);
			sql.append("    where ticket_type in ('210','212','211','213','214') group by station_id ");
			sql.append("  ) aa, ");
			sql.append("  ( ");
			sql.append("    select line_id,station_id,trim(station_nm_cn) station_nm from viw_metro_station_name where to_char(sysdate,'yyyymmdd') between start_time and end_time ");
			sql.append("  ) bb where aa.station_id=bb.station_id ");
			sql.append("  group by bb.station_nm order by times desc ");
			sql.append(") where rownum<=20 ");
			list = jsonTagJdbcDao.getJdbcTemplate().queryForList(sql.toString());
		}else if("period".equals(sel_flag)){
			sql=new StringBuffer();
			sql.append("select bb.period||':00' period,case when bb.period<=bb.curhour then nvl(enter_times,0) else enter_times end enter_times,");
			sql.append(" case when bb.period<=bb.curhour then nvl(exit_times,0) else exit_times end exit_times from ");
			sql.append("( ");
			sql.append("  select substr(start_time,9,2) period,round(sum(enter_times)/100) enter_times,round(sum(exit_times)/100) exit_times from tbl_metro_fluxnew_").append(start_date);
			sql.append("  where trim(line_id)=? and ticket_type in ('210','212','211','213','214') group by substr(start_time,9,2) ");
			sql.append(") aa, ");
			sql.append("( ");
			sql.append("  select period,to_char(sysdate,'hh24') curhour from(select to_char(to_date('20160201 0000','yyyyMMdd hh24:mi')-(level-1)/24,'hh24') period from dual connect by level<=24) "); 
			sql.append("  where period>='04' ");
			sql.append(") bb where bb.period=aa.period(+) order by bb.period ");
			list = jsonTagJdbcDao.getJdbcTemplate().queryForList(sql.toString(),line_id.trim());
		}else if("line_new".equals(sel_flag)){
			list=findLineFlux();
		}else if("period_new".equals(sel_flag)){
			list=findLinePeriodFlux();
		}else if("station_new".equals(sel_flag)){
			list=findLineStationFlux();
		}else if("rank_new".equals(sel_flag)){
			list=findStationRank();
		}
		
		return list;
	}
	
	public Map<String,StringBuffer> pingSql() throws ParseException{
		Map<String,StringBuffer> map=new HashMap<String,StringBuffer>();
		StringBuffer sql_tp1=new StringBuffer();
		StringBuffer sql_tp2=new StringBuffer();
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
		Date start_date=df.parse(start_day);
		
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(new Date());
		calendar.add(GregorianCalendar.DAY_OF_MONTH, -60);
		Date tempDate = calendar.getTime();
		
		calendar.setTime(start_date);
		calendar.add(GregorianCalendar.DAY_OF_MONTH,1);
		String next_date=df.format(calendar.getTime());
		
		if(start_date.compareTo(tempDate) > 0) {
			sql_tp1.append(" tbl_metro_fluxnew_").append(start_day).append(" where ticket_type in ('210','212','211','213','214') and start_time>='").append(start_day).append("020000' ");
			sql_tp2.append(" tbl_metro_fluxnew_").append(next_date).append(" where ticket_type in ('210','212','211','213','214') and start_time<'").append(next_date).append("020000' ");
		}else{
			sql_tp1.append(" tbl_metro_fluxnew_history partition(V").append(start_day).append("_FLUXNEW_HISTORY) where ticket_type in ('210','212','211','213','214') and start_time>='").append(start_day).append("020000' ");
			sql_tp2.append(" tbl_metro_fluxnew_history partition(V").append(next_date).append("_FLUXNEW_HISTORY) where ticket_type in ('210','212','211','213','214') and start_time<'").append(next_date).append("020000' ");
		}
		map.put("sql_tp1", sql_tp1);
		map.put("sql_tp2", sql_tp2);
		return map;
	}

	//查询线路客流(修改,日期跨日)
	private List findLineFlux() throws Exception{
		List list=null;
		
		//判断日期，拼接sql
		Map<String,StringBuffer> map=pingSql();
		StringBuffer sql_tp1=map.get("sql_tp1");
		StringBuffer sql_tp2=map.get("sql_tp2");
		
		StringBuffer sql=new StringBuffer();
		sql.append("select bb.line_id,nvl(aa.enter_times,0) enter_times,nvl(aa.exit_times,0) exit_times from ");
		sql.append("( ");
		sql.append("  select trim(line_id) line_id,sum(enter_times) enter_times,sum(exit_times) exit_times from ");
		sql.append("  ( ");
		sql.append("    select line_id,round(sum(enter_times)/100) enter_times,round(sum(exit_times)/100) exit_times from ").append(sql_tp1);
		sql.append("    group by line_id ");
		sql.append("    union all ");
		sql.append("    select line_id,round(sum(enter_times)/100) enter_times,round(sum(exit_times)/100) exit_times from ").append(sql_tp2);
		sql.append("    group by line_id ");
		sql.append("  ) group by line_id ");
		sql.append(") aa, ");
		sql.append("(select trim(line_id) line_id from viw_metro_line_name where '").append(start_day).append("' between start_time and end_time) bb ");
		sql.append("where bb.line_id=aa.line_id(+) order by bb.line_id ");
		list = jsonTagJdbcDao.getJdbcTemplate().queryForList(sql.toString());
		return list;
	}
	
	//查询线路分时客流(修改,日期跨日)
	private List findLinePeriodFlux() throws Exception{
		List list=null;
		
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
		
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(df.parse(start_day));
		calendar.add(GregorianCalendar.DAY_OF_MONTH,1);
		String next_date=df.format(calendar.getTime());
		
		//判断日期，拼接sql
		Map<String,StringBuffer> map=pingSql();
		StringBuffer sql_tp1=map.get("sql_tp1");
		StringBuffer sql_tp2=map.get("sql_tp2");
		if(sql_tp1!=null&&sql_tp2!=null){
			sql_tp1.append(" and trim(line_id)=? ");
			sql_tp2.append(" and trim(line_id)=? ");
		}
		
		StringBuffer sql=new StringBuffer();
		sql.append("select substr(period,9,5) period,sum(enter_times) over(order by period) lj_enter_times,enter_times, ");
		sql.append("sum(exit_times) over(order by period) lj_exit_times,exit_times from ");
		sql.append("( ");
		sql.append("  select bb.period,case when bb.period<=bb.curhour then nvl(enter_times,0) else enter_times end enter_times, "); 
		sql.append("   case when bb.period<=bb.curhour then nvl(exit_times,0) else exit_times end exit_times from ");
		sql.append("  ( ");
		sql.append("    select substr(start_time,1,10)||':'||lpad(trunc(to_number(substr(start_time,11,2))/30,0)*30,2,'0') period,round(sum(enter_times)/100) enter_times,round(sum(exit_times)/100) exit_times from ").append(sql_tp1);
		sql.append("    group by substr(start_time,1,10)||':'||lpad(trunc(to_number(substr(start_time,11,2))/30,0)*30,2,'0') ");
		sql.append("  ) aa, ");
		sql.append("  ( ");
		sql.append("    select '").append(start_day).append("'||period period,to_char(sysdate,'yyyyMMddhh24:mi') curhour from  ");
		sql.append("    (select to_char(to_date('20160201 0000','yyyyMMdd hh24:mi')-(level-1)/48,'hh24:mi') period from dual connect by level<=48) where period>='02:00' ");
		sql.append("  ) bb where bb.period=aa.period(+) ");
		sql.append("  union all ");
		sql.append("  select bb.period,case when bb.period<=bb.curhour then nvl(enter_times,0) else enter_times end enter_times, "); 
		sql.append("   case when bb.period<=bb.curhour then nvl(exit_times,0) else exit_times end exit_times from ");
		sql.append("  ( ");
		sql.append("    select substr(start_time,1,10)||':'||lpad(trunc(to_number(substr(start_time,11,2))/30,0)*30,2,'0') period,round(sum(enter_times)/100) enter_times,round(sum(exit_times)/100) exit_times from ").append(sql_tp2);
		sql.append("    group by substr(start_time,1,10)||':'||lpad(trunc(to_number(substr(start_time,11,2))/30,0)*30,2,'0') ");
		sql.append("  ) aa, ");
		sql.append("  ( ");
		sql.append("    select '").append(next_date).append("'||period period,to_char(sysdate,'yyyyMMddhh24:mi') curhour from  ");
		sql.append("    (select to_char(to_date('20160201 0000','yyyyMMdd hh24:mi')-(level-1)/48,'hh24:mi') period from dual connect by level<=48) where period<'02:00' ");
		sql.append("  ) bb where bb.period=aa.period(+) ");
		sql.append(") ");
		list = jsonTagJdbcDao.getJdbcTemplate().queryForList(sql.toString(),line_id,line_id);
		return list;
	}
	
	//查询线路的车站客流(修改,日期跨日)
	private List findLineStationFlux() throws Exception{
		List list=null;
		//判断日期，拼接sql
		Map<String,StringBuffer> map=pingSql();
		StringBuffer sql_tp1=map.get("sql_tp1");
		StringBuffer sql_tp2=map.get("sql_tp2");
		if(sql_tp1!=null&&sql_tp2!=null){
			sql_tp1.append(" and trim(line_id)=? ");
			sql_tp2.append(" and trim(line_id)=? ");
		}
		
		StringBuffer sql=new StringBuffer();
		sql.append("select bb.*,nvl(aa.enter_times,0) enter_times,nvl(aa.exit_times,0) exit_times from ");
		sql.append("( ");
		sql.append("  select station_id,sum(enter_times) enter_times,sum(exit_times) exit_times from ");
		sql.append("  ( ");
		sql.append("  	select trim(station_id) station_id,round(sum(enter_times)/100) enter_times,round(sum(exit_times)/100) exit_times from ").append(sql_tp1);
		sql.append("  	group by station_id ");
		sql.append("  	union all ");
		sql.append("  	select trim(station_id) station_id,round(sum(enter_times)/100) enter_times,round(sum(exit_times)/100) exit_times from ").append(sql_tp2);
		sql.append("  	group by station_id ");
		sql.append("  ) group by station_id ");
		sql.append(") aa, ");
		sql.append("( ");
		sql.append("  select trim(station_id) station_id,trim(station_nm_cn) station_nm from tbl_metro_station_time ");
		sql.append(") bb where aa.station_id=bb.station_id order by bb.station_id ");
		list = jsonTagJdbcDao.getJdbcTemplate().queryForList(sql.toString(),line_id,line_id);
		return list;
	}
	
	//查询车站客流排名(修改,日期跨日)
	private List findStationRank() throws Exception{
		List list=null;
		//判断日期，拼接sql
		Map<String,StringBuffer> map=pingSql();
		StringBuffer sql_tp1=map.get("sql_tp1");
		StringBuffer sql_tp2=map.get("sql_tp2");
		
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
		
		StringBuffer sql=new StringBuffer();
		sql.append("select station_nm,times,rownum rn from ");
		sql.append("( ");
		sql.append("  select bb.station_nm,sum(times) times from ");
		sql.append("  ( ");
		sql.append("    select trim(station_id) station_id,round(sum(").append(total_times).append(")/100) times from ").append(sql_tp1);
		sql.append("    group by station_id ");
		sql.append("    union all ");
		sql.append("    select trim(station_id) station_id,round(sum(").append(total_times).append(")/100) times from ").append(sql_tp2);
		sql.append("    group by station_id ");
		sql.append("  ) aa, ");
		sql.append("  ( ");
		sql.append("	select station_id,case when station_id='0418' then trim(station_nm_cn)||'04' when station_id='0631' then trim(station_nm_cn)||'06' else trim(station_nm_cn) end station_nm "); 
		sql.append("	from viw_metro_station_name where to_char(sysdate,'yyyymmdd') between start_time and end_time ");
		sql.append("  ) bb where aa.station_id=bb.station_id ");
		sql.append("  group by bb.station_nm order by times desc ");
		sql.append(") where rownum<=20 ");
		list = jsonTagJdbcDao.getJdbcTemplate().queryForList(sql.toString());
		return list;
	}
	
	public String getSel_flag() {
		return sel_flag;
	}

	public void setSel_flag(String selFlag) {
		sel_flag = selFlag;
	}

	public String getFlux_flag() {
		return flux_flag;
	}

	public void setFlux_flag(String fluxFlag) {
		flux_flag = fluxFlag;
	}

	public String getLine_id() {
		return line_id;
	}

	public void setLine_id(String lineId) {
		line_id = lineId;
	}

	public String getStart_day() {
		return start_day;
	}

	public void setStart_day(String startDay) {
		start_day = startDay;
	}

}
