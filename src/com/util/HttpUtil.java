package com.util;

import java.util.Iterator;
import java.util.Map;

import org.apache.commons.lang.StringEscapeUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.http.HttpResponse;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

public class HttpUtil {
	
	private static final Log log=LogFactory.getLog(HttpUtil.class);
	/**
	 * POST请求
	 * @throws Exception
	 */
	public static String doPostStr(String url,String params,Map<String,String> mapKeys){
		String result = null;
		
		try{
			log.info("开始调用接口，url："+url+",参数："+params);
			HttpPost httpost = new HttpPost(url);
			httpost.addHeader("Content-Type", "application/x-www-form-urlencoded");
			if(mapKeys!=null){
				Iterator<String> it= mapKeys.keySet().iterator();
				while(it.hasNext()){
					String key=it.next();
					httpost.addHeader(key,mapKeys.get(key));
				}
			}
			
			if(params!=null){
				StringEntity se=new StringEntity(params,"UTF-8");
				httpost.setEntity(se);
			}
			
			//设置超时时间，setConnectTimeout：设置连接超时时间；setConnectionRequestTimeout：设置从connect Manager获取Connection超时时间；setSocketTimeout：请求获取数据的超时时间
			//RequestConfig requestConfig = RequestConfig.custom().setConnectTimeout(5000).setConnectionRequestTimeout(1000).setSocketTimeout(5000).build();  
			//httpost.setConfig(requestConfig);
			
			CloseableHttpClient client = HttpClients.createDefault(); 
			HttpResponse response = client.execute(httpost);
			result = EntityUtils.toString(response.getEntity(),"utf-8");
			result=StringEscapeUtils.unescapeXml(result);
			log.info("调用接口返回结果："+result);
			
		}catch(Exception e){
			log.error("接口调用异常，异常信息："+e.getMessage());
		}
		return result;
	}
	
	
	public static String doPostJSON(String url,String params,Map<String,String> mapKeys){
		String result=null;
		try{
			log.info("开始调用接口，url："+url+",参数："+params);
			StringEntity se=new StringEntity(params,"UTF-8");
			
			HttpPost httpost = new HttpPost(url);
			httpost.addHeader("Content-Type", "application/json");
			if(mapKeys!=null){
				Iterator<String> it= mapKeys.keySet().iterator();
				while(it.hasNext()){
					String key=it.next();
					httpost.addHeader(key,mapKeys.get(key));
				}
			}
			
			httpost.setEntity(se);
			
			//设置超时时间，setConnectTimeout：设置连接超时时间；setConnectionRequestTimeout：设置从connect Manager获取Connection超时时间；setSocketTimeout：请求获取数据的超时时间
			//RequestConfig requestConfig = RequestConfig.custom().setConnectTimeout(5000).setConnectionRequestTimeout(1000).setSocketTimeout(5000).build();  
			//httpost.setConfig(requestConfig);
			
			CloseableHttpClient client = HttpClients.createDefault(); 
			HttpResponse response = client.execute(httpost);
			result = EntityUtils.toString(response.getEntity(),"UTF-8");
			
			log.info("调用接口返回结果："+result);
			
		}catch(Exception e){
			log.error("接口调用异常，异常信息："+e.getMessage());
		}
		return result;
	}
	
	
	public static int getStatusCode(String url){
		CloseableHttpClient httpCilent = HttpClients.createDefault();
        RequestConfig requestConfig = RequestConfig.custom()
                .setConnectTimeout(5000)   //设置连接超时时间
                .setConnectionRequestTimeout(5000) // 设置请求超时时间
                .setSocketTimeout(5000)
                .setRedirectsEnabled(true)//默认允许自动重定向
                .build();
        HttpGet httpGet = new HttpGet("http://www.baidu.com");
        httpGet.setConfig(requestConfig);
        try {
            HttpResponse httpResponse = httpCilent.execute(httpGet);
            return httpResponse.getStatusLine().getStatusCode();
        } catch (Exception e) {
            return 0;
        }finally {
            try {
                httpCilent.close();
            } catch (Exception e) {
                
            }
        }
	}
}
