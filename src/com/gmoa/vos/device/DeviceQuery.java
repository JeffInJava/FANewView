package com.gmoa.vos.device;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jsontag.annotation.JsonTagAnnotation;
import jsontag.dao.JsonTagTemplateDaoImpl;
import jsontag.interf.IDoService;

import org.apache.commons.lang.StringUtils;
/*
 * 设备管理
 * 根据参数分页查询相关数据
 * 
 */
@JsonTagAnnotation(actionValue="/device_query",namespace="/device",isJsonReturn=true)
public class DeviceQuery extends JsonTagTemplateDaoImpl implements IDoService {

	private String line_id;   //线路
	private String station_id; //车站
	private String device_type; //设备类型
	
	private String currentPage;//当前页数
	private String pageSize;   //每页记录条数 
	
	private String device_node;   //设备节点号
	private String qf_node;   //清分节点号
	private String ip;   //IP地址
	public Object doService() throws Exception {
		HashMap<Object, Object> map = new HashMap();
		int cp=Integer.parseInt(getCurrentPage());
		int ps=Integer.parseInt(getPageSize());
		StringBuffer sql = new StringBuffer();
		sql.append("select to_number(t1.line_id)||'号线' line_name,t1.*,t2.device_name from tbl_metro_device t1,device_name t2 ");
		sql.append("where t1.device_type=t2.device_type(+) ");
		
		if(!"全部".equals(line_id)){
			sql.append(" and t1.line_id='").append(line_id).append("'");
		}
		if(!"全部".equals(station_id)){
			sql.append(" and t1.station_id='").append(station_id).append("'");
		}
		if(!"全部".equals(device_type)){
			sql.append(" and t1.device_type='").append(device_type).append("'");
		}
		if(StringUtils.isNotBlank(device_node)){
			sql.append(" and device_node like '%").append(device_node).append("%'");
		}
		if(StringUtils.isNotBlank(qf_node)){
			sql.append(" and qf_node like '%").append(qf_node).append("%'");
		}
		if(StringUtils.isNotBlank(ip)){
			sql.append(" and ip like '%").append(ip).append("%'");
		}
		
		String  tp_sql = "select * from ( select s1.*,rownum rn from ("+sql.toString()+") s1  where rownum <? )where rn>? ";
		
		List<Map<String, Object>> count = jsonTagJdbcDao.getJdbcTemplate().queryForList("select count(*) nm from( "+sql.toString()+" )");
		List<Map<String, Object>> list = jsonTagJdbcDao.getJdbcTemplate().queryForList(tp_sql,cp*ps,(cp-1)*ps);
		if(count!=null&&count.size()>0){
			map.put("count", count.get(0).get("nm"));
		}
		map.put("list", list);
		return map;
	}
	public String getLine_id() {
		return line_id;
	}
	public void setLine_id(String line_id) {
		this.line_id = line_id;
	}
	public String getStation_id() {
		return station_id;
	}
	public void setStation_id(String station_id) {
		this.station_id = station_id;
	}
	public String getDevice_type() {
		return device_type;
	}
	public void setDevice_type(String device_type) {
		this.device_type = device_type;
	}
	public String getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(String currentPage) {
		this.currentPage = currentPage;
	}
	public String getPageSize() {
		return pageSize;
	}
	public void setPageSize(String pageSize) {
		this.pageSize = pageSize;
	}
	public String getDevice_node() {
		return device_node;
	}
	public void setDevice_node(String device_node) {
		this.device_node = device_node;
	}
	public String getQf_node() {
		return qf_node;
	}
	public void setQf_node(String qf_node) {
		this.qf_node = qf_node;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	
}
