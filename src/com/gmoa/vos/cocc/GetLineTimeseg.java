package com.gmoa.vos.cocc;

import java.util.List;

import jsontag.annotation.JsonTagAnnotation;
import jsontag.dao.JsonTagTemplateDaoImpl;
import jsontag.interf.IDoService;

import org.springframework.jdbc.core.BeanPropertyRowMapper;

import com.gmoa.bean.LineChainCompare;
/**
 * 获取外滩两岸旅游点车站客流
 * @author Administrator
 *
 */
@JsonTagAnnotation(actionValue="/get_line_time_seg_flow.action",namespace="/cocc",isJsonReturn=true)
public class GetLineTimeseg extends JsonTagTemplateDaoImpl implements IDoService{
	
	private String startTime;
	private String chainTime;
	
	@Override
	public Object doService() throws Exception {
		//两个日期差大于60天时part=0,小于60天part=1,环比时part=1
		String sql = "select a.line_id as lineId,a.times,a.times-b.times as dvalue,a.start_time as startTime FROM ("
				+ " select line_id,substr(start_time,9,2)||':'||lpad(trunc(substr(start_time,11,2)/30,0)*30,2,'0') start_time,"
				+ " round((sum(enter_times)+sum(change_times))/100) times from tbl_metro_fluxnew_"+startTime
				+ " where ticket_type not in ('40','41','130','131','140','141')"
				+ " and (case when  ('"+startTime+"' = to_char(sysdate, 'yyyyMMdd') or '"+chainTime+"' = to_char(sysdate, 'yyyyMMdd')"
				+ ") then to_char(sysdate-30/(24*60), 'hh24mi') else '2400' end ) >= substr(start_time,9,4) and"
				+ " substr(start_time,9,4)>='0700' group by line_id, "
				+ "substr(start_time,9,2)||':'||lpad(trunc(substr(start_time,11,2)/30,0)*30,2,'0')) a,"
				+ "(select line_id,substr(start_time,9,2)||':'||lpad(trunc(substr(start_time,11,2)/30,0)*30,2,'0')"
				+ " start_time,round((sum(enter_times)+sum(change_times))/100) times from tbl_metro_fluxnew_"+chainTime 
				+ " where (case when  ('"+startTime+"' = to_char(sysdate, 'yyyyMMdd') or '"+chainTime+"' = to_char(sysdate, 'yyyyMMdd')"
				+ ") then to_char(sysdate-30/(24*60), 'hh24mi') else '2400' end ) >= substr(start_time,9,4)"
				+ " and substr(start_time,9,4)>='0700' group by line_id,"
				+ " substr(start_time,9,2)||':'||lpad(trunc(substr(start_time,11,2)/30,0)*30,2,'0')) b "
				+ " where a.line_id=b.line_id and a.start_time=b.start_time order by a.line_id, a.start_time";
		List<LineChainCompare> lst = this.jsonTagJdbcDao.getJdbcTemplate().query(sql, new Object[] {}, new BeanPropertyRowMapper<LineChainCompare>(LineChainCompare.class));
		
		return lst;
	}
	
	public String getStartTime() {
		return startTime;
	}


	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}


	public String getChainTime() {
		return chainTime;
	}


	public void setChainTime(String chainTime) {
		this.chainTime = chainTime;
	}
}
