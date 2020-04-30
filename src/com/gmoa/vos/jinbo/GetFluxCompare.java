package com.gmoa.vos.jinbo;


import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import jsontag.annotation.JsonTagAnnotation;
import jsontag.dao.JsonTagTemplateDaoImpl;
import jsontag.interf.IDoService;

import org.apache.commons.lang.StringUtils;


/**
 * 查询当前客流与背景客流比较
 * 日期格式：yyyymmdd
 *
 */    
@JsonTagAnnotation(actionValue="/get_fluxcompare.action",namespace="/station",isJsonReturn=true)
public class GetFluxCompare extends JsonTagTemplateDaoImpl implements IDoService {
	private String start_date;
	private String com_date;
	private String selFlag;

	@Override
	public Object doService() throws Exception {
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd"); 
		if(StringUtils.isBlank(start_date)){
			start_date=df.format(new java.util.Date());
		}
		
		String com_date_start;
		String com_date_end;
		
		StringBuffer sql1=new StringBuffer();
		StringBuffer sql2=new StringBuffer();
		Calendar calendar = Calendar.getInstance(); 
		calendar.setTime(new java.util.Date());
		
		if(StringUtils.isNotBlank(com_date)&&"self".equals(selFlag)){
			calendar.add(Calendar.DAY_OF_MONTH, -60);
			Date tempDate = calendar.getTime();
			Date com_date1=df.parse(com_date);
			
			sql1.append("select station_id,sum(enter_times)/100 enter_times,sum(exit_times)/100 exit_times from ");
			//查询日期和服务器的当前日期比较，如果查询日期是60天以前，则查询tbl_metro_fluxnew_history表
			if(com_date1.compareTo(tempDate) > 0) {
				sql1.append("tbl_metro_fluxnew_").append(com_date).append(" where ticket_type not in ('40','41','130','131','140','141') ");
			}else{
				sql1.append("tbl_metro_fluxnew_history where stmt_day='").append(com_date).append("' ");
			}
			sql1.append("and station_id in ('0234 ','0235 ','1722 ') and start_time<='").append(com_date).append("'||to_char(sysdate-30/(24*60),'hh24miss') ");
			sql1.append("group by station_id ");
			
			sql2.append("select self_val val,self_times,to_char(sysdate-30/(24*60),'hh24:mi') hours from TBL_METRO_VAL where rownum=1");
		}else{
			calendar.add(Calendar.DAY_OF_MONTH,-2);  
			com_date_end=df.format(calendar.getTime());
			
			calendar.add(Calendar.DAY_OF_MONTH,-27);  
			com_date_start=df.format(calendar.getTime());
			
			sql1.append("select station_id,round(avg(enter_times)/100) enter_times,round(avg(exit_times)/100) exit_times from ");
			sql1.append("  ( ");
			sql1.append("    select aa.stmt_day,station_id,sum(enter_times) enter_times,sum(exit_times) exit_times from tbl_metro_fluxnew_history aa, ");
			sql1.append("    ( ");
			sql1.append("      select stmt_day,stmt_day||to_char(sysdate-30/(24*60),'hh24miss') start_time from ");
			sql1.append("      ( ");
			sql1.append("        select to_char(to_date('").append(com_date_start).append("','yyyymmdd')+(rownum-1),'yyyymmdd') stmt_day from dual "); 
			sql1.append("        connect by rownum<=(to_date('").append(com_date_end).append("','yyyymmdd')-to_date('").append(com_date_start).append("','yyyymmdd')+1) ");
			sql1.append("      ) "); 
			if("workday".equals(selFlag)){
				sql2.append("select workday_val val,self_times,to_char(sysdate-30/(24*60),'hh24:mi') hours from TBL_METRO_VAL where rownum=1");
				
				sql1.append("      where (instr('23456',to_char(to_date(stmt_day,'YYYYMMDD'),'d'))>0 or stmt_day in (select stmt_day from TBL_HOLIDAY where holiday_type='0')) ");
				sql1.append("      and stmt_day not in (select stmt_day from TBL_HOLIDAY where holiday_type='1') ");
			}else if("holiday".equals(selFlag)){
				sql2.append("select holiday_val val,self_times,to_char(sysdate-30/(24*60),'hh24:mi') hours from TBL_METRO_VAL where rownum=1");
				
				sql1.append("      where (instr('17',to_char(to_date(stmt_day,'YYYYMMDD'),'d'))>0 or stmt_day in (select stmt_day from TBL_HOLIDAY where holiday_type='1')) ");
				sql1.append("      and stmt_day not in (select stmt_day from TBL_HOLIDAY where holiday_type='0') ");
			}
			sql1.append("    ) bb ");
			sql1.append("    where aa.stmt_day=bb.stmt_day and aa.station_id in ('0234 ','0235 ','1722 ') and aa.start_time<=bb.start_time ");
			sql1.append("    group by aa.stmt_day,station_id ");
			sql1.append("  ) group by station_id ");
		}
		
		StringBuffer sql=new StringBuffer();
		sql.append("select t1.station_nm_cn,case when round(t1.enter_times*t2.val)<0 then 0 else round(t1.enter_times*t2.val) end enter_times,");
		sql.append("case when round(t1.exit_times*t2.val)<0 then 0 else round(t1.exit_times*t2.val) end exit_times,t2.self_times,t2.hours from ");
		sql.append("( ");
		sql.append("  select t1.station_id,t3.station_nm_cn,t1.enter_times-t2.enter_times enter_times,t1.exit_times-t2.exit_times exit_times from ");
		sql.append("  ( ");
		sql.append("    select station_id,sum(enter_times)/100 enter_times,sum(exit_times)/100 exit_times from tbl_metro_fluxnew_").append(start_date);
		sql.append("    where station_id in ('0234 ','0235 ','1722 ') and ticket_type not in ('40','41','130','131','140','141') and start_time<='").append(start_date).append("'||to_char(sysdate-30/(24*60),'hh24miss') ");
		sql.append("    group by station_id ");
		sql.append("  ) t1, ");
		sql.append("  ( ");
		sql.append(sql1);
		sql.append("  ) t2, ");
		sql.append("  (select station_id,station_nm_cn from viw_metro_station_name where to_char(sysdate,'yyyyMMdd') between start_time and end_time) t3 ");
		sql.append("  where t1.station_id=t2.station_id and trim(t1.station_id)=t3.station_id");
		sql.append(") t1, ");
		sql.append("(").append(sql2).append(") t2 ");
		return jsonTagJdbcDao.getJdbcTemplate().queryForList(sql.toString());
	}

	public String getStart_date() {
		return start_date;
	}

	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}

	public String getCom_date() {
		return com_date;
	}

	public void setCom_date(String com_date) {
		this.com_date = com_date;
	}

	public String getSelFlag() {
		return selFlag;
	}

	public void setSelFlag(String selFlag) {
		this.selFlag = selFlag;
	}

}
