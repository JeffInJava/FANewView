package com.gmoa.bean;


public class ModelsBean {
	private int verId;
	private int modelId;
	private String modelName;
	private String subModelName;
	private String lineId;
	private String stationNmCm;
	private String viewFlag;
	public int getVerId() {
		return verId;
	}
	public void setVerId(int verId) {
		this.verId = verId;
	}
	public int getModelId() {
		return modelId;
	}
	public void setModelId(int modelId) {
		this.modelId = modelId;
	}
	public String getModelName() {
		return modelName;
	}
	public void setModelName(String modelName) {
		this.modelName = modelName;
	}
	public String getSubModelName() {
		return subModelName;
	}
	public void setSubModelName(String subModelName) {
		this.subModelName = subModelName;
	}
	public String getLineId() {
		return lineId;
	}
	public void setLineId(String lineId) {
		this.lineId = lineId;
	}
	public String getStationNmCm() {
		return stationNmCm;
	}
	public void setStationNmCm(String stationNmCm) {
		this.stationNmCm = stationNmCm;
	}
	public String getViewFlag() {
		if("1".equals(viewFlag)){
			return "是";
		}
		return "否";
	}
	public void setViewFlag(String viewFlag) {
		this.viewFlag = viewFlag;
	}
	
}
