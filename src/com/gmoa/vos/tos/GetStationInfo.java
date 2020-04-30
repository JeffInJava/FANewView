package com.gmoa.vos.tos;


import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import com.gmoa.bean.CacheDataBean;

import jsontag.JsonTagContext;
import jsontag.annotation.JsonTagAnnotation;
import jsontag.dao.JsonTagTemplateDaoImpl;
import jsontag.interf.IDoService;

   
@JsonTagAnnotation(actionValue="/get_stations.action",namespace="/tos",isJsonReturn=true)
public class GetStationInfo extends JsonTagTemplateDaoImpl implements IDoService {
	private String flag;
	private String lineId;
	private String startStation;
	private String endStation;
	private String startStationNm;
	private String endStationNm;
	private String ctype;
	
	@Override
	public Object doService() throws Exception {
		
		if("station".equals(flag)){
			return findStation();
		}else if("addOd".equals(flag)){
			JSONObject od=new JSONObject();
			od.put("lineId", lineId);
			od.put("startStation", startStation);
			od.put("endStation", endStation);
			od.put("startStationNm", startStationNm);
			od.put("endStationNm", endStationNm);
			od.put("ctype", ctype);
			CacheDataBean.LINE_OD.put(startStation+endStation,od);
			return "success";
		}else if("selOd".equals(flag)){
			return CacheDataBean.LINE_OD;
		}else if("delOd".equals(flag)){
			String[] odIds=JsonTagContext.getRequest().getParameterValues("odIds[]");
			for(String id:odIds){
				CacheDataBean.LINE_OD.remove(id);
			}
			return "success";
		}else if("clearOd".equals(flag)){
			CacheDataBean.LINE_OD.clear();
			return "success";
		}
		return null;
	}
	
	//查询车站
	public List findStation(){
		StringBuffer sql=new StringBuffer();
		sql.append("select line_id,trim(station_nm_cn) station_nm,station_id from viw_metro_station_name ");
		sql.append("where to_char(sysdate,'yyyymmdd') between start_time and end_time order by station_id ");
		List<Map<String,Object>> list=jsonTagJdbcDao.getJdbcTemplate().queryForList(sql.toString());
		return list;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public String getLineId() {
		return lineId;
	}

	public void setLineId(String lineId) {
		this.lineId = lineId;
	}

	public String getStartStation() {
		return startStation;
	}

	public void setStartStation(String startStation) {
		this.startStation = startStation;
	}

	public String getEndStation() {
		return endStation;
	}

	public void setEndStation(String endStation) {
		this.endStation = endStation;
	}

	public String getCtype() {
		return ctype;
	}

	public void setCtype(String ctype) {
		this.ctype = ctype;
	}

	public String getStartStationNm() {
		return startStationNm;
	}

	public void setStartStationNm(String startStationNm) {
		this.startStationNm = startStationNm;
	}

	public String getEndStationNm() {
		return endStationNm;
	}

	public void setEndStationNm(String endStationNm) {
		this.endStationNm = endStationNm;
	}
	
	

}
