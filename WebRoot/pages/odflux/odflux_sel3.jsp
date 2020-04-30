<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
  <head>
    <base href="<%=basePath%>">
    <title>返程客流走向图</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" href="resource/font-awesome/css/font-awesome.min.css">
	<script src="resource/jquery/js/jquery-1.7.2.js"></script>
	<script src="resource/svg/jquery.mousewheel.min.js"></script>
	<script src="resource/svg/snap.svg-min.js"></script>
	<script src="resource/inesa/js/common.js"></script>
	<script src="resource/svg/anime.min.js"></script>
	<style type="text/css">
		.motion-path {
		  position: relative;
		  width: 256px;
		  margin: auto;
		}
		
		.follow-path {
		    position: absolute;
		    top: -9px;left: -9px;
		}
		
		.small {
		  width: 18px;
		  height: 2px;
		}
    </style>
  </head>
  
  <body>
  	  
	  <div>
		 <div class="motion-path">
		    <div id="tt" class="small square el follow-path" style="background-color: black;"></div> 
		    <div id="tt1" class="small square el follow-path" style="background-color: black;"></div> 
		    <svg width="256" height="132" viewBox="0 0 256 132">
		        <path id="motionPath" fill="none" stroke="currentColor" stroke-width="1" d="M8,56 C8,33.90861 25.90861,16 48,16 C70.09139,16 88,33.90861 88,56 C88,78.09139 105.90861,92 128,92 C150.09139,92 160,72 160,56 C160,40 148,24 128,24 C108,24 96,40 96,56 C96,72 105.90861,92 128,92 C154,93 168,78 168,56 C168,33.90861 185.90861,16 208,16 C230.09139,16 248,33.90861 248,56 C248,78.09139 Z"></path>
		    
		    	<path id="motionPath1" fill="none" stroke="currentColor" stroke-width="1" d="M8,86 C8,63.90861 25.90861,46 48,46 C70.09139,46 88,63.90861 88,86 C88,108.09139 105.90861,122 128,122 C150.09139,122 160,102 160,86 C160,70 Z"></path>
		    
		    </svg> 
		 </div>
	  </div>

      <script type="text/javascript">
      	var path = anime.path('#motionPath');
		anime({
		  targets: '#tt',
		  translateX: path('x'),
		  translateY: path('y'),
		  rotate: path('angle'),
		  easing: 'linear',
		  duration: 2000,
		  loop: true
		});
		
		
		path = anime.path('#motionPath1');
		anime({
		  targets: '#tt1',
		  translateX: path('x'),
		  translateY: path('y'),
		  rotate: path('angle'),
		  easing: 'linear',
		  duration: 2000,
		  loop: true
		});
		
      </script>
  </body>
</html>