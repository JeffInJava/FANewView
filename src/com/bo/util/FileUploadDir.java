package com.bo.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import com.gmoa.util.PropertiesUtil;

public class FileUploadDir extends HttpServlet {

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * Initialization of the servlet. <br>
	 * 创建员工信息上传目录
	 * @throws ServletException
	 *             if an error occurs
	 */
	public void init() throws ServletException {
		PropertiesUtil pu= new PropertiesUtil();
		Properties properties = null;
		try {
			properties = pu.getProperties();
		} catch (Exception e1) {
			e1.printStackTrace();
		} 
		File staffUpload = new File(properties.getProperty("STAFF_ENTERING_FLODER"));//用户信息上传目录
		File staffPic = new File(properties.getProperty("PHOTO_DISTINCT_FOLDER"));//证件照处理
		File staffDownload = new File(properties.getProperty("DOWNLOAD_BINARY_FILE"));//用户信息下载目录
		if (!staffUpload.exists() && !staffUpload.isDirectory()) {
			staffUpload.mkdirs();
		}
		if (!staffPic.exists() && !staffPic.isDirectory()) {
			staffPic.mkdirs();
		}
		if (!staffDownload.exists() && !staffDownload.isDirectory()) {
			staffDownload.mkdirs();
		}
		
	}
}
