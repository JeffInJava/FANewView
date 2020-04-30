package com.gmoa.vos.statistics;

import java.util.List;
import java.util.Map;

import jsontag.annotation.JsonTagAnnotation;
import jsontag.dao.JsonTagTemplateDaoImpl;
import jsontag.interf.IDoService;

  
@JsonTagAnnotation(actionValue="/get_addlineodflux.action",namespace="/odflux",isJsonReturn=true)
public class GetAddLineOdflux extends JsonTagTemplateDaoImpl implements IDoService {

	private String startDate;
	private String lineId;
	private String classId;

	@Override
	public Object doService() throws Exception {
		String sql="select replace(sectionname,'->','-') sectionname,times,case when times>=3000 then 12 when 3000>times and times>=2500 then 10 " +
				" when 2500>times and times>=2000 then 8 when 2000>times and times>=1500 then 6 when 1500>times and times>=1000 then 4 else 2 end lv from (select sectionname,sum(times) times from TBL_METRO_OVER_od_flux where stmt_day='"+startDate+"' group by sectionname)";
		List<Map<String,Object>> list=jsonTagJdbcDao.getJdbcTemplate().queryForList(sql);
		return list;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getLineId() {
		return lineId;
	}

	public void setLineId(String lineId) {
		this.lineId = lineId;
	}

	public String getClassId() {
		return classId;
	}

	public void setClassId(String classId) {
		this.classId = classId;
	}
	
}
