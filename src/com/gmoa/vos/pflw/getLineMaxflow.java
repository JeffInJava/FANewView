package com.gmoa.vos.pflw;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jsontag.annotation.JsonTagAnnotation;
import jsontag.dao.JsonTagTemplateDaoImpl;
import jsontag.interf.IDoService;
@JsonTagAnnotation(actionValue="/get_line_flux_max.action",namespace="/pflw",isJsonReturn=true)

public class getLineMaxflow extends JsonTagTemplateDaoImpl implements IDoService{
	private String start_date;
	private String line_id;
	private String flux_flag;
	
	public String getStart_date() {
		return start_date;
	}

	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}

	public String getLine_id() {
		return line_id;
	}

	public void setLine_id(String line_id) {
		this.line_id = line_id;
	}

	public String getFlux_flag() {
		return flux_flag;
	}

	public void setFlux_flag(String flux_flag) {
		this.flux_flag = flux_flag;
	}

	@Override
	public Object doService() throws Exception {
		Map<String,Object>  result=new 	HashMap<String, Object>();
		List<Map<String,Object>> list=null;
		String sql="";
		String sql_tp="";
		
		String total_times="0";	
		if(flux_flag.indexOf("1")>-1){
			 total_times+="+nvl(enter_times,0)";
		}
		if(flux_flag.indexOf("2")>-1){
			 total_times+="+nvl(exit_times,0)";
		}
		if(flux_flag.indexOf("3")>-1){
			 total_times+="+nvl(change_times,0)";
		}
		
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
   		Date s_date=df.parse(start_date);
   		GregorianCalendar calendar = new GregorianCalendar();
		calendar.add(GregorianCalendar.DAY_OF_MONTH, -60);
		Date tempDate = calendar.getTime();
		//查询日期和服务器的当前日期比较，如果查询日期是60天以前，则查询tbl_metro_fluxnew_history表
		if(s_date.compareTo(tempDate) > 0) {
			sql_tp=" tbl_metro_fluxnew_"+start_date+" where ticket_type not in ('40','41','130','131','140','141') and trim(line_id)<>'00' ";
		}else{
			sql_tp=" tbl_metro_fluxnew_history partition(V"+start_date+"_FLUXNEW_HISTORY) where  trim(line_id)<>'00'";
		}

		sql="select round(sum("+total_times+")/1000000,1) total_times,case when trim(line_id)='41' then '浦江线' else trim(line_id) end line_id from"+sql_tp+ 
				  " group by trim(line_id) order by total_times desc";
		
		list = jsonTagJdbcDao.getJdbcTemplate().queryForList(sql);
		result.put("tep", list);
		if(flux_flag.indexOf("1")>-1&&flux_flag.indexOf("3")>-1){
			
			List<Map<String,Object>> slist=new  ArrayList<Map<String,Object>>();
			for (int j = 0; j < list.size(); j++) {
				
				Map<String, Object>  mpc=list.get(j);
				 String lineId=mpc.get("LINE_ID").toString();
				 
				 
				 
				 String  sqlb="select stmt_day,round(MILESTONE/10000,2) times from  TBL_MILESTONE  where  line_id=? ORDER BY MILESTONE desc";
				 List<Map<String,Object>>	hstlist = jsonTagJdbcDao.getJdbcTemplate().queryForList(sqlb,lineId);
				 Map<String,Object>  hit=new 	HashMap<String, Object>();
				 
				 for (int i = 0; i < hstlist.size(); i++) {
						
						Map<String, Object>  mp=hstlist.get(0);
						
						 String maxtimes=mp.get("TIMES").toString(); 
						 String stmt_day=mp.get("STMT_DAY").toString(); 
						 hit.put("times", maxtimes);
						 hit.put("lineId", lineId);
						 hit.put("stmt_day", stmt_day);
						
						 slist.add(hit);
						 break;
				 }
				 
				 if(lineId.equals("浦江线")){
					 String  sqlc="select stmt_day,round(MILESTONE/10000,2) times from  TBL_MILESTONE  where  line_id='41' ORDER BY MILESTONE desc";
					 List<Map<String,Object>>	phstlist = jsonTagJdbcDao.getJdbcTemplate().queryForList(sqlc);
					 
					 for (int k = 0; k < phstlist.size(); k++) {
							
							Map<String, Object>  mpa=phstlist.get(0);
							
							 String maxtimes=mpa.get("TIMES").toString(); 
							 String stmt_day=mpa.get("STMT_DAY").toString(); 
							 hit.put("times", maxtimes);
							 hit.put("lineId", lineId);
							 hit.put("stmt_day", stmt_day);
							
							 slist.add(hit);
							 break;
					 }
					 
				 }
				 
				 
				 
			}
			
			result.put("hst", slist);
			
		}
		return result;
		// TODO Auto-generated method stub
	}
	
	

}
