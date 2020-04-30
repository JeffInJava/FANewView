<%@ page language="java" import="java.util.*,java.lang.*,com.util.*,net.sf.json.*,java.text.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>参数设置</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script src="resource/anime/jquery-1.11.1.min.js"></script> 
  </head>
  
  <body>
    
    <form id="form1">
     	工作日折扣：<input type="text" name="workDay" id="workDay"/><br><br>
     	节假日折扣：<input type="text" name="holiDay" id="holiDay"/><br><br>
     	自定义折扣：<input type="text" name="selfVal" id="selfVal"/><br><br>
     	入馆客流：<input type="text" name="selfTimes" id="selfTimes"/><br><br><br>
     	
     	徐泾东进站预测客流：<input type="text" name="xjdEnTimes" id="xjdEnTimes"/>&nbsp;出站预测客流：<input type="text" name="xjdExTimes" id="xjdExTimes"/><br><br>
     	诸光路进站预测客流：<input type="text" name="zglEnTimes" id="zglEnTimes"/>&nbsp;出站预测客流：<input type="text" name="zglExTimes" id="zglExTimes"/><br><br>
     	虹桥火车站进站预测客流：<input type="text" name="hqEnTimes" id="hqEnTimes"/>&nbsp;出站预测客流：<input type="text" name="hqExTimes" id="hqExTimes"/><br><br><br>
     	
     	徐泾东去年同期进站客流：<input type="text" name="xjdEnTimesCp" id="xjdEnTimesCp"/>&nbsp;去年同期出站客流：<input type="text" name="xjdExTimesCp" id="xjdExTimesCp"/><br><br>
     	诸光路去年同期进站客流：<input type="text" name="zglEnTimesCp" id="zglEnTimesCp"/>&nbsp;去年同期出站客流：<input type="text" name="zglExTimesCp" id="zglExTimesCp"/><br><br>
     	虹桥火车站去年同期进站客流：<input type="text" name="hqEnTimesCp" id="hqEnTimesCp"/>&nbsp;去年同期出站客流：<input type="text" name="hqExTimesCp" id="hqExTimesCp"/><br><br>
     	
    	<input type="button" value="更新" onclick="updateData()">
    </form>
    <script type="text/javascript">
	    function updateData(){
	    	$.post("jinbo/updateParam.action",$("#form1").serialize(),function(dt){
	    		location.href="pages/jinbo/updateMs.jsp?flag=sc";
	    	});
	    }
	    initData();
	    function initData(){
	    	$.post("jinbo/updateParam.action",{"flag":"sel"},function(dt){
	    		$("#workDay").val(dt[0].WORKDAY_VAL);
	    		$("#holiDay").val(dt[0].HOLIDAY_VAL);
	    		$("#selfVal").val(dt[0].SELF_VAL);
	    		
	    		$("#selfTimes").val(dt[0].SELF_TIMES);
	    		
	    		$("#xjdEnTimes").val(dt[0].XJD_EN_TIMES);
	    		$("#xjdExTimes").val(dt[0].XJD_EX_TIMES);
	    		$("#zglEnTimes").val(dt[0].ZGL_EN_TIMES);
	    		$("#zglExTimes").val(dt[0].ZGL_EX_TIMES);
	    		$("#hqEnTimes").val(dt[0].HQ_EN_TIMES);
	    		$("#hqExTimes").val(dt[0].HQ_EX_TIMES);
	    		
	    		$("#xjdEnTimesCp").val(dt[0].XJD_EN_TIMES_CP);
	    		$("#xjdExTimesCp").val(dt[0].XJD_EX_TIMES_CP);
	    		$("#zglEnTimesCp").val(dt[0].ZGL_EN_TIMES_CP);
	    		$("#zglExTimesCp").val(dt[0].ZGL_EX_TIMES_CP);
	    		$("#hqEnTimesCp").val(dt[0].HQ_EN_TIMES_CP);
	    		$("#hqExTimesCp").val(dt[0].HQ_EX_TIMES_CP);
	    	});
	    }
    </script>
  </body>
</html>
