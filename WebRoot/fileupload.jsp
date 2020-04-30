<%@ page language="java"
	import="java.util.*,java.lang.*,net.sf.json.*,java.sql.*,java.text.*,java.io.*"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title>文件上传导入</title>
</head>
<body>

	<form method="post" action="csv/upload.action"
		enctype="multipart/form-data">
		<br><br><br>
		
		<div style="text-align:center">
		<h2>文件上传</h2>
			<table border="0" cellpadding="15" cellspacing="0"
				style="width: 40%;margin:auto">
				<tr>
					<td>选择要上传的文件：<input type="file" name="uploadFile" id="uploadFile" /><br /></td>
					<td><input type="submit" value="提交" /></td>
				</tr>
			</table>
		</div>
	</form>

</body>
</html>
