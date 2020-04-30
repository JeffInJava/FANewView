<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
  <head>
    <base href="<%=basePath%>">
    <title>业务监控</title>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link rel="stylesheet" href="resource/font-awesome/css/font-awesome.min.css">
	<link rel="stylesheet" href="resource/element-ui/index.css" />
	
	<script src="resource/jquery/js/jquery-1.9.1.min.js"></script>
	<script src="resource/svg/jquery.mousewheel.min.js"></script>
	<script src="resource/svg/snap.svg-min.js"></script>
	<script src="resource/js/common.js"></script>
	<script src="resource/svg/snap.svg.zpd.js"></script>
	<script src="resource/anime/anime.min.js"></script>
	
	<script src="resource/vue/vue.min.js"></script>
    <script src="resource/element-ui/index.js"></script>
    
    <script src="resource/echarts3/echarts.min.js"></script>
    
	<style type="text/css">
    	html,body {
      		margin:0;
			padding:0;
			width: 100%;
    		height: 100%;
	 		overflow: hidden;
	 		font-family:'SimHei';
	 		color:#fff;
   		}
   		svg{
   			height:100%; 
   		}
		
		.downpath{
          	stroke-dasharray:10;
          	stroke-dashoffset:1000;
          	animation: dash 30s linear both infinite;
        }

        @keyframes dash {
          to {
            stroke-dashoffset: 0;
          }
        }

    </style>
  </head>
  
  <body style="background-color:rgba(20,38,56,1);">
  	
    <script type="text/javascript">
      	
      
      //http://gallery.echartsjs.com/editor.html?c=xrkfewyjjG
      //http://gallery.echartsjs.com/editor.html?c=xxcSZEgsPX
      
      //http://wow.techbrood.com/fiddle/25302
      //http://www.17sucai.com/pins/tag/14805.html
      
      
     	var s;
     	var svg;
     	$(function(){
     		//加载svg文件
     		loadSvg();
     	});
     	
     	//加载数据并显示对应的动画效果
     	function loadDataAddAnime(){
     		var paths=["psc","plc","pacc","ppulish","pqfDeal","ppackage","pftp","pdatabase","phttp","ppw","prunqian"];
     		$.post("monitor/get_monitordata.action",function(dt){
     			if(dt.pacc&&dt.pacc.length>0){
     				addAnime("#pacc","#FF0000");
     				paths.splice($.inArray('pacc',paths),1);
     			}
     			if(dt.ppulish&&dt.ppulish.length>0&&dt.ppulish[0].NUMS>0){
     				addAnime("#ppulish","#FF0000");
     				paths.splice($.inArray('ppulish',paths),1);
     			}
     			if(dt.pqfDeal&&dt.pqfDeal.length>0&&dt.pqfDeal[0].CODE_VALUE!="0"){
     				addAnime("#pqfDeal","#FF0000");
     				paths.splice($.inArray('pqfDeal',paths),1);
     			}
     			if(dt.ppackage&&dt.pqfDeal.ppackage>0){
     				$.each(dt.ppackage,function(i,v){
     					if((v.PROC_ST==2&&v.TIMES>30)||v.PROC_ST==6){
     						addAnime("#ppackage","#FF0000");
     						paths.splice($.inArray('ppackage',paths),1);
     						return;
     					}
     				});
     			}
     			if(dt.pdatabase&&dt.pdatabase.length>0){
     				addAnime("#pdatabase","#FF0000");
     				paths.splice($.inArray('pdatabase',paths),1);
     			}
     			if(dt.phttp!=200){
     				addAnime("#phttp","#FF0000");
     				paths.splice($.inArray('phttp',paths),1);
     			}
     			
     			$(".downpath").remove();
     			$.each(paths,function(i,v){
			    	var tp1=$("#"+v);
				    var tp3=tp1.clone().attr({"id":v+"Bk","class":"downpath"}).css({"stroke-width":"3","stroke":"#00FF00"});
	    			tp1.after(tp3);
			    });
     		});
     	}
     	
     	//添加动画
     	function addAnime(pid,cor){
     		$(pid).css("stroke",cor);
     		anime({
			  targets:pid,
			  stroke: [
	   			{value: 'rgba(19,37,56,1)'},
	   			{value:cor}
			  ],
			  easing: 'linear',
	 			  direction: 'alternate',
	             duration: 1000,
	             loop: true
		   });
     	}
     	
     	//加载svg文件
     	function loadSvg(){
			if($("svg")){
     			$("svg").remove();
     		}
     		s = Snap();
     		//加载svg文件
     		Snap.load("pages/monitor/business.svg", function (f) {
     			svg = f.select("svg").select("g");
    			s.append(svg);
			    //设置鼠标拖拽、滚动图像进行放大和缩小
			    s.zpd();
			    s.panTo('+100', '0');
			    
			    //加载数据并显示对应的动画效果
			    loadDataAddAnime();
			    setInterval('loadDataAddAnime()',600000);
		    });
     		
     	}
     	
      	
      </script>
  </body>
</html>