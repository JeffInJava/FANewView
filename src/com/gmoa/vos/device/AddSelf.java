package com.gmoa.vos.device;

import jsontag.annotation.JsonTagAnnotation;
import jsontag.annotation.validation.MyValidation;
import jsontag.dao.JsonTagTemplateDaoImpl;
import jsontag.interf.IDoService;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/*
 * 设备管理
 * 自营网点的添加
 */
@JsonTagAnnotation(actionValue="/add_self",namespace="/device",isJsonReturn = true)
public class AddSelf extends JsonTagTemplateDaoImpl implements IDoService {
    private static final Log log = LogFactory.getLog(AddSelf.class);
    @MyValidation(required=true,exceptionDesc="线路不能为空")
	private String line_id;
    @MyValidation(required=true,exceptionDesc="车站不能为空")
	private String station_id;
    @MyValidation(required=true,exceptionDesc="设备类型不能为空")
	private String device_type;
    @MyValidation(required=true,exceptionDesc="IP不能为空")
	private String ip;
	int i =0;
	public Object doService() throws Exception {
		try {
			i = jsonTagJdbcDao.getJdbcTemplate().update(" insert into tbl_metro_device(line_id,station_id,device_type,IP) values (?,?,?,?) ",line_id,station_id,device_type,ip);
			if (i>0) {
				return "success";
			}else {
				return "false";
			}
			
		} catch (Exception e) {
			log.error("添加异常,异常信息为："+e.getMessage());
			return "error";
		}
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
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	

}
