<%@ page language="java" import="java.util.*,java.lang.*,com.util.*,net.sf.json.*"  pageEncoding="UTF-8" %>
<jsp:useBean id="time" scope="page" class="com.bo.util.DateDemo"/>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String baseUrl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
%>
<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">
		<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
		<title>菜单</title>
		<style> 
			a{ text-decoration:none} 
			a:hover{ text-decoration:none} 
		</style>
	</head>

<body>
	<p>&nbsp;</p><p>&nbsp;</p>
	<p><a href="pages/odflux/odflux.jsp" target="_blank" >&nbsp;&nbsp;1.返程客流走向图（设置）</a></p>
	<p><a href="pages/odflux/odflux_sel.jsp" target="_blank">&nbsp;&nbsp;2.返程客流走向图（媒体部）</a></p>
	<p><a href="pages/odflux/odflux_sel1.jsp" target="_blank">&nbsp;&nbsp;3.返程客流走向图</a></p>
	<p><a href="pages/flow/dashboard.jsp" target="_blank">&nbsp;&nbsp;4.二维码客流看板</a></p>
	<p><a href="pages/flow/dashboardscreen.jsp" target="_blank">&nbsp;&nbsp;5.二维码客流看板(cocc大屏)</a></p
	<p><a href="pages/device/devicemg.jsp" target="_blank">&nbsp;&nbsp;6.全路网车站终端设备</a></p>
	<p><a href="<%=baseUrl%>/TVMView/pages/index.jsp" target="_blank">&nbsp;&nbsp;7.TVM监控</a></p>
	<p><a href="pages/staticsboard/syntheboard.jsp" target="_blank">&nbsp;&nbsp;8.综合看板</a></p>
	<p><a href="pages/staticsboard/pasgflwdtls.jsp" target="_blank">&nbsp;&nbsp;9.实时客流看板</a></p>
	<p><a href="pages/flow/onlineFlows.jsp" target="_blank">&nbsp;&nbsp;10.在线客流</a></p>
	<p><a href="pages/flow/test.jsp" target="_blank">&nbsp;&nbsp;11.AFC(媒体部)</a></p>
	<p><a href="pages/flow/cmytest.jsp" target="_blank">&nbsp;&nbsp;12.新AFC(媒体部)</a></p>
	<p><a href="pages/staticsboard/pasgflwstd.jsp" target="_blank">&nbsp;&nbsp;13.新AFC大屏(媒体部)</a></p>
	<p><a href="pages/staticsboard/pasgflwste.jsp" target="_blank">&nbsp;&nbsp;14.新AFC曲屏(媒体部)</a></p>
</body>
</html>
