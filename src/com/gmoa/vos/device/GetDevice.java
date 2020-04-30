package com.gmoa.vos.device;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jsontag.annotation.JsonTagAnnotation;
import jsontag.dao.JsonTagTemplateDaoImpl;
import jsontag.interf.IDoService;
/*
 * 页面初始化
 * 获取设备管理页面相关的参数
 * 
 */
@JsonTagAnnotation(actionValue="/data_Load",namespace="/device",isJsonReturn=true)
public class GetDevice extends JsonTagTemplateDaoImpl implements IDoService {
	
	public Object doService() throws Exception {
		 HashMap<Object, Object> map = new HashMap();
		//线路id
		List<Map<String, Object>> line_list = jsonTagJdbcDao.getJdbcTemplate().queryForList("select line_id,line_nm_cn line_name from viw_metro_line_name where to_char(sysdate,'yyyyMMdd') between start_time and end_time order by line_id");
		//车站id,车站名称集合
		List<Map<String, Object>> station_list = jsonTagJdbcDao.getJdbcTemplate().queryForList("select line_id,station_id,station_id||'-'||station_nm_cn station_nm_cn from viw_metro_station_name where to_char(sysdate,'yyyyMMdd') between start_time and end_time order by station_id");
		//设备id,设备类型
		List<Map<String, Object>> device_list = jsonTagJdbcDao.getJdbcTemplate().queryForList("select trim(device_type) device_type,device_name from device_name");
		//设备id,设备类型,排除自营网点
		//List<Map<String, Object>> device_list_add = jsonTagJdbcDao.getJdbcTemplate().queryForList("select trim(device_type)device_type,device_name from device_name where  device_type !=09 ");
		//全网通数据
		//List<Map<String, Object>>  list = jsonTagJdbcDao.getJdbcTemplate().queryForList(" select t1.line_id||'号线' line_name, t1.* ,t2.station_nm_cn,t3.device_name from tbl_metro_device t1,tbl_pw_station_info t2,device_name t3  where  t1.station_id=t2.station_id(+) and t1.device_type=t3.device_type(+) ");
		map.put("line_list", line_list);
		map.put("station_list", station_list);
		map.put("device_list", device_list);
		//map.put("device_list_add", device_list_add);
		//map.put("list", list);
		return map;
	}

}
