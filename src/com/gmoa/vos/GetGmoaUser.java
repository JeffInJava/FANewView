package com.gmoa.vos;

import jsontag.annotation.JsonTagAnnotation;
import jsontag.interf.IDoService;

import com.gmoa.security.GmoaUserHolder;

/**
 * 用户信息的action
 * @author xyc
 *
 */
@JsonTagAnnotation(actionValue="/get_gmoa_user.action")
public class GetGmoaUser implements IDoService{

	@Override
	public Object doService() throws Exception {
		return GmoaUserHolder.getCurrentUser();
	}
	

	

}
