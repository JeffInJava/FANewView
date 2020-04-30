package com.gmoa.vos.tos;


import java.util.Iterator;
import java.util.List;
import java.util.Map;

import jsontag.annotation.JsonTagAnnotation;
import jsontag.dao.JsonTagTemplateDaoImpl;
import jsontag.interf.IDoService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;

import com.util.HttpUtil;
import com.util.PropertiesUtil;
import com.util.tos.ReadStationUtil;
import com.util.tos.ReadStationXmlUtil;
import com.util.tos.ReadStationXmlUtil2;
import com.util.tos.ReadThreeLineXmlUtil;
import com.util.tos.ReadLineXmlUtil;


/**
 *
 */    
@JsonTagAnnotation(actionValue="/get_path.action",namespace="/tos",isJsonReturn=true)
public class GetPath extends JsonTagTemplateDaoImpl implements IDoService {
	
	@Override
	public Object doService() throws Exception {
		JSONArray retResult=new JSONArray();
		try{
			StringBuffer sql=new StringBuffer();
			sql.append("select to_number(line_id)||trim(station_nm_cn) station_nm,station_id from viw_metro_station_name ");
			sql.append("where to_char(sysdate,'yyyymmdd') between start_time and end_time order by station_id ");
			List<Map<String,Object>> list=jsonTagJdbcDao.getJdbcTemplate().queryForList(sql.toString());
			
			for(Map<String,Object> mp:list){
				//ReadLineXmlUtil.STATIONS.put(mp.get("STATION_NM"),mp.get("station_id"));
				//ReadStationXmlUtil.STATIONS.put(mp.get("STATION_NM"),mp.get("station_id"));
				ReadStationXmlUtil2.STATIONS.put(mp.get("STATION_NM"),mp.get("station_id"));
				
				//ReadThreeLineXmlUtil.STATIONS.put(mp.get("STATION_NM"),mp.get("station_id"));
				//ReadStationUtil.STATIONS.put(mp.get("STATION_NM"),mp.get("station_id"));
			}
			//ReadLineXmlUtil.startDraw();
			//ReadStationXmlUtil.startDraw();
			ReadStationXmlUtil2.startDraw();
			
			//ReadThreeLineXmlUtil.startDraw();
			//ReadStationUtil.startDraw();
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return retResult;
	}
	

}
