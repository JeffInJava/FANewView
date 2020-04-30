package com.gmoa.vos.pflw;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jsontag.JsonTagContext;
import jsontag.annotation.JsonTagAnnotation;
import jsontag.dao.JsonTagTemplateDaoImpl;
import jsontag.interf.IDoService;
/**
 * 获取交通拥堵率
 * @author Administrator
 *
 */
@JsonTagAnnotation(actionValue="/GetSomeJams.action",namespace="/traffic",isJsonReturn=true)
public class GetSomeJams extends JsonTagTemplateDaoImpl implements IDoService{
	private String date;
	private String size;
	
	
	private String compDate;
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
	public String getCompDate() {
		return compDate;
	}
	public void setCompDate(String compDate) {
		this.compDate = compDate;
	}
	@Override
	public Object doService() throws Exception {
		// TODO Auto-generated method stub
		String sql;
		List<Map<String,Object>> list=new  ArrayList<Map<String,Object>>();
		List<Map<String,Object>> listy=new  ArrayList<Map<String,Object>>();
		List<Map<String,Object>> rst=new  ArrayList<Map<String,Object>>();
		List<Map<String,Object>> rsut=new  ArrayList<Map<String,Object>>();
		double[] num =new double[10];
		//List<Object> lis=new ArrayList<Object >();
		
		sql="select * from"
			+"(select station_id,sum(enter_times+change_times) times from tbl_metro_fluxnew_"+date+" where ticket_type not in (40,41,130,131,140,141)"  
			+" and start_time ="+date+"||to_char(sysdate-30/(24*60),'hh24')||lpad(trunc(to_number(to_char(sysdate-30/(24*60),'mi'))/5,0)*5,2,'0')||'00'  group by"
			+ "  station_id ORDER BY times desc "
			+") where trim(station_id)=?";
		String sqls="select * from VIW_METRO_STATION_NAME where to_char(sysdate,'yyyyMMdd') between start_time and end_time and STATION_NM_CN=?";
		
		String  sqlm="select station_nm_cn, sum(times) times from (select * from(select station_id,sum(enter_times+change_times) times from tbl_metro_fluxnew_20190514 "
				+ " where ticket_type not in (40,41,130,131,140,141) and start_time =20190514||to_char(sysdate-30/(24*60),'hh24')||lpad(trunc(to_number(to_char(sysdate-30/(24*60),'mi'))/5,0)*5,2,'0')||'00'  group by  station_id ORDER BY times desc )) a ,"
				+" (select * from VIW_METRO_STATION_NAME where to_char(sysdate,'yyyyMMdd') between start_time and end_time and STATION_NM_CN=?) b  where b.station_id=a.station_id(+)  group by"
				+" station_nm_cn";
		String [] site=JsonTagContext.getRequest().getParameterValues("sites[]");
		
		for (int l = site.length-1;l>=0; l--) {
			
			String station_nm=site[l];
		
			listy = jsonTagJdbcDao.getJdbcTemplate().queryForList(sqls,station_nm);
		for (Map<String, Object>  mpa:listy) {
			
			String station_id=mpa.get("STATION_ID").toString();
			
			list = jsonTagJdbcDao.getJdbcTemplate().queryForList(sql,station_id);
			for (int i = 0; i < list.size(); i++) {
				
			
			
			Map<String, Object>  mp=list.get(i);
			Map<String, Object>  obj=new HashMap<String, Object>();
			
			double	times=Double.parseDouble(mp.get("TIMES").toString());
			String	stationID=mp.get("STATION_ID").toString();
			
			String sqla="select max(times) max_times from (select start_time,sum(enter_times+change_times) times"
						+" from tbl_metro_fluxnew_history where stmt_day >= '20181230' and station_id = ?"
						+" group by start_time) t";
			
			List<Map<String,Object>> lista=new  ArrayList<Map<String,Object>>();
			lista = jsonTagJdbcDao.getJdbcTemplate().queryForList(sqla,stationID);
			double	maxtimes=0;
			for (Map<String, Object>  mpc:lista) {
				
					maxtimes=Double.parseDouble(mpc.get("MAX_TIMES").toString());
			}
			double  jamrate=Math.abs(times*100/maxtimes);
			
					num[i]=jamrate;
			
			
			 NumberFormat nf = NumberFormat.getNumberInstance();
		        // 保留两位小数
		        nf.setMaximumFractionDigits(2); 
		        // 如果不需要四舍五入，可以使用RoundingMode.DOWN
		        nf.setRoundingMode(RoundingMode.UP);
		       String trfcjam=nf.format(jamrate);
		       
		       String sqlb="select * from VIW_METRO_STATION_NAME where to_char(sysdate,'yyyyMMdd') between start_time and end_time and station_id=?";
			
			List<Map<String,Object>> listb=new  ArrayList<Map<String,Object>>();
			listb = jsonTagJdbcDao.getJdbcTemplate().queryForList(sqlb,stationID.trim());
			String	stationName="";
			for (Map<String, Object>  mpc:listb) {
				
					stationName=mpc.get("STATION_NM_CN").toString();
			}
              obj.put("stationName", stationName);
              obj.put("trfcjam", trfcjam);
              rst.add(obj);
              
              
            
				
			
		 
	 }
		}
	}
		
			Arrays.sort(num);
			
			for (int j = num.length-1; j>=0;j--) {
				
				 NumberFormat nf = NumberFormat.getNumberInstance();
			        // 保留两位小数
			        nf.setMaximumFractionDigits(2); 
			        // 如果不需要四舍五入，可以使用RoundingMode.DOWN
			        nf.setRoundingMode(RoundingMode.UP);
			       String b=nf.format(num[j]);
				for (Map<String, Object>  mp:rst) {
				String a=mp.get("trfcjam").toString();
				String c=mp.get("stationName").toString();
					if(a.equals(b)){
						Map<String, Object>  oj=new HashMap<String, Object>();
						oj.put("stationName", c);
			              oj.put("trfcjam", a);
			              rsut.add(oj);
					}
				}
				
			}
			
		
		
		return rst;
	}
	
	

}
