package com.gmoa.vos.tos;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import jsontag.annotation.JsonTagAnnotation;
import jsontag.dao.JsonTagTemplateDaoImpl;
import jsontag.interf.IDoService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;

import com.gmoa.bean.CacheDataBean;
import com.util.HttpUtil;
import com.util.PropertiesUtil;


/**
 *
 */    
@JsonTagAnnotation(actionValue="/get_tosstate.action",namespace="/tos",isJsonReturn=true)
public class GetTosState extends JsonTagTemplateDaoImpl implements IDoService {
	public static JSONObject STATIONS=null;
	private String flag;
	private static final Log log=LogFactory.getLog(GetTosState.class);
	
	@Override
	public Object doService() throws Exception {
		JSONObject rt=new JSONObject();
		JSONArray retResult=new JSONArray();
		StringBuffer title=new StringBuffer();
		
		if(STATIONS==null){
			STATIONS=new JSONObject();
			StringBuffer sql=new StringBuffer();
			sql.append("select trim(station_nm_cn) station_nm,station_id from viw_metro_station_name ");
			sql.append("where to_char(sysdate,'yyyymmdd') between start_time and end_time order by station_id ");
			List<Map<String,Object>> list=jsonTagJdbcDao.getJdbcTemplate().queryForList(sql.toString());
			for(Map<String,Object> mp:list){
				STATIONS.put(mp.get("STATION_ID"),mp.get("STATION_NM"));
			}
		}
		
		try{
			String result=HttpUtil.doPostStr(PropertiesUtil.getTosUrl(), null, null);
//			String result="<msg><body><infos>" +
//					"<info><bs>1321</bs><es>1322</es><cType>2</cType></info>" +
//					"<info><bs>0245</bs><es>0246</es><cType>2</cType></info>" +
//					"<info><bs>0246</bs><es>0247</es><cType>2</cType></info>" +
//					"<info><bs>0247</bs><es>0248</es><cType>2</cType></info>" +
//					"<info><bs>0848</bs><es>0849</es><cType>2</cType>" +
//					"<memo>上海地铁提示信息：请乘客们配合安检、不越黄线、嘀声勿闯、先下后上、有序上车，共同营造上海地铁文明安全的乘车环境，交通运输服务监督电话：12328。</memo></info></infos></body><vcode/></msg>";
			result=result.substring(result.indexOf("<msg>"),result.indexOf("</msg>")+6).replaceAll(" ", "");
			Document doc=DocumentHelper.parseText(result);
			Element root = doc.getRootElement();
			Element info;
			Element list= root.element("body").element("infos");
			
			JSONObject ob=null;
			for(Iterator<Element> i = list.elementIterator("info"); i.hasNext();) {   
				info = i.next();
				//cType:1(通畅)，2(拥堵)，3(中断)
				if(info.elementText("bs")!=null&&info.elementText("bs").equals(info.elementText("es"))){
					ob=new JSONObject();
					ob.put("id",info.elementText("bs")+"u");
					ob.put("cType",info.elementText("cType"));
					ob.put("STATION_NM_START",STATIONS.get(info.elementText("bs")));
					retResult.add(ob);
					
					ob=new JSONObject();
					ob.put("id",info.elementText("bs")+"d");
					ob.put("cType",info.elementText("cType"));
					retResult.add(ob);
				}else if(info.elementText("bs")!=null&&info.elementText("es")!=null&&(!info.elementText("bs").equals(info.elementText("es")))){
					ob=new JSONObject();
					ob.put("id",info.elementText("bs")+"-"+info.elementText("es"));
					ob.put("cType",info.elementText("cType"));
					String lineId=info.elementText("bs").substring(0,2);
					
					int bs=Integer.parseInt(info.elementText("bs"));
					int es=Integer.parseInt(info.elementText("es"));
					if("06".equals(lineId)||"08".equals(lineId)||"17".equals(lineId)||"41".equals(lineId)){
						if(bs>es){
							ob.put("sid",info.elementText("bs")+"u");
						}else{
							ob.put("sid",info.elementText("bs")+"d");
						}
					}else{
						if(bs<es){
							ob.put("sid",info.elementText("bs")+"u");
						}else{
							ob.put("sid",info.elementText("bs")+"d");
						}
					}
					ob.put("STATION_NM_START",STATIONS.get(info.elementText("bs")));
					ob.put("STATION_NM_END",STATIONS.get(info.elementText("es")));
					retResult.add(ob);
				}
				if(info.elementText("memo")!=null){
					title.append(info.elementText("memo"));
				}
				
			}
		}catch(Exception e){
			log.error("调用tos接口异常："+e.getMessage());
		}
		if("selOd".equals(flag)){
			List<Map<String,Object>> list=findOd();
			boolean flag=false;
			
			for(int i=0;i<retResult.size();i++){
				JSONObject ob=(JSONObject)retResult.get(i);
				if((!ob.getString("cType").equals("1"))&&ob.getString("id").indexOf("-")>0){
					flag=true;
					for(Map<String,Object> mp:list){
						if(ob.getString("id").equals(mp.get("ID").toString())){
							flag=false;
							mp.put("CTYPE", ob.getString("cType"));
							break;
						}else if(ob.getString("id").equals(mp.get("RID").toString())){
							flag=false;
							mp.put("CTYPE", ob.getString("cType"));
							String[] tp=ob.getString("id").split("-");
							mp.put("ID",ob.getString("id"));
							mp.put("RID",tp[1]+"-"+tp[0]);
							break;
						}
					}
					if(flag){
						Map<String,Object> omp=new HashMap<String,Object>();
						String[] tp=ob.getString("id").split("-");
						omp.put("CTYPE",ob.getString("cType"));
						omp.put("ID",ob.getString("id"));
						omp.put("RID",tp[1]+"-"+tp[0]);
						omp.put("STATION_NM_START",ob.getString("STATION_NM_START"));
						omp.put("STATION_NM_END",ob.getString("STATION_NM_END"));
						list.add(omp);
					}
				}
			}
			rt.put("data",list);
		}else{
			rt.put("data", retResult);
		}
		rt.put("title", title.toString());
		return rt;
	}
	
