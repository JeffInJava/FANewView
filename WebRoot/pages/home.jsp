<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html lang="zh-cn">
	<head>
		<%@ include file="/WEB-INF/common_inc/head.inc"%>
		<title>公告版</title>
	</head>

	<body>
		
		
		<%@ include file="/WEB-INF/common_inc/foot.inc"%>
		
		<!-- inline scripts related to this page -->
		<script type="text/javascript">
		
			
			$(document).ready(function(){
			
				//获取用户信息
				initUserPhoto();
				openInnerPage("index.jsp");

				var hash = location.hash.replace(/^#/, "");
				if(!hash){
					setTimeout(function(){
						openInnerPage("pages/main/main.jsp");
					}, 1000);
				}
			});
			
			//获取用户信息
			function initUserPhoto(){
				getUserInfo(function(userInfo){
					var trueName = userInfo.trueName;
					var orgName = userInfo.basOrg ? userInfo.basOrg.orgName : "";
					var sex = userInfo.sex == "女" ? 0 : 1;
					var photos = ["user_female.png", "user_male.png"];
					$(".nav-user-photo").attr("src", "resource/inesa/images/common/" + photos[sex]);
					$(".user-info .username").html(trueName);
					$(".user-info .orgname").html(orgName);
				});				
			}
			
		</script>		
	</body>
</html>
