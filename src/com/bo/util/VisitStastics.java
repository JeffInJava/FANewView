package com.bo.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.util.BaseDao;

public class VisitStastics {
	
	static Logger log= Logger.getLogger(VisitStastics.class);
	
	@SuppressWarnings("resource")
	public void saveOrUpdate(String type){
		
		DateDemo ddo = new DateDemo();
		String operDay = ddo.getToday();
		
		Connection con = null;
		PreparedStatement prest = null;
		ResultSet rs = null;
		String sql = " select VISIT_COUNT from tbl_visit_statistics where visit_date= '"+operDay+"' and visit_type='"+type+"'" ;
		try{
			con=BaseDao.getJDBCConnection();
			prest = con.prepareStatement(sql);
			rs = prest.executeQuery();
			int count = 0;
			boolean rsbn = false;
			while(rs.next()){//更新
				rsbn = true;
				count = Integer.parseInt(rs.getString("VISIT_COUNT").toString());
				con = BaseDao.getJDBCConnection();
				sql = "update tbl_visit_statistics set visit_count = ? where visit_date= '"+operDay+"' and visit_type='"+type+"'" ;
				prest = con.prepareStatement(sql);
				prest.setInt(1, count+=1);
				prest.execute();
				con.commit();
			}
			if(!rsbn){//添加
				con = BaseDao.getJDBCConnection();
				sql = "INSERT INTO tbl_visit_statistics VALUES(?,?,?)";
				prest = con.prepareStatement(sql);
				prest.setString(1, operDay);
				prest.setString(2, type);
				prest.setInt(3, 1);;
				prest.execute();
				con.commit();
			}
		}catch(SQLException e){
			e.printStackTrace();
		} finally {
			BaseDao.closeAll(con, prest, null);
		}
	}
}
