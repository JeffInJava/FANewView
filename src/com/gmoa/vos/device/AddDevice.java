package com.gmoa.vos.device;

import jsontag.annotation.JsonTagAnnotation;
import jsontag.annotation.validation.MyValidation;
import jsontag.dao.JsonTagTemplateDaoImpl;
import jsontag.interf.IDoService;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/*
 * 设备管理
 * 添加设备
 * 
 */
@JsonTagAnnotation(actionValue="/add_device",namespace="/device",isJsonReturn=true)
public class AddDevice extends JsonTagTemplateDaoImpl implements IDoService {
	private static final Log log = LogFactory.getLog(AddDevice.class);
	@MyValidation(required=true,exceptionDesc="线路不能为空")
    private String line_id;
	@MyValidation(required=true,exceptionDesc="车站不能为空")
    private String station_id;
	@MyValidation(required=true,exceptionDesc="设备不能为空")
    private String device_id;
	@MyValidation(required=true,exceptionDesc="设备节点号不能为空")
    private String device_node;
	@MyValidation(required=true,exceptionDesc="清分节点号不能为空")
    private String QF_node;
	@MyValidation(required=true,exceptionDesc="设备类型不能为空")
    private String device_type;
	@MyValidation(required=true,exceptionDesc="IP不能为空")
    private String IP;
    private String OS;
    private String softwar_ver;
    private String version;
    private String production_name;
    private String reader_writer_firm_enter;
    private String reader_writer_type_enter;
    private String reader_writer_ver_enter;
    private String reader_writer_firm_out;
    private String reader_writer_type_out;
    private String reader_writer_ver_out;
    private String bao_card;
    private String switc_hboard;
    private String type;
    private String remark;
    int i = 0;
   
	public Object doService() throws Exception {
		
		try {
			//添加
			i = jsonTagJdbcDao.getJdbcTemplate().update(" insert into tbl_metro_device (line_id,station_id,device_id,device_node,QF_node,device_type,IP,OS,softwar_ver,version,production_name,reader_writer_firm_enter,reader_writer_type_enter,reader_writer_ver_enter,reader_writer_firm_out,reader_writer_type_out,reader_writer_ver_out,bao_card,switc_hboard,type,remark) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) ",line_id,station_id,device_id,device_node,QF_node,device_type,IP,OS,softwar_ver,version,production_name,reader_writer_firm_enter,reader_writer_type_enter,reader_writer_ver_enter,reader_writer_firm_out,reader_writer_type_out,reader_writer_ver_out,bao_card,switc_hboard,type,remark);
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
	public String getDevice_id() {
		return device_id;
	}
	public void setDevice_id(String device_id) {
		this.device_id = device_id;
	}
	public String getDevice_node() {
		return device_node;
	}
	public void setDevice_node(String device_node) {
		this.device_node = device_node;
	}
	public String getQF_node() {
		return QF_node;
	}
	public void setQF_node(String qF_node) {
		QF_node = qF_node;
	}
	public String getDevice_type() {
		return device_type;
	}
	public void setDevice_type(String device_type) {
		this.device_type = device_type;
	}
	public String getIP() {
		return IP;
	}
	public void setIP(String iP) {
		IP = iP;
	}
	public String getOS() {
		return OS;
	}
	public void setOS(String oS) {
		OS = oS;
	}
	public String getSoftwar_ver() {
		return softwar_ver;
	}
	public void setSoftwar_ver(String softwar_ver) {
		this.softwar_ver = softwar_ver;
	}
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public String getProduction_name() {
		return production_name;
	}
	public void setProduction_name(String production_name) {
		this.production_name = production_name;
	}
	public String getReader_writer_firm_enter() {
		return reader_writer_firm_enter;
	}
	public void setReader_writer_firm_enter(String reader_writer_firm_enter) {
		this.reader_writer_firm_enter = reader_writer_firm_enter;
	}
	public String getReader_writer_type_enter() {
		return reader_writer_type_enter;
	}
	public void setReader_writer_type_enter(String reader_writer_type_enter) {
		this.reader_writer_type_enter = reader_writer_type_enter;
	}
	public String getReader_writer_ver_enter() {
		return reader_writer_ver_enter;
	}
	public void setReader_writer_ver_enter(String reader_writer_ver_enter) {
		this.reader_writer_ver_enter = reader_writer_ver_enter;
	}
	public String getReader_writer_firm_out() {
		return reader_writer_firm_out;
	}
	public void setReader_writer_firm_out(String reader_writer_firm_out) {
		this.reader_writer_firm_out = reader_writer_firm_out;
	}
	public String getReader_writer_type_out() {
		return reader_writer_type_out;
	}
	public void setReader_writer_type_out(String reader_writer_type_out) {
		this.reader_writer_type_out = reader_writer_type_out;
	}
	public String getReader_writer_ver_out() {
		return reader_writer_ver_out;
	}
	public void setReader_writer_ver_out(String reader_writer_ver_out) {
		this.reader_writer_ver_out = reader_writer_ver_out;
	}
	public String getBao_card() {
		return bao_card;
	}
	public void setBao_card(String bao_card) {
		this.bao_card = bao_card;
	}
	public String getSwitc_hboard() {
		return switc_hboard;
	}
	public void setSwitc_hboard(String switc_hboard) {
		this.switc_hboard = switc_hboard;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
  
}
