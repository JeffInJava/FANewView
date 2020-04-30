package com.gmoa.vos.pflw;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import jsontag.JsonTagContext;
import jsontag.annotation.JsonTagAnnotation;
import jsontag.dao.JsonTagTemplateDaoImpl;
import jsontag.interf.IDoService;
/**
 * 获取车站客流增量
 * @author Administrator
 *
 */
@JsonTagAnnotation(actionValue="/GetZlaChzpfw.action",namespace="/zlchzpfw",isJsonReturn=true)
public class GetZlaChzpfw extends JsonTagTemplateDaoImpl implements IDoService{
private String id;
	
	private String date;
	
	private String controlDate;

	private String type;

	private String size;
	
	private String fluxType;
	
	private String sortType;
	
	@Override
	public Object doService() throws Exception {
		String sql;
		List<Map<String,Object>> list;
		String condition = "";
		String orderBy = "";
		
		//判断比较类型
		if ("1".equals(fluxType)){//1为进站
			condition = "enter_times";
		}else if ("2".equals(fluxType)){//2为出站
			condition = "exit_times";
		}else if ("3".equals(fluxType)){//3为换乘
			condition = "change_times";
		}else if ("4".equals(fluxType)){//4为进站+换乘
			condition = "enter_times + chg_times";
		}
		
		//排序方式
		if ("1".equals(sortType)){//按数值降序排列
			orderBy = "increase";
		}else if ("-1".equals(sortType)){//按数值绝对值降序排列
			orderBy = "increase_abs";
		}
		
		
			sql = "with tb as"
				+ "	 (select nvl(sum(a.total_times),0) total_times,"
				+ "	         case"
				+ "	           when (nvl(sum(a.total_times),0) - nvl(sum(b.total_times),0)) > 0 then"
				+ "	            1"
				+ "	           else"
				+ "	            -1"
				+ "	         end symbol,"
				+ "	         nvl(sum(a.total_times),0) - nvl(sum(b.total_times),0)"
				//+ "	               nvl(sum(b.total_times),0)) * 100,"
				+ "	               increase,"
				+ "	         abs(nvl(sum(a.total_times),0) - nvl(sum(b.total_times),0))"
				//+ "	               nvl(sum(b.total_times),0)) * 100,"
				+ "	               increase_abs,"
				+ "	         c.station_nm_cn"
				+ "	    from (select trim(station_id) station_id,total_times from  (select station_id, sum(nvl("+condition+", 0))/100 total_times	 from "
				+ "TBL_METRO_FLUXNEW_"+date+" where start_time<="+date+"||to_char(sysdate-30/(24*60),'hh24miss') and ticket_type not in (40, 41, 130, 131, 140, 141) GROUP BY station_id)) a,"
				+ "	         (select trim(station_id) station_id,total_times from  (select station_id, sum(nvl("+condition+", 0))/100 total_times	 from "
				+ "TBL_METRO_FLUXNEW_"+controlDate+" where start_time<="+controlDate+"||to_char(sysdate-30/(24*60),'hh24miss') and ticket_type not in (40, 41, 130, 131, 140, 141) GROUP BY station_id)) b,"
				+ "	         (select trim(station_id) station_id,"
				+ "	                 case"
				+ "	                   when station_id in ('0418', '0631') then"
				+ "	                    trim(station_nm_cn) || substr(station_id, 1, 2)"
				+ "	                   else"
				+ "	                    trim(station_nm_cn)"
				+ "	                 end station_nm_cn"
				+ "	            from viw_metro_station_name"
				+ "	           where ? between start_time and end_time) c"
				+ "	   where a.station_id(+) = c.station_id"
				+ "	     and b.station_id(+) = c.station_id"
				+ "	   group by c.station_nm_cn"
				+ "	  having sum(b.total_times) > 0)"
				+ "	select aa.*, rownum nm"
				+ "	  from (select * from tb order by tb." + orderBy + " desc) aa"
				+ "	 where rownum <= ?" ;
			System.out.println(sql);
			System.out.println("00000000000000000000000000000000000");
			list = jsonTagJdbcDao.getJdbcTemplate().queryForList(sql,date,this.getSize());
			
		
		return list;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getControlDate() {
		return controlDate;
	}

	public void setControlDate(String controlDate) {
		this.controlDate = controlDate;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getSize() {
		int _size = 0;
		try{
			_size = Integer.parseInt(size);
			if (_size<0)
				_size = 10;
		}catch(Exception e){
			_size = 10;
		}
		return String.valueOf(_size);
	}

	public void setSize(String size) {
		this.size = size;
	}

	public String getFluxType() {
		return fluxType;
	}

	public void setFluxType(String fluxType) {
		this.fluxType = fluxType;
	}

	public String getSortType() {
		return sortType;
	}

	public void setSortType(String sortType) {
		this.sortType = sortType;
	}
	
}
