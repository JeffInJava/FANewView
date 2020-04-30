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
 * 查询二维码客流、收益、交易处理情况,二维码客流占总客流情况
 * 日期格式：yyyymmdd
 *
 */    
@JsonTagAnnotation(actionValue="/get_qrcdfluxincome.action",namespace="/qrcd",isJsonReturn=true)
public class GetQrcdFluxIncome extends JsonTagTemplateDaoImpl implements IDoService {
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
		if("flux".equals(sel_flag)){
			sql=new StringBuffer();
			sql.append("with tp as ");
			sql.append("( ");
			sql.append("  select aa.*,bb.income_value from");
			sql.append("  (");
			sql.append("    select 'zfb' flag,sum(case when trans_type in (43,39) then nm else 0 end) enter_times, ");
			sql.append("    sum(case when trans_type in (37,65) then nm else 0 end) exit_times, ");
			sql.append("    sum(case when trans_type in (49,50,54) then nm else 0 end) update_times, ");
			sql.append("    sum(case when trans_type not in (43,39,37,65,49,50,54) then nm else 0 end) other_times from ");
			sql.append("    (   ");
			sql.append("      select trans_type,count(*) nm from tbl_metro_qrcd_").append(start_date).append(" where ticket_type in ('210','212') group by trans_type ");
			sql.append("    ) ");
			sql.append("    union all ");
			sql.append("    select 'upy' flag,sum(case when trans_type in (43,39) then nm else 0 end) enter_times, ");
			sql.append("    sum(case when trans_type in (37,65) then nm else 0 end) exit_times, ");
			sql.append("    sum(case when trans_type in (49,50,54) then nm else 0 end) update_times, ");
			sql.append("    sum(case when trans_type not in (43,39,37,65,49,50,54) then nm else 0 end) other_times from ");
			sql.append("    (   ");
			sql.append("      select trans_type,count(*) nm from tbl_metro_qrcd_").append(start_date).append(" where ticket_type in ('211','213') group by trans_type  ");
			sql.append("    ) ");
			sql.append("    union all ");
			sql.append("    select 'wechat' flag,nvl(sum(case when trans_type in (43,39) then nm else 0 end),0) enter_times, ");
			sql.append("    nvl(sum(case when trans_type in (37,65) then nm else 0 end),0) exit_times, ");
			sql.append("    nvl(sum(case when trans_type in (49,50,54) then nm else 0 end),0) update_times, ");
			sql.append("    nvl(sum(case when trans_type not in (43,39,37,65,49,50,54) then nm else 0 end),0) other_times from ");
			sql.append("    (   ");
			sql.append("      select trans_type,count(*) nm from tbl_metro_qrcd_").append(start_date).append(" where ticket_type in ('214') group by trans_type  ");
			sql.append("    ) ");
			sql.append("  ) aa,");
			sql.append("  (");
			sql.append("    select 'zfb' flag,round(sum(income_value)/100) income_value from tbl_metro_sta_inc_day where stmt_day=? and ticket_type in ('210','212')");
			sql.append("    union all");
			sql.append("    select 'upy' flag,round(sum(income_value)/100) income_value from tbl_metro_sta_inc_day where stmt_day=? and ticket_type in ('211','213')");
			sql.append("    union all");
			sql.append("    select 'wechat' flag,nvl(round(sum(income_value)/100),0) income_value from tbl_metro_sta_inc_day where stmt_day=? and ticket_type in ('214')");
			sql.append("  ) bb where aa.flag=bb.flag ");
			sql.append(") ");
			sql.append("select 'total' flag,sum(enter_times) enter_times,sum(exit_times) exit_times,sum(update_times) update_times,sum(other_times) other_times,sum(income_value) income_value from tp ");
			sql.append("union all ");
			sql.append("select flag,enter_times,exit_times,update_times,other_times,income_value from tp");
			list = jsonTagJdbcDao.getJdbcTemplate().queryForList(sql.toString(),start_date,start_date,start_date);
		}else if("jy".equals(sel_flag)){
			sql=new StringBuffer();
			sql.append("select totals,dealnum,totals-dealnum undeals,round(totals/3000,2) totals_per,round(dealnum/3000,2) dealnum_per,round((totals-dealnum)/3000,2) undeals_per,to_char(sysdate,'yyyy/MM/dd hh24:mi') curhour from");
			sql.append("(select sum(rec_num) totals from tbl_fep_qrcd_").append(start_date).append(") aa,");
			sql.append("(select count(*) dealnum from tbl_metro_qrcd_").append(start_date).append(") bb");
			list = jsonTagJdbcDao.getJdbcTemplate().queryForList(sql.toString());
		}else if("qrcdper".equals(sel_flag)){
			sql=new StringBuffer();
			sql.append("with qrcd as ");
			sql.append("( ");
			sql.append("  select sum(case when trans_type in (43,39) then nm else 0 end) enter_times,sum(case when trans_type in (37,65) then nm else 0 end) exit_times from "); 
			sql.append("  ( ");   
			sql.append("    select trans_type,count(*) nm from tbl_metro_qrcd_").append(start_date).append(" where ticket_type in ('210','212','211','213','214') group by trans_type ");  
			sql.append("  ) ");
			sql.append("), ");
			sql.append("alls as ");
			sql.append("(select round(sum(enter_times)/100) enter_times,round(sum(exit_times)/100) exit_times from tbl_metro_fluxnew_").append(start_date).append(" where ticket_type not in ('40','41','130','131','140','141')) ");
			sql.append("select a.*,a.enter_times+a.exit_times totals from alls a ");
			sql.append("union all ");
			sql.append("select a.*,a.enter_times+a.exit_times totals from qrcd a ");
			sql.append("union all ");
			sql.append("select round(b.enter_times/a.enter_times*100,2) enter_times,round(b.exit_times/a.exit_times*100,2) exit_times, ");
			sql.append("round((b.enter_times+b.exit_times)/(a.enter_times+a.exit_times)*100,2) totals from alls a,qrcd b ");
			list = jsonTagJdbcDao.getJdbcTemplate().queryForList(sql.toString());
		}else if("flux_new".equals(sel_flag)){
			//查询客流和收益总览(修改,日期跨日)
			list=findFluxAndIncNew();
		}
		return list;
	}

	//查询客流和收益总览
	private List findFluxAndIncNew() throws Exception{
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
			sql_tp1.append(" tbl_metro_fluxnew_").append(start_day).append(" where ticket_type not in ('40','41','130','131','140','141') and start_time>='").append(start_day).append("020000' ");
			sql_tp2.append(" tbl_metro_fluxnew_").append(next_date).append(" where ticket_type not in ('40','41','130','131','140','141') and start_time<'").append(next_date).append("020000' ");
		}else{
			sql_tp1.append(" tbl_metro_fluxnew_history partition(V").append(start_day).append("_FLUXNEW_HISTORY) where start_time>='").append(start_day).append("020000' ");
			sql_tp2.append(" tbl_metro_fluxnew_history partition(V").append(next_date).append("_FLUXNEW_HISTORY) where start_time<'").append(next_date).append("020000' ");
		}
		
		StringBuffer sql=new StringBuffer();
		sql.append("with tp as ");
		sql.append("(  ");
		sql.append("  select ticket_type,round(sum(enter_times)/100) enter_times,round(sum(exit_times)/100) exit_times from ").append(sql_tp1);
		sql.append("  group by ticket_type ");
		sql.append("  union all ");
		sql.append("  select ticket_type,round(sum(enter_times)/100) enter_times,round(sum(exit_times)/100) exit_times from ").append(sql_tp2);
		sql.append("  group by ticket_type ");
		sql.append(") ");
		sql.append("select 'qrcd' flag,sum(enter_times) enter_times,sum(exit_times) exit_times,to_char(sysdate,'yyyy/MM/dd hh24:mi') curhour from tp where ticket_type in('210','212','211','213','214') ");
		sql.append("union all ");
		sql.append("select 'zfb' flag,sum(enter_times) enter_times,sum(exit_times) exit_times,null from tp where ticket_type in('210','212') ");
		sql.append("union all ");
		sql.append("select 'upy' flag,sum(enter_times) enter_times,sum(exit_times) exit_times,null from tp where ticket_type in('211','213') ");
		sql.append("union all ");
		sql.append("select 'wechat' flag,nvl(sum(enter_times),0) enter_times,nvl(sum(exit_times),0) exit_times,null from tp where ticket_type in('214') ");
		sql.append("union all ");
		sql.append("select 'all' flag,sum(enter_times) enter_times,sum(exit_times) exit_times,null from tp ");
		System.out.println(sql.toString());
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
