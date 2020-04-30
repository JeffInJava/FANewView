package com.gmoa.vos.pflw;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jsontag.annotation.JsonTagAnnotation;
import jsontag.dao.JsonTagTemplateDaoImpl;
import jsontag.interf.IDoService;
/**
 * 获取客流总量
 * @author Administrator
 *
 */
@JsonTagAnnotation(actionValue="/GetpfwSmy.action",namespace="/sumflw",isJsonReturn=true)
public class GetpfwSmy extends JsonTagTemplateDaoImpl implements IDoService{
	private String date;
	private String size;
	private String hour;
	
	public String getHour() {
		return hour;
	}
	public void setHour(String hour) {
		this.hour = hour;
	}
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
		String sql1;
		String sql2;
		String sql3;
		String sql4;
		String sql5;
		String sql6;
	
		List<Map<String,Object>> list=new  ArrayList<Map<String,Object>>();
		
		List<Map<String,Object>> list1=new  ArrayList<Map<String,Object>>();
		List<Map<String,Object>> list2=new  ArrayList<Map<String,Object>>();
		List<Map<String,Object>> list3=new  ArrayList<Map<String,Object>>();
		List<Map<String,Object>> list4=new  ArrayList<Map<String,Object>>();
		List<Map<String,Object>> list5=new  ArrayList<Map<String,Object>>();
		List<Map<String,Object>> list6=new  ArrayList<Map<String,Object>>();
		
		double  enterTimes=0;
		double  exitTimes=0;
		double  changeTimes=0;
		double  pfwAmount=0;
		double  menterTimes=0;
		double  mexitTimes=0;
		double  mchangeTimes=0;
		double  mpfwAmount=0;
		double  hpfwAmount=0;
		double  compfwAmount=0;
		double  transAmount=0;
		double  istAmount=0;
		double  cpistAmount=0;
		String  asrt="";
		String  Mdate="";
		String  dsrt="";
		
		double  ascRate=0;
		double  dscRate=0;
		
		String fir_sql="";
		String sec_sql="";
		String fir_sql1="";
		
		 SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
		  	Calendar calendar = Calendar.getInstance(); 
		 java.util.Date s_date1=df.parse(date);
		 java.util.Date s_date2=df.parse(compDate);
		 String today = df.format(calendar.getTime());//当前日期
	 	 calendar.setTime(df.parse(today));
		 calendar.add(GregorianCalendar.DAY_OF_MONTH, -60);
		 java.util.Date tempDate = calendar.getTime();
		
		 calendar.setTime(s_date1);
		 calendar.add(GregorianCalendar.DAY_OF_MONTH,1);
		 String date1=df.format(calendar.getTime());
		 
		 calendar.setTime(s_date2);
		 calendar.add(GregorianCalendar.DAY_OF_MONTH,1);
		 String compDate1=df.format(calendar.getTime());
		//查询日期和服务器的当前日期比较，如果查询日期是60天以前，则查询tbl_metro_fluxnew_history表
		if(s_date1.compareTo(tempDate) > 0) {
			fir_sql=" tbl_metro_fluxnew_"+date+" where ticket_type not in ('40','41','130','131','140','141') ";
			fir_sql1=" tbl_metro_fluxnew_"+date1+" where ticket_type not in ('40','41','130','131','140','141') ";
		}else{
			fir_sql=" tbl_metro_fluxnew_history partition(V"+date+"_FLUXNEW_HISTORY) where 1=1 ";
			fir_sql1=" tbl_metro_fluxnew_history partition(V"+date1+"_FLUXNEW_HISTORY) where 1=1 ";
		}
		if(s_date2.compareTo(tempDate) > 0) {
			sec_sql=" tbl_metro_fluxnew_"+compDate+" where ticket_type not in ('40','41','130','131','140','141') ";
		}else{
			sec_sql=" tbl_metro_fluxnew_history partition(V"+compDate+"_FLUXNEW_HISTORY) where 1=1 ";
		}
		Map<String,Object>  result=new 	HashMap<String, Object>();
		if(hour.equals("last")){
			
			sql2=" select a.*,b.entimes cent_amount,b.in_pass_num capfw_amount,b.chgtimes cchg_amount,b.extimes cexit_amount from"
					  + "(select round( sum( ENTER_TIMES + CHANGE_TIMES ) / 1000000, 1 ) apfw_amount,round(sum(ENTER_TIMES)/1000000,1) ent_amount,round(sum(CHANGE_TIMES)/1000000,1) chg_amount,round(sum(EXIT_TIMES)/1000000,1) exit_amount from "+fir_sql
					  +" ) a,"
					  +"( select round( sum( ENTER_TIMES + CHANGE_TIMES ) / 1000000, 1 ) in_pass_num,round(sum(ENTER_TIMES)/1000000,1) entimes,round(sum(CHANGE_TIMES)/1000000,1) chgtimes,round(sum(EXIT_TIMES)/1000000,1) extimes from "+sec_sql
					  +"  "
					  +") b";
		}else{

				
				sql2=" select a.*,b.entimes cent_amount,b.in_pass_num capfw_amount,b.chgtimes cchg_amount,b.extimes cexit_amount from"
					  + "(select round( sum( ENTER_TIMES + CHANGE_TIMES ) / 1000000, 1 ) apfw_amount,round(sum(ENTER_TIMES)/1000000,1) ent_amount,round(sum(CHANGE_TIMES)/1000000,1) chg_amount,round(sum(EXIT_TIMES)/1000000,1) exit_amount from "+fir_sql
					  +"  and start_time <="+date+"||to_char(sysdate-30/(24*60),'hh24miss')"
					  +" ) a,"
					  +"( select round( sum( ENTER_TIMES + CHANGE_TIMES ) / 1000000, 1 ) in_pass_num,round(sum(ENTER_TIMES)/1000000,1) entimes,round(sum(CHANGE_TIMES)/1000000,1) chgtimes,round(sum(EXIT_TIMES)/1000000,1) extimes from "+sec_sql
					  +"  and start_time <="+compDate+"||to_char(sysdate-30/(24*60),'hh24miss')"
					  +") b";
				
		}
				list2 = jsonTagJdbcDao.getJdbcTemplate().queryForList(sql2);
				
