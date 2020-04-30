package com.gmoa.vos.cocc;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jsontag.annotation.JsonTagAnnotation;
import jsontag.dao.JsonTagTemplateDaoImpl;
import jsontag.interf.IDoService;

import org.springframework.jdbc.core.BeanPropertyRowMapper;

import com.gmoa.bean.LineChainCompare;
import com.gmoa.util.CommonUtil;
/**
 * cocc线路客流
 * @author Jeff
 *
 */
@JsonTagAnnotation(actionValue="/get_line_time_seg_flow.action",namespace="/cocc",isJsonReturn=true)
public class GetLineTimesegFlow extends JsonTagTemplateDaoImpl implements IDoService{
	
	private String startTime;
	private String chainTime;
	private String preview;
	
	@Override
	public Object doService() throws Exception {
		Map<Object, Object> map = new HashMap();
		int segNum = 0;
		if(preview.equals("1")){
			segNum=4;
		}else{
			segNum=5;
		}
		String filterStartTime = CommonUtil.getRightDay(startTime);
		String filterChainTime = CommonUtil.getRightDay(chainTime);
		String timeFtsql = " ";
		boolean weeFlag = false;
		String nextDay = null;
		String nextChainDay = null;
		//日期没有过24点
		if(filterStartTime.equals(startTime)){
			timeFtsql = " to_char(sysdate - 30 / (24 * 60), 'hh24mi') >= substr(start_time, 9, 4) ";
		}else{
			//日期介于0点至3点,timeFtsql对应的是0-3点前一天的日期
			timeFtsql = "  '2400' >= substr(start_time, 9, 4) ";
			weeFlag = true;
		}
		startTime = filterStartTime;
		chainTime = filterChainTime;
		//下一天的日期（startTime已经减去一天了，所以这里要重新加上）
		nextDay = CommonUtil.getNextDay(startTime);
		nextChainDay = CommonUtil.getNextDay(chainTime);
		
		String tblFluxnewStart = "tbl_metro_fluxnew_";
		String tblFluxnewChain = "tbl_metro_fluxnew_";
		String tblWeeStart = "tbl_metro_fluxnew_";
		String tblWeeChain = "tbl_metro_fluxnew_";
		String startTicketTypes = "";
		String chainTicketTypes = "";
		//两个日期差大于60天时part=0,小于60天part=1,环比时part=1
		if(CommonUtil.stmtDayDiff(startTime)>=60){
			tblFluxnewStart+="history";
			startTicketTypes+=" and stmt_day='"+startTime+"'";
			tblWeeStart+="history";
			tblWeeChain+="history";
		}else{
			tblFluxnewStart+=startTime;
			startTicketTypes+=" and ticket_type not in ('40', '41', '130', '131', '140', '141') ";
			tblWeeStart+=nextDay;
			tblWeeChain+=nextChainDay;
		}
		if(CommonUtil.stmtDayDiff(chainTime)>=60){
			tblFluxnewChain+="history";
			chainTicketTypes+=" and stmt_day='"+chainTime+"'";
		}else{
			tblFluxnewChain+=chainTime;
			chainTicketTypes += " and ticket_type not in ('40', '41', '130', '131', '140', '141') ";
		}
		
		String timeSeg = " select ot.* from ( select substr(start_time, 9, 2) || ':' || lpad(trunc(substr(start_time, 11, 2) / 30, 0) * 30, 2, '0') as startTime "
				+ " from "+tblFluxnewStart+" where "
				+timeFtsql+startTicketTypes+ " and substr(start_time, 9, 4) >= '0700' group by substr(start_time, 9, 2) || ':' || lpad(trunc(substr(start_time, 11, 2) / 30, 0) * 30, 2, '0') "
				+ " order by startTime desc) ot  where rownum<"+segNum+" order by ot.startTime";
		
		List<LineChainCompare> lstTimeSeg = this.jsonTagJdbcDao.getJdbcTemplate().query(timeSeg, new Object[] {}, new BeanPropertyRowMapper<LineChainCompare>(LineChainCompare.class));
		boolean preDayData = true;
		//如果是0点至3点
		if(weeFlag){
			String weeSql = "select ot1.startTime from (select substr(start_time, 9, 2) || ':' || "
			+" lpad(trunc(substr(start_time, 11, 2) / 30, 0) * 30, 2, '0') as startTime from "+tblWeeStart
			+" where to_char(sysdate - 30 / (24 * 60), 'hh24mi') >= substr(start_time, 9, 4) "+startTicketTypes
			+" group by substr(start_time, 9, 2) || ':' || lpad(trunc(substr(start_time, 11, 2) / 30, 0) * 30,2,'0') "
			+" order by startTime desc) ot1  where rownum<6 order by ot1.startTime";
			List<LineChainCompare> lstWeeSeg = this.jsonTagJdbcDao.getJdbcTemplate().query(weeSql, new Object[] {}, new BeanPropertyRowMapper<LineChainCompare>(LineChainCompare.class));
			lstTimeSeg.addAll(lstWeeSeg);
			int lstSegSize = lstTimeSeg.size();
			if(lstSegSize>segNum-1){
				for(int i=0;i<=lstSegSize-segNum;i++){
					lstTimeSeg.remove(0);
				}
			}
			if(lstTimeSeg.size()==0 || lstTimeSeg==null)return null;
			String hourMin = lstTimeSeg.get(0).getStartTime().replace(":","");
			if("0000".equals(hourMin)){
				preDayData = false;
			}
		}
		
		
		String tails="";
		if(lstTimeSeg.size()==0 || lstTimeSeg==null){
			return null;
		}else{
			tails = " and substr(start_time, 9, 4)>='"+lstTimeSeg.get(0).getStartTime().replace(":","")+"'";
		}
	
		String lineLst = " select case line_id when '41' then '浦江线' else line_id end as lineId "
				+ " from "+tblFluxnewStart+" where "
				+ timeFtsql + startTicketTypes + " and substr(start_time, 9, 4) >= '0700' group by line_id order by line_id ";
		List<LineChainCompare> lines = this.jsonTagJdbcDao.getJdbcTemplate().query(lineLst, new Object[] {}, new BeanPropertyRowMapper<LineChainCompare>(LineChainCompare.class));
		
		List<LineChainCompare> lst = new ArrayList<LineChainCompare>();
		
		if(preDayData){
			String sql = "select case a.line_id when '41' then '浦江线' else a.line_id end as lineId,a.times as enterTimes,a.exitTimes ,a.times-b.times as enterDvalue,a.exitTimes-b.exitTimes as exitDvalue,a.start_time as startTime FROM ("
					+ " select line_id,substr(start_time,9,2)||':'||lpad(trunc(substr(start_time,11,2)/30,0)*30,2,'0') start_time,"
					+ " round((sum(enter_times)+sum(change_times))/100) times,round(sum(exit_times)/100) exitTimes from "+tblFluxnewStart
					+ " where "
					+ timeFtsql+startTicketTypes+tails+"  group by line_id, "
					+ "substr(start_time,9,2)||':'||lpad(trunc(substr(start_time,11,2)/30,0)*30,2,'0')) a,"
					+ "(select line_id,substr(start_time,9,2)||':'||lpad(trunc(substr(start_time,11,2)/30,0)*30,2,'0')"
					+ " start_time,round((sum(enter_times)+sum(change_times))/100) times,round(sum(exit_times)/100) exitTimes from "+tblFluxnewChain 
					+ " where "
					+ timeFtsql+ chainTicketTypes +tails+" group by line_id,"
					+ " substr(start_time,9,2)||':'||lpad(trunc(substr(start_time,11,2)/30,0)*30,2,'0')) b "
					+ " where a.line_id=b.line_id and a.start_time=b.start_time order by a.line_id, a.start_time";
			lst = this.jsonTagJdbcDao.getJdbcTemplate().query(sql, new Object[] {}, new BeanPropertyRowMapper<LineChainCompare>(LineChainCompare.class));
		}
		
		if(weeFlag){
			Calendar cal = Calendar.getInstance();
			cal = Calendar.getInstance();
			int hour= cal.get(Calendar.HOUR_OF_DAY);
			//大于1时，才会有数据
			if(hour>=1){
				String weeComp = "select case a.line_id when '41' then '浦江线' else a.line_id end as lineId,a.times as enterTimes,"
				+ " a.exitTimes, a.times - b.times as enterDvalue,a.exitTimes - b.exitTimes as exitDvalue, a.start_time as startTime"
				+ " FROM (select line_id,substr(start_time, 9, 2) || ':' || lpad(trunc(substr(start_time, 11, 2) / 30, 0) * 30, 2, '0') start_time,"
				+ " round((sum(enter_times) + sum(change_times)) / 100) times,round(sum(exit_times) / 100) exitTimes from "+tblWeeStart
				+ " where to_char(sysdate - 30 / (24 * 60), 'hh24mi') >= substr(start_time, 9, 4) "+startTicketTypes
				+ " group by line_id,substr(start_time, 9, 2) || ':' || lpad(trunc(substr(start_time, 11, 2) / 30, 0) * 30, 2, '0')) a,"
				+ " (select line_id,substr(start_time, 9, 2) || ':' || lpad(trunc(substr(start_time, 11, 2) / 30, 0) * 30, 2, '0') start_time,"
				+ " round((sum(enter_times) + sum(change_times)) / 100) times, round(sum(exit_times) / 100) exitTimes from "+tblWeeChain
				+ " where to_char(sysdate - 30 / (24 * 60), 'hh24mi')>= substr(start_time, 9, 4) "+chainTicketTypes
				+ " group by line_id,substr(start_time, 9, 2) || ':' || lpad(trunc(substr(start_time, 11, 2) / 30, 0) * 30, 2, '0')) b "
				+ " where a.line_id = b.line_id and a.start_time = b.start_time order by a.line_id, a.start_time";
				List<LineChainCompare> lstWee = this.jsonTagJdbcDao.getJdbcTemplate().query(weeComp, new Object[] {}, new BeanPropertyRowMapper<LineChainCompare>(LineChainCompare.class));
				lst.addAll(lstWee);
			}
		}
		map.put("timeSeg", lstTimeSeg);
		map.put("chainCompare", lst);
		map.put("lineLst", lines);
		return map;
	}
	
	public String getStartTime() {
		return startTime;
	}


	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}


	public String getChainTime() {
		return chainTime;
	}

	public void setChainTime(String chainTime) {
		this.chainTime = chainTime;
	}

	public String getPreview() {
		return preview;
	}

	public void setPreview(String preview) {
		this.preview = preview;
	}
	
}
