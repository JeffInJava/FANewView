package com.gmoa.vos.sumboard;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import com.alibaba.fastjson.JSONArray;
import com.runqian.base4.util.Logger;

import jsontag.annotation.JsonTagAnnotation;
import jsontag.interf.IDoService;
import net.sf.json.JSONObject;

@JsonTagAnnotation(actionValue="/GetEupState.action",namespace="/synt",isJsonReturn=true,jsonRoot="")
public class GetSumflow implements IDoService{
	
	private String date;
	
	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getCompDate() {
		return compDate;
	}

	public void setCompDate(String compDate) {
		this.compDate = compDate;
	}

	private String compDate;

	@Override
	public Object doService() throws Exception {
		// TODO Auto-generated method stub
		
		//id: 0 type: 0 date: 20190624 controlDate: 20190617 isDetail: 0
		
		
		String url="http://172.16.98.53/operation/api/v1/external/alarm/query";
		String  res=getStrHttpURLConnection(url);
		
		//JSONObject json = JSONObject.fromObject(res); 
		JSONArray  jsonarr=JSONArray.parseArray(res);
		
		System.out.println(res);
		
		return jsonarr;
	}
	
	/**
	 * 通过远程调用其他系统里的URL获取数据的方法
	 *
	 * @param path 需要调用远程的URL地址
	 * @return 返回的是调用URL后返回的的数据
	 */
	private String getStrHttpURLConnection(String path) {
	    BufferedReader in = null;
	    InputStreamReader isRead = null;
	    InputStream inputStream = null;
	    HttpURLConnection conn = null;
	    String retStr = null;
	    try {
	        URL url = new URL(path);
	        //开启远程调用
	        conn = (HttpURLConnection) url.openConnection();
	        conn.setConnectTimeout(6000);
	        conn.setRequestMethod("GET");
	        conn.setDoInput(true);
	        //用流读取远程URL获取的数据
	        inputStream = conn.getInputStream();
	        isRead = new InputStreamReader(inputStream, "UTF-8");
	        in = new BufferedReader(isRead);
	        String inputLine = null;
	        StringBuffer response = new StringBuffer();
	        while ((inputLine = in.readLine()) != null) {
	            response.append(inputLine);
	        }
	        //对拿到的数据进行判断是否为空,如果不为空转为String
	        if (response != null && response.length() > 0) {
	            retStr = response.toString().trim();
	        }
	    } catch (Exception e) {
	        Logger.error("ImageCtrlAction中getStrHttpURLConnection" + e.getMessage());
	    } finally {
	        try {
	            inputStream.close();
	            conn.disconnect();
	        } catch (Exception e) {
	        	Logger.error(e);
	        }
	    }
	    return retStr;
	}
	

}
