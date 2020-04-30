<%@ page language="java" import="java.util.*,java.lang.*,com.util.*,net.sf.json.*,java.text.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>参数设置结果</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%	
		String flag=request.getParameter("flag");
	%>
  </head>
  
  <body>
    <div id="massageId" style="font-size: 14px;font-weight:bold;margin:50px 40px;">
    	<%="sc".equals(flag)?"更新成功":"更新失败" %>
    </div>
    <div style="font-size: 14px;font-weight:bold;margin:50px 40px;">
    	<input type="button" value="返回" onclick="javascript:location.href='pages/jinbo/update.jsp';">
    </div>
  </body>
</html>
