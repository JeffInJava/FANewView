package com.gmoa.util;

import java.util.Properties;

public class PropertiesUtil {
	
	public static Properties getProperties()throws Exception{
		Properties p=new Properties();
		p.load(PropertiesUtil.class.getClassLoader().getResourceAsStream("gmoa.properties"));
		return p;
	}
	public static String getProperties(String prop,String propName)throws Exception{
		Properties p=new Properties();
		p.load(PropertiesUtil.class.getClassLoader().getResourceAsStream(prop));
		return p.getProperty(propName);
	}
	
}
