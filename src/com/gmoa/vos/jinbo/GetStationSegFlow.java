package com.gmoa.vos.jinbo;

import java.util.Calendar;
import java.util.List;

import jsontag.annotation.JsonTagAnnotation;
import jsontag.dao.JsonTagTemplateDaoImpl;
import jsontag.interf.IDoService;

import org.springframework.jdbc.core.BeanPropertyRowMapper;

import com.gmoa.bean.StationSegFlow;
import com.gmoa.util.CommonUtil;
/**
 * cocc车站分时客流
 * @author Jeff
 *
 */
@JsonTagAnnotation(actionValue="/station_seg_flow.action",namespace="/jinbo",isJsonReturn=true)
public class GetStationSegFlow extends JsonTagTemplateDaoImpl implements IDoService{
	
	private String stationName;
	private String startTime;
	
	
	@Override
	public Object doService() throws Exception {
		String sId = "";
		if("诸光路".equals(stationName)){
			sId = "1722";
		}else if("徐泾东".equals(stationName)){
			sId = "0234";
		}else if("虹桥火车站".equals(stationName)){
			sId = "0235";
		}
		
		String reviseTime = CommonUtil.getRightDay(startTime);
		String timeRange = "";
		boolean weeFlag = false;
		//日期未过24点
		if(reviseTime.equals(startTime)){
			timeRange = " to_char(sysdate - 30 / (24 * 60), 'hh24mi') >= substr(start_time, 9, 4) ";
		}else{
			//日期在0-3点之间，startTime修正后是昨天的日期
			timeRange = "  '2400' >= substr(start_time, 9, 4) ";
			weeFlag = true;
		}
		reviseTime = startTime;
		
		String sfStr =
				 "select pkf.time_seg as timeSeg,"+
						 "       (nvl(stf.enter_times / 100, 0) + nvl(stf.exit_times / 100, 0)) as totalTimes,"+
						 "       nvl(stf.enter_times / 100, 0) as enterTimes, nvl(stf.exit_times / 100, 0) as exitTimes,"+
						 "       (nvl(pkf.enter_times, 0) + nvl(pkf.exit_times, 0)) as totalPkTimes,"+
						 "       nvl(pkf.enter_times, 0) as pkEnterTimes, nvl(pkf.exit_times, 0) as pkExitTimes "+
						 "  from (select substr(start_time, 9, 2) || ':' ||"+
						 "               lpad(trunc(substr(start_time, 11, 2) / 30, 0) * 30, 2, '0') as time_seg,"+
						 "               sum(enter_times) as enter_times,"+
						 "               sum(exit_times) as exit_times"+
						 "          from (select station_id, start_time, enter_times, exit_times"+
						 "                  from tbl_metro_fluxnew_"+reviseTime+
						 "                 where station_id = '"+sId+"'"+
						 "                   and "+timeRange+
						 "                   and ticket_type not in"+
						 "                       ('40', '41', '130', '131', '140', '141')"+
						 "                   and substr(start_time, 9, 4) >= '0500') ot1"+
						 "         group by substr(start_time, 9, 2) || ':' ||"+
						 "                  lpad(trunc(substr(start_time, 11, 2) / 30, 0) * 30,"+
						 "                       2,"+
						 "                       '0')"+
						 "         order by time_seg) stf"+
						 "  right join (select substr(time_hour, 0, 2) || ':' ||"+
						 "                    substr(time_hour, 3, 4) as time_seg,"+
						 "                    enter_times,"+
						 "                    exit_times"+
						 "               from TBL_METRO_JBH_MAXFLUX"+
						 "              where station_id = '"+sId+"'"+
						 "                and time_hour between '0500' and to_char(sysdate, 'hh24mi')"+
						 "              order by time_seg) pkf"+
						 "    on stf.time_seg = pkf.time_seg";
		
		List<StationSegFlow> lstSeg = this.jsonTagJdbcDao.getJdbcTemplate().query(sfStr, new Object[] {}, new BeanPropertyRowMapper<StationSegFlow>(StationSegFlow.class));
		
		if(weeFlag){
			Calendar cal = Calendar.getInstance();
			cal = Calendar.getInstance();
			int hour= cal.get(Calendar.HOUR_OF_DAY);
			//大于1时，才会有数据
			if(hour>=1){
				String weeStr =
						 "select pkf.time_seg as timeSeg,"+
								 "       (nvl(stf.enter_times / 100, 0) + nvl(stf.exit_times / 100, 0)) as totalTimes,"+
								 "       nvl(stf.enter_times / 100, 0) as enterTimes, nvl(stf.exit_times / 100, 0) as exitTimes,"+
								 "       (nvl(pkf.enter_times, 0) + nvl(pkf.exit_times, 0)) as totalPkTimes,"+
								 "       nvl(pkf.enter_times, 0) as pkEnterTimes, nvl(pkf.exit_times, 0) as pkExitTimes "+
								 "  from (select substr(start_time, 9, 2) || ':' ||"+
								 "               lpad(trunc(substr(start_time, 11, 2) / 30, 0) * 30, 2, '0') as time_seg,"+
								 "               sum(enter_times) as enter_times,"+
								 "               sum(exit_times) as exit_times"+
								 "          from (select station_id, start_time, enter_times, exit_times"+
								 "                  from tbl_metro_fluxnew_"+reviseTime+
								 "                 where station_id = '"+sId+"'"+
								 "                   and to_char(sysdate - 30 / (24 * 60), 'hh24mi') >= substr(start_time, 9, 4) "+
								 "                   and ticket_type not in"+
								 "                       ('40', '41', '130', '131', '140', '141')) ot1"+
								 "         group by substr(start_time, 9, 2) || ':' ||"+
								 "                  lpad(trunc(substr(start_time, 11, 2) / 30, 0) * 30,"+
								 "                       2,"+
								 "                       '0')"+
								 "         order by time_seg) stf"+
								 "  right join (select substr(time_hour, 0, 2) || ':' ||"+
								 "                    substr(time_hour, 3, 4) as time_seg,"+
								 "                    enter_times,"+
								 "                    exit_times"+
								 "               from TBL_METRO_JBH_MAXFLUX"+
								 "              where station_id = '"+sId+"'"+
								 "                and time_hour < '0300'"+
								 "              order by time_seg) pkf"+
								 "    on stf.time_seg = pkf.time_seg";
				List<StationSegFlow> weeSeg = this.jsonTagJdbcDao.getJdbcTemplate().query(weeStr, new Object[] {}, new BeanPropertyRowMapper<StationSegFlow>(StationSegFlow.class));
				lstSeg.addAll(weeSeg);
			}
		}
		return lstSeg;
	}

	public String getStationName() {
		return stationName;
	}

	public void setStationName(String stationName) {
		this.stationName = stationName;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

}
