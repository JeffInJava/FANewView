<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html lang="zh-cn">
	<head>
		<title>禁止访问</title>
	<%@include file="/WEB-INF/common_inc/head.inc" %>
	</head>
	<body>
		<!-- PAGE CONTENT BEGINS -->
	
		<div class="error-container">
			<div class="well">
				<h1 class="grey lighter smaller text-center">
					<span class="blue bigger-125">
						<i class="icon-exclamation-sign"></i>
						您无此权限
					</span>
				</h1>
	
				<hr />
				<h3 class="lighter smaller text-center">抱歉，您无权限访问当前资源</h3>
	
				<hr />
				<div class="space"></div>
	
				<div class="center">
					<a href="index.jsp" class="btn btn-primary">
						<i class="icon-desktop"></i>
						官方首页
					</a>
				</div>
			</div>
		</div><!-- PAGE CONTENT ENDS -->  

		<%@include file="/WEB-INF/common_inc/foot.inc" %>
	</body>
</html>
    	
