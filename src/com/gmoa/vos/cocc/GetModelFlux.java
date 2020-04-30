package com.gmoa.vos.cocc;


import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;

import jsontag.annotation.JsonTagAnnotation;
import jsontag.dao.JsonTagTemplateDaoImpl;
import jsontag.interf.IDoService;


/**
 * 查询模块下相关车站的客流
 *
 */    
@JsonTagAnnotation(actionValue="/getModelFlux.action",namespace="/station",isJsonReturn=true)
public class GetModelFlux extends JsonTagTemplateDaoImpl implements IDoService {
	private String start_date1;
	private String start_date2;
	private String com_date1;
	private String com_date2;
	private String[] flag;
	private String model_id;//模板id
	private String addr_id;//子模板名称
  	
	private String fir_hour;
	private String sec_hour;
	private String fir_min;
	private String sec_min;
	private String viewFlag;
	private String date_flag;
	private String avg_total;
	

	@Override
	public Object doService() throws Exception {
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd"); 
		Calendar calendar = Calendar.getInstance(); 
		if(start_date2==null){
			start_date2=df.format(new java.util.Date()); 
		}   
		if(start_date1==null){
			calendar.setTime(new java.util.Date());
			calendar.add(Calendar.DAY_OF_MONTH, -6);  
			start_date1=df.format(calendar.getTime());
	    }  
		if(com_date1==null){
			calendar.setTime(new java.util.Date());
			calendar.add(Calendar.DAY_OF_MONTH, -13);  
			com_date1=df.format(calendar.getTime());
		}
		if(com_date2==null){
			calendar.setTime(new java.util.Date());
			calendar.add(Calendar.DAY_OF_MONTH, -7);  
			com_date2=df.format(calendar.getTime());
		}
		String flags="";
	  	if(flag!=null){
		   for(String tp:flag){	  
			 flags+=","+tp;
		   }
		}else{
			flags="1,3";
		}
	  	if("00".equals(fir_hour)||"24".equals(sec_hour)){
	  		fir_hour="00";
	  		fir_min="00";
	  		sec_hour="24";
	  		sec_min="00";
	  	}
	  	String sql1="";
	  	String sql2="1";
	  	String sql3="1";
	  	if("1".equals(date_flag)){
	  		sql1=" and to_char(to_date(stmt_day,'YYYYMMDD'),'d') in ('2','3','4','5','6')";
	  	}else if("2".equals(date_flag)){
	  		sql1=" and to_char(to_date(stmt_day,'YYYYMMDD'),'d') in ('1','7')";
	  	}
	  	if("avg".equals(avg_total)){
	  		sql2="select n from nm1";
	  		sql3="select n from nm2";
	  	}
		
	  	String total_times="0";
	  	if(flags.indexOf("1")>=0){
			total_times+="+nvl(enter_times,0)";
		}
		if(flags.indexOf("2")>=0){
			total_times+="+nvl(exit_times,0)";
		} 
		if(flags.indexOf("3")>=0){
			total_times+="+nvl(change_times,0)";
		}
	  	
		List<String> stations=new ArrayList();
	    List fir_times=new ArrayList();//第一天客流量
	    List sec_times=new ArrayList();//第二天客流量
	    List addnum=new ArrayList();//增值
	    List addrate=new ArrayList();//增幅
	    
	    List<JSONObject> list=new ArrayList();//两天的客流量
	    
		List dates=new ArrayList();
	    SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy/MM/dd");
	    SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMMdd");
	    dates.add(sdf1.format(sdf2.parse(start_date1))+"~"+sdf1.format(sdf2.parse(start_date2)));
	    dates.add(sdf1.format(sdf2.parse(com_date1))+"~"+sdf1.format(sdf2.parse(com_date2)));
	    
	    String tpstations="";
	    String today="";
	    today=df.format(new java.util.Date());
		
		calendar.setTime(new java.util.Date());
		calendar.add(Calendar.DAY_OF_MONTH, -1);  
		String next_date=df.format(calendar.getTime());
		if(Integer.parseInt(today)<=Integer.parseInt(start_date1)
				||Integer.parseInt(today)<=Integer.parseInt(start_date2)
				||Integer.parseInt(today)<=Integer.parseInt(com_date1)
				||Integer.parseInt(today)<=Integer.parseInt(com_date2)){
			       if("24".equals(sec_hour)){
				      Calendar cal=Calendar.getInstance();
				      cal.add(Calendar.MINUTE,-30);
				      SimpleDateFormat sdf=new SimpleDateFormat("HHmm");
				      String cur_time=sdf.format( cal.getTime());
				      sec_hour=cur_time.substring(0,2);
			  		  sec_min="00";
				   }
		}
	    
		if(StringUtils.isNotBlank(today)){
			String sqlStr="with tp1 as "+
			 		"( "+
					"  select stmt_day,station_nm_cn,sum(total_times) total_times from "+
					"  ( "+
					"    select '"+today+"' stmt_day,station_id,sum("+total_times+") total_times from tbl_metro_fluxnew_"+today+
					"    where ticket_type not in (40, 41, 130, 131, 140, 141) and substr(end_time, 9, 4) between '"+fir_hour+fir_min+"' and '"+sec_hour+sec_min+"' "+
					"    group by station_id "+
					"    union all "+
					"    select '"+next_date+"' stmt_day,station_id,sum("+total_times+") total_times from tbl_metro_fluxnew_"+next_date+
					"    where ticket_type not in (40, 41, 130, 131, 140, 141) and substr(end_time, 9, 4) between '"+fir_hour+fir_min+"' and '"+sec_hour+sec_min+"' "+
					"    group by station_id "+
					"    union all "+
					"    select stmt_day,station_id,sum("+total_times+") total_times from tbl_metro_fluxnew_history "+
					"    where stmt_day between '"+start_date1+"' and '"+start_date2+"' and stmt_day<>'"+next_date+"' and substr(end_time,9,4) between '"+fir_hour+fir_min+"' and '"+sec_hour+sec_min+"' "+
					"    group by stmt_day,station_id "+
					"  ) t1, "+
					"  ( "+
					"    select distinct aa.station_nm_cn,bb.station_id from "+
					"    ( "+
					"      select trim(station_nm_cn) station_nm_cn,sub_model_name from tbl_metro_model_station "+ 
					"      where model_id ="+model_id+" and state=1 and (sub_model_name ='"+addr_id+"' or '"+addr_id+"' like '全部') "+
					"      group by station_nm_cn, sub_model_name "+
					"    ) aa, "+
					"    ( "+
					"      select station_id,trim(station_nm_cn) station_nm_cn from viw_metro_station_name "+
					"      where '"+today+"' between start_time and end_time "+
					"    ) bb where aa.station_nm_cn=bb.station_nm_cn "+
					"  ) t2 where t1.station_id=t2.station_id and t1.stmt_day between '"+start_date1+"' and '"+start_date2+"' "+sql1+
					"  group by stmt_day,station_nm_cn "+
					"), "+
					"tp2 as "+
					"( "+
					"  select stmt_day,station_nm_cn,sum(total_times) total_times from "+
    				"  ( "+
						"    select '"+today+"' stmt_day,station_id,sum("+total_times+") total_times from tbl_metro_fluxnew_"+today+
						"    where ticket_type not in (40, 41, 130, 131, 140, 141) and substr(end_time, 9, 4) between '"+fir_hour+fir_min+"' and '"+sec_hour+sec_min+"' "+
						"    group by station_id "+
						"    union all "+
						"    select '"+next_date+"' stmt_day,station_id,sum("+total_times+") total_times from tbl_metro_fluxnew_"+next_date+
						"    where ticket_type not in (40, 41, 130, 131, 140, 141) and substr(end_time, 9, 4) between '"+fir_hour+fir_min+"' and '"+sec_hour+sec_min+"' "+
						"    group by station_id "+
						"    union all "+
						"    select stmt_day,station_id,sum("+total_times+") total_times from tbl_metro_fluxnew_history "+
						"    where stmt_day between '"+com_date1+"' and '"+com_date2+"' and stmt_day<>'"+next_date+"' and substr(end_time,9,4) between '"+fir_hour+fir_min+"' and '"+sec_hour+sec_min+"' "+
						"    group by stmt_day,station_id "+
						"  ) t1, "+
					"  ( "+
					"    select distinct aa.station_nm_cn,bb.station_id from "+
					"    ( "+
					"      select trim(station_nm_cn) station_nm_cn,sub_model_name from tbl_metro_model_station "+
					"      where model_id ="+model_id+" and state=1 and (sub_model_name ='"+addr_id+"' or '"+addr_id+"' like '全部') "+
					"      group by station_nm_cn, sub_model_name "+
					"    ) aa, "+
					"    ( "+
					"      select station_id,trim(station_nm_cn) station_nm_cn from viw_metro_station_name "+
					"      where '"+today+"' between start_time and end_time "+
					"    ) bb where aa.station_nm_cn=bb.station_nm_cn "+
					"  ) t2 where t1.station_id=t2.station_id and t1.stmt_day between '"+com_date1+"' and '"+com_date2+"' "+sql1+
					"  group by stmt_day,station_nm_cn "+
					"), "+
					"nm1 as "+
					"(select count(*) n from (select stmt_day from tp1 group by stmt_day)), "+
					"nm2 as "+
					"(select count(*) n from (select stmt_day from tp2 group by stmt_day)) "+
					"select t1.station_nm_cn,t1.total_times fir_times,t2.total_times sec_times from "+
					"( "+
					"  select station_nm_cn,round(sum(total_times)/("+sql2+")/1000000,1) total_times from tp1 "+
					"  group by station_nm_cn "+
					") t1, "+
					"( "+
					"  select station_nm_cn,round(sum(total_times)/("+sql3+")/1000000,1) total_times from tp2 "+
					"  group by station_nm_cn "+
					") t2 where t1.station_nm_cn=t2.station_nm_cn order by fir_times desc";
			List<Map<String,Object>> listFlux=jsonTagJdbcDao.getJdbcTemplate().queryForList(sqlStr);
			for(Map<String,Object> mp:listFlux){
				tpstations+="'"+mp.get("STATION_NM_CN").toString().trim()+"',";
				stations.add(mp.get("STATION_NM_CN").toString().trim());
				fir_times.add(mp.get("FIR_TIMES"));
				sec_times.add(mp.get("SEC_TIMES"));
			}
			if(tpstations.length()>0){
				tpstations=tpstations.substring(0,tpstations.length()-1);
			}
			
			String sql="with st as "+
				    "( "+
					"  select station_id,trim(station_nm_cn) station_nm_cn from viw_metro_station_name "+
					"  where '"+today+"' between start_time and end_time and trim(station_nm_cn) in ("+tpstations+") "+
					"), "+
					" tp1 as "+
					"( "+
					"  select stmt_day,station_nm_cn,start_time,sum(total_times) total_times from "+
					"  ( "+
					"    select '"+today+"' stmt_day,station_id,substr(start_time,9,2)||':'||lpad(trunc(substr(start_time,11,2)/10,0)*10,2,'0') start_time, "+ 
					"    sum("+total_times+") total_times from tbl_metro_fluxnew_"+today+
					"    where ticket_type not in (40, 41, 130, 131, 140, 141) "+
					"    group by station_id,substr(start_time,9,2)||':'||lpad(trunc(substr(start_time,11,2)/10,0)*10,2,'0') "+
					"    union all "+
					"    select '"+next_date+"' stmt_day,station_id,substr(start_time,9,2)||':'||lpad(trunc(substr(start_time,11,2)/10,0)*10,2,'0') start_time, "+ 
					"    sum("+total_times+") total_times from tbl_metro_fluxnew_"+next_date+
					"    where ticket_type not in (40, 41, 130, 131, 140, 141) "+
					"    group by station_id,substr(start_time,9,2)||':'||lpad(trunc(substr(start_time,11,2)/10,0)*10,2,'0') "+
					"    union all "+
					"    select stmt_day,station_id,substr(start_time,9,2)||':'||lpad(trunc(substr(start_time,11,2)/10,0)*10,2,'0') start_time, "+ 
					"    sum("+total_times+") total_times from tbl_metro_fluxnew_history "+
					"    where stmt_day between '"+start_date1+"' and '"+start_date2+"' and stmt_day<>'"+next_date+"'"+
					"    group by stmt_day,station_id,substr(start_time,9,2)||':'||lpad(trunc(substr(start_time,11,2)/10,0)*10,2,'0') "+
					"  ) t1,st t2 where t1.station_id=t2.station_id and t1.stmt_day between '"+start_date1+"' and '"+start_date2+"' "+sql1+" and start_time>='05:00' and start_time<='"+sec_hour+":"+sec_min+"'"+
					"  group by stmt_day,station_nm_cn,start_time "+
					"), "+
					"tp2 as "+
					"( "+
					"  select stmt_day,station_nm_cn,start_time,sum(total_times) total_times from "+
					"  ( "+
					"    select '"+today+"' stmt_day,station_id,substr(start_time,9,2)||':'||lpad(trunc(substr(start_time,11,2)/10,0)*10,2,'0') start_time, "+ 
					"    sum("+total_times+") total_times from tbl_metro_fluxnew_"+today+
					"    where ticket_type not in (40, 41, 130, 131, 140, 141) "+
					"    group by station_id,substr(start_time,9,2)||':'||lpad(trunc(substr(start_time,11,2)/10,0)*10,2,'0') "+
					"    union all "+
					"    select '"+next_date+"' stmt_day,station_id,substr(start_time,9,2)||':'||lpad(trunc(substr(start_time,11,2)/10,0)*10,2,'0') start_time, "+ 
					"    sum("+total_times+") total_times from tbl_metro_fluxnew_"+next_date+
					"    where ticket_type not in (40, 41, 130, 131, 140, 141) "+
					"    group by station_id,substr(start_time,9,2)||':'||lpad(trunc(substr(start_time,11,2)/10,0)*10,2,'0') "+
					"    union all "+
					"    select stmt_day,station_id,substr(start_time,9,2)||':'||lpad(trunc(substr(start_time,11,2)/10,0)*10,2,'0') start_time, "+ 
					"    sum("+total_times+") total_times from tbl_metro_fluxnew_history "+
					"    where stmt_day between '"+com_date1+"' and '"+com_date2+"' and stmt_day<>'"+next_date+"'"+
					"    group by stmt_day,station_id,substr(start_time,9,2)||':'||lpad(trunc(substr(start_time,11,2)/10,0)*10,2,'0') "+
					"  ) t1,st t2 where t1.station_id=t2.station_id and t1.stmt_day between '"+com_date1+"' and '"+com_date2+"' "+sql1+" and start_time>='05:00' "+
					"  group by stmt_day,station_nm_cn,start_time "+
					"), "+
					"nm1 as "+
					"(select count(*) n from (select stmt_day from tp1 group by stmt_day)), "+
					"nm2 as "+
					"(select count(*) n from (select stmt_day from tp2 group by stmt_day)), "+
					"tm as "+
					"( "+
					"   select t1.*,t2.* from "+
					"   (select to_char(to_date('20160201 0000','yyyyMMdd hh24:mi')-(level-1)/144,'hh24:mi') start_time from dual connect by level<=144) t1, "+
					"   (select station_nm_cn from st group by station_nm_cn) t2 "+
					"   where t1.start_time>='05:00' "+
					") "+
					"select t1.station_nm_cn,t1.start_time time_period,t1.fir_times,t2.sec_times from "+
					"( "+
					"  select bb.*,nvl(aa.total_times,0) fir_times from "+
					"  ( "+
					"    select station_nm_cn,start_time,round(sum(total_times)/("+sql2+")/1000000,2) total_times from tp1 "+
					"    group by station_nm_cn,start_time "+
					"  ) aa,tm bb where bb.station_nm_cn=aa.station_nm_cn(+) and bb.start_time=aa.start_time(+) "+
					") t1, "+
					"( "+
					"  select bb.*,nvl(aa.total_times,0) sec_times from "+
					"  ( "+
					"    select station_nm_cn,start_time,round(sum(total_times)/("+sql3+")/1000000,2) total_times from tp2 "+
					"    group by station_nm_cn,start_time "+
					"  ) aa,tm bb where bb.station_nm_cn=aa.station_nm_cn(+) and bb.start_time=aa.start_time(+) "+
					") t2 where t1.station_nm_cn=t2.station_nm_cn and t1.start_time=t2.start_time order by time_period";
			List<Map<String,Object>> listFen=jsonTagJdbcDao.getJdbcTemplate().queryForList(sql);
			for(Map<String,Object> mp:listFen){
				JSONObject jsonObj=new JSONObject();
		 		jsonObj.put("station_nm_cn",mp.get("STATION_NM_CN"));
		 		jsonObj.put("time_period",mp.get("TIME_PERIOD"));
		 		if(mp.get("fir_times")!=null){
				       jsonObj.put("fir_times",mp.get("FIR_TIMES"));
				}
				if(mp.get("sec_times")!=null){
				       jsonObj.put("sec_times",mp.get("SEC_TIMES"));
				}
		 		list.add(jsonObj);
			}
		}
		JSONObject data=new JSONObject();
		data.put("dates", dates);
		data.put("stations", stations);
		data.put("fir_times", fir_times);
		data.put("sec_times", sec_times);
		data.put("list", list);
		
		return data;
	}


