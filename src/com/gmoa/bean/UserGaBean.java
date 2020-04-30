package com.gmoa.bean;

public class UserGaBean {

	//员工号ID
	String employeeWorkno;
	//姓名
	String employeename;
	//性别
	String gender;
	//身份证
	String sfz;
	//公司编号
	String companyId;
	//公司名称
	String companyName;
	//身份标识
	String validdate;
	//添加日期
	String addDate;
	//原工号
	String oldWorkno;
	//办卡状态
	String operatedType;
	
	public String getOldWorkno() {
		return oldWorkno;
	}
	public void setOldWorkno(String oldWorkno) {
		this.oldWorkno = oldWorkno;
	}
	public String getEmployeeWorkno() {
		return employeeWorkno;
	}
	public void setEmployeeWorkno(String employeeWorkno) {
		this.employeeWorkno = employeeWorkno;
	}
	public String getEmployeename() {
		return employeename;
	}
	public void setEmployeename(String employeename) {
		this.employeename = employeename;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getSfz() {
		return sfz;
	}
	public void setSfz(String sfz) {
		this.sfz = sfz;
	}
	public String getCompanyId() {
		return companyId;
	}
	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getValiddate() {
		return validdate;
	}
	public void setValiddate(String validdate) {
		this.validdate = validdate;
	}
	public String getAddDate() {
		return addDate;
	}
	public void setAddDate(String addDate) {
		this.addDate = addDate;
	}
	public String getOperatedType() {
		return operatedType;
	}
	public void setOperatedType(String operatedType) {
		this.operatedType = operatedType;
	}
}
