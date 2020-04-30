package com.gmoa.security;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jkuser.security.IAfterAuthenticationHandler;
import jkuser.security.bean.JkUser;
import jkuser.security.exception.JkUserException;

public class AfterAuthenticationHandler implements IAfterAuthenticationHandler{


	@Override
	public Map<String,Object> onAuthenticationSuccess(HttpServletRequest request,
			HttpServletResponse response, JkUser commonUser)
			throws IOException, ServletException {
		Map map =new HashMap();
		if(request.getParameter("an") != null && request.getParameter("an").equals("1")){
			map.put("msg", "success");
		}
		return map;
	}

	@Override
	public Map<String, Object> onAuthenticationFailure(
			HttpServletRequest request, HttpServletResponse response,
			JkUserException e) throws IOException, ServletException {
		//异步方式登录
		Map map =new HashMap();
		if(request.getParameter("an") != null && request.getParameter("an").equals("1")){
			map.put("login_error",  e.getExceptionCode());
		}
		return map;
	}

}