	public String getStart_date1() {
		return start_date1;
	}


	public void setStart_date1(String start_date1) {
		this.start_date1 = start_date1;
	}


	public String getStart_date2() {
		return start_date2;
	}


	public void setStart_date2(String start_date2) {
		this.start_date2 = start_date2;
	}


	public String getCom_date1() {
		return com_date1;
	}


	public void setCom_date1(String com_date1) {
		this.com_date1 = com_date1;
	}


	public String getCom_date2() {
		return com_date2;
	}


	public void setCom_date2(String com_date2) {
		this.com_date2 = com_date2;
	}

	public String getModel_id() {
		return model_id;
	}


	public void setModel_id(String model_id) {
		this.model_id = model_id;
	}


	public String getAddr_id() {
		return addr_id;
	}


	public void setAddr_id(String addr_id) {
		this.addr_id = addr_id;
	}


	public String getFir_hour() {
		return fir_hour;
	}


	public void setFir_hour(String fir_hour) {
		this.fir_hour = fir_hour;
	}


	public String getSec_hour() {
		return sec_hour;
	}


	public void setSec_hour(String sec_hour) {
		this.sec_hour = sec_hour;
	}


	public String getFir_min() {
		return fir_min;
	}


	public void setFir_min(String fir_min) {
		this.fir_min = fir_min;
	}


	public String getSec_min() {
		return sec_min;
	}


	public void setSec_min(String sec_min) {
		this.sec_min = sec_min;
	}


	public String getViewFlag() {
		return viewFlag;
	}


	public void setViewFlag(String viewFlag) {
		this.viewFlag = viewFlag;
	}


	public String[] getFlag() {
		return flag;
	}


	public void setFlag(String[] flag) {
		this.flag = flag;
	}


	public String getDate_flag() {
		return date_flag;
	}


	public void setDate_flag(String date_flag) {
		this.date_flag = date_flag;
	}


	public String getAvg_total() {
		return avg_total;
	}


	public void setAvg_total(String avg_total) {
		this.avg_total = avg_total;
	}
	
	
}
