package com.gmoa.vos.qrcd;


import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import jsontag.annotation.JsonTagAnnotation;
import jsontag.dao.JsonTagTemplateDaoImpl;
import jsontag.interf.IDoService;

import org.apache.commons.lang.StringUtils;


/**
 * 查询二维码分时客流
 * 日期格式：yyyymmdd
 *
 */    
@JsonTagAnnotation(actionValue="/get_qrcdalllineflux.action",namespace="/qrcd",isJsonReturn=true)
public class GetQrcdAllLineFlux extends JsonTagTemplateDaoImpl implements IDoService {
	private String sel_flag;
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
		if("period".equals(sel_flag)){
			sql=new StringBuffer();
			
			sql.append("select bb.period,case when bb.period<=bb.curhour then nvl(enter_times,0) else enter_times end enter_times, ");
			sql.append(" case when bb.period<=bb.curhour then nvl(exit_times,0) else exit_times end exit_times from  ");
			sql.append("(  ");
			sql.append("  select substr(start_time,9,2)||':'||lpad(trunc(to_number(substr(start_time,11,2))/30,0)*30,2,'0') period,round(sum(enter_times)/100) enter_times,round(sum(exit_times)/100) exit_times from tbl_metro_fluxnew_").append(start_date);
			sql.append("  where ticket_type in ('210','212','211','213','214') group by substr(start_time,9,2)||':'||lpad(trunc(to_number(substr(start_time,11,2))/30,0)*30,2,'0') ");
			sql.append(") aa,  ");
			sql.append("(  ");
			sql.append("  select period,to_char(sysdate,'hh24:mi') curhour from(select to_char(to_date('20160201 0000','yyyyMMdd hh24:mi')-(level-1)/48,'hh24:mi') period from dual connect by level<=48) ");  
			sql.append("  where period>='04:00'  ");
			sql.append(") bb where bb.period=aa.period(+) order by bb.period ");
			list = jsonTagJdbcDao.getJdbcTemplate().queryForList(sql.toString());
		}else if("period_new".equals(sel_flag)){
			list=findPeriodFlux();
		}
		return list;
	}

	
	private List findPeriodFlux() throws Exception{
		List list=null;
		
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
		Date start_date=df.parse(start_day);
		
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(new Date());
		calendar.add(GregorianCalendar.DAY_OF_MONTH, -60);
		Date tempDate = calendar.getTime();
		
		calendar.setTime(start_date);
		calendar.add(GregorianCalendar.DAY_OF_MONTH,1);
		String next_date=df.format(calendar.getTime());
		
		StringBuffer sql_tp1=new StringBuffer();
		StringBuffer sql_tp2=new StringBuffer();
		if(start_date.compareTo(tempDate) > 0) {
			sql_tp1.append(" tbl_metro_fluxnew_").append(start_day).append(" where ticket_type in ('210','212','211','213','214') and start_time>='").append(start_day).append("020000' ");
			sql_tp2.append(" tbl_metro_fluxnew_").append(next_date).append(" where ticket_type in ('210','212','211','213','214') and start_time<'").append(next_date).append("020000' ");
		}else{
			sql_tp1.append(" tbl_metro_fluxnew_history partition(V").append(start_day).append("_FLUXNEW_HISTORY) where ticket_type in ('210','212','211','213','214') and start_time>='").append(start_day).append("020000' ");
			sql_tp2.append(" tbl_metro_fluxnew_history partition(V").append(next_date).append("_FLUXNEW_HISTORY) where ticket_type in ('210','212','211','213','214') and start_time<'").append(next_date).append("020000' ");
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
		list = jsonTagJdbcDao.getJdbcTemplate().queryForList(sql.toString());
		return list;
	}
	
	
	public String getSel_flag() {
		return sel_flag;
	}

	public void setSel_flag(String selFlag) {
		sel_flag = selFlag;
	}

	public String getStart_day() {
		return start_day;
	}

	public void setStart_day(String startDay) {
		start_day = startDay;
	}

	
}
