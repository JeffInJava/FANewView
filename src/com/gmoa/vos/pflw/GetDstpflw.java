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
 * 获取区域客流
 * @author Administrator
 *
 */
@JsonTagAnnotation(actionValue="/GetDstpflw.action",namespace="/distrc",isJsonReturn=true)
public class GetDstpflw extends JsonTagTemplateDaoImpl implements IDoService{
	private String date;
	private String size;
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getSize() {
		return size;
	}
	public void setSize(String size) {
		this.size = size;
	}
	@Override
	public Object doService() throws Exception {
		// TODO Auto-generated method stub
		
		String sql;
	
		List<Map<String,Object>> list=new  ArrayList<Map<String,Object>>();
		
		
		
		//全路网
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
			sql ="SELECT T.*, ROWNUM RN FROM ("
					+"select b.district_code,sum(in_pass_num) in_pass_num from"
					 +"(select station_id,round(sum("+tp_sql+")/1000000,2) in_pass_num from TBL_METRO_FLUXNEW_" +date+" GROUP BY station_id) a,"
					+"(select * from tbl_metro_station_info_area WHERE STATION_VER in (select  max(STATION_VER) from tbl_metro_station_info_area)) b"
					 +" where a.STATION_ID=b.station_id"
					 +" GROUP BY b.district_code  order by in_pass_num desc"
				+ ") T where ROWNUM <= ?" ;
			//jsonTagJdbcDao.getJdbcTemplate().setMaxRows(this.getSize());
			list = jsonTagJdbcDao.getJdbcTemplate().queryForList(sql,this.getSize());
			
		
			
		     
		    
		return list;
		
	}

}
