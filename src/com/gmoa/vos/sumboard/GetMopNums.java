package com.gmoa.vos.sumboard;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jsontag.JsonTagContext;
import jsontag.annotation.JsonTagAnnotation;
import jsontag.dao.JsonTagTemplateDaoImpl;
import jsontag.interf.IDoService;

/**
 * 获取设备数量
 * @author Administrator
 *
 */
@JsonTagAnnotation(actionValue="/GetMopNums.action",namespace="/synt",isJsonReturn=true)
public class GetMopNums extends JsonTagTemplateDaoImpl implements IDoService{
	private String date;
	private String size;
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
	String	month;
		String sql;
		int  ticls=0;
		int  scct=0;
		int  Bc=0;
		int  Cc=0;
		int  tot=0;
		String beforedate="";
		
		
		//获取上个月的最后一天
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.DAY_OF_MONTH, 1); 
		calendar.add(Calendar.DATE, -1);
		beforedate =sdf.format(calendar.getTime());
		
		month=beforedate.substring(0, 6);
		//获取昨天日期
		Calendar ldate = Calendar.getInstance();
		
			ldate.setTime(new Date());
			ldate.add(Calendar.DATE, -1);
			date=sdf.format(ldate.getTime());
		
		Map<String,Object>  result=new 	HashMap<String, Object>();
		List<Map<String,Object>> list=new  ArrayList<Map<String,Object>>();		
			sql ="select stmt_day,sum(STORAGE_TODAY_END_TOTAL_VALUE) tickCount from tms.tbl_metro_rpt_total_value where stmt_day="+date+" group by stmt_day" ;
			list = jsonTagJdbcDao.getJdbcTemplate().queryForList(sql);
				for(Map<String,Object> gma:list){
					ticls=Integer.parseInt(gma.get("TICKCOUNT").toString());
				}
				String	vql ="with station as (select station_id,station_nm_cn from tms.viw_metro_station_name"
						+" where start_time<="+date+ " and end_time>="+date+") select count(*) scct from (select   i.station_id,'已上传' un_ctl from station i"
						 +" where  exists(select 'X' from tms.tbl_metro_stmt_ctl j where stmt_day="+date+" and i.station_id=j.station_id)"
						  +" and i.station_id not in (select station_id from tms.viw_metro_sta_no_equip))" ;
				List<Map<String,Object>> vl = jsonTagJdbcDao.getJdbcTemplate().queryForList(vql);
						for(Map<String,Object> vma:vl){
							scct=Integer.parseInt(vma.get("SCCT").toString());
						}
			String  sqa=" select  b.owner_id,b.owner_nm_cn,round(sum(a.times)/10000,2) times,round(sum(a.amt)/10000,2) amt  from "
				+" (select a.stmt_mon, a.line_id,sum(a.times) + sum(b.sale_nubs) times,sum(a.amt) amt  from (select a.stmt_mon, a.line_id,"
				+"   sum(b.enter_times) + sum(b.change_times) times,sum(nvl(a.sjt_amt_s,0)) + sum(nvl(a.spt_amt,0)) + sum(nvl(a.pboc_amt,0)) +"
				+"  sum(nvl(a.special_1_amt,0)) + sum(nvl(a.special_3_amt,0)) +sum(nvl(a.special_4_amt,0)) + sum(nvl(a.special_5_amt,0)) + sum(nvl(a.qrcd_amt,0)) +"
				+"  sum(nvl(a.unip_amt,0))+ sum(nvl(a.wechat_amt,0)) amt from tms.tbl_metro_comanymontemp a left join (select substr(stmt_day, 0, 6) stmt_mon,"
				+"    b.line_id,station_id_sub_detail station_id_sub, station_id_detail station_id,sum(enter_times) enter_times,sum(change_times) change_times"
				+"    from TBL_METRO_COMANYDAYTEMP@pbdata a,(select * from viw_metro_station_name_41_08@pbdata where start_time <="+beforedate+" and end_time>="+beforedate+") b" 
				+"      where substr(stmt_day, 0, 6) = "+month+" and a.station_id=b.station_id group by substr(stmt_day, 0, 6), b.line_id,station_id_sub_detail,"
				+"   station_id_detail) b on a.stmt_mon = b.stmt_mon and a.line_id = b.line_id  and a.station_id_sub = b.station_id_sub  and a.station_id = b.station_id"
				+"   where a.stmt_mon = "+month+" group by a.stmt_mon, a.line_id order by a.line_id) a, (select line_id, nvl(sum(sale_nubs - unsale_nubs), 0) sale_nubs"
				+"     from tbl_metro_report_en_flux_day@pbdata where substr(stmt_day, 0, 6) = "+month+" group by line_id order by line_id) b  where a.line_id = b.line_id"
				+"    group by a.stmt_mon, a.line_id) a,(select * from TBL_METRO_LINE_INFO_OWNER) b where  a.line_id=b.line_id  group by b.owner_id,b.owner_nm_cn ORDER BY amt desc";
			List<Map<String,Object>> oml = jsonTagJdbcDao.getJdbcTemplate().queryForList(sqa);
			
			
			String qrcdsql="select STMT_DAY,round(SUM(QRCD_ENTER_TIMES)/10000,1) hqrcdt from TBL_METRO_REPORT_SAVE_FLUX WHERE  STMT_DAY>='20180401'  GROUP BY STMT_DAY  ORDER BY hqrcdt desc";
			List<Map<String,Object>> orcdl = jsonTagJdbcDao.getJdbcTemplate().queryForList(qrcdsql);
			
			String  qrcdate="";
			double qrcdt=0;
			for(Map<String,Object> vma:orcdl){
				
				vma=orcdl.get(0);
				qrcdt=Double.parseDouble(vma.get("HQRCDT").toString());
				qrcdate=vma.get("STMT_DAY").toString();
			}
			
			double qrcdtotal=0;
			String qrcdql="select round(sum(dcp_sell_times + jck_enter_times +jfk_enter_times + lrk_enter_times +ygk_enter_times+czp_enter_times+gwp_enter_times"
						+"+ jcp_enter_times +cmcc_enter_times + pboc_enter_times+qrcd_enter_times)/10000,1) total from TBL_METRO_REPORT_SAVE_FLUX WHERE  STMT_DAY=?";
			List<Map<String,Object>> orcdtl = jsonTagJdbcDao.getJdbcTemplate().queryForList(qrcdql,qrcdate);
			
			for(Map<String,Object> vma:orcdtl){
				qrcdtotal=Double.parseDouble(vma.get("TOTAL").toString());
			}
			int tsgtotal=0;
			String tsgql="select sum(sjt_balance) stge from tms.tbl_metro_sta_tick_storage_day where  stmt_day=?";
			List<Map<String,Object>> tsgl = jsonTagJdbcDao.getJdbcTemplate().queryForList(tsgql,date);
			
			for(Map<String,Object> vma:tsgl){
				tsgtotal=Integer.parseInt(vma.get("STGE").toString());
			}
			String seql=" with station as"
			+"	(select station_id,station_nm_cn from tms.viw_metro_station_name where start_time<="+date+" and end_time>="+date+")"
			+"	select count(*) staEnd from tms.tbl_metro_day_end i,station j  where end_day = "+date+" and i.station_id not in (select station_id from tms.viw_metro_sta_no_end) and i.station_id = j.station_id";
			List<Map<String,Object>> stedl = jsonTagJdbcDao.getJdbcTemplate().queryForList(seql);
			int staEnd=0;
			for(Map<String,Object> vma:stedl){
				staEnd=Integer.parseInt(vma.get("STAEND").toString());
			}
			String eqmql="with sta as"
					 +" (select t.line_id, t.station_id from viw_metro_station_name t where "+date+" between start_time and end_time"
					 +"  order by line_id, station_id),"
					 +" deail as"
					 +" (select a.*, NVL(b.sm, 0) SM"
					 +"     from (SELECT b.line_id,"
					 +"                      B.LINE_NM_CN,"
					 +"                     C.STATION_ID,"
					 +"                     C.STATION_NM_CN,"
					 +"                     A.QF_EQUIP_ID,"
					 +"                     A.EQUIP_NODE_ID,"
					 +"                    A.EQUIP_ID,"
					 +"                A.EQUIP_TYPE,"
					 +"                       STATUS,"
					 +"                       LAST_DEAL_TIME,"
					 +"                       LAST_CREATE_TIME,"
					 +"                     A.REFER_STATE,"
					 +"                      A.UPDATE_RESON,"
					 +"                      A.PC_MAKER,"
					 +"                      d.s1,"
					 +"                       e.s2,"
					 +"                     a.trans_type"
					 +"                  FROM (SELECT case when trim(station_id) in ('0819','0818','0817','0816','0815') then '41' else line_id end line_id,"
					 +"                            case when trim(station_id)='0819' then '4102' when trim(station_id)='0818' then '4103' when trim(station_id)='0817' then '4104'"
					 +"                when trim(station_id)='0816' then '4105' when trim(station_id)='0815' then '4106' else trim(station_id) end station_id,"
					 +"                      QF_EQUIP_ID,"
					 +"                EQUIP_NODE_ID,"
					 +"                           EQUIP_ID,"
					 +"                              EQUIP_TYPE,"
					 +"                     CASE"
					 +"                                WHEN STOP_FLAG = '0' THEN"
					 +"                         '停用'"
					 +"                              WHEN STOP_FLAG = '1' THEN"
					 +"              '启用'"
					 +"                             END STATUS,"
					 +"                CASE tms.IS_DATE(LAST_DEAL_TIME)"
					 +"                               WHEN 0 THEN"
					 +"                      ''"
					 +"            WHEN 1 THEN"
					                                   +"                              LAST_DEAL_TIME"
					                                   +"           END LAST_DEAL_TIME,"
					                                   +"                CASE tms.IS_DATE(LAST_CREATE_TIME)"
					                                   +"   WHEN 0 THEN"
					                                   +"        ''"
					                                   +"     WHEN 1 THEN"
					                                   +"  LAST_CREATE_TIME"
					                                   +"     END LAST_CREATE_TIME,"
					                                   +"  REFER_STATE,"
					                                   +"  UPDATE_RESON,"
					                                   +"   PC_MAKER,"
					                                   +"  CASE"
					                                   +"  WHEN trans_type in (38, 39, 42, 43) THEN"
					                                   +"   '进'"
					                                   +" WHEN trans_type in (36, 37, 64, 65) THEN"
					                                   +"    '出'"
					                                   +"   END trans_type"
					                                   +"   FROM tms.TBL_METRO_DEVICE_INFO_LOG"
					                                   +"   WHERE STOP_FLAG = '1'"
					                                   +" AND STATUS = '1'"
					                                   +"  AND STMT_DAY = "+date
					                                   +"  AND (SUBSTR(LAST_DEAL_TIME, 1, 8) < "+date+" OR"
					                                +" SUBSTR(LAST_CREATE_TIME, 1, 8) < "+date+")) A,"
					                    +"     (SELECT LINE_ID, LINE_NM_CN"
					                    +"     FROM VIW_METRO_LINE_NAME"
					                    +"       WHERE START_TIME <= "+date
					                    +"      AND END_TIME >= "+date+") B,"
					                    +"     (SELECT LINE_ID, STATION_ID, STATION_NM_CN"
					                    +"    FROM VIW_METRO_STATION_NAME"
					                    +"      WHERE START_TIME <= "+date
					                    +"       AND END_TIME >= "+date+") C,"
					                    +"     (SELECT case when trim(station_id) in ('0819','0818','0817','0816','0815') then '41' else line_id end line_id,"
					                    +"       case when trim(station_id)='0819' then '4102' when trim(station_id)='0818' then '4103' when trim(station_id)='0817' then '4104'"
					                    +"           when trim(station_id)='0816' then '4105' when trim(station_id)='0815' then '4106' else trim(station_id) end station_id,"
					                    +"             EQUIP_TYPE,"
					                    +"            COUNT(EQUIP_ID) S1"
					                    +"       FROM tms.TBL_METRO_DEVICE_INFO_LOG"
					                    +"      WHERE STOP_FLAG = '1'"
					                    +"        AND STATUS = '1'"
					                    +"           AND STMT_DAY = "+date
					                    +"        AND (SUBSTR(LAST_DEAL_TIME, 1, 8) < "+date+" OR"
					                      +"           SUBSTR(LAST_CREATE_TIME, 1, 8) < "+date+")"
					                    +"       GROUP BY LINE_ID, STATION_ID, EQUIP_TYPE) D,"
					                    +"    (SELECT case when trim(station_id) in ('0819','0818','0817','0816','0815') then '41' else line_id end line_id,"
					                    +"         case when trim(station_id)='0819' then '4102' when trim(station_id)='0818' then '4103' when trim(station_id)='0817' then '4104'"
					                    +"         when trim(station_id)='0816' then '4105' when trim(station_id)='0815' then '4106' else trim(station_id) end station_id,"
					                    +"           EQUIP_TYPE,"
					                    +"        COUNT(EQUIP_ID) S2"
					                    +"      FROM tms.TBL_METRO_DEVICE_INFO_LOG"
					                    +"      WHERE STOP_FLAG = '1'"
					                    +"        AND STATUS = '1'"
					                    +"       AND STMT_DAY = "+date
					                    +"       GROUP BY LINE_ID, STATION_ID, EQUIP_TYPE) E"
					              +"     WHERE C.LINE_ID = B.LINE_ID"
					              +"     AND A.STATION_ID = C.STATION_ID"
					              +"       AND A.LINE_ID = D.LINE_ID"
					              +"      AND A.STATION_ID = D.STATION_ID"
					              +"     AND A.EQUIP_TYPE = D.EQUIP_TYPE"
					              +"      AND A.LINE_ID = E.LINE_ID"
					              +"      AND A.STATION_ID = E.STATION_ID"
					              +"    AND A.EQUIP_TYPE = E.EQUIP_TYPE"
					              +"    ORDER BY A.QF_EQUIP_ID) a"
					              +" left join (select case when trim(t.station_id)='0819' then '4102' when trim(t.station_id)='0818' then '4103' when trim(t.station_id)='0817' then '4104'"
					              +"        when trim(t.station_id)='0816' then '4105' when trim(t.station_id)='0815' then '4106' else trim(t.station_id) end station_id,"
					              +"     STMT_DAY,EQUIP_ID,SM from"
					              +"   ("
					              +"        SELECT STMT_DAY,station_id,EQUIP_ID,SUM(en_time + ex_time) SM FROM tms.afc_diffient_get_cc T"
					              +"          WHERE STMT_DAY ="+date
					              +"        GROUP BY STMT_DAY,station_id, EQUIP_ID"
					                   +"       UNION ALL"
					                   +"       SELECT STMT_DAY,station_id,EQUIP_ID,SUM(times) FROM tms.afc_diffient_bom_cc T"
					                   +"      WHERE STMT_DAY = '' ||"+date+" || ''"
					                    +"       GROUP BY STMT_DAY,station_id, EQUIP_ID"
					                    +"        UNION ALL"
					                    +"        SELECT STMT_DAY,station_id,EQUIP_ID,SUM(times) FROM tms.afc_diffient_tvm_cc T"
					                    +"         WHERE STMT_DAY = "+date
					                    +"     GROUP BY STMT_DAY, STATION_ID, EQUIP_ID"
					                   +"      ) t,sta where t.station_id = sta.station_id) b"
					                   +"    on a.station_id = b.station_id"
					                   +"      and a.EQUIP_ID = b.EQUIP_ID"
					                   +"    where a.equip_type in"
					                   +"    ('进站检票机', '出站检票机', '双向检票机', '触摸屏式TVM')"
					                   +"    order by a.last_create_time, a.last_deal_time, a.LINE_NM_CN, a.station_id),"
					                   +"    sources as ("
					                   +"    select a.*,rank() over(order by is_type desc,sc desc) rn from ("
					                   +"    select line_id,line_nm_cn,station_id,station_nm_cn,qf_equip_id,equip_node_id,equip_id,equip_type,last_deal_time,last_create_time,sm,3 is_type,abs(last_create_time-"+date+"||'000000') sc"
					                   +"    from  deail where sm>=1"
					                   +"    union all"
					                   +"     select line_id,line_nm_cn,station_id,station_nm_cn,qf_equip_id,equip_node_id,equip_id,equip_type,last_deal_time,last_create_time,sm,2 is_type,abs(last_create_time-"+date+"||'000000') sc"
					         +" from  deail where sm=0 and last_deal_time<"+date+"||'000000' and last_create_time<"+date+"||'000000'"
					        +"   union all"
					        +"    select line_id,line_nm_cn,station_id,station_nm_cn,qf_equip_id,equip_node_id,equip_id,equip_type,last_deal_time,last_create_time,sm,1 is_type,abs(last_create_time-"+date+"||'000000') sc"
					        +"   from  deail where sm=0 and last_deal_time>"+date+"||'000000' and last_create_time<"+date+"||'000000'"
					         +"  ) a"
					           
				+"  )"
				+"	SELECT a.LINE_ID,case when a.LINE_ID='41' then '浦江线' else a.LINE_ID || '号线' end LINE_NM_CN,"
				+"	       a.STATION_ID,"
				+"   a.STATION_NM_CN,"
				+"       a.QF_EQUIP_ID,"
				+"      a.EQUIP_NODE_ID,"
				+"	       a.EQUIP_ID,"
				+"	       a.EQUIP_TYPE,"
				+"	       a.LAST_DEAL_TIME,"
				+"		       a.LAST_CREATE_TIME,"
				+"	       b.total,"
				+"	       a.sm,"
				+"       a.rn,"
				+"       a.sc,"
				+"       a.is_type,"
				+"       case "
				+"       when is_type='3' then"
				+"        '当日疑似断流水号'"
				+"      when is_type='2' then"
				+"         '24小时内未上传寄存器和明细'"
				+"	         when is_type='1' then"
				+"		           '24小时内仅寄存器未上传'"
				+"		           else "
				+"			             '' end remark"
				+"	  FROM sources a, (select count(1) total from sources) b"
				+"	 where rn between 1 and 10"
				+"		 order by a.rn";
			List<Map<String,Object>> eqml = jsonTagJdbcDao.getJdbcTemplate().queryForList(eqmql);	
			
			result.put("ticlost", ticls);
			result.put("scct", scct);
			result.put("staEnd", staEnd);
			result.put("qrcdt", qrcdt);
			result.put("qrcdate", qrcdate);
			result.put("qrcdtotal", qrcdtotal);
			result.put("tsgtotal", tsgtotal);
			result.put("eqml", eqml);
			
			result.put("opAmt", oml);
			
			
			
			
			
			 
		return result;
		
	}

}
