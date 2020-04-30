package com.gmoa.vos.qrcd;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import jsontag.annotation.JsonTagAnnotation;
import jsontag.dao.JsonTagTemplateDaoImpl;
import jsontag.interf.IDoService;


/**
 * 查询进站分时对比
 * 日期格式：yyyymmdd
 *
 */    
@JsonTagAnnotation(actionValue="/get_qrcdperiodcp.action",namespace="/qrcd",isJsonReturn=true)
public class GetQrcdPeriodCp extends JsonTagTemplateDaoImpl implements IDoService {
	private String sel_flag;
	private String start_day;
	private String compare_day;
	private String seg;
	
	@Override
	public Object doService() throws Exception {
		List list=null;
		
		StringBuffer sql=null;
		if("period_cp".equals(sel_flag)){
			int nm=48;
			if("60".equals(seg)){
				nm=24;
			}
			sql=new StringBuffer();
			sql.append("select bb.period,aa.enter_times,aa.total_times,nvl(bb.enter_times,0) cp_enter_times,nvl(bb.total_times,0) cp_total_times from ");
			sql.append("( ");
			sql.append("  select t2.period,nvl(sum(enter_times) over(order by t2.period),0) total_times,nvl(enter_times,0) enter_times from ");
			sql.append("  ( ");
			sql.append("    select round(sum(enter_times)/100) enter_times,substr(start_time,9,2)||':'||lpad(trunc(to_number(substr(start_time,11,2))/").append(seg).append(",0)*").append(seg).append(",2,'0') period from tbl_metro_fluxnew_").append(start_day); 
			sql.append("    where ticket_type between 210 and 214 ");
			sql.append("    group by substr(start_time,9,2)||':'||lpad(trunc(to_number(substr(start_time,11,2))/").append(seg).append(",0)*").append(seg).append(",2,'0') ");
			sql.append("  ) t1, ");
			sql.append("  ( ");
			sql.append("  	select * from ( ");
			sql.append("      select to_char(to_date('20160201 0000','yyyyMMdd hh24:mi')-(level-1)/").append(nm).append(",'hh24:mi') period from dual connect by level<=").append(nm);
			sql.append("  	) where period<=to_char(sysdate,'hh24:mi') ");
			sql.append("  ) t2 where t2.period=t1.period(+) ");
			sql.append(")aa, ");
			sql.append("( ");
			sql.append("  select t2.period,sum(enter_times) over(order by t2.period) total_times,enter_times from ");
			sql.append("  ( ");
			sql.append("    select round(sum(enter_times)/100) enter_times,substr(start_time,9,2)||':'||lpad(trunc(to_number(substr(start_time,11,2))/").append(seg).append(",0)*").append(seg).append(",2,'0') period from tbl_metro_fluxnew_").append(compare_day); 
			sql.append("    where ticket_type between 210 and 214 ");
			sql.append("    group by substr(start_time,9,2)||':'||lpad(trunc(to_number(substr(start_time,11,2))/").append(seg).append(",0)*").append(seg).append(",2,'0') ");
			sql.append("  ) t1, ");
			sql.append("  ( ");
			sql.append("     select to_char(to_date('20160201 0000','yyyyMMdd hh24:mi')-(level-1)/").append(nm).append(",'hh24:mi') period from dual connect by level<=").append(nm);
			sql.append("  ) t2 where t2.period=t1.period(+) ");
			sql.append(") bb where aa.period(+)=bb.period order by bb.period");
			
			list = jsonTagJdbcDao.getJdbcTemplate().queryForList(sql.toString());
		}else if("period_cp_new".equals(sel_flag)){
			list=findEnterPeriod();
		}
		return list;
	}

