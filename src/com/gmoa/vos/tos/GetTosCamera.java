package com.gmoa.vos.tos;


import java.util.List;
import java.util.Map;

import jsontag.annotation.JsonTagAnnotation;
import jsontag.dao.JsonTagTemplateDaoImpl;
import jsontag.interf.IDoService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


/**
 *数据库查询，获取摄像头相关信息
 *x、y坐标，URL
 */    
@JsonTagAnnotation(actionValue="/get_camera.action",namespace="/tos",isJsonReturn=true)
public class GetTosCamera extends JsonTagTemplateDaoImpl implements IDoService {
	
	@Override
	public Object doService() throws Exception {
		JSONArray retResult=new JSONArray();
		
		StringBuffer sql=new StringBuffer();
		sql.append("select * from TBL_METRO_CAMERA where x is not null order by group_name,camera_name");
		List<Map<String,Object>> list=jsonTagJdbcDao.getJdbcTemplate().queryForList(sql.toString());
		
		JSONArray group=new JSONArray();
		JSONObject ca=new JSONObject();
		String groupName="";
		for(int i=0;i<list.size();i++){
			Map<String,Object> mp=list.get(i);
			if(!groupName.equals(mp.get("group_name"))){
				if(i!=0){
					ca.put("cameras",group);
					retResult.add(ca);
				}
				
				ca=new JSONObject();
				ca.put("group_name",mp.get("group_name"));
				ca.put("x",mp.get("x"));
				ca.put("y",mp.get("y"));
				
				group=new JSONArray();
			}
			
			JSONObject camera=new JSONObject();
			camera.put("camera_name",mp.get("camera_name"));
			camera.put("url1",mp.get("url1"));
			camera.put("url2",mp.get("url2"));
			group.add(camera);
			
			if(i==list.size()-1){
				ca.put("cameras",group);
				retResult.add(ca);
			}
			groupName=mp.get("group_name").toString();
		}
		return retResult;
	}
	

}
