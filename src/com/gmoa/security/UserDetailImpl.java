package com.gmoa.security;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import jkuser.po.BasUsrInfo;
import jkuser.security.IUserDetailsService;
import jkuser.security.bean.JkUser;
import jkuser.security.exception.UsernameNotFoundException;
import jkuser.util.PasswordUtil;
import jsontag.dao.JsonTagDaoImpl;
import jsontag.exception.JsonTagException;


public class UserDetailImpl implements IUserDetailsService {

	@Override
	public JkUser loadUser(String userName,String password, 
			JsonTagDaoImpl dao,HttpServletRequest request) throws JsonTagException{
		GmoaUser user=new GmoaUser();
		userName=userName==null?"":userName.trim();
		if(userName.length()==0)throw new UsernameNotFoundException("");

		List list=dao.getHibernateTemplate().find("from BasUsrInfo where usrName=?",userName);
		BasUsrInfo bui= ((list!=null&&list.size()>0)?(BasUsrInfo)(list.get(0)):null);
		//取得用户的密码  
		if (bui ==null){  
			throw new JsonTagException("用户"+userName+"不存在");  
		}  

		if(!bui.getPassword().equals(PasswordUtil.getPassword(userName, password))){
			throw new JsonTagException("用户名或密码错误");  
		}
		//获得用户的角色  
		List<String> auths=new ArrayList<String>();

		//当前用户的角色
		List<String> userRoleList=dao.getHibernateTemplate().find("select bri.roleKey from BasRoleInfo bri,BasUsrRoleRelation burr where burr.roleId=bri.roleId and burr.usrId=? ",bui.getUsrId());

		for (String role:userRoleList) {
			auths.add(role);  
		}

		//当前用户的部门no
		List<String> bdList=dao.getHibernateTemplate().find("select bdi.departmentNo from BasDepartmentInfo bdi,BasDepartmentUsrRelation bdur where bdi.departmentNo=bdur.departmentNo and bdur.usrId=?" ,bui.getUsrId());
		
		user.setUserName(userName);
		user.setUserId(bui.getUsrId());
		user.setAuthorities(auths);
		user.setDepartmentNoList(bdList);
		return user;
	}

}
