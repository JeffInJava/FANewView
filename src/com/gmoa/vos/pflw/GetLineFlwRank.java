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
 * 获取全路网线路客流排名
 * @author Administrator
 *
 */
@JsonTagAnnotation(actionValue="/GetLineFlwRank.action",namespace="/lflw",isJsonReturn=true)
public class  GetLineFlwRank extends JsonTagTemplateDaoImpl implements IDoService{
	
	private String date;
	private String size;
	
	private String compDate;
	
	public String getCompDate() {
		return compDate;
	}

	public void setCompDate(String compDate) {
		this.compDate = compDate;
	}

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
		String sql1;
		List<Map<String,Object>> list=new  ArrayList<Map<String,Object>>();
		
		List<Map<String,Object>> list1=new  ArrayList<Map<String,Object>>();
		
		Map<String,Object>  result=new 	HashMap<String, Object>();
		
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
			sql = "SELECT T.*, ROWNUM RN FROM ("
				+ "select line_nm_cn, round(sum("+tp_sql+")/1000000,2) in_pass_num"
				+ " from TBL_METRO_FLUXNEW_"+date+" a,"
				+ " (select * from VIW_METRO_LINE_NAME where to_char(sysdate,'yyyyMMdd') between start_time and end_time) b" 
				+ " where a.line_id = b.line_id"
				+ " and a.ticket_type not in ('40','41','130','131','140','141')"
				+ " and a.start_time <="+date+"||to_char(sysdate-30/(24*60),'hh24')||lpad(trunc(to_number(to_char(sysdate-30/(24*60),'mi'))/5,0)*5,2,'0')||'00'"
				+ " group by b.line_nm_cn"
				+ " order by in_pass_num desc"
				+ " ) T WHERE ROWNUM <= ?" ;
			//jsonTagJdbcDao.getJdbcTemplate().setMaxRows(this.getSize());
			list = jsonTagJdbcDao.getJdbcTemplate().queryForList(sql,this.getSize());
			
			sql1 = "SELECT T.*, ROWNUM RN FROM ("
					+ "select line_nm_cn, round(sum("+tp_sql+")/1000000,2) in_pass_num"
					+ " from TBL_METRO_FLUXNEW_"+compDate+" a,"
					+ " (select * from VIW_METRO_LINE_NAME where to_char(sysdate,'yyyyMMdd') between start_time and end_time) b" 
					+ " where a.line_id = b.line_id"
					+ " and a.ticket_type not in ('40','41','130','131','140','141')"
					+ " and a.start_time <="+compDate+"||to_char(sysdate-30/(24*60),'hh24')||lpad(trunc(to_number(to_char(sysdate-30/(24*60),'mi'))/5,0)*5,2,'0')||'00'"
					+ " group by b.line_nm_cn"
					+ " order by in_pass_num desc"
					+ " ) T WHERE ROWNUM <= ?" ;
				//jsonTagJdbcDao.getJdbcTemplate().setMaxRows(this.getSize());
				list1 = jsonTagJdbcDao.getJdbcTemplate().queryForList(sql1,this.getSize());
				
				
				
			
		     result.put("todayData", list);
		     result.put("compData", list1);
		return result;
	}

	
	

}