				for (Map<String, Object>  mp:list2) {
					pfwAmount=Double.parseDouble(mp.get("APFW_AMOUNT").toString());
					enterTimes=Double.parseDouble(mp.get("ENT_AMOUNT").toString());
					exitTimes=Double.parseDouble(mp.get("EXIT_AMOUNT").toString());
					changeTimes=Double.parseDouble(mp.get("CHG_AMOUNT").toString());
					mpfwAmount=Double.parseDouble(mp.get("CAPFW_AMOUNT").toString());
					menterTimes=Double.parseDouble(mp.get("CENT_AMOUNT").toString());
					mexitTimes=Double.parseDouble(mp.get("CEXIT_AMOUNT").toString());
					mchangeTimes=Double.parseDouble(mp.get("CCHG_AMOUNT").toString());
			 }
				
		
			sql6 = "select * from"
			+" ("
			+" select stmt_day,round(sum(times)/10000,1) times from"
			+"  ("
			+"    select stmt_day,sum(change_times_save) times from tbl_metro_report_en_flux_day where stmt_day>='20190308'"
			+"     group by stmt_day"
			+"     union all"
			+"     select stmt_day,sum(sale_nubs-unsale_nubs)times from tbl_metro_ctcard_line_day where stmt_day>='20190308'"
			+"    group by stmt_day"
			+"    union all"
			+"   select stmt_day,(sum(dcp_sell_times)+sum(jck_enter_times)+sum(jfk_enter_times)+sum(YGK_ENTER_TIMES)+sum(jcp_enter_times)+sum(lrk_enter_times)+sum(cmcc_enter_times)+sum(pboc_enter_times)+sum(qrcd_enter_times)) times"
			+"    from tbl_metro_report_save_flux where stmt_day>='20190308'"
			+"     group by stmt_day"
			+"   )"
			+"   group by stmt_day "
			+"   order by times desc"
			+" ) where rownum=1 ";
											//jsonTagJdbcDao.getJdbcTemplate().setMaxRows(this.getSize());
								list6 = jsonTagJdbcDao.getJdbcTemplate().queryForList(sql6);
								
								
								for (int i = 0; i < list6.size(); i++) {
									
									Map<String, Object>  mp=list6.get(0);
									 hpfwAmount=Double.parseDouble(mp.get("TIMES").toString());
									 Mdate=mp.get("STMT_DAY").toString();
								 }
			
	
			 double  num=pfwAmount-mpfwAmount;
			 NumberFormat nf = NumberFormat.getNumberInstance();
		        // 保留两位小数
		        nf.setMaximumFractionDigits(2); 
		        // 如果不需要四舍五入，可以使用RoundingMode.DOWN
		        nf.setRoundingMode(RoundingMode.UP);
			 if(num>0){
				 ascRate= Math.abs(num*100/mpfwAmount);
				 asrt=nf.format(ascRate);
			 } else {
				 dscRate=Math.abs(num*100/mpfwAmount);
				 dsrt=nf.format(dscRate);
			 }
			 
			
			 
			 result.put("pfwAmount", pfwAmount);
			 result.put("enterTimes", enterTimes);
			 result.put("exitTimes", exitTimes);
			 result.put("changeTimes", changeTimes);
			 result.put("mpfwAmount", mpfwAmount);
			 result.put("menterTimes", menterTimes);
			 result.put("mexitTimes", mexitTimes);
			 result.put("mchangeTimes", mchangeTimes);
			 result.put("hpfwAmount", hpfwAmount);
			 result.put("Mdate", Mdate);
			 result.put("ascRate", asrt);
			 result.put("dscRate", dsrt);
			 
		return result;
	}

}
