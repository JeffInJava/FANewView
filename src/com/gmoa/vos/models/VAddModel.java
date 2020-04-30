package com.gmoa.vos.models;

import java.util.List;

import jsontag.JsonTagContext;
import jsontag.annotation.JsonTagAnnotation;
import jsontag.annotation.validation.MyValidation;
import jsontag.dao.JsonTagTemplateDaoImpl;
import jsontag.exception.JsonTagException;
import jsontag.interf.IDoService;
import jsontag.vos.GetHttpResource;

import org.apache.commons.lang.StringUtils;
import org.hibernate.SQLQuery;
import org.hibernate.Session;




/**
 * 添加模板
 *
 */
@JsonTagAnnotation(actionValue="/add_model.action",namespace = "/sysmanage",isJsonReturn=true)
public class VAddModel extends JsonTagTemplateDaoImpl implements IDoService {

	@MyValidation(required=true,exceptionDesc="模板名称不能为空!")
	private String modelName;
	@MyValidation(required=true,exceptionDesc="子模板名称不能为空!")
	private String subModelName;
	private String[] stationName;
//	@MyValidation(required=true,exceptionDesc="车站名称不能为空!")
	private String[] stationId;
	@MyValidation(required=true,exceptionDesc="图表是否显示标识不能为空!")
	private String viewFlag;
	private String modelId;
	private String optType;
	
	
	@Override
	public Object doService() throws Exception {
		stationName=JsonTagContext.getRequest().getParameterValues("stationName[]");
		stationId=JsonTagContext.getRequest().getParameterValues("stationId[]");
		if((!"0".equals(optType))&&StringUtils.isBlank(modelId)){
			throw new JsonTagException("模板id不能为空");
		}
		
		Session session=jsonTagDao.getHibernateTemplate().getSessionFactory().getCurrentSession();
		String ids="";
		for(String tp:stationId){
			ids+="'"+tp+"',";
		}
		//根据station_id删除模板，防止相同的记录
		SQLQuery query=session.createSQLQuery("delete from tbl_metro_model_station where model_name ='"+modelName+"' and sub_model_name='"+
				subModelName+"' and station_id in ("+ids.substring(0,ids.length()-1)+")");
		query.executeUpdate();
		
//		SQLQuery query= session.createSQLQuery("select count(*) c from tbl_metro_model_station where model_name='"+bn.getModelName()+"' and sub_model_name='"+bn.getSubModelName()+"' and station_id='"+bn.getStationId()+"' and state='1'");
//		List listCount=query.list();
//		if(listCount!=null&&listCount.size()>0&&listCount.get(0)!=null&&Integer.parseInt(listCount.get(0).toString())>0){
//			return "此模板已存在！";
//		}
		
		//查询库中最大ver_id和model_id的值
		query= session.createSQLQuery("select max(ver_id) ver_id,max(model_id) model_id from tbl_metro_model_station");
		List<Object[]> list=query.list();
		int id=0;
		int modelId=0;
		if(list!=null&&list.size()>0&&list.get(0)!=null&&list.get(0)[0]!=null){
			id=Integer.parseInt(list.get(0)[0].toString()); 
			modelId=Integer.parseInt(list.get(0)[1].toString());
		}
		
		//循环添加数据
		for(int i=0;i<stationId.length;i++){
			String tpStationNm=stationName[i];
			query= session.createSQLQuery("insert into tbl_metro_model_station(VER_ID,INFO_VER,MODEL_ID,MODEL_NAME,SUB_MODEL_NAME,LINE_ID,STATION_ID,STATION_NM_CN,STATE,VIEW_FLAG) values(:verId,1,:modelId,:modelName,:subModelName,:lineId,:stationId,:stationNmCn,'1',:viewFlag)");
			query.setInteger("verId", (id+1+i));
			if("0".equals(optType)){
				query.setInteger("modelId",(modelId+1));
			}else{
				query.setInteger("modelId",Integer.parseInt(getModelId()));
			}
			query.setString("modelName",getModelName());
			query.setString("subModelName",getSubModelName());
			query.setString("lineId",tpStationNm.substring(tpStationNm.length()-2));
			query.setString("stationId",getStationId()[i]);
			query.setString("stationNmCn",tpStationNm.substring(0,tpStationNm.length()-2));
			query.setString("viewFlag",getViewFlag());
			query.executeUpdate();
		}
		return "模板添加成功！";
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

	public String[] getStationName() {
		return stationName;
	}

	public void setStationName(String[] stationName) {
		this.stationName = stationName;
	}

	public String[] getStationId() {
		return stationId;
	}

	public void setStationId(String[] stationId) {
		this.stationId = stationId;
	}

	public String getViewFlag() {
		return viewFlag;
	}

	public void setViewFlag(String viewFlag) {
		this.viewFlag = viewFlag;
	}

	public String getModelId() {
		return modelId;
	}

	public void setModelId(String modelId) {
		this.modelId = modelId;
	}

	public String getOptType() {
		return optType;
	}

	public void setOptType(String optType) {
		this.optType = optType;
	}

}
