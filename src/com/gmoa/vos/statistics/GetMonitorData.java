package com.gmoa.vos.statistics;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;

import com.util.HttpUtil;

import net.sf.json.JSONObject;

import jsontag.annotation.JsonTagAnnotation;
import jsontag.dao.JsonTagTemplateDaoImpl;
import jsontag.interf.IDoService;
import jsontag.util.DateUtil;

  
@JsonTagAnnotation(actionValue="/get_monitordata.action",namespace="/monitor",isJsonReturn=true)
public class GetMonitorData extends JsonTagTemplateDaoImpl implements IDoService {

	@Override
	public Object doService() throws Exception {
		JSONObject result=new JSONObject();
		String start_date=DateUtil.dateToStringByDateFormat(new Date(),DateUtil.DATEFORMAT_YYYYMMDD);
		
		StringBuffer sql=new StringBuffer();
		sql.append("select '单程票' name,t2.line_id from ");
		sql.append("( ");
		sql.append("  select substr(issue_node,1,2) line_id from zf_txn_tick_").append(start_date).append("@MCCDB where last_time>=to_char(sysdate-20/60/24,'yyyyMMddHH24miss') ");
		sql.append("  group by substr(issue_node,1,2) ");
		sql.append(") t1, ");
		sql.append("(select line_id from viw_metro_line_name where '").append(start_date).append("' between start_time and end_time and line_id<>'41') t2 ");
		sql.append("where t1.line_id(+)=t2.line_id and t1.line_id is null ");
		sql.append("union all ");
		sql.append("select '公交卡' name,t2.line_id from ");
		sql.append("( ");
		sql.append("  select substr(issue_node,1,2) line_id from zf_txn_card_").append(start_date).append("@MCCDB where last_time>=to_char(sysdate-20/60/24,'yyyyMMddHH24miss') ");
		sql.append("  group by substr(issue_node,1,2) ");
		sql.append(") t1, ");
		sql.append("(select line_id from viw_metro_line_name where '").append(start_date).append("' between start_time and end_time and line_id<>'41') t2 ");
		sql.append("where t1.line_id(+)=t2.line_id and t1.line_id is null ");
		sql.append("union all ");
		sql.append("select '二维码' name,t2.line_id from ");
		sql.append("( ");
		sql.append("  select substr(issue_node,1,2) line_id from zf_txn_qrcd_").append(start_date).append("@MCCDB where last_time>=to_char(sysdate-20/60/24,'yyyyMMddHH24miss') ");
		sql.append("  group by substr(issue_node,1,2) ");
		sql.append(") t1, ");
		sql.append("(select line_id from viw_metro_line_name where '").append(start_date).append("' between start_time and end_time and line_id<>'41') t2 ");
		sql.append("where t1.line_id(+)=t2.line_id and t1.line_id is null ");
		//查询前置线路数据是否入库
		List<Map<String,Object>> list=jsonTagJdbcDao.getJdbcTemplate().queryForList(sql.toString());
		result.put("pacc", list);
		
		sql=new StringBuffer("select count(*) nums from tbl_metro_seg_dtl where state<>0");
		//段分发，查询是否有段数据挤压
		list=jsonTagJdbcDao.getJdbcTemplate().queryForList(sql.toString());
		result.put("ppulish", list);
		
		sql=new StringBuffer("select trim(code_value) code_value from tbl_metro_code_list where code_tbl='DB_EERROR_FLAG_STR'");
		//查看codelist是否有异常(0 数据库状态正常 ,!=0 数据库异常)
		list=jsonTagJdbcDao.getJdbcTemplate().queryForList(sql.toString());
		result.put("pqfDeal", list);
		
		sql=new StringBuffer();
		sql.append("select 'sptc' name,proc_st,count(*) times from tbl_metro_sptc_package_ctl where stmt_day='").append(start_date).append("' and proc_st in (2,6) and msg_code in('9800','9900','9840','9850') ");
		sql.append("group by proc_st ");
		sql.append("union all ");
		sql.append("select 'qrcd' name,proc_st,count(*) times from tbl_metro_qrcd_pkg_ctl_blob where stmt_day='").append(start_date).append("' and proc_st in (2,6) and msg_code in('9800','9900','9840','9850') ");
		sql.append("group by proc_st ");
		//打包转发，查看未发送或发送失败的条数(2 未发送，6发送失败)
		list=jsonTagJdbcDao.getJdbcTemplate().queryForList(sql.toString());
		result.put("ppackage", list);
		
		/*********票务管理平台相关监控**********/
		sql=new StringBuffer();
		sql.append("select i.station_nm_cn||'('||i.station_id ||')' station_id from "); 
		sql.append("(select line_id,station_id,station_nm_cn from tms.viw_metro_station_name where start_time<='").append(start_date).append("' and end_time>='").append(start_date).append("') i "); 
		sql.append("where not exists( select 'x' from tms.tbl_metro_stmt_ctl j where stmt_day='").append(start_date).append("' and i.station_id=j.station_id ) "); 
		sql.append("and i.station_id not in('0501','0245','1061','1054','1041','1042', '0403','0404','0405','0406','0407','0408','0409','0410', ");
		sql.append("'0411','0422','0249','0632','0942','0826','0748','0746','1230','1237') ");
		//查看所有SC数据是否入库
		list=jsonTagJdbcDao.getJdbcTemplate().queryForList(sql.toString());
		result.put("pdatabase", list);
		
		//模拟HTTP请求,访问票务应用
		int statusCode=HttpUtil.getStatusCode("http://10.37.5.173/SubwayTicket/login.action");
		result.put("phttp",statusCode);
		
		return result;
	}

	
	
}
