package com.gmoa.vos.models;


import java.net.URLDecoder;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import jsontag.annotation.JsonTagAnnotation;
import jsontag.bean.pagination.Pagination;
import jsontag.dao.JsonTagTemplateDaoImpl;
import jsontag.interf.IDoService;

import org.apache.commons.lang.StringUtils;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.transform.AliasToBeanResultTransformer;
import org.springframework.orm.hibernate3.HibernateCallback;

import com.gmoa.bean.ModelsBean;

/**
 * 分页查询模板信息
 *
 */
@JsonTagAnnotation(actionValue="/search_modelpg.action",namespace = "/sysmanage",isJsonReturn=true)		
public class VSearchModelsPag extends JsonTagTemplateDaoImpl implements IDoService{
	private String modelName;
	private String subModelName;
	
	private String currentPage;//当前页数
	private String pageSize;
	
	@Override
	public Object doService() throws Exception {
		final int cp=Integer.parseInt(getCurrentPage());
		final int ps=getPageSize()==null?10:Integer.parseInt(getPageSize());
		
		return (Pagination)jsonTagDao.getHibernateTemplate().execute(new HibernateCallback(){
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				StringBuffer sql=new StringBuffer(" from tbl_metro_model_station where state='1' and sub_model_name is not null");
				List<String> paramNames=new ArrayList<String>();
				List<Object> values=new ArrayList<Object>();
				if(StringUtils.isNotBlank(getModelName())){
					sql.append(" and model_name='"+URLDecoder.decode(getModelName().trim())+"'");
					paramNames.add("modelName");
					values.add(URLDecoder.decode(getModelName().trim()));
				}
				if(StringUtils.isNotBlank(getSubModelName())){
					sql.append(" and sub_model_name='"+URLDecoder.decode(getSubModelName().trim())+"'");
					paramNames.add("subModelName");
					values.add(URLDecoder.decode(getSubModelName().trim()));
				}
				
				SQLQuery query=session.createSQLQuery("select count(*) "+sql.toString());
//				for(int i=0;i<values.size();i++){
//					query.setParameter(paramNames.get(i),values.get(i));
//				}
				int counts=Integer.parseInt(query.list().get(0)+"");//总条数
				query=session.createSQLQuery("select ver_id verId,model_id modelId,model_name modelName,sub_model_name subModelName,station_nm_cn stationNmCm,line_id||'号线' lineId,view_flag viewFlag "+sql.toString());
				
//				for(int i=0;i<values.size();i++){
//					query.setParameter(paramNames.get(i),values.get(i));
//				}
				query.setFirstResult((cp-1)*ps);
				query.setMaxResults(ps);
				query.addScalar("verId",Hibernate.INTEGER);
				query.addScalar("modelId",Hibernate.INTEGER);
				query.addScalar("modelName",Hibernate.STRING);
				query.addScalar("subModelName",Hibernate.STRING);
				query.addScalar("lineId",Hibernate.STRING);
				query.addScalar("stationNmCm",Hibernate.STRING);
				query.addScalar("viewFlag",Hibernate.STRING);
				query.setResultTransformer(new AliasToBeanResultTransformer(ModelsBean.class));
				List<ModelsBean> list=query.list();
				return new Pagination(list,counts,cp,ps);
			}});
	}


	public String getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(String currentPage) {
		this.currentPage = currentPage;
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

	public String getPageSize() {
		return pageSize;
	}

	public void setPageSize(String pageSize) {
		this.pageSize = pageSize;
	}

	
}
