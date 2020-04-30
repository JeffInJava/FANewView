package com.gmoa.bean;

import java.math.BigDecimal;
import java.math.BigInteger;

public class PeakFlowBean {
	private String STMT_DAY;
	private BigInteger TIMES;
	public String getSTMT_DAY() {
		return STMT_DAY;
	}
	public void setSTMT_DAY(String sTMT_DAY) {
		STMT_DAY = sTMT_DAY;
	}
	public BigInteger getTIMES() {
		return TIMES;
	}
	public void setTIMES(BigInteger tIMES) {
		TIMES = tIMES;
	}
	
}
