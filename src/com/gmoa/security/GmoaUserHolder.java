package com.gmoa.security;

import jkuser.security.UserHolder;

public class GmoaUserHolder extends UserHolder{

	
	public static GmoaUser getCurrentUser(){
		return (GmoaUser) UserHolder.getCurrentUser();
	}	
	
	public static String getGroupId() {
		return GmoaUserHolder.getCurrentUser().getSimpleDepartmentNo();
	}
	
}
