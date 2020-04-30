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
 * 获取重点车站换乘客流
 * @author Administrator
 *
 */
@JsonTagAnnotation(actionValue="/get_all_change.action",namespace="/sheete",isJsonReturn=true)
public class GetChzchange extends JsonTagTemplateDaoImpl implements IDoService{
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
		Map<String,Object>  result=new 	HashMap<String, Object>();
		List<Map<String,Object>> list=new  ArrayList<Map<String,Object>>();
		List<Map<String,Object>> clist=new  ArrayList<Map<String,Object>>();
		List<Map<String,Object>> slist=new  ArrayList<Map<String,Object>>();
		if ("0".equals(type)){//全路网
			 String [] selType=JsonTagContext.getRequest().getParameterValues("selType[]");
			String tp_sql="0";
			if(selType!=null){
				for(String tp:selType){
					if("1".equals(tp)){
						tp_sql+="+enter_times";
					}else if("2".equals(tp)){
						tp_sql+="+exit_times";
					}else if("3".equals(tp)){
						tp_sql+="+change_times";
					}
				}
			}
			 String [] stNames=JsonTagContext.getRequest().getParameterValues("stNames[]");
			 String stns="";
				if(stNames!=null){
					for(String tp:stNames){
						stns+="'"+tp+"'"+",";
					}
				}
				stns = stns.substring(0,stns.length()-1);
			
			sql = "SELECT T.*, ROWNUM RN FROM ("
				+ "select station_nm_cn, round(sum("+tp_sql+")/1000000,2) in_pass_num"
				+ " from TBL_METRO_FLUXNEW_"+date+" a,"
				+ " (select * from VIW_METRO_STATION_NAME where to_char(sysdate,'yyyyMMdd') between start_time and end_time) b" 
				+ " where a.station_id = b.station_id and b.station_nm_cn in("+stns+")"
				+ " and a.ticket_type not in ('40','41','130','131','140','141')"
				//+ " and a.START_TIME = ?"
				+ " group by b.station_nm_cn"
				+ " order by in_pass_num desc"
				+ " ) T " ;
			//jsonTagJdbcDao.getJdbcTemplate().setMaxRows(this.getSize());
			list = jsonTagJdbcDao.getJdbcTemplate().queryForList(sql);
			
			for (Map<String, Object>  mp:list) {
				
				Map<String,Object>  it=new 	HashMap<String, Object>();
				String  stationName=mp.get("STATION_NM_CN").toString();
				
				String sql1 = "SELECT T.*, ROWNUM RN FROM ("
						+ "select  b.line_id, round(sum("+tp_sql+")/1000000,2) in_pass_num"
						+ " from TBL_METRO_FLUXNEW_"+date+" a,"
						+ " (select * from VIW_METRO_STATION_NAME where to_char(sysdate,'yyyyMMdd') between start_time and end_time) b" 
						+ " where a.station_id = b.station_id and b.station_nm_cn=?"
						+ " and a.ticket_type not in ('40','41','130','131','140','141')"
						//+ " and a.START_TIME = ?"
						+ " group by  b.line_id"
						+ " order by in_pass_num desc"
						+ " ) T " ;
					//jsonTagJdbcDao.getJdbcTemplate().setMaxRows(this.getSize());
				List<Map<String,Object>> list1 = jsonTagJdbcDao.getJdbcTemplate().queryForList(sql1,stationName);
				it.put("stationName", stationName);
				it.put("chg", list1);
				clist.add(it);
				
			}
		
			result.put("chgst", list);
			result.put("chgln", clist);
		}

		return result;
	}

}
