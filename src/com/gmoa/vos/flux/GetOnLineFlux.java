package com.gmoa.vos.flux;


import java.util.List;
import java.util.Map;

import jsontag.annotation.JsonTagAnnotation;
import jsontag.dao.JsonTagTemplateDaoImpl;
import jsontag.interf.IDoService;


/**
 * 根据日期、车站、起止时间查询在网客流
 * 日期格式：yyyymmdd
 *
 */    
@JsonTagAnnotation(actionValue="/get_online_flux.action",namespace="/station",isJsonReturn=true)
public class GetOnLineFlux extends JsonTagTemplateDaoImpl implements IDoService {
	private String start_date;
	private String com_date;
	private String start_time;
	private String end_time;
	private String station_id;
	private String station_id2;
	
	@Override
	public Object doService() throws Exception {
		List<Map<String,Object>> list=null;
//		jsonTagJdbcDao.getJdbcTemplate().execute("alter session force parallel query parallel 8");
		
		StringBuffer sql=new StringBuffer();
		sql.append(" with tp as");
		sql.append(" (");
		sql.append("   select cardid,entrance_station_id,exit_station_id,en_deal_time,od_id,way_percent,sub_io_stat,sub_oi_stat from t_online2"); 
		sql.append("   where deal_time>='").append(start_time).append("' and deal_time2<'").append(end_time).append("'");
		sql.append(" ),");
		sql.append(" tp1 as");
		sql.append(" (");
		sql.append("   select aa.*,bb.station_nm_cn||'-'||cc.station_nm_cn station1,cc.station_nm_cn||'-'||bb.station_nm_cn station2 from");
		sql.append("   (");
		sql.append("     select distinct sub_io_stat,sub_oi_stat from tbl_metro_ch_sub_road_1");
		sql.append("     where info_ver =(select max(info_ver) from tbl_metro_ch_sub_road_1) ");
		sql.append("     and io_stat ='").append(station_id).append("' and oi_stat ='").append(station_id2).append("' and substr(sub_io_stat,1,2) ='").append(station_id.substring(0,2)).append("'");
		sql.append("   ) aa,");
		sql.append("   (select station_id,station_nm_cn from viw_metro_station_name where to_char(sysdate,'yyyyMMdd') between start_time and end_time) bb,");
		sql.append("   (select station_id,station_nm_cn from viw_metro_station_name where to_char(sysdate,'yyyyMMdd') between start_time and end_time) cc");
		sql.append("   where aa.sub_io_stat=bb.station_id and aa.sub_oi_stat=cc.station_id");
		sql.append(" )");
		sql.append(" select t5.station1,t5.station2,round(t1.way_percent/t2.way_percent_total*(t3.en-t4.ex)/100) total_times,");
		sql.append(" round(t5.way_percent/t2.way_percent_total*(t3.en-t4.ex)/100) times,");
		sql.append(" round(t1.way_percent/t2.way_percent_total*(t6.en-t7.ex)/100) com_total_times,");
		sql.append(" round(t5.way_percent/t2.way_percent_total*(t6.en-t7.ex)/100) com_times from");
		sql.append(" (");
		sql.append("   select sum(way_percent)/100000 way_percent from");
		sql.append("   (");
		sql.append("     select cardid,entrance_station_id,exit_station_id,en_deal_time,od_id,way_percent from tp aa,tp1 bb");
		sql.append("     where aa.sub_io_stat = bb.sub_io_stat and aa.sub_oi_stat = bb.sub_oi_stat");
		sql.append("     group by cardid,entrance_station_id,exit_station_id,en_deal_time,od_id,way_percent");
		sql.append("   )");
		sql.append(" ) t1,");
		sql.append(" (");
		sql.append("   select sum(way_percent)/100000 way_percent_total from"); 
		sql.append("   (");
		sql.append("     select cardid,entrance_station_id,exit_station_id,en_deal_time,od_id,way_percent from tp");
		sql.append("     group by cardid,entrance_station_id,exit_station_id,en_deal_time,od_id,way_percent");
		sql.append("   )");
		sql.append(" ) t2,");
		sql.append(" (select sum(enter_times) en from tbl_metro_fluxnew_").append(start_date).append(" where end_time<'").append(start_date+end_time).append("') t3,");
		sql.append(" (select sum(exit_times) ex from tbl_metro_fluxnew_").append(start_date).append(" where end_time<'").append(start_date+start_time).append("') t4,");
		sql.append(" (");
		sql.append("   select station1,station2,nvl(sum(way_percent)/100000,0) way_percent from");
		sql.append("   (");
		sql.append("     select bb.station1,bb.station2,cardid,entrance_station_id,exit_station_id,en_deal_time,od_id,way_percent from tp aa,tp1 bb");
		sql.append("     where aa.sub_io_stat(+) = bb.sub_io_stat and aa.sub_oi_stat(+) = bb.sub_oi_stat");
		sql.append("     group by bb.station1,bb.station2,cardid,entrance_station_id,exit_station_id,en_deal_time,od_id,way_percent");
		sql.append("   ) group by station1,station2");
		sql.append(" ) t5,");
		sql.append(" (select sum(enter_times) en from tbl_metro_fluxnew_history where stmt_day='").append(com_date).append("' and end_time<'").append(com_date+end_time).append("') t6,");
		sql.append(" (select sum(exit_times) ex from tbl_metro_fluxnew_history where stmt_day='").append(com_date).append("' and end_time<'").append(com_date+start_time).append("') t7");
		
		list=jsonTagJdbcDao.getJdbcTemplate().queryForList(sql.toString());
		return list;
	}

	public String getStart_date() {
		return start_date;
	}

	public void setStart_date(String startDate) {
		start_date = startDate;
	}

	public String getStart_time() {
		return start_time;
	}

	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}

	public String getEnd_time() {
		return end_time;
	}

	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}

	public String getStation_id() {
		return station_id;
	}

	public void setStation_id(String station_id) {
		this.station_id = station_id;
	}

	public String getStation_id2() {
		return station_id2;
	}

	public void setStation_id2(String station_id2) {
		this.station_id2 = station_id2;
	}

	public String getCom_date() {
		return com_date;
	}

	public void setCom_date(String com_date) {
		this.com_date = com_date;
	}


}