	public List findOd(){
		ConcurrentHashMap map=CacheDataBean.LINE_OD;
		Iterator it=map.keySet().iterator();
		
		StringBuffer sql=new StringBuffer("select aa.ctype,aa.sub_io_stat||'-'||aa.sub_oi_stat id,aa.sub_oi_stat||'-'||aa.sub_io_stat rid,bb.station_nm station_nm_start,cc.station_nm station_nm_end from(");
		sql.append(" select null sub_io_stat,null sub_oi_stat,null ctype from dual");
		while(it.hasNext()){
			JSONObject ob=(JSONObject)map.get(it.next());
			String lineId=ob.getString("lineId");
			String startStation=ob.getString("startStation");
			String endStation=ob.getString("endStation");
			String ctype=ob.getString("ctype");
			if(startStation.equals(endStation)){
				sql.append(" union all");
				sql.append(" select '").append(startStation).append("' sub_io_stat,'").append(endStation).append("' sub_oi_stat,'").append(ctype).append("' ctype from dual");
			}else{
				sql.append(" union all");
				sql.append(" select sub_io_stat,sub_oi_stat,'").append(ctype).append("' ctype from tbl_metro_report_sub_road_ch ");
				sql.append(" where info_ver=(select max(info_ver) from tbl_metro_report_sub_road_ch) ");
				sql.append(" and io_stat='").append(startStation).append("' and oi_stat='").append(endStation).append("' and substr(sub_io_stat,1,2)='").append(lineId).append("' and substr(sub_oi_stat,1,2)='").append(lineId).append("'");
				sql.append(" group by sub_io_stat,sub_oi_stat");
			}
		}
		sql.append(") aa,");
		sql.append("(");
		sql.append("  select trim(station_nm_cn) station_nm,station_id from viw_metro_station_name ");
		sql.append("  where to_char(sysdate,'yyyymmdd') between start_time and end_time ");
		sql.append(") bb,");
		sql.append("(");
		sql.append("  select trim(station_nm_cn) station_nm,station_id from viw_metro_station_name ");
		sql.append("  where to_char(sysdate,'yyyymmdd') between start_time and end_time ");
		sql.append(") cc where aa.sub_io_stat=bb.station_id and aa.sub_oi_stat=cc.station_id and aa.sub_io_stat is not null");
		
		
		List<Map<String,Object>> list=jsonTagJdbcDao.getJdbcTemplate().queryForList(sql.toString());
		
		return list;
	}
	
	

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}
	
	

}
