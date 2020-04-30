package com.gmoa.bean;

import java.math.BigDecimal;

public class SpaceTimeOdBean {
	
	private String STMT_YEAR;
	private String TYPE;
	private String SUB_TYPE;
	private int SUB_LEN;
	private BigDecimal TIMES;
	private BigDecimal RATE;
	private String priceType;
	public String getSTMT_YEAR() {
		return STMT_YEAR;
	}
	public void setSTMT_YEAR(String sTMT_YEAR) {
		STMT_YEAR = sTMT_YEAR;
	}
	public String getTYPE() {
		return TYPE;
	}
	public void setTYPE(String tYPE) {
		TYPE = tYPE;
	}
	public String getSUB_TYPE() {
		return SUB_TYPE;
	}
	public void setSUB_TYPE(String sUB_TYPE) {
		SUB_TYPE = sUB_TYPE;
	}
	public int getSUB_LEN() {
		return SUB_LEN;
	}
	public void setSUB_LEN(int sUB_LEN) {
		SUB_LEN = sUB_LEN;
	}
	public BigDecimal getTIMES() {
		return TIMES;
	}
	public void setTIMES(BigDecimal tIMES) {
		TIMES = tIMES;
	}
	public BigDecimal getRATE() {
		return RATE;
	}
	public void setRATE(BigDecimal rATE) {
		RATE = rATE;
	}
	public String getPriceType() {
		return priceType;
	}
	public void setPriceType(String priceType) {
		this.priceType = priceType;
	}
	
}
