package com.gmoa.vos.models;

import jsontag.annotation.JsonTagAnnotation;
import jsontag.annotation.validation.MyValidation;
import jsontag.dao.JsonTagTemplateDaoImpl;
import jsontag.interf.IDoService;

import org.hibernate.SQLQuery;




/**
 * 删除模板
 *
 */
@JsonTagAnnotation(actionValue="/del_model.action",namespace = "/sysmanage",isJsonReturn=true)
public class VDelModel extends JsonTagTemplateDaoImpl implements IDoService {

	@MyValidation(required=true,exceptionDesc="模板编号不能为空!")
	private String verId;
	
	@Override
	public Object doService() throws Exception {
		SQLQuery query= jsonTagDao.getHibernateTemplate().getSessionFactory().getCurrentSession().createSQLQuery("delete tbl_metro_model_station where ver_id=:verId");
		query.setString("verId",getVerId());
		query.executeUpdate();
		return "模板删除成功！";
	}
	
	public String getVerId() {
		return verId;
	}

	public void setVerId(String verId) {
		this.verId = verId;
	}
	
}
