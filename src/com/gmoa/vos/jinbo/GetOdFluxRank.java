package com.gmoa.vos.jinbo;


import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import jsontag.annotation.JsonTagAnnotation;
import jsontag.dao.JsonTagTemplateDaoImpl;
import jsontag.interf.IDoService;


/**
 * 根据日期查询od排名
 * 日期格式：yyyymmdd
 *
 */    
@JsonTagAnnotation(actionValue="/get_odfluxrank.action",namespace="/od",isJsonReturn=true)
public class GetOdFluxRank extends JsonTagTemplateDaoImpl implements IDoService {
	private String start_date;
	private String endTime;
	private String topnum;
	private String station_id;
	private String selFlag;
	private String odFlag;//查询od标志，值为od表示查询O->D,do表示查询D->O

	@Override
	public Object doService() throws Exception {
		if(StringUtils.isBlank(start_date)){
			SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd"); 
			start_date=df.format(new java.util.Date());
		}
		if(StringUtils.isBlank(topnum)){
			topnum="10";
		}
		boolean flag=true;
		if(StringUtils.isBlank(endTime)){
//			Calendar calendar = Calendar.getInstance();
//	        int cur_hour=calendar.get(Calendar.HOUR_OF_DAY);
	        endTime="24";
		}
		if("do".equals(odFlag)){
			flag=false;
		}
		
		StringBuffer sql1=new StringBuffer("0");
		for(int i=1;i<=Integer.parseInt(endTime)*12;i++){
			sql1.append("+time_seg").append(i);
		}
		
		if("0000".equals(station_id)){
			station_id=" in ('0234 ','0235 ','1722 ') ";
		}else{
			station_id="='"+station_id+" ' ";
		}
		
		if("station".equals(selFlag)){
			return findStationOd(sql1,flag);
		}else if("line".equals(selFlag)){
			return findLindOd(sql1,flag);
		}
		return null;
	}

	/**
	 * 查询车站Od排名
	 * @param sql1
	 * @param flag
	 * @return
	 */
	public List findStationOd(StringBuffer sql1,boolean flag){
		StringBuffer sql=new StringBuffer();
		sql.append("select bb.station_nm_cn||'->'||cc.station_nm_cn od,aa.times from ");
		sql.append("( ");
		sql.append("  select * from ");
		sql.append("  ( ");
		sql.append("    select enter_station_id,exit_station_id,sum(").append(sql1).append(") times from tbl_metro_odflux_day_").append(start_date);
		sql.append("    where ticket_type not in ('40','41','130','131','140','141') and ").append(flag?"exit_station_id":"enter_station_id").append(station_id);
		sql.append("    group by enter_station_id,exit_station_id ");
		sql.append("    order by times desc ");
		sql.append("  ) where rownum<=").append(topnum);
		sql.append(") aa, ");
		sql.append("(select station_id,station_nm_cn from viw_metro_station_name where to_char(sysdate,'yyyyMMdd') between start_time and end_time) bb, ");
		sql.append("(select station_id,station_nm_cn from viw_metro_station_name where to_char(sysdate,'yyyyMMdd') between start_time and end_time) cc ");
		sql.append("where trim(aa.enter_station_id)=bb.station_id and trim(aa.exit_station_id)=cc.station_id order by times desc");
		
		return jsonTagJdbcDao.getJdbcTemplate().queryForList(sql.toString());
	}
	
	/**
	 * 查询线路Od排名
	 * @param sql1
	 * @param flag
	 * @return
	 */
	public List findLindOd(StringBuffer sql1,boolean flag){
		StringBuffer sql=new StringBuffer();
		sql.append("select * from(select case when aa.line_id='41' then '浦江' else to_number(aa.line_id)||'号线' end line_id,aa.times,bb.line_color from ");
		sql.append("( ");
		sql.append("  select line_id,sum(times) times from ");
		sql.append("  ( ");
		sql.append("    select case when ").append(flag?"enter_station_id":"exit_station_id").append(" between '0815' and '0819' then '41' else substr(").append(flag?"enter_station_id":"exit_station_id").append(",1,2) end line_id,");
		sql.append("	sum(").append(sql1).append(") times from tbl_metro_odflux_day_").append(start_date);
		sql.append("    where ticket_type not in ('40','41','130','131','140','141') and ").append(flag?"exit_station_id":"enter_station_id").append(station_id); 
		sql.append("    group by ").append(flag?"enter_station_id":"exit_station_id ");
		sql.append("  ) where line_id<>'00' group by line_id ");
		sql.append(")  aa,tbl_metro_line_color bb ");
		sql.append("where aa.line_id=bb.line_id order by aa.times desc)");
		
		return jsonTagJdbcDao.getJdbcTemplate().queryForList(sql.toString());
	}
	
	public String getStart_date() {
		return start_date;
	}

	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getSelFlag() {
		return selFlag;
	}

	public void setSelFlag(String selFlag) {
		this.selFlag = selFlag;
	}

	public String getTopnum() {
		return topnum;
	}

	public void setTopnum(String topnum) {
		this.topnum = topnum;
	}

	public String getStation_id() {
		return station_id;
	}

	public void setStation_id(String station_id) {
		this.station_id = station_id;
	}

	public String getOdFlag() {
		return odFlag;
	}

	public void setOdFlag(String odFlag) {
		this.odFlag = odFlag;
	}
	
}
