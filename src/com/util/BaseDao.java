package com.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.naming.*;
import javax.sql.*;

public class BaseDao {
	/**
	 * 连接池的方式获取数据库连接对象方法
	 * @return
	 */
	public static Connection getJNDIConnection(){
		Connection con=null;
		try{
			Context ctx=new InitialContext();
			DataSource ds=(DataSource)ctx.lookup(PropertiesUtil.getDbJNDI());
			con=ds.getConnection();
		}catch(Exception e){
			e.printStackTrace();
		}
		return con;
	}
	
	
	/**
	 * JDBC的方式获取数据库连接对象方法
	 * @return
	 */
	public static Connection getJDBCConnection(){
		Connection con=null;
		try{
			Class.forName(PropertiesUtil.getDbDriver());
			con=DriverManager.getConnection(PropertiesUtil.getDbUrl(),PropertiesUtil.getDbUser(),PropertiesUtil.getDbPass());
		}catch(Exception e){
			e.printStackTrace();
		}
		return con;
	}

	/**
	 * 关闭数据库连接方法
	 */
	public static void closeAll(Connection con,Statement stmt,ResultSet rs){
		if(rs!=null){
			try{
				rs.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		if(stmt!=null){
			try{
				stmt.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		if(con!=null){
			try{
				con.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * 可以进行增、删、改的操作
	 */
	public static int executeSQL(String preparedSql, Object[] param) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int num = 0;

		//处理SQL,执行SQL 
		try {
			con = getJNDIConnection();
			if(con==null){
				con = getJNDIConnection();
			}
			if(con==null){
				con = getJDBCConnection();
			}
			pstmt = con.prepareStatement(preparedSql); 
			if (param != null) {
				for (int i = 0; i < param.length; i++) {
					pstmt.setObject(i + 1, param[i]);
				}
			}
			
			num = pstmt.executeUpdate(); // 执行SQL语句
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeAll(con, pstmt, null);
		}
		return num;
	}
}
