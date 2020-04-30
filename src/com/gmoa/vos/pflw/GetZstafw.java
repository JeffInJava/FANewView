package com.gmoa.vos.pflw;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import jsontag.JsonTagContext;
import jsontag.annotation.JsonTagAnnotation;
import jsontag.dao.JsonTagTemplateDaoImpl;
import jsontag.interf.IDoService;
/**
 * 获取重点车站车站客流
 * @author Administrator
 *
 */
@JsonTagAnnotation(actionValue="/GetZdChzpfws.action",namespace="/zdchzpfw",isJsonReturn=true)
public class GetZstafw extends JsonTagTemplateDaoImpl implements IDoService{
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
		List<Map<String,Object>> list=new  ArrayList<Map<String,Object>>();
		
		 String [] selType=JsonTagContext.getRequest().getParameterValues("selType[]");
			String tp_sql="0";
			if(type!=null){
				
					if(type.indexOf("1")>-1){
						tp_sql+="+enter_times";
					} 
					if(type.indexOf("2")>-1){
						tp_sql+="+exit_times";
					} 
					if(type.indexOf("3")>-1){
						tp_sql+="+change_times";
					}
				
			}
		
			sql = "select trim(station_nm_cn) station_nm_cn, round(sum("+tp_sql+")/1000000,1) pass_num "
					//+ "to_char(round(sum(EXIT_TIMES)/1000000,1),'fm99990.099') exit_num，to_char(round(sum(CHANGE_TIMES)/1000000,1),'fm99990.099') chg_num"
				+ " from TBL_METRO_FLUXNEW_"+date+" a,"
				+ " (select station_id,station_nm_cn from tbl_metro_model_station where model_id =94 and state=1 ) b" 
				+ " where a.station_id = b.station_id"
				+ " and a.ticket_type not in ('40','41','130','131','140','141')"
				//+ " and a.START_TIME = ?"
				+ " group by b.station_nm_cn order by  pass_num desc";
				
			//jsonTagJdbcDao.getJdbcTemplate().setMaxRows(this.getSize());
			list = jsonTagJdbcDao.getJdbcTemplate().queryForList(sql);
			
		

		return list;
	}

}
