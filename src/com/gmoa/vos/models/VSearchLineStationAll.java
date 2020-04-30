package com.gmoa.vos.models;

import java.util.List;

import jsontag.annotation.JsonTagAnnotation;
import jsontag.dao.JsonTagTemplateDaoImpl;
import jsontag.interf.IDoService;
import net.sf.json.JSONObject;

import org.hibernate.Hibernate;
import org.hibernate.SQLQuery;
import org.hibernate.transform.AliasToBeanResultTransformer;

import com.gmoa.bean.LineStationBean;



/**
 * 查询全部线路和车站
 *
 */
@JsonTagAnnotation(actionValue="/search_linestationall.action",namespace = "/sysmanage",isJsonReturn=true)
public class VSearchLineStationAll extends JsonTagTemplateDaoImpl implements IDoService {

	@Override
	public Object doService() throws Exception {
		String sql="select a.line_id lineId,trim(b.line_nm_cn) lineName,a.station_id stationId,trim(a.station_nm_cn) stationName from (select line_id,station_id,station_nm_cn from viw_metro_station_name"+ 
		" where to_char(sysdate,'yyyyMMdd') between start_time and end_time)a, (select line_id,line_nm_cn "+
		" from viw_metro_line_name where to_char(sysdate,'yyyyMMdd') between start_time and end_time order by line_id ) b where a.line_id=b.line_id order by lineId,stationId";
		SQLQuery query=jsonTagDao.getHibernateTemplate().getSessionFactory().getCurrentSession().createSQLQuery(sql);
		query.addScalar("lineId",Hibernate.STRING);
		query.addScalar("lineName",Hibernate.STRING);
		query.addScalar("stationId",Hibernate.STRING);
		query.addScalar("stationName",Hibernate.STRING);
		query.setResultTransformer(new AliasToBeanResultTransformer(LineStationBean.class));
		
		List<LineStationBean> list_station=query.list();
		query=jsonTagDao.getHibernateTemplate().getSessionFactory().getCurrentSession().createSQLQuery("select line_id,trim(line_nm_cn) line_nm_cn from viw_metro_line_name where to_char(sysdate,'yyyyMMdd') between start_time and end_time group by line_id,line_nm_cn order by line_id");
		query.addScalar("line_id",Hibernate.STRING);
		query.addScalar("line_nm_cn",Hibernate.STRING);
		List<Object> list_line=query.list();
		JSONObject json=new JSONObject();
		json.put("line",list_line);
		json.put("station",list_station);
		return json;
	}

	
}
