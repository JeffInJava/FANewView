package com.gmoa.vos.tos;


import jsontag.annotation.JsonTagAnnotation;
import jsontag.dao.JsonTagTemplateDaoImpl;
import jsontag.interf.IDoService;
import net.sf.json.JSONObject;

import com.util.HttpUtil;


/**
 *
 */    
@JsonTagAnnotation(actionValue="/get_trainPosition.action",namespace="/tos",isJsonReturn=false)
public class GetTrainPosition extends JsonTagTemplateDaoImpl implements IDoService {
	
	@Override
	public Object doService() throws Exception {
		JSONObject rqParms=new JSONObject();
		rqParms.put("requestTime","2018-03-13 11:24:31");
		String result=HttpUtil.doPostJSON("http://222.66.139.92:8080/positionService/getAllTrainPosition.action", rqParms.toString(), null);
		return result;
	}
	

}
