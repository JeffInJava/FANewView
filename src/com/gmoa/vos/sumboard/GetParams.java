package com.gmoa.vos.sumboard;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.jdbc.core.JdbcTemplate;

import com.runqian.base4.util.Logger;

import jsontag.annotation.JsonTagAnnotation;
import jsontag.dao.JsonTagTemplateDaoImpl;
import jsontag.interf.IDoService;
import net.sf.json.JSONObject;
/*
 * 页面初始化查询页面参数
 */
@JsonTagAnnotation(actionValue="/GetTVMdata.action",namespace="/synt",isJsonReturn=true,jsonRoot="")
public class GetParams implements IDoService{

	@Override
	public Object doService() throws Exception {
		// TODO Auto-generated method stub
		String url="http://localhost:8080/TVMView/data_Load.action";
		String  res=getStrHttpURLConnection(url);
		
		JSONObject json = JSONObject.fromObject(res); 
		
		System.out.println(res);
		
		return json;
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
	        conn.setRequestMethod("POST");
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
