package com.gmoa.bean;

import java.math.BigDecimal;

public class YearFluxBean {
	private String LINE_ID;
	private BigDecimal TOTAL_FLUX;
	private BigDecimal TOTAL_TIMES;
	private BigDecimal TOTAL_FLUX_COMP;
	private BigDecimal TOTAL_AMOUNT;
	private BigDecimal TOTAL_AMOUNT_COMP;
	private BigDecimal FLUX_RATIO;
	private String STMT_MONTH;
	private BigDecimal PER_MONTH_FLUX;
	private Integer AMOUNT;
	private String TIME_PERIOD;
	private BigDecimal IN_PASS_NUM;
	private BigDecimal OUT_PASS_NUM;
	private String YEAR;
	private BigDecimal DCP;
	private BigDecimal JFK;
	private BigDecimal YGK;
	private BigDecimal JCP;
	private BigDecimal LRK;
	private BigDecimal LC;
	private BigDecimal LJ;
	private BigDecimal PBOC;
	private String TICKET_TYPE;
	private Integer ENTER_TIMES;
	private Integer EXIT_TIMES;
	private Integer CHANGE_TIMES;
	private Integer TIMES;
	private String STATION_NM_CN;
	private String RING;
	private BigDecimal TOTAL_INCOME;
	private BigDecimal AVGLINE;
	private BigDecimal AVG_PRICE;
	private BigDecimal AVGLINE_INCR;
	private BigDecimal AVG_PRICE_INCR;
	private BigDecimal AVGLINE_COMP;
	private BigDecimal AVG_PRICE_COMP;
	private BigDecimal CHG_FLUX;
	private String OPER_NAME;
	private BigDecimal COMP_RATE;
	private BigDecimal INCR_RATE;
	private BigDecimal YEAR_FLUX;
	private BigDecimal YEAR_AMOUNT;
	
