package com.gmoa.vos.pflw;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jsontag.JsonTagContext;
import jsontag.annotation.JsonTagAnnotation;
import jsontag.dao.JsonTagTemplateDaoImpl;
import jsontag.interf.IDoService;
/**
 * 获取外滩两岸旅游点车站客流
 * @author Administrator
 *
 */
@JsonTagAnnotation(actionValue="/GetHotChzpflfw.action",namespace="/visitpfw",isJsonReturn=true)
public class GetHotChzpflfw extends JsonTagTemplateDaoImpl implements IDoService{
private String date;
	
	private String type;
	private String startTime;
	
	
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	private String id;
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getSize() {
		return size;
	}
	public void setSize(String size) {
		this.size = size;
	}
	private String size;
	
	
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	
	
	@Override
	public Object doService() throws Exception {
		String sql;
		String sql1;
		
		List<Map<String,Object>> list=new  ArrayList<Map<String,Object>>();
		List<Map<String,Object>> list1=new  ArrayList<Map<String,Object>>();
		List<Map<String,Object>> rest=new  ArrayList<Map<String,Object>>();
				sql1="select trim(station_nm_cn) station_nm_cn,sub_model_name from tbl_metro_model_station "
						+ "where model_id =1 and state=1 and sub_model_name='外滩两岸' group by station_nm_cn, sub_model_name";
			sql = " select * from "
					+ "(select t2.station_nm_cn,t2.start_time,nvl(sum(enter_times),0) enter_times,nvl(sum(exit_times),0) exit_times,nvl(sum(change_times),0) change_times,"
					+" t2.start_time||':00~'||to_char(to_date(t2.start_time,'hh24')+1/24,'hh24:mi') show_time from"
					+" ( select station_id,substr(start_time,9,2) start_time,sum(enter_times)/100 enter_times,sum(exit_times)/100 exit_times,sum(change_times)/100 change_times" 
					+" from tbl_metro_fluxnew_"+date+" where ticket_type not in (40, 41, 130, 131, 140, 141) and start_time>="+date+"||'020000'"
					+" group by station_id,substr(start_time,9,2)) t1,"
					+" (select aa.start_time,bb.* from"
					+"  (select to_char(to_date('20160201 0000','yyyyMMdd hh24:mi')-(level-1)/24,'hh24') start_time from dual connect by level<=24) aa,"
					+" ("
					+"   select aa.*,bb.station_id from"
					+"   ("
					+"   select trim(station_nm_cn) station_nm_cn,sub_model_name from tbl_metro_model_station where model_id =1 and state=1 and sub_model_name='外滩两岸'"
					+"    group by station_nm_cn, sub_model_name"
					+"    ) aa,"
					+"    ("
					+"     select station_id,trim(station_nm_cn) station_nm_cn from viw_metro_station_name where "+date+" between start_time and end_time"
					+"   ) bb where aa.station_nm_cn=bb.station_nm_cn"
					+"  ) bb where aa.start_time<=to_char(sysdate,'hh24')"
					+" ) t2 where t1.station_id(+)=t2.station_id and t1.start_time(+)=t2.start_time"
					+" group by t2.station_nm_cn,t2.start_time"
					+" order by t2.station_nm_cn,t2.start_time) m where station_nm_cn=?";
			list = jsonTagJdbcDao.getJdbcTemplate().queryForList(sql1);
			for (int i = 0; i < list.size(); i++) {
				
		
					Map<String,Object>  result=new 	HashMap<String, Object>();
					Map<String,Object>  mp=list.get(i);
					
				 String stationName=mp.get("STATION_NM_CN").toString();
				 list1 = jsonTagJdbcDao.getJdbcTemplate().queryForList(sql,stationName);
				 result.put("stationName", stationName);
				 result.put("tadata", list1);
				 rest.add(result);
			 }
			
		

		return rest;
	}

}
