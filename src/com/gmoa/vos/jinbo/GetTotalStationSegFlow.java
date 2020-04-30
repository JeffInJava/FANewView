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
 * cocc进博会三个车站分时客流总和
 * @author Jeff
 *
 */
@JsonTagAnnotation(actionValue="/total_station_seg_flow.action",namespace="/jinbo",isJsonReturn=true)
public class GetTotalStationSegFlow extends JsonTagTemplateDaoImpl implements IDoService{
	
	private String startTime;
	
	@Override
	public Object doService() throws Exception {
		
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
				 " select b.timeSeg, nvl(a.totalTimes,0) as totalTimes,a.enterTimes,a.exitTimes, b.totalPkTimes,b.pkEnterTimes,b.pkExitTimes "+
						 "  from (select substr(start_time, 9, 2) || ':' ||"+
						 "               lpad(trunc(substr(start_time, 11, 2) / 30, 0) * 30, 2, '0') as timeSeg,"+
						 "               sum(enter_times / 100 + exit_times / 100) as totalTimes,"+
						 "				sum(enter_times / 100) as enterTimes,sum(exit_times/100)as exitTimes	"+
						 "          from tbl_metro_fluxnew_"+reviseTime+
						 "         where station_id in ('0234', '0235', '1722')"+
						 "           and "+timeRange+
						 "           and ticket_type not in ('40', '41', '130', '131', '140', '141')"+
						 "           and substr(start_time, 9, 4) >= '0500'"+
						 "         group by substr(start_time, 9, 2) || ':' ||"+
						 "                  lpad(trunc(substr(start_time, 11, 2) / 30, 0) * 30,"+
						 "                       2,"+
						 "                       '0')"+
						 "         order by timeSeg) a"+
						 "  right join (select substr(time_hour, 0, 2) || ':' ||"+
						 "                    substr(time_hour, 3, 4) as timeSeg,"+
						 "                    sum(enter_times + exit_times) as totalPkTimes,"+
						 "                    sum(enter_times) as pkEnterTimes,sum(exit_times) as pkExitTimes "+
						 "               from TBL_METRO_JBH_MAXFLUX"+
						 "              where station_id = '0000'"+
						 "                and time_hour between '0500' and to_char(sysdate, 'hh24mi')"+
						 "              group by substr(time_hour, 0, 2) || ':' ||"+
						 "                       substr(time_hour, 3, 4)"+
						 "              order by timeSeg) b"+
						 "    on a.timeSeg = b.timeSeg";
		List<StationSegFlow> lstSeg = this.jsonTagJdbcDao.getJdbcTemplate().query(sfStr, new Object[] {}, new BeanPropertyRowMapper<StationSegFlow>(StationSegFlow.class));
		if(weeFlag){
			Calendar cal = Calendar.getInstance();
			cal = Calendar.getInstance();
			int hour= cal.get(Calendar.HOUR_OF_DAY);
			//大于1时，才会有数据
			if(hour>=1){
				String weeSql =  " select b.timeSeg, nvl(a.totalTimes,0) as totalTImes,a.enterTimes,a.exitTimes, b.totalPkTimes,b.pkEnterTimes,b.pkExitTimes"+
						 "  from (select substr(start_time, 9, 2) || ':' ||"+
						 "               lpad(trunc(substr(start_time, 11, 2) / 30, 0) * 30, 2, '0') as timeSeg,"+
						 "               sum(enter_times / 100 + exit_times / 100) as totalTimes,"+
						 "				sum(enter_times / 100) as enterTimes,sum(exit_times/100)as exitTimes	"+
						 "          from tbl_metro_fluxnew_"+reviseTime+
						 "         where station_id in ('0234', '0235', '1722')"+
						 "           and to_char(sysdate - 30 / (24 * 60), 'hh24mi') >= substr(start_time, 9, 4) "+
						 "           and ticket_type not in ('40', '41', '130', '131', '140', '141')"+
						 "         group by substr(start_time, 9, 2) || ':' ||"+
						 "                  lpad(trunc(substr(start_time, 11, 2) / 30, 0) * 30,"+
						 "                       2,"+
						 "                       '0')"+
						 "         order by timeSeg) a"+
						 "  right join (select substr(time_hour, 0, 2) || ':' ||"+
						 "                    substr(time_hour, 3, 4) as timeSeg,"+
						 "                    sum(enter_times + exit_times) as totalPkTimes,"+
						 "                    sum(enter_times) as pkEnterTimes,sum(exit_times) as pkExitTimes "+
						 "               from TBL_METRO_JBH_MAXFLUX"+
						 "              where station_id = '0000'"+
						 "                and time_hour < '0300'"+
						 "              group by substr(time_hour, 0, 2) || ':' ||"+
						 "                       substr(time_hour, 3, 4)"+
						 "              order by timeSeg) b"+
						 "    on a.timeSeg = b.timeSeg";
				
				List<StationSegFlow> weeSeg = this.jsonTagJdbcDao.getJdbcTemplate().query(weeSql, new Object[] {}, new BeanPropertyRowMapper<StationSegFlow>(StationSegFlow.class));
				lstSeg.addAll(weeSeg);
			}
		}
		return lstSeg;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

}