	public BigDecimal getTOTAL_FLUX() {
		if(TOTAL_FLUX == null){
			return BigDecimal.ZERO;
		}
		return TOTAL_FLUX;
	}
	public void setTOTAL_FLUX(BigDecimal tOTAL_FLUX) {
		TOTAL_FLUX = tOTAL_FLUX;
	}
	public String getSTMT_MONTH() {
		return STMT_MONTH;
	}
	public void setSTMT_MONTH(String sTMT_MONTH) {
		STMT_MONTH = sTMT_MONTH;
	}
	public BigDecimal getPER_MONTH_FLUX() {
		return PER_MONTH_FLUX;
	}
	public void setPER_MONTH_FLUX(BigDecimal pER_MONTH_FLUX) {
		PER_MONTH_FLUX = pER_MONTH_FLUX;
	}
	public String getLINE_ID() {
		return LINE_ID;
	}
	public void setLINE_ID(String lINE_ID) {
		LINE_ID = lINE_ID;
	}
	public BigDecimal getTOTAL_FLUX_COMP() {
		return TOTAL_FLUX_COMP;
	}
	public void setTOTAL_FLUX_COMP(BigDecimal tOTAL_FLUX_COMP) {
		TOTAL_FLUX_COMP = tOTAL_FLUX_COMP;
	}
	public BigDecimal getFLUX_RATIO() {
		return FLUX_RATIO;
	}
	public void setFLUX_RATIO(BigDecimal fLUX_RATIO) {
		FLUX_RATIO = fLUX_RATIO;
	}
	public Integer getAMOUNT() {
		return AMOUNT;
	}
	public void setAMOUNT(Integer aMOUNT) {
		AMOUNT = aMOUNT;
	}
	public String getTIME_PERIOD() {
		return TIME_PERIOD;
	}
	public void setTIME_PERIOD(String tIME_PERIOD) {
		TIME_PERIOD = tIME_PERIOD;
	}
	public BigDecimal getIN_PASS_NUM() {
		return IN_PASS_NUM;
	}
	public void setIN_PASS_NUM(BigDecimal iN_PASS_NUM) {
		IN_PASS_NUM = iN_PASS_NUM;
	}
	public BigDecimal getOUT_PASS_NUM() {
		return OUT_PASS_NUM;
	}
	public void setOUT_PASS_NUM(BigDecimal oUT_PASS_NUM) {
		OUT_PASS_NUM = oUT_PASS_NUM;
	}
	public String getYEAR() {
		return YEAR;
	}
	public void setYEAR(String yEAR) {
		YEAR = yEAR;
	}
	public BigDecimal getDCP() {
		return DCP;
	}
	public void setDCP(BigDecimal dCP) {
		DCP = dCP;
	}
	public BigDecimal getJFK() {
		return JFK;
	}
	public void setJFK(BigDecimal jFK) {
		JFK = jFK;
	}
	public BigDecimal getYGK() {
		return YGK;
	}
	public void setYGK(BigDecimal yGK) {
		YGK = yGK;
	}
	public BigDecimal getJCP() {
		return JCP;
	}
	public void setJCP(BigDecimal jCP) {
		JCP = jCP;
	}
	public BigDecimal getLRK() {
		return LRK;
	}
	public void setLRK(BigDecimal lRK) {
		LRK = lRK;
	}
	public BigDecimal getPBOC() {
		return PBOC;
	}
	public void setPBOC(BigDecimal pBOC) {
		PBOC = pBOC;
	}
	public String getTICKET_TYPE() {
		return TICKET_TYPE;
	}
	public void setTICKET_TYPE(String tICKET_TYPE) {
		TICKET_TYPE = tICKET_TYPE;
	}
	public Integer getENTER_TIMES() {
		return ENTER_TIMES;
	}
	public void setENTER_TIMES(Integer eNTER_TIMES) {
		ENTER_TIMES = eNTER_TIMES;
	}
	public Integer getEXIT_TIMES() {
		return EXIT_TIMES;
	}
	public void setEXIT_TIMES(Integer eXIT_TIMES) {
		EXIT_TIMES = eXIT_TIMES;
	}
	public Integer getCHANGE_TIMES() {
		return CHANGE_TIMES;
	}
	public void setCHANGE_TIMES(Integer cHANGE_TIMES) {
		CHANGE_TIMES = cHANGE_TIMES;
	}
	public Integer getTIMES() {
		return TIMES;
	}
	public void setTIMES(Integer tIMES) {
		TIMES = tIMES;
	}
	public String getSTATION_NM_CN() {
		return STATION_NM_CN;
	}
	public void setSTATION_NM_CN(String sTATION_NM_CN) {
		STATION_NM_CN = sTATION_NM_CN;
	}
	public String getRING() {
		return RING;
	}
	public void setRING(String rING) {
		RING = rING;
	}
	public BigDecimal getTOTAL_INCOME() {
		return TOTAL_INCOME;
	}
	public void setTOTAL_INCOME(BigDecimal tOTAL_INCOME) {
		TOTAL_INCOME = tOTAL_INCOME;
	}
	public BigDecimal getAVGLINE() {
		return AVGLINE;
	}
	public void setAVGLINE(BigDecimal aVGLINE) {
		AVGLINE = aVGLINE;
	}
	public BigDecimal getAVG_PRICE() {
		return AVG_PRICE;
	}
	public void setAVG_PRICE(BigDecimal aVG_PRICE) {
		AVG_PRICE = aVG_PRICE;
	}
	public BigDecimal getAVGLINE_COMP() {
		return AVGLINE_COMP;
	}
	public void setAVGLINE_COMP(BigDecimal aVGLINE_COMP) {
		AVGLINE_COMP = aVGLINE_COMP;
	}
	public BigDecimal getAVG_PRICE_COMP() {
		return AVG_PRICE_COMP;
	}
	public void setAVG_PRICE_COMP(BigDecimal aVG_PRICE_COMP) {
		AVG_PRICE_COMP = aVG_PRICE_COMP;
	}
	public BigDecimal getCHG_FLUX() {
		return CHG_FLUX;
	}
	public void setCHG_FLUX(BigDecimal cHG_FLUX) {
		CHG_FLUX = cHG_FLUX;
	}
	public BigDecimal getLC() {
		return LC;
	}
	public void setLC(BigDecimal lC) {
		LC = lC;
	}
	public BigDecimal getLJ() {
		return LJ;
	}
	public void setLJ(BigDecimal lJ) {
		LJ = lJ;
	}
	public String getOPER_NAME() {
		return OPER_NAME;
	}
	public void setOPER_NAME(String oPER_NAME) {
		OPER_NAME = oPER_NAME;
	}
	public BigDecimal getCOMP_RATE() {
		return COMP_RATE;
	}
	public void setCOMP_RATE(BigDecimal cOMP_RATE) {
		COMP_RATE = cOMP_RATE;
	}
	public BigDecimal getINCR_RATE() {
		if(INCR_RATE == null){
			return BigDecimal.ZERO;
		}
		return INCR_RATE;
	}
	public void setINCR_RATE(BigDecimal iNCR_RATE) {
		INCR_RATE = iNCR_RATE;
	}
	public BigDecimal getYEAR_FLUX() {
		return YEAR_FLUX;
	}
	public void setYEAR_FLUX(BigDecimal yEAR_FLUX) {
		YEAR_FLUX = yEAR_FLUX;
	}
	public BigDecimal getTOTAL_AMOUNT() {
		return TOTAL_AMOUNT;
	}
	public void setTOTAL_AMOUNT(BigDecimal tOTAL_AMOUNT) {
		TOTAL_AMOUNT = tOTAL_AMOUNT;
	}
	public BigDecimal getTOTAL_AMOUNT_COMP() {
		return TOTAL_AMOUNT_COMP;
	}
	public void setTOTAL_AMOUNT_COMP(BigDecimal tOTAL_AMOUNT_COMP) {
		TOTAL_AMOUNT_COMP = tOTAL_AMOUNT_COMP;
	}
	public BigDecimal getYEAR_AMOUNT() {
		return YEAR_AMOUNT;
	}
	public void setYEAR_AMOUNT(BigDecimal yEAR_AMOUNT) {
		YEAR_AMOUNT = yEAR_AMOUNT;
	}
	public BigDecimal getAVGLINE_INCR() {
		return AVGLINE_INCR;
	}
	public void setAVGLINE_INCR(BigDecimal aVGLINE_INCR) {
		AVGLINE_INCR = aVGLINE_INCR;
	}
	public BigDecimal getAVG_PRICE_INCR() {
		return AVG_PRICE_INCR;
	}
	public void setAVG_PRICE_INCR(BigDecimal aVG_PRICE_INCR) {
		AVG_PRICE_INCR = aVG_PRICE_INCR;
	}
	public BigDecimal getTOTAL_TIMES() {
		return TOTAL_TIMES;
	}
	public void setTOTAL_TIMES(BigDecimal tOTALTIMES) {
		TOTAL_TIMES = tOTALTIMES;
	}
	
}
