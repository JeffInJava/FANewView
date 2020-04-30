package com.gmoa.vos.jinbo;

import java.math.BigDecimal;

import jsontag.annotation.JsonTagAnnotation;
import jsontag.dao.JsonTagTemplateDaoImpl;
import jsontag.interf.IDoService;
/**
 * cocc更新参数表
 * @author Jeff
 *
 */
@JsonTagAnnotation(actionValue="/updateParam.action",namespace="/jinbo",isJsonReturn=true)
public class UpdateParam extends JsonTagTemplateDaoImpl implements IDoService{
	
	private String workDay;
	private String holiDay;
	private String selfVal;
	private String selfTimes;
	
	private String xjdEnTimes;
	private String xjdExTimes;
	private String zglEnTimes;
	private String zglExTimes;
	private String hqEnTimes;
	private String hqExTimes;
	
	private String xjdEnTimesCp;
	private String xjdExTimesCp;
	private String zglEnTimesCp;
	private String zglExTimesCp;
	private String hqEnTimesCp;
	private String hqExTimesCp;
	
	private String flag;
	
	@Override
	public Object doService() throws Exception {
		
		if("sel".equals(flag)){
			return jsonTagJdbcDao.getJdbcTemplate().queryForList("select * from TBL_METRO_VAL");
		}else{
			BigDecimal wd = new BigDecimal(workDay);
			BigDecimal hd = new BigDecimal(holiDay);
			BigDecimal sv = new BigDecimal(selfVal);
			BigDecimal st = new BigDecimal(selfTimes);
			
			BigDecimal xjdEn= new BigDecimal(xjdEnTimes);
			BigDecimal xjdEx = new BigDecimal(xjdExTimes);
			BigDecimal zglEn = new BigDecimal(zglEnTimes);
			BigDecimal zglEx = new BigDecimal(zglExTimes);
			BigDecimal hqEn = new BigDecimal(hqEnTimes);
			BigDecimal hqEx = new BigDecimal(hqExTimes);
			
			BigDecimal xjdEnCp= new BigDecimal(xjdEnTimesCp);
			BigDecimal xjdExCp = new BigDecimal(xjdExTimesCp);
			BigDecimal zglEnCp = new BigDecimal(zglEnTimesCp);
			BigDecimal zglExCp = new BigDecimal(zglExTimesCp);
			BigDecimal hqEnCp = new BigDecimal(hqEnTimesCp);
			BigDecimal hqExCp = new BigDecimal(hqExTimesCp);
			
			this.jsonTagJdbcDao.getJdbcTemplate().execute("delete from TBL_METRO_VAL");
			this.jsonTagJdbcDao.getJdbcTemplate().execute("insert into TBL_METRO_VAL values("+wd+","+hd+","+sv+","+st+
					","+xjdEn+","+xjdEx+","+zglEn+","+zglEx+","+hqEn+","+hqEx+
					","+xjdEnCp+","+xjdExCp+","+zglEnCp+","+zglExCp+","+hqEnCp+","+hqExCp+")");
			return "更新成功";
		}
	}

	
	public String getWorkDay() {
		return workDay;
	}

	public void setWorkDay(String workDay) {
		this.workDay = workDay;
	}

	public String getHoliDay() {
		return holiDay;
	}

	public void setHoliDay(String holiDay) {
		this.holiDay = holiDay;
	}

	public String getSelfVal() {
		return selfVal;
	}

	public void setSelfVal(String selfVal) {
		this.selfVal = selfVal;
	}

	public String getSelfTimes() {
		return selfTimes;
	}

	public void setSelfTimes(String selfTimes) {
		this.selfTimes = selfTimes;
	}


	public String getXjdEnTimes() {
		return xjdEnTimes;
	}


	public void setXjdEnTimes(String xjdEnTimes) {
		this.xjdEnTimes = xjdEnTimes;
	}


	public String getXjdExTimes() {
		return xjdExTimes;
	}


	public void setXjdExTimes(String xjdExTimes) {
		this.xjdExTimes = xjdExTimes;
	}


	public String getZglEnTimes() {
		return zglEnTimes;
	}


	public void setZglEnTimes(String zglEnTimes) {
		this.zglEnTimes = zglEnTimes;
	}


	public String getZglExTimes() {
		return zglExTimes;
	}


	public void setZglExTimes(String zglExTimes) {
		this.zglExTimes = zglExTimes;
	}


	public String getHqEnTimes() {
		return hqEnTimes;
	}


	public void setHqEnTimes(String hqEnTimes) {
		this.hqEnTimes = hqEnTimes;
	}


	public String getHqExTimes() {
		return hqExTimes;
	}


	public void setHqExTimes(String hqExTimes) {
		this.hqExTimes = hqExTimes;
	}


	public String getFlag() {
		return flag;
	}


	public void setFlag(String flag) {
		this.flag = flag;
	}


	public String getXjdEnTimesCp() {
		return xjdEnTimesCp;
	}


	public void setXjdEnTimesCp(String xjdEnTimesCp) {
		this.xjdEnTimesCp = xjdEnTimesCp;
	}


	public String getXjdExTimesCp() {
		return xjdExTimesCp;
	}


	public void setXjdExTimesCp(String xjdExTimesCp) {
		this.xjdExTimesCp = xjdExTimesCp;
	}


	public String getZglEnTimesCp() {
		return zglEnTimesCp;
	}


	public void setZglEnTimesCp(String zglEnTimesCp) {
		this.zglEnTimesCp = zglEnTimesCp;
	}


	public String getZglExTimesCp() {
		return zglExTimesCp;
	}


	public void setZglExTimesCp(String zglExTimesCp) {
		this.zglExTimesCp = zglExTimesCp;
	}


	public String getHqEnTimesCp() {
		return hqEnTimesCp;
	}


	public void setHqEnTimesCp(String hqEnTimesCp) {
		this.hqEnTimesCp = hqEnTimesCp;
	}


	public String getHqExTimesCp() {
		return hqExTimesCp;
	}


	public void setHqExTimesCp(String hqExTimesCp) {
		this.hqExTimesCp = hqExTimesCp;
	}
	
}
