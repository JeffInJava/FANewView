package com.gmoa.vos.sumboard;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jsontag.JsonTagContext;
import jsontag.annotation.JsonTagAnnotation;
import jsontag.dao.JsonTagTemplateDaoImpl;
import jsontag.interf.IDoService;

/**
 * 获取在线客流
 * @author Administrator
 *
 */
@JsonTagAnnotation(actionValue="/GetonLineFlow.action",namespace="/lflw",isJsonReturn=true)
public class GetOnlineflw extends JsonTagTemplateDaoImpl implements IDoService{
	private String date;
	private String size;
	private String compDate;


	public String getCompDate()
	{
		return compDate;
	}

	public void setCompDate(String compDate)
	{
		this.compDate = compDate;
	}

	public String getDate()
	{
		return date;
	}

	public void setDate(String date)
	{
		this.date = date;
	}

	public String getSize()
	{
		return size;
	}

	public void setSize(String size)
	{
		this.size = size;
	}

	public Object doService()
		throws Exception
	{
		List<String> listTimes = new ArrayList<String>();
		List<Map<String,Object>> listTime = new ArrayList<Map<String,Object>>();
		List<Map<String,Object>> listLine = new ArrayList<Map<String,Object>>();
		Map<String,Object>  result=new 	HashMap<String, Object>();
		String sqlt = "select * from tbl_metro_online where CREATE_DATE='20190718' AND LINE_ID='41' and CREATE_TIME >= '0600' ORDER BY CREATE_TIME";
		listTime = jsonTagJdbcDao.getJdbcTemplate().queryForList(sqlt);
		for (int i = 0; i < listTime.size(); i++)
		{
			Map<String, Object>  mp = listTime.get(i);
			String time = mp.get("CREATE_TIME").toString();
			StringBuffer sb = new StringBuffer();
			sb.append(time).insert(2, ":");
			time = sb.toString();
			listTimes.add(time);
		}

		String lisq = "select * from tbl_metro_online where CREATE_DATE='20190718'  and CREATE_TIME = '0800' ORDER BY CREATE_TIME";
		List<Map<String,Object>> lines = jsonTagJdbcDao.getJdbcTemplate().queryForList(lisq);
		for (int i = 0; i < lines.size(); i++)
		{
			Map<String, Object>  mp =lines.get(i);
			String lineId = mp.get("LINE_ID").toString();
			Map<String, Object>  linefl = new HashMap<String, Object>();
			List<Double> lt = new ArrayList<Double>();
			String liolf = (new StringBuilder("select round(online_times/10000,2) online_times from tbl_metro_online where CREATE_DATE=")).append(date).append(" AND LINE_ID=").append(lineId).append(" and CREATE_TIME >= '0600' ORDER BY CREATE_TIME").toString();
			List<Map<String,Object>> linest = jsonTagJdbcDao.getJdbcTemplate().queryForList(liolf);
			for (int j = 0; j < linest.size(); j++)
			{
				Map<String, Object> lmp = linest.get(j);
				double times = Double.parseDouble(lmp.get("ONLINE_TIMES").toString());
				lt.add(times);
			}

			List<Double> cplt = new ArrayList<Double>();
			String cpliolf = (new StringBuilder("select round(online_times/10000,2) online_times from tbl_metro_online where CREATE_DATE=")).append(compDate).append(" AND LINE_ID=").append(lineId).append(" and CREATE_TIME >= '0600' ORDER BY CREATE_TIME").toString();
			List<Map<String,Object>> cplinest = jsonTagJdbcDao.getJdbcTemplate().queryForList(cpliolf);
			for (int f = 0; f < cplinest.size(); f++)
			{
				Map<String, Object> lmp = cplinest.get(f);
				double times = Double.parseDouble(lmp.get("ONLINE_TIMES").toString());
				cplt.add(times);
			}

			linefl.put("times", lt);
			linefl.put("cpTimes", cplt);
			listLine.add(linefl);
		}

		Map<String,Object> alflti = new HashMap<String,Object>();
		List<Double> allt = new ArrayList<Double>();
		String alliolf = (new StringBuilder("select CREATE_TIME,round(sum(ONLINE_TIMES)/10000,2) TOTAL_TIMES from tbl_metro_online where CREATE_DATE=")).append(date).append(" and CREATE_TIME >= '0600'  GROUP BY CREATE_TIME ORDER BY CREATE_TIME").toString();
		List<Map<String,Object>> allft = jsonTagJdbcDao.getJdbcTemplate().queryForList(alliolf);
		for (int f = 0; f < allft.size(); f++)
		{
			Map<String, Object> lmp = allft.get(f);
			double times = Double.parseDouble(lmp.get("TOTAL_TIMES").toString());
			allt.add(times);
		}

		List<Double> cpallt = new ArrayList<Double>();
		String cpalliolf = (new StringBuilder("select CREATE_TIME,round(sum(ONLINE_TIMES)/10000,2) TOTAL_TIMES from tbl_metro_online where CREATE_DATE=")).append(compDate).append(" and CREATE_TIME >= '0600'  GROUP BY CREATE_TIME ORDER BY CREATE_TIME").toString();
		List<Map<String,Object>> cpallft = jsonTagJdbcDao.getJdbcTemplate().queryForList(cpalliolf);
		for (int l = 0; l < cpallft.size(); l++)
		{
			Map<String, Object> lmp =cpallft.get(l);
			double times = Double.parseDouble(lmp.get("TOTAL_TIMES").toString());
			cpallt.add(times);
		}

		alflti.put("alline", allt);
		alflti.put("cpalline", cpallt);
		listLine.add(alflti);
		result.put("times", listTimes);
		result.put("lineT", listLine);
		return result;
	}

}
