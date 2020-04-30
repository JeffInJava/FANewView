package com.gmoa.vos.pflw;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jsontag.JsonTagContext;
import jsontag.annotation.JsonTagAnnotation;
import jsontag.dao.JsonTagTemplateDaoImpl;
import jsontag.interf.IDoService;
/**
 * 获取车站客流
 * @author Administrator
 *
 */
@JsonTagAnnotation(actionValue="/get_all_passe.action",namespace="/sheete",isJsonReturn=true)
public class GetChzpflw extends JsonTagTemplateDaoImpl implements IDoService{
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
		Map<String,Object>  result=new 	HashMap<String, Object>();
		if ("0".equals(type)){//全路网
			 String [] selType=JsonTagContext.getRequest().getParameterValues("selType[]");
			String tp_sql="0";
			String atp_sql="";
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
				if(selType.length==1){
					
					for(int i=0;i<selType.length;i++){
						String  st=selType[i];
						if(st.equals("1")){
							atp_sql="enter_times";
						}
						if(st.equals("2")){
							atp_sql="exit_times";
						}
					}
					
				}
				if(selType.length==2){
					String  st=selType[0];
					String  sd=selType[1];
					if(st.equals("1")&&sd.equals("2")){
						atp_sql="enter_exit_times";
					}
					if(st.equals("1")&&sd.equals("3")){
						atp_sql="enter_change_times";
					}
				}
				if(selType.length==3){
					atp_sql="en_ex_ch_times";
				}
				
			}
			String  sql_tp;
			SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
	   		Date s_date=df.parse(date);
	   		GregorianCalendar calendar = new GregorianCalendar();
			calendar.add(GregorianCalendar.DAY_OF_MONTH, -60);
			Date tempDate = calendar.getTime();
			//查询日期和服务器的当前日期比较，如果查询日期是60天以前，则查询tbl_metro_fluxnew_history表
			if(s_date.compareTo(tempDate) > 0) {
				sql_tp=" tbl_metro_fluxnew_"+date+" where ticket_type not in ('40','41','130','131','140','141') and trim(line_id)<>'00' ";
			}else{
				sql_tp=" tbl_metro_fluxnew_history partition(V"+date+"_FLUXNEW_HISTORY) where  trim(line_id)<>'00'";
			}
			sql = "SELECT T.*, ROWNUM RN FROM ("
				+ "select station_nm_cn, round(sum("+tp_sql+")/1000000,2) in_pass_num from"
				+"(select * from " +sql_tp+") a,"
				+ " (select * from VIW_METRO_STATION_NAME where to_char(sysdate,'yyyyMMdd') between start_time and end_time) b" 
				+ " where a.station_id = b.station_id"
				+ " and a.ticket_type not in ('40','41','130','131','140','141')"
				//+ " and a.START_TIME = ?"
				+ " group by b.station_nm_cn"
				+ " order by in_pass_num desc"
				+ " ) T WHERE ROWNUM <= ?" ;
			//jsonTagJdbcDao.getJdbcTemplate().setMaxRows(this.getSize());
			list = jsonTagJdbcDao.getJdbcTemplate().queryForList(sql,this.getSize());
			
			List<Map<String,Object>> numlist=new  ArrayList<Map<String,Object>>();
			for (Map<String, Object>  mpc:list) {
				
				 String stationName=mpc.get("STATION_NM_CN").toString();
				 
			String  sqls=" select * from (select stmt_day,round("+atp_sql+"/10000,2) times  from"
					+" (select distinct station_nm_cn, a.stmt_day,enter_times,exit_times,enter_change_times,en_ex_ch_times,enter_exit_times "
					+ "from tbl_milestone_station a, (select * from VIW_METRO_STATION_NAME where to_char(sysdate,'yyyyMMdd') between "
					+ "start_time and end_time) b, TBL_MILESTONE_STATION_EN_EX c"
			+" where a.station_id = b.station_id and b.station_id = c.station_id and b.station_nm_cn=? ) order by  times desc) where times>0";	 
			List<Map<String,Object>> listn = jsonTagJdbcDao.getJdbcTemplate().queryForList(sqls,stationName);
			for (int i = 1; i < 2; i++) {
				
				Map<String, Object>  mp=listn.get(0);
				Map<String,Object>  hit=new 	HashMap<String, Object>();
				 String maxtimes=mp.get("TIMES").toString(); 
				 String stmt_day=mp.get("STMT_DAY").toString(); 
				 hit.put("times", maxtimes);
				 hit.put("stmt_day", stmt_day);
				 numlist.add(hit);
				 
			}
					}
			result.put("stalist", list);
			result.put("hst", numlist);
		}

		return result;
	}

}
