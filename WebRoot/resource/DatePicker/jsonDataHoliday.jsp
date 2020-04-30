<%@ page language="java" import="java.util.*,java.lang.*,java.sql.*" pageEncoding="UTF-8" contentType="text/json; charset=UTF-8"%>
<%@ page import="net.tool.*,net.sf.json.*,com.util.*" %>
<%
String year = request.getParameter("year");
if (year == null || "".equals(year)){
	java.util.Date d = new java.util.Date();
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy");
	year = sdf.format(d);
}

java.sql.Connection con=null;
java.sql.PreparedStatement pstmt = null;
java.sql.ResultSet rs=null;
List<JSONObject> holidayList = new ArrayList<JSONObject>();
try{
	con=BaseDao.getJDBCConnection();
	String sql = "SELECT STMT_DAY,HOLIDAY_TYPE,HOLIDAY_NAME,HOLIDAY_NAME_ASCII FROM TBL_HOLIDAY ";
				//+ " WHERE SUBSTR(STMT_DAY, 1, 4) = ?";
	pstmt = con.prepareStatement(sql);
	//pstmt.setString(1,year);
	rs = pstmt.executeQuery();
	while (rs.next()){
		JSONObject _holiday = new JSONObject();
		_holiday.put("STMT_DAY",rs.getString("STMT_DAY"));
		_holiday.put("HOLIDAY_TYPE",rs.getString("HOLIDAY_TYPE"));
		_holiday.put("HOLIDAY_NAME_ASCII",rs.getString("HOLIDAY_NAME_ASCII"));
		_holiday.put("HOLIDAY_NAME",rs.getString("HOLIDAY_NAME"));
		holidayList.add(_holiday);
	}
}catch(Exception e){
	e.printStackTrace();
}finally{
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
response.getOutputStream().write(holidayList.toString().getBytes("UTF-8"));  
%>
