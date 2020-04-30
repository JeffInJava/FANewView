package com.util;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

public class LoginFilter implements Filter {

	@Override
	public void destroy() {

	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,FilterChain chain) throws IOException, ServletException {
		String token=request.getParameter("token");
		HttpGet httGet = new HttpGet("http://localhost:8080/demo/security/sso/server/token/validate.action?token="+token);
		CloseableHttpClient client = HttpClients.createDefault(); 
		HttpResponse httpResponse = client.execute(httGet);
		String result = EntityUtils.toString(httpResponse.getEntity(),"UTF-8");
		
		System.out.println(result);
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {

	}

}
