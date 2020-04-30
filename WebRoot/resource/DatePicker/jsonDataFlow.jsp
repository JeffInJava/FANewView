<%@ page language="java" import="java.util.*,java.lang.*,java.sql.*" pageEncoding="UTF-8" contentType="text/json; charset=UTF-8"%>
<%@ page import="net.tool.*,net.sf.json.*,com.util.*" %>
<%
String month = request.getParameter("month");
if (month == null || "".equals(month)){
	java.util.Date d = new java.util.Date();
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMM");
	month = sdf.format(d);
}
java.sql.Connection con=null;
java.sql.PreparedStatement pstmt = null;
java.sql.ResultSet rs=null;

List<JSONObject> fluxList = new ArrayList<JSONObject>();
try{
	con=BaseDao.getJDBCConnection();//获取数据库连接
	//客流
	String sql = "select STMT_DAY, ROUND((SUM(ENTER_TIMES) + SUM(CHG_TIMES) + SUM(FLUX_TIMES))/10000,0) TOTAL_TIMES"
		+ "  from TBL_PW_FLUX_TOTAL t"
		+ " WHERE SUBSTR(STMT_DAY, 1, 4)>'2014'"
		+ " GROUP BY STMT_DAY"
		+ " ORDER BY STMT_DAY";
	pstmt = con.prepareStatement(sql);
	//pstmt.setString(1,month);
	rs = pstmt.executeQuery();
	while (rs.next()){
		JSONObject _flux = new JSONObject();
		_flux.put("STMT_DAY",rs.getString("STMT_DAY"));
		_flux.put("TOTAL_TIMES",rs.getString("TOTAL_TIMES"));
		fluxList.add(_flux);
	}
}catch(Exception e){
	e.printStackTrace();
}finally{
        //关闭con、st、rs
		if(pstmt!=null){
			try{
				pstmt.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	BaseDao.closeAll(con,null,rs);
   }

response.reset();
response.setContentType("text/json; charset=UTF-8");

out.clear();  
out = pageContext.pushBody();  
response.getOutputStream().write(fluxList.toString().getBytes("UTF-8"));  
%>
