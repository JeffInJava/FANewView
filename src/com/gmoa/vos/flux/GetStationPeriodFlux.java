package com.gmoa.vos.flux;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.util.StringUtil;

import jsontag.annotation.JsonTagAnnotation;
import jsontag.dao.JsonTagTemplateDaoImpl;
import jsontag.interf.IDoService;

/**
 * 车站客流分时比较 日期格式：yyyymmdd
 *
 */
@JsonTagAnnotation(actionValue = "/get_station_periodflux.action", namespace = "/station", isJsonReturn = true)
public class GetStationPeriodFlux extends JsonTagTemplateDaoImpl implements IDoService {
	private String startDate;
	private String comDate;
	private String lineId;
	private String stationId;
	private String ckflag;

	@Override
	public Object doService() throws Exception {

		List<Map<String, Object>> list = null;
		String sql_tp1 = "";
		String sql_tp2 = "";
		String sumCnd = "0";
		boolean cfg = false;
		if (StringUtils.trimToNull(ckflag) != null) {
			if (ckflag.contains("1")) {
				sumCnd += " +enter_times ";
			}
			if (ckflag.contains("2")) {
				sumCnd += " +exit_times ";
			}
			if (ckflag.contains("3")) {
				sumCnd += " +change_times ";
				cfg = true;
			}
		}

		SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
		Date f_date = df.parse(startDate);
		Date s_date = df.parse(comDate);
		GregorianCalendar calendar = new GregorianCalendar();
		calendar.add(GregorianCalendar.DAY_OF_MONTH, -60);
		Date tempDate = calendar.getTime();

		// 查询日期和服务器的当前日期比较，如果查询日期是60天以前，则查询tbl_metro_fluxnew_history表
		if (f_date.compareTo(tempDate) > 0) {
			sql_tp1 = " tbl_metro_fluxnew_" + startDate
					+ " where ticket_type not in ('40','41','130','131','140','141') ";
		} else {
			sql_tp1 = " tbl_metro_fluxnew_history partition(V" + startDate + "_FLUXNEW_HISTORY) where 1=1 ";
		}
		if (s_date.compareTo(tempDate) > 0) {
			sql_tp2 = " tbl_metro_fluxnew_" + comDate
					+ " where ticket_type not in ('40','41','130','131','140','141') ";
		} else {
			sql_tp2 = " tbl_metro_fluxnew_history partition(V" + comDate + "_FLUXNEW_HISTORY) where 1=1 ";
		}

		if (StringUtils.trimToNull(lineId) != null && StringUtils.trimToNull(stationId) == null) {
			sql_tp1 += " and trim(line_id)='" + lineId.trim() + "'";
			sql_tp2 += " and trim(line_id)='" + lineId.trim() + "'";
		}

		if (StringUtils.isNotBlank(stationId)) {
			if (cfg && "0418".equals(StringUtils.trimToNull(stationId)) && "0631".equals(StringUtils.trimToNull(stationId))) {// 浦电路不是换乘站

				String staIds = " select trim(station_id) station_id from tbl_metro_station_info "
						+ " where station_ver = (select max(station_ver) from tbl_metro_station_info) "
						+ " and trim(station_nm_cn) in (select trim(station_nm_cn) "
						+ "  from tbl_metro_station_info where station_ver = "
						+ "           (select max(station_ver) from tbl_metro_station_info) "
						+ "       and trim(station_id) = '" + stationId.trim() + "')";
				List<Map<String, Object>> lstStations = jsonTagJdbcDao.getJdbcTemplate().queryForList(staIds);
				StringBuffer sqlIn = new StringBuffer();
				for(Map<String,Object> m:lstStations){
					sqlIn.append("'").append(m.get("station_id").toString()).append("'").append(",");
				}
				String stas = sqlIn.toString().substring(0, sqlIn.length() - 1);
				sql_tp1 += " and trim(station_id) in ("+stas+")";
				sql_tp2 += " and trim(station_id) in ("+stas+")";
			} else {
				sql_tp1 += " and trim(station_id)='" + stationId.trim() + "'";
				sql_tp2 += " and trim(station_id)='" + stationId.trim() + "'";
			}

		}

		StringBuffer sql = new StringBuffer();
		sql.append("select cc.period,nvl(aa.times,0) times,nvl(bb.times,0) cp_times from ");
		sql.append("( ");
		sql.append(
				"  select substr(start_time,9,2)||':'||lpad(trunc(to_number(substr(start_time,11,2))/5,0)*5,2,'0') period,"
						+ "round(sum(" + sumCnd + ")/100) times from ")
				.append(sql_tp1);
		sql.append(
				"  group by substr(start_time,9,2)||':'||lpad(trunc(to_number(substr(start_time,11,2))/5,0)*5,2,'0') ");
		sql.append(") aa, ");
		sql.append("( ");
		sql.append(
				"  select substr(start_time,9,2)||':'||lpad(trunc(to_number(substr(start_time,11,2))/5,0)*5,2,'0') period,"
						+ "round(sum(" + sumCnd + ")/100) times from ")
				.append(sql_tp2);
		sql.append(
				"  group by substr(start_time,9,2)||':'||lpad(trunc(to_number(substr(start_time,11,2))/5,0)*5,2,'0') ");
		sql.append(") bb, ");
		sql.append(
				"(select to_char(to_date('20160201 0000','yyyyMMdd hh24:mi')-(level-1)/288,'hh24:mi') period from dual connect by level<=288) cc ");
		sql.append("where cc.period=aa.period(+) and cc.period=bb.period(+) and cc.period>='0500' order by cc.period ");
		list = jsonTagJdbcDao.getJdbcTemplate().queryForList(sql.toString());
		return list;
	}

	public static void main(String[] args) {
		String a = "a,b,c";
		String b = " abc ";
		System.out.println(b.trim());
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getComDate() {
		return comDate;
	}

	public void setComDate(String comDate) {
		this.comDate = comDate;
	}

	public String getStationId() {
		return stationId;
	}

	public void setStationId(String stationId) {
		this.stationId = stationId;
	}

	public String getLineId() {
		return lineId;
	}

	public void setLineId(String lineId) {
		this.lineId = lineId;
	}

	public String getCkflag() {
		return ckflag;
	}

	public void setCkflag(String ckflag) {
		this.ckflag = ckflag;
	}

}
