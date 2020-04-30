package com.gmoa.bean;

import java.math.BigDecimal;

public class InOutTrsPropBean {
	private String TIME_IVL;
	private BigDecimal LOOP_PROP;
	private BigDecimal SAME_PROP;
	private String IN_OUT_AMT;
	private String TRS_NUM;
	private BigDecimal TRS_LOOP_PROP;
	private BigDecimal TRS_SAME_PROP;
	
	public String getTRS_NUM() {
		return TRS_NUM;
	}
	public void setTRS_NUM(String tRS_NUM) {
		TRS_NUM = tRS_NUM;
	}
	public BigDecimal getTRS_LOOP_PROP() {
		return TRS_LOOP_PROP;
	}
	public void setTRS_LOOP_PROP(BigDecimal tRS_LOOP_PROP) {
		TRS_LOOP_PROP = tRS_LOOP_PROP;
	}
	public BigDecimal getTRS_SAME_PROP() {
		return TRS_SAME_PROP;
	}
	public void setTRS_SAME_PROP(BigDecimal tRS_SAME_PROP) {
		TRS_SAME_PROP = tRS_SAME_PROP;
	}
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
	public String getIN_OUT_AMT() {
		return IN_OUT_AMT;
	}
	public void setIN_OUT_AMT(String iNOUTAMT) {
		IN_OUT_AMT = iNOUTAMT;
	}
	
	
}