	//二维码进站分时、累计对比（修改，日期跨日）
	private List findEnterPeriod() throws Exception{
		List list=null;
		StringBuffer sql_tp1=new StringBuffer();
		StringBuffer sql_tp2=new StringBuffer();
		StringBuffer cpsql_tp1=new StringBuffer();
		StringBuffer cpsql_tp2=new StringBuffer();
		
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
		
		Date compare_date=df.parse(compare_day);
		calendar.setTime(compare_date);
		calendar.add(GregorianCalendar.DAY_OF_MONTH,1);
		String compare_next_day=df.format(calendar.getTime());
		if(compare_date.compareTo(tempDate) > 0) {
			cpsql_tp1.append(" tbl_metro_fluxnew_").append(compare_day).append(" where ticket_type in ('210','212','211','213','214') and start_time>='").append(compare_day).append("020000' ");
			cpsql_tp2.append(" tbl_metro_fluxnew_").append(compare_next_day).append(" where ticket_type in ('210','212','211','213','214') and start_time<'").append(compare_next_day).append("020000' ");
		}else{
			cpsql_tp1.append(" tbl_metro_fluxnew_history partition(V").append(compare_day).append("_FLUXNEW_HISTORY) where ticket_type in ('210','212','211','213','214') and start_time>='").append(compare_day).append("020000' ");
			cpsql_tp2.append(" tbl_metro_fluxnew_history partition(V").append(compare_next_day).append("_FLUXNEW_HISTORY) where ticket_type in ('210','212','211','213','214') and start_time<'").append(compare_next_day).append("020000' ");
		}
		
		int nm=48;
		if("60".equals(seg)){
			nm=24;
		}
		StringBuffer sql=new StringBuffer();
		sql.append("select t1.period,t1.enter_times,case when t1.enter_times is null then null else t1.total_times end total_times, ");
		sql.append("t2.enter_times cp_enter_times,case when t2.enter_times is null then null else t2.total_times end cp_total_times from ");
		sql.append("( ");
		sql.append("  select substr(period,9,5) period,case when period<=curhour then nvl(enter_times,0) else enter_times end enter_times,  ");
		sql.append("  nvl(sum(enter_times) over(order by period),0) total_times from  ");
		sql.append("  (  ");
		sql.append("    select bb.period,bb.curhour,aa.enter_times from  ");
		sql.append("    (  ");
		sql.append("      select substr(start_time,1,10)||':'||lpad(trunc(to_number(substr(start_time,11,2))/").append(seg).append(",0)*").append(seg).append(",2,'0') period,round(sum(enter_times)/100) enter_times from  ").append(sql_tp1);
		sql.append("      group by substr(start_time,1,10)||':'||lpad(trunc(to_number(substr(start_time,11,2))/").append(seg).append(",0)*").append(seg).append(",2,'0')  ");
		sql.append("    ) aa,  ");
		sql.append("    (  ");
		sql.append("      select '").append(start_day).append("'||period period,to_char(sysdate,'yyyyMMddhh24:mi') curhour from  "); 
		sql.append("      (select to_char(to_date('20160201 0000','yyyyMMdd hh24:mi')-(level-1)/").append(nm).append(",'hh24:mi') period from dual connect by level<=").append(nm).append(") where period>='02:00' "); 
		sql.append("    ) bb where bb.period=aa.period(+)  ");
		sql.append("    union all  ");
		sql.append("    select bb.period,bb.curhour,aa.enter_times from  ");
		sql.append("    (  ");
		sql.append("      select substr(start_time,1,10)||':'||lpad(trunc(to_number(substr(start_time,11,2))/").append(seg).append(",0)*").append(seg).append(",2,'0') period,round(sum(enter_times)/100) enter_times from ").append(sql_tp2);
		sql.append("      group by substr(start_time,1,10)||':'||lpad(trunc(to_number(substr(start_time,11,2))/").append(seg).append(",0)*").append(seg).append(",2,'0')  ");
		sql.append("    ) aa,  ");
		sql.append("    (  ");
		sql.append("      select '").append(next_date).append("'||period period,to_char(sysdate,'yyyyMMddhh24:mi') curhour from  "); 
		sql.append("      (select to_char(to_date('20160201 0000','yyyyMMdd hh24:mi')-(level-1)/").append(nm).append(",'hh24:mi') period from dual connect by level<=").append(nm).append(") where period<'02:00' "); 
		sql.append("    ) bb where bb.period=aa.period(+)  ");
		sql.append("  ) ");
		sql.append(") t1, ");
		sql.append("( ");
		sql.append("  select substr(period,9,5) period,case when period<=curhour then nvl(enter_times,0) else enter_times end enter_times,  ");
		sql.append("  nvl(sum(enter_times) over(order by period),0) total_times from  ");
		sql.append("  (  ");
		sql.append("    select bb.period,bb.curhour,aa.enter_times from  ");
		sql.append("    (  ");
		sql.append("      select substr(start_time,1,10)||':'||lpad(trunc(to_number(substr(start_time,11,2))/").append(seg).append(",0)*").append(seg).append(",2,'0') period,round(sum(enter_times)/100) enter_times from ").append(cpsql_tp1); 
		sql.append("      group by substr(start_time,1,10)||':'||lpad(trunc(to_number(substr(start_time,11,2))/").append(seg).append(",0)*").append(seg).append(",2,'0')  ");
		sql.append("    ) aa,  ");
		sql.append("    (  ");
		sql.append("      select '").append(compare_day).append("'||period period,to_char(sysdate,'yyyyMMddhh24:mi') curhour from ");  
		sql.append("      (select to_char(to_date('20160201 0000','yyyyMMdd hh24:mi')-(level-1)/").append(nm).append(",'hh24:mi') period from dual connect by level<=").append(nm).append(") where period>='02:00' "); 
		sql.append("    ) bb where bb.period=aa.period(+) "); 
		sql.append("    union all  ");
		sql.append("   select bb.period,bb.curhour,aa.enter_times from  ");
		sql.append("    (  ");
		sql.append("      select substr(start_time,1,10)||':'||lpad(trunc(to_number(substr(start_time,11,2))/").append(seg).append(",0)*").append(seg).append(",2,'0') period,round(sum(enter_times)/100) enter_times from ").append(cpsql_tp2);
		sql.append("      group by substr(start_time,1,10)||':'||lpad(trunc(to_number(substr(start_time,11,2))/").append(seg).append(",0)*").append(seg).append(",2,'0')  ");
		sql.append("    ) aa,  ");
		sql.append("    (  ");
		sql.append("      select '").append(compare_next_day).append("'||period period,to_char(sysdate,'yyyyMMddhh24:mi') curhour from ");  
		sql.append("      (select to_char(to_date('20160201 0000','yyyyMMdd hh24:mi')-(level-1)/").append(nm).append(",'hh24:mi') period from dual connect by level<=").append(nm).append(") where period<'02:00' "); 
		sql.append("    ) bb where bb.period=aa.period(+)  ");
		sql.append("  ) ");
		sql.append(") t2 where t1.period=t2.period ");
		
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

	public String getCompare_day() {
		return compare_day;
	}

	public void setCompare_day(String compareDay) {
		compare_day = compareDay;
	}

	public String getSeg() {
		return seg;
	}

	public void setSeg(String seg) {
		this.seg = seg;
	}

	
}
