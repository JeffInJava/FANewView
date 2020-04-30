package com.gmoa.vos.sumboard;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jsontag.JsonTagContext;
import jsontag.annotation.JsonTagAnnotation;
import jsontag.dao.JsonTagTemplateDaoImpl;
import jsontag.interf.IDoService;

/**
 * 获取设备数量
 * @author Administrator
 *
 */
@JsonTagAnnotation(actionValue="/GetEpNums.action",namespace="/synt",isJsonReturn=true)
public class GetEpNums extends JsonTagTemplateDaoImpl implements IDoService{
	private String date;
	private String size;
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getSize() {
		return size;
	}
	public void setSize(String size) {
		this.size = size;
	}
	@Override
	public Object doService() throws Exception {
		// TODO Auto-generated method stub
		
		String sql;
		int  Gc=0;
		int  Vc=0;
		int  Bc=0;
		int  Cc=0;
		int  tot=0;
		Map<String,Object>  result=new 	HashMap<String, Object>();
		List<Map<String,Object>> list=new  ArrayList<Map<String,Object>>();		
			sql ="select count(*) Gm from tbl_metro_device_info where status='1' and stop_flag='1'  and  equip_id like  'G%'" ;
			list = jsonTagJdbcDao.getJdbcTemplate().queryForList(sql);
				for(Map<String,Object> gma:list){
						Gc=Integer.parseInt(gma.get("GM").toString());
				}
			
			String	vql ="select count(*) vm from tbl_metro_device_info where status='1' and stop_flag='1'  and  equip_id like  'V%'" ;
			List<Map<String,Object>> vl = jsonTagJdbcDao.getJdbcTemplate().queryForList(vql);
					for(Map<String,Object> vma:vl){
							Vc=Integer.parseInt(vma.get("VM").toString());
					}
					String	bql ="select count(*) bm from tbl_metro_device_info where status='1' and stop_flag='1'  and  equip_id like  'B%'" ;
					List<Map<String,Object>> bl = jsonTagJdbcDao.getJdbcTemplate().queryForList(bql);
							for(Map<String,Object> bma:bl){
									Bc=Integer.parseInt(bma.get("BM").toString());
							}
							String	cql ="select count(*) cm from tbl_metro_device_info where status='1' and stop_flag='1'  and  equip_id like  'C%'" ;
							List<Map<String,Object>> cl = jsonTagJdbcDao.getJdbcTemplate().queryForList(cql);
									for(Map<String,Object> cma:cl){
											Cc=Integer.parseInt(cma.get("CM").toString());
									} 
									
									
									tot=Gc+Vc+Bc+Cc;
									result.put("GM", Gc);
									result.put("TVM", Vc);
									result.put("BOM", Bc);
									result.put("CVM", Cc);
									result.put("total", tot);
		return result;
		
	}

}
