package com.util;

import java.io.InputStream;
import java.util.Properties;

public class PropertiesUtil {

    private static Properties properties = null;

    static {
    	properties=new Properties();
		InputStream in=null;
		try {
			in=Thread.currentThread().getContextClassLoader().getResourceAsStream("/config.properties");
			properties.load(in);
			in.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

    }

    public static String getReportUrl() {
        return properties.getProperty("report.url");
    }

    public static String getDbDriver(){
    	return properties.getProperty("db.driver");
    }
    
    public static String getDbUrl() {
        return properties.getProperty("db.url");
    }
    
    public static String getDbUser() {
        return properties.getProperty("db.user");
    }
    
    public static String getDbPass() {
        return properties.getProperty("db.pass");
    }
    
    public static String getDbJNDI() {
        return properties.getProperty("db.jndi");
    }
    
    public static String getMopUrl() {
        return properties.getProperty("mop.url");
    }
    
    public static String getTosUrl() {
        return properties.getProperty("tos.url");
    }
    
    public static Properties getProperties() {
        return properties;
    }

}
