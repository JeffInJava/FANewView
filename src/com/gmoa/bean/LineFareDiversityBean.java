package com.gmoa.bean;

import java.math.BigDecimal;
import java.math.BigInteger;

public class LineFareDiversityBean {
	private String OPER_NAME;
	private String LINE_ID;
	private String STATION_NM_CN;
	private String EQUIP_TYPE;
	private String ERR_TYPE;
	private BigDecimal DIFF_AMOUNT;
	private BigInteger DIFF_COUNT;
	
	public String getOPER_NAME() {
		return OPER_NAME;
	}
	public void setOPER_NAME(String oPER_NAME) {
		OPER_NAME = oPER_NAME;
	}
	public String getLINE_ID() {
		return LINE_ID;
	}
	public void setLINE_ID(String lINE_ID) {
		LINE_ID = lINE_ID;
	}
	
	public String getSTATION_NM_CN() {
		return STATION_NM_CN;
	}
	public void setSTATION_NM_CN(String sTATION_NM_CN) {
		STATION_NM_CN = sTATION_NM_CN;
	}
	public String getEQUIP_TYPE() {
		return EQUIP_TYPE;
	}
	public void setEQUIP_TYPE(String eQUIP_TYPE) {
		EQUIP_TYPE = eQUIP_TYPE;
	}
	public String getERR_TYPE() {
		return ERR_TYPE;
	}
	public void setERR_TYPE(String eRR_TYPE) {
		ERR_TYPE = eRR_TYPE;
	}
	public BigDecimal getDIFF_AMOUNT() {
		return DIFF_AMOUNT;
	}
	public void setDIFF_AMOUNT(BigDecimal dIFF_AMOUNT) {
		DIFF_AMOUNT = dIFF_AMOUNT;
	}
	public BigInteger getDIFF_COUNT() {
		return DIFF_COUNT;
	}
	public void setDIFF_COUNT(BigInteger dIFF_COUNT) {
		DIFF_COUNT = dIFF_COUNT;
	}
	
}
