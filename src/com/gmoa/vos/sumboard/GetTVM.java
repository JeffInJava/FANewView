package com.gmoa.vos.sumboard;

import java.util.ArrayList;
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
@JsonTagAnnotation(actionValue="/get_tvm.action",namespace="/sheete",isJsonReturn=true)
public class GetTVM extends JsonTagTemplateDaoImpl implements IDoService{
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
		double  sellTimes=0;
		double  tradeTimes=0;
		double  totalAmount=0;
		Map<String,Object>  result=new 	HashMap<String, Object>();

		List<Map<String,Object>> list=new  ArrayList<Map<String,Object>>();
	
			sql = "select sum(times) tratimes,sum(amount) amount from "
				+" ("
				+"  select count(*) times,round(sum(amount)/100) amount from tbl_metro_sjtsell_"+date
				+"  where ticket_type in (100,101,104,105) and trans_type=32 and DUBIOUS_TYPE='00'"
				+"  union all"
				+"  select count(*) times,round(sum(amount)/100) amount from"
				+"  ("
				+"  select distinct cardid,deal_time,card_counter,exit_station_id,amount from tbl_metro_tick_"+date
				+"   where ticket_type='100' and except_type in ('56','57','100')"
				+" ) "
				+"  union all"
				+"  select count(dubious_times) times,round(sum(amount)/100) amount from tbl_metro_sjtky_sell"
				+"  where substr(deal_time,1,8)="+date+" and ticket_type in (100,101,104,105) and dubious_type!='T0'"
				+")" ;
			list = jsonTagJdbcDao.getJdbcTemplate().queryForList(sql);
			for (int i = 0; i < list.size(); i++) {
				Map<String, Object>  mp=list.get(0);
				tradeTimes=Double.parseDouble(mp.get("TRATIMES").toString());
				totalAmount=Double.parseDouble(mp.get("AMOUNT").toString());
			 }
			
			String sql1="select sum(times) selltimes from "
				+" ("
				+"  select count(*) times from tbl_metro_sjtsell_"+date
				+"   where ticket_type in (100,101,104,105) and trans_type=32 and DUBIOUS_TYPE='00'"
				+"  union all"
				+"   select count(*) times from"
				+"   ("
				+"    select distinct cardid,deal_time,card_counter,exit_station_id from tbl_metro_tick_"+date
				+"    where ticket_type='100' and except_type in ('56','57')"
				+"  ) "
				+"   union all   "
				+"   select sum(count_num) times from tbl_qf_cloud_income where stmt_day="+date+" and ticket_type=100"
				+"   union all"
				+"  select count(dubious_times) times from tbl_metro_sjtky_sell"
				+"   where substr(deal_time,1,8)="+date+" and ticket_type in (100,101,104,105) and dubious_type!='T0'"
				+" 	)";
			List<Map<String,Object>> list1 = jsonTagJdbcDao.getJdbcTemplate().queryForList(sql1);
			for (int i = 0; i < list1.size(); i++) {
				Map<String, Object>  mpa=list1.get(0);
				sellTimes=Double.parseDouble(mpa.get("SELLTIMES").toString());
			 }
			result.put("tradeTimes", tradeTimes);
			result.put("totalAmount", totalAmount);
			result.put("sellTimes", sellTimes);
		return result;
	}

}
