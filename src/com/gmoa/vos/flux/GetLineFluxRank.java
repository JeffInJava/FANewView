package com.gmoa.vos.flux;


import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Map;

import jsontag.annotation.JsonTagAnnotation;
import jsontag.dao.JsonTagTemplateDaoImpl;
import jsontag.interf.IDoService;


/**
 * 根据日期、线路、进出换类型查询全路网线路客流排名
 * 日期格式：yyyymmdd
 *
 */    
@JsonTagAnnotation(actionValue="/get_line_fluxrank.action",namespace="/station",isJsonReturn=true)
public class GetLineFluxRank extends JsonTagTemplateDaoImpl implements IDoService {
	private String start_date;
	private String line_id;
	private String flux_flag;
	
	@Override
	public Object doService() throws Exception {
		
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
			sql_tp=" tbl_metro_fluxnew_history partition(V"+start_date+"_FLUXNEW_HISTORY) where and trim(line_id)<>'00'";
		}

		sql="select round(sum("+total_times+")/1000000,1) total_times,case when trim(line_id)='41' then '浦江线' else trim(line_id) end line_id from"+sql_tp+ 
				  " group by trim(line_id) order by total_times desc";
		
		list = jsonTagJdbcDao.getJdbcTemplate().queryForList(sql);
		return list;
	}

	public String getStart_date() {
		return start_date;
	}

	public void setStart_date(String startDate) {
		start_date = startDate;
	}

	public String getLine_id() {
		return line_id;
	}

	public void setLine_id(String lineId) {
		line_id = lineId;
	}

	public String getFlux_flag() {
		return flux_flag;
	}

	public void setFlux_flag(String fluxFlag) {
		flux_flag = fluxFlag;
	}


}
