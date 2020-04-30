package com.gmoa.vos.models;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jsontag.annotation.JsonTagAnnotation;
import jsontag.dao.JsonTagTemplateDaoImpl;
import jsontag.interf.IDoService;



/**
 * 查询全部模板名称
 *
 */
@JsonTagAnnotation(actionValue="/search_modelall.action",namespace = "/sysmanage",isJsonReturn=true)
public class VSearchModelAll extends JsonTagTemplateDaoImpl implements IDoService {
	
	@Override
	public Object doService() throws Exception {
		List<Object[]> list=jsonTagDao.findBySql("select trim(model_name) modelName,trim(sub_model_name) subModelName,model_id from tbl_metro_model_station where state='1' and sub_model_name is not null group by trim(model_name),trim(sub_model_name),model_id order by model_id");
		Map<String,List> maps=new HashMap<String,List>();
		if(list!=null&&list.size()>0){
			Object[] fir=list.get(0);
			List<String> listChild=new ArrayList<String>();
			maps.put(fir[0].toString()+"-"+fir[2].toString(), listChild);
			listChild.add(fir[1].toString());
			for(int i=1;i<list.size();i++){
				Object[] ob1=list.get(i-1);
				Object[] ob2=list.get(i);
				if(ob1[0].toString().equals(ob2[0].toString())){
					listChild.add(ob2[1].toString());
				}else{
					listChild=new ArrayList<String>();
					maps.put(ob2[0].toString()+"-"+ob2[2].toString(), listChild);
					listChild.add(ob2[1].toString());
				}
			}
		}
		return maps;
	}

}
