package com.gmoa.bean;

import java.math.BigDecimal;

public class TransferPropBean {
	private String TIME_IVL;
	private BigDecimal LOOP_PROP;
	private BigDecimal SAME_PROP;
	private String TRS_NUM;
	public String getTIME_IVL() {
		return TIME_IVL;
	}
	public void setTIME_IVL(String tIMEIVL) {
		TIME_IVL = tIMEIVL;
	}
	public BigDecimal getLOOP_PROP() {
		return LOOP_PROP;
	}
	public void setLOOP_PROP(BigDecimal lOOPPROP) {
		LOOP_PROP = lOOPPROP;
	}
	public BigDecimal getSAME_PROP() {
		return SAME_PROP;
	}
	public void setSAME_PROP(BigDecimal sAMEPROP) {
		SAME_PROP = sAMEPROP;
	}
	public String getTRS_NUM() {
		return TRS_NUM;
	}
	public void setTRS_NUM(String tRSNUM) {
		TRS_NUM = tRSNUM;
	}
	
}
