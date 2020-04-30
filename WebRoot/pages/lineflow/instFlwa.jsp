<%@ page language="java" import="java.util.*,java.lang.*,com.util.*,net.sf.json.*,java.text.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>

<!DOCTYPE html>
<html>
<head>
	<title>dashboard</title>
	<base href="<%=basePath%>">
	<%--	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">--%>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0"/>
	
	<script src="resource/jquery/js/jquery-1.7.2.js" type="text/javascript"></script>
	<script src="resource/inesa/js/common.js"></script>
	<script src="resource/echarts3/echarts.min.js"></script>
	<script src="resource/echarts3/d3.v4.min.js"></script>
	<script src="resource/echarts3/highchartse.js"></script>
	<!-- <script src="http://code.highcharts.com/highcharts.js"></script> -->
	<style type="text/css">
		 .mainApp {
            position: absolute;
            height: 100%;
            width: 100%;
            color: #fff;
            overflow: hidden;
	 		
            
        }

        html, body, div, span, applet, object, iframe, h1, h2, h3, h4, h5, h6, p, blockquote, pre, a, abbr, acronym, address, big, cite, code, del, dfn, em, img, ins, kbd, q, s, samp, small, strike, strong, sub, sup, tt, var, b, u, i, center, dl, dt, dd, ol, ul, li, fieldset, form, label, legend, table, caption, tbody, tfoot, thead, article, aside, canvas, details, embed, figure, figcaption, footer, header, menu, nav, output, ruby, section, summary, time, mark, audio, video, input {
            margin: 0;
            padding: 0;
            border: 0;
            font-weight: normal;
            vertical-align: baseline;
        }

        div {
            display: block;
        }

        *[data-v-0b39df2e] {
            box-sizing: border-box;
        }

        .point[data-v-0b39df2e],
        .multipleColumn[data-v-0b39df2e],
        .columnChart[data-v-0b39df2e],
        .line[data-v-0b39df2e] {
            height: 100% !important;
            width: 100% !important;
            background: none !important;
        }

        .item[data-v-0b39df2e] {
            padding: 0px;
            margin: 0px;
            width: 62%;
            height: 100%;
            position: absolute;
            transform: scale(0.33);
            transition: all 0.8s;

        }

        #my {
            width: 100%;
            height: 100%;
            background-image: url("resource/images/ncbg.png");
            background-size: 100% 100%;
            position: absolute;
        }

        .dashboard[data-v-0b39df2e] {
            position: relative;
            width: 100%;
            height: 100%;
            margin: 0px;
            padding: 0px;
            padding: 2% 0;
            background-image: url("resource/images/ncbg.png");
            background-size: 100% 100%;
            background-repeat: no-repeat;

        }

        .flex-container.column[data-v-0b39df2e] {
            position: relative;
            height: 100%;
            width: 100%;
            overflow: hidden;
            margin: 0 auto;
            z-index: 10;
            box-sizing: content-box;
        }

        .active[data-v-0b39df2e] {
            height: 100%;
            width: 84%;
            line-height: 300px;
        }

        .filter {
            top: 0px;
            position: relative;
            width: 1500px;
            margin-left: -1%;

            position: relative;
            display: -ms-flexbox;
            display: flex;
            padding-left: 5px;
            line-height: 11px;
            color: #fff;
            z-index: 2;
            font-family: 'Open Sans';
            font-size: 13px;
        }

        .main {
            width: 100%;
            height: calc(100% - 30px);
        }

        .srank {
          margin-left: 15px;
            margin-bottom: 12px;
            width: 1200px;
            height: 490px;
        }
        .sranks {
            margin-left: 4%;
            margin-top: 15%;
            margin-bottom: 20px;
            width: 1600px;
            height: 700px;
        }
        .filters {
            top: 0px;
            margin-left: -3%;
            position: relative;
            display: -ms-flexbox;
            display: flex;
            padding-left: 5px;
            line-height: 11px;
            color: #fff;
            z-index: 2;
            font-family: 'Open Sans';
            font-size: 13px;
        }

        .btns {
            color: #fff;
            margin-left: 95px;
            width: 60px;
            height: 42px;
            text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25);
            background-color: #1134A8;
            text-align: center;
            border-radius: 4px;
            padding: 2px 10px;
            margin-bottom: 0;
            font-size: 14px;
        }

       .searchbtns {
  
            width: 71px;
            height: 30px;
            color: #fff;
            text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25);
            background-color: #1134A8;
            text-align: center;
            border-radius: 9px;
            padding: 2px 15px;
            margin-left: 3px;
            margin-bottom: 0;
            font-size: 15px;
        }

        .btn, .searchbtn {
            margin-left: 60px;
            width: 60px;
            height: 42px;
            color: #fff;
            text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25);
            background-color: #1134A8;
            text-align: center;
            border-radius: 8px;
            padding: 2px 15px;
            margin-bottom: 0;
            font-size: 15px;
        }

        .prm {
            width: 100%;
            font-size: 15px;
            vertical-align: bottom;
            margin-left: 15px;
            display: none;
            float: left;
        }

        .prm input, .prm select {
            border: 1px solid #2f96b4;
            font-size: 15px;
        }

        .tab {
            float: right;
            margin-left: 10px;
            height: 45px;
            width: 450px;
            background-image: url(resource/images/swchbg.png);
            color: #fff;
            background-size: 80% 90%;
            background-repeat: no-repeat;

            color: #fff;
        }
 .tabs {
            float: right;
            margin-left: 10px;
            height: 45px;
            width: 1000px;
            margin-left: 45px;
            color: #fff;
            background-size: 80% 90%;
            background-repeat: no-repeat;

            color: #fff;
        }
        .tab span {
            margin: 3px 30px 3px 30px;
            height: 35px;
            width: 60px;
            float: left;
            font-size: 15px;
            display: block;
            text-align: center;
            line-height: 36px;
            border-radius: 8px;
            background-color: #1134A8;

        }

        .tab .act {
            background: #3887FF;
        }

        div.tip-hill-div {
            position: relative;
            z-index: 999;
            opacity: 0.8;
            background: black;
            color: #fff;
            padding: 10px;
            border-radius: 5px;
            font-family: Microsoft Yahei;
        }

        div.tip-hill-div > h1 {
            padding-left: 7px;
            font-size: 15px;
        }

        div.tip-hill-div > h2 {
            padding-left: 7px;
            font-size: 16px;
        }
		.sranka {
    margin-left: 5%;
    margin-top: 15%;
    margin-bottom: 12px;
    width: 100%;
    height: calc(100% - 250px);
}
	</style>
</head>
	<%
		String fir_date="";
  	String sec_date="";
  	String week_date="";
  	SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
  	Calendar calendar = Calendar.getInstance(); 
    calendar.setTime(new java.util.Date());
    
		calendar.add(Calendar.DAY_OF_MONTH, -2);  
		sec_date=df.format(calendar.getTime());
	
    
        calendar.add(Calendar.DAY_OF_MONTH, -1);  
        fir_date=df.format(calendar.getTime());
        
        calendar.add(Calendar.DAY_OF_MONTH, -4);  
        week_date=df.format(calendar.getTime());
	%>
	<body>
<div class="mainApp">
               
                <div data-v-c5b8f8b4 data-v-0b39df2e class="point" id="zf">

                    <div id="mainChartZF" class="srank" style=""></div>

                    <div data-v-c5b8f8b4 class="filter">
                        <input type="button" value=">>" class="btn" style="font-weight: bold">
			<div class="tabs">
			                <input  id="l00" type="button" value="全路网" class="searchbtns" style="color:#666666;background-color: #FFFFFF">
                            <input  id="l1" type="button" value="1" class="searchbtns" style="background-color: #ED3229">
                            <input id="l2" type="button" value="2" class="searchbtns" style="background-color: #36B854">
                            <input id="l3" type="button" value="3" class="searchbtns" style="background-color: #FFD823">
                            <input id="l4" type="button" value="4" class="searchbtns" style="background-color: #320176">
                            <input id="l5" type="button" value="5" class="searchbtns" style="background-color: #823094">
                            <input id="l6" type="button" value="6" class="searchbtns" style="background-color: #CF047A">
                            <input id="l7" type="button" value="7" class="searchbtns" style="background-color: #F3560F">
                            <input id="l8" type="button" value="8" class="searchbtns" style="background-color: #008CC1">
                            <input id="l9" type="button" value="9" class="searchbtns" style="background-color: #91C5DB">
                            <input id="l10" type="button" value="10" class="searchbtns" style="background-color: #C7AFD3">
                            <input id="l11" type="button" value="11" class="searchbtns" style="background-color: #842223">
                            <input id="l12" type="button" value="12" class="searchbtns" style="margin-top: 5px;background-color: #007C64">
                            <input id="l13" type="button" value="13" class="searchbtns" style="margin-top: 5px;background-color: #DC87C2">
                            <input id="l16" type="button" value="16" class="searchbtns" style="background-color: #33D4CC">
                            <input id="l17" type="button" value="17" class="searchbtns" style="background-color: #BC7970">
                            <input id="l18" type="button" value="浦江线" class="searchbtns" style="background-color: #DDDDDD">
                        </div>

                        <div class="prm">
                            对比日期1：<input type="text" name="start_date" id="start_date2" value="<%=fir_date %>"
                                        style="width:70px;height: 25px">
                                         对比日期2：<input type="text" name="start_date" id="comp_date" value="<%=sec_date %>"
                                        style="width:70px;height: 25px">

                     
                            <input type="button" value="查询" onclick="searchLineRankData()" class="searchbtn">
                        </div>

                    </div> 
                </div>

           
  
</div>
<script type="text/javascript">
    var chartStationRank, chartZFRank, chartZLRank, chartPeriodCom;
    $(function () {

        $('body').css('zoom', 'reset');
        $(document).keydown(function (event) {

            if ((event.ctrlKey === true || event.metaKey === true)
                    && (event.which === 61 || event.which === 107
                    || event.which === 173 || event.which === 109
                    || event.which === 187 || event.which === 189)) {
                event.preventDefault();
            }
        });

        $(window).bind('mousewheel DOMMouseScroll', function (event) {
            if (event.ctrlKey === true || event.metaKey) {
                event.preventDefault();
            }

        });

        //加载线路车站
         //loadLineAndStation();
 		makedate();
       loadLineRankData();
     

        //显示或隐藏查询条件
        $(".btns").click(function () {
            if (this.value == ">>") {
                $(".prm").show();
                $(".tab").hide();
                this.value = "<<";
            } else if (this.value == "<<") {
                $(".prm").hide();
                $(".tab").show();
                this.value = ">>";
            }
        });
        //显示或隐藏查询条件
          //显示或隐藏查询条件
        
        $(".btn").click(function () {
            if (this.value == ">>") {

                $(".prm").show();

                
                    $('.tabs').hide();
                
                    this.value = "<<";

            } else if (this.value == "<<") {
                $(".prm").hide();
                
                    $('.tabs').show();
                




                this.value = ">>";
            }
        });


    });


  

  
   
    //使用d3.js绘制图表


    var margin = {
        top: 30,
        right: 50,
        bottom: 60,
        left: 100
    };

    var svgWidth = 800;
    var svgHeight = 500;

    //创建各个面的颜色数组
    var mainColorList = ['#f6e242', '#ebec5b', '#d2ef5f', '#b1d894', '#97d5ad', '#82d1c0', '#70cfd2', '#63c8ce', '#50bab8', '#38a99d'];
    var topColorList = ['#e9d748', '#d1d252', '#c0d75f', '#a2d37d', '#83d09e', '#68ccb6', '#5bc8cb', '#59c0c6', '#3aadab', '#2da094'];
    var rightColorList = ['#dfce51', '#d9db59', '#b9d54a', '#9ece7c', '#8ac69f', '#70c3b1', '#65c5c8', '#57bac0', '#42aba9', '#2c9b8f'];


    
    //线路切换
     $('#l1').click(function(){
     		var line='01';
     		 tname="1号线实时累积客流";
     		swhLineRankData(line);
    });
	
    $('#l2').click(function(){
       	var line='02';
     		 tname="2号线实时累积客流";
     		swhLineRankData(line);
    });
    $('#l3').click(function(){
        	var line='03';
     		 tname="3号线实时累积客流";
     		swhLineRankData(line);
    });
    $('#l4').click(function(){
       	var line='04';
     		 tname="4号线实时累积客流";
     		swhLineRankData(line);
    });
    $('#l5').click(function(){
         	var line='05';
     		 tname="5号线实时累积客流";
     		swhLineRankData(line);
    });
    $('#l6').click(function(){
        	var line='06';
     		 tname="6号线实时累积客流";
     		swhLineRankData(line);
    });
    $('#l7').click(function(){
       	var line='07';
     		 tname="7号线实时累积客流";
     		swhLineRankData(line);
    });
    $('#l8').click(function(){
         	var line='08';
     		 tname="8号线实时累积客流";
     		swhLineRankData(line);
    });
    $('#l9').click(function(){
        	var line='09';
     		 tname="9号线实时累积客流";
     		swhLineRankData(line);
    });
    $('#l10').click(function(){
         	var line='10';
     		 tname="10号线实时累积客流";
     		swhLineRankData(line);
    });
    $('#l11').click(function(){
        	var line='11';
     		 tname="11号线实时累积客流";
     		swhLineRankData(line);
    });
    $('#l12').click(function(){
         	var line='12';
     		 tname="12号线实时累积客流";
     		swhLineRankData(line);
    });
    $('#l13').click(function(){
        	var line='13';
     		 tname="13号线实时累积客流";
     		swhLineRankData(line);
    });
    $('#l16').click(function(){
        	var line='16';
     		 tname="16号线实时累积客流";
     		swhLineRankData(line);
    });
    $('#l17').click(function(){
         	var line='17';
     		 tname="17号线实时累积客流";
     		swhLineRankData(line);
    });
    $('#l18').click(function(){
        	var line='41';
     		 tname="浦江线实时累积客流";
     		swhLineRankData(line);
    });
    $('#l00').click(function(){
    		var line='all';
     		 tname="全路网实时累积客流";
     		swhLineRankData(line);
    })
   //加载单个线路客流排名数据
var coloro,colorin,pmtp,datas,tpa,start_date,comp_date,leng,tname,line;
    function loadLineRankData() {
    ptmp='czpm';
        $(".prm").hide();
         $(".btn").val(">>");
         $(".tabs").show();
			var leng=[];
		
         start_date = $("#start_date2").val();//选择日期
         comp_date = $("#comp_date").val();//选择日期
      	 line="all";
      	 lined='all';
        tname="全路网实时累积客流";
      $.post("pasflw/getime_paflws.action",{"fir_date":start_date,"sec_date":comp_date,"lineId":line}, function(data){
		  		if(myChart){
		  		myChart.clear();
		  		}
		  				
		  				datas=data;
		  		 
			initChart();

        });

      
    }
    function searchLineRankData() {
    ptmp='czpm';
        $(".prm").hide();
         $(".btn").val(">>");
         $(".tabs").show();
			var leng=[];
		
         start_date = $("#start_date2").val();//选择日期
         comp_date = $("#comp_date").val();//选择日期
      	 line="all";
      	 lined='all';
        tname="全路网实时累积客流";
      $.post("pasflw/getime_paflws.action",{"fir_date":start_date,"sec_date":comp_date,"lineId":line}, function(data){
		  		if(myChart){
		  		myChart.clear();
		  		}
		  				
		  				datas=data;
		  		 callparent("fsflw",datas);
			initChart();

        });

      
    }
    function upLineRankData(firdate,secdate) {
    ptmp='czpm';
        $(".prm").hide();
         $(".btn").val(">>");
         $(".tabs").show();
			var leng=[];
			$("#start_date2").val(firdate);	
				$("#comp_date").val(secdate);	
         start_date = $("#start_date2").val();//选择日期
         comp_date = $("#comp_date").val();//选择日期
      	 line="all";
      	 lined='all';
        tname="全路网实时累积客流";
      $.post("pasflw/getime_paflws.action",{"fir_date":start_date,"sec_date":comp_date,"lineId":line}, function(data){
		  		if(myChart){
		  		myChart.clear();
		  		}
		  				
		  				datas=data;
		  		 callparent("fsflw",datas);
			initChart();

        });

      
    }
    function callparent(type,params){
    	parent.notifyifram(type,params);
    }
      //判断当前时间 产生日期
		  var adate;var aweekdate;var firdate;var secdate;
		 function makedate(){
		  		var datesc =  Date.now();
		  		var date;
		  		date= new Date(parseInt(Date.now()));
               var nowHours= new Date().getHours().toString();       //获取当前小时数(0-23)
               if(nowHours >= 0 && nowHours <= 2){
                		this.hournow=nowHours;
                		
                	
                	 var sed=datesc- 3600 * 1000 * 24;
                	 
                	  date=new Date(parseInt(sed));
                		console.log('当前修改天：'+date);
                		 }
                var year = date.getFullYear();
               console.log('当前修改年：'+year); 
                var month = (date.getMonth() + 1).toString();;
                console.log('当前修改月：'+month); 
                var strDate = date.getDate().toString();
                 if(month >= 1 && month <= 9){
                    month = "0" + month;
                }
                 
                if (strDate >= 0 && strDate <= 9) {
                    strDate = "0" + strDate;
                }
                 console.log('当前修改ri：'+strDate); 
                  if(nowHours >= 0 && nowHours <= 2){
                 	var cpyear=new Date(parseInt(datesc- 3600 * 1000 * 24*8)).getFullYear();
                var cpDate=new Date(parseInt(datesc- 3600 * 1000 * 24*8)).getDate().toString();
                var cpmonth=(new Date(parseInt(datesc- 3600 * 1000 * 24*8)).getMonth() + 1).toString();
                 }else{
                 cpyear=new Date(parseInt(datesc- 3600 * 1000 * 24*7)).getFullYear();
                 cpDate=new Date(parseInt(datesc- 3600 * 1000 * 24*7)).getDate().toString();
                 cpmonth=(new Date(parseInt(datesc- 3600 * 1000 * 24*7)).getMonth() + 1).toString();
                 }
                if(cpmonth >= 1 && cpmonth <= 9){
                    cpmonth = "0" + cpmonth;
                }
                 if (cpDate >= 0 && cpDate <= 9) {
                    cpDate = "0" + cpDate;
                }
                if(nowHours >= 0 && nowHours <= 2){
                var secyear=new Date(parseInt(datesc- 3600 * 1000 * 24*3)).getFullYear();
                var secDate=new Date(parseInt(datesc- 3600 * 1000 * 24*3)).getDate().toString();
                var secmonth=(new Date(parseInt(datesc- 3600 * 1000 * 24*3)).getMonth() + 1).toString();
                
                }else{
                 secyear=new Date(parseInt(datesc- 3600 * 1000 * 24*2)).getFullYear();
                 secDate=new Date(parseInt(datesc- 3600 * 1000 * 24*2)).getDate().toString();
                 secmonth=(new Date(parseInt(datesc- 3600 * 1000 * 24*2)).getMonth() + 1).toString();
                 }
                if(secmonth >= 1 && secmonth <= 9){
                    secmonth = "0" + secmonth;
                }
                 if (secDate >= 0 && secDate <= 9) {
                    secDate = "0" + secDate;
                }
                if(nowHours >= 0 && nowHours <= 2){
                	var firyear=new Date(parseInt(datesc- 3600 * 1000 * 24*2)).getFullYear();
                var firDate=new Date(parseInt(datesc- 3600 * 1000 * 24*2)).getDate().toString();
                var firmonth=(new Date(parseInt(datesc- 3600 * 1000 * 24*2)).getMonth() + 1).toString();
                }else{
                
                  firyear=new Date(parseInt(datesc- 3600 * 1000 * 24)).getFullYear();
                firDate=new Date(parseInt(datesc- 3600 * 1000 * 24)).getDate().toString();
               firmonth=(new Date(parseInt(datesc- 3600 * 1000 * 24)).getMonth() + 1).toString();
               }
                if(firmonth >= 1 && firmonth <= 9){
                    firmonth = "0" + firmonth;
                }
                 if (firDate >= 0 && firDate <= 9) {
                    firDate = "0" + firDate;
                }
                
                console.log('对比日期修改ri：'+cpmonth); 
                var nowMin= new Date().getMinutes();     //获取当前分钟数(0-59)
                //var nowHours= new Date().getHours().toString();       //获取当前小时数(0-23)
                
                if (nowHours >= 0 && nowHours <= 9) {
                    nowHours = "0" + nowHours;
                }
                
		  		
               
                 if (nowMin >= 0 && nowMin <= 9) {
                    nowMin = "0" + nowMin;
                }
                adate=year + month + strDate;
                aweekdate=cpyear + cpmonth + cpDate;
                firdate=firyear + firmonth + firDate;
               secdate=secyear + secmonth + secDate;
                console.log('修改后日期：'+adate+'xiug'+aweekdate);
                
               	$("#start_date2").val(firdate);	
				$("#comp_date").val(secdate);	
		  
		  }
    var  lined;
function swhLineRankData(line) {
    ptmp='czpm';
        $(".prm").hide();
         $(".btn").val(">>");
         $(".tabs").show();
			var leng=[];
			
         start_date = $("#start_date2").val();//选择日期
         comp_date = $("#comp_date").val();//选择日期
      	lined=line;
        
      $.post("pasflw/getime_paflws.action",{"fir_date":start_date,"sec_date":comp_date,"lineId":line}, function(data){
		  		if(myChart){
		  		myChart.clear();
		  		}
		  				
		  				datas=data;
			initChart();

        });

      
    }
  
     
        
    	//绘制折线图
    	 var myChart;
    	 var option;
		  	function initChart(){
		  		$(".prm").hide();
        	$(".btn").val(">>");
        	
        	var cda=datas;
		  		
		    var predict_time=cda.predict_time;
    	var time_period=cda.time_period;
    	var fir_times=cda.fir_times;
    	var sec_times=cda.sec_times;
    	var today_times=cda.today_times;
    	var fir_fen_times=cda.fir_fen_times;
    	var sec_fen_times=cda.sec_fen_times;
    	var fen_times=cda.fen_times;
    	var pre_times=cda.pre_times;
    	var dates=cda.dates;
    	var total_times=cda.total_times;
    	
    	for(var i=0;i<fen_times.length;i++){
    		if(fen_times[i]<=-50){
    			fen_times[i]={
						        value :fen_times[i],
						        itemStyle:{normal: {color:'red'}}
						    }
    		}
    	}
    	
    	for(var i=0;i<today_times.length;i++){pre_times[i]=today_times[i];}
                var time_period_tp=[];
				for(var i=0;i<time_period.length;i++){
					if(time_period[i].toString().indexOf("30")>-1){
						time_period_tp.push({
					        value:time_period[i],            
					        textStyle:{fontSize:9,color: 'rgba(32,32,35,0)'}
					     });
					}
					else{
						time_period_tp.push({
					        value:time_period[i],            
					        textStyle:{fontSize:13,color: '#ffffff'}
					     });
					} 
				}
				if(lined=="all"){
					var dates1=dates[0].substring(0,4)+"/"+dates[0].substring(4,6)+"/"+dates[0].substring(6)+"("+total_times[dates[0]]+"万"+")";
				var dates2=dates[1].substring(0,4)+"/"+dates[1].substring(4,6)+"/"+dates[1].substring(6)+"("+total_times[dates[1]]+"万"+")";
				}
				else{
					var dates1=dates[0].substring(0,4)+"/"+dates[0].substring(4,6)+"/"+dates[0].substring(6)+"("+fir_times[fir_times.length-1]+"万"+")";
				var dates2=dates[1].substring(0,4)+"/"+dates[1].substring(4,6)+"/"+dates[1].substring(6)+"("+sec_times[sec_times.length-1]+"万"+")";
				}
				
				var dates3=dates[2].substring(0,4)+"/"+dates[2].substring(4,6)+"/"+dates[2].substring(6)+"("+today_times[today_times.length-1]+"万"+")";
				
				legdates=[
						dates1,dates2,dates3
				
					  ];
				
				var x_s="center";
				if(predict_time){
					x_s="50";
					
					//dates[2]=dates[2]+"  "+predict_time+"点预测("+pre_times[pre_times.length-1]+"万)";
					//dates[2]=dates[2]+"  12点预测(1023.1)";
				}
                //初始化echarts图表
               myChart = echarts.init(document.querySelector('#mainChartZF'));
				
				option = {
                		  title : {
				        text:tname,
				        x:'left',
		        		   
				        textStyle:{fontSize:22,fontWeight:'bold',color:'#FFFFFF'}
				    }, 
				    tooltip : {
				        trigger: 'axis',
				        textStyle: {fontWeight:'bold',fontSize:16,color:'orange'},
				        formatter:function (params){
							if(params.length==2){
				        		
				        		var tpstr=(params[0].name.toString().indexOf("30")>-1?params[0].name:params[0].name+":00")
						    +"<br/>"+params[0].seriesName.substring(0,10)+" "+params[0].value+"万<br/>"
							+params[1].seriesName.substring(0,10)+" "+params[1].value+"万<br/>"
							//params[2].seriesName.substring(0,10)+" "+params[2].value+"万";
				        	}
				        	
				        	else if(params.length==3){
				        		
				        		var tpstr=(params[0].name.toString().indexOf("30")>-1?params[0].name:params[0].name+":00")
						    +"<br/>"+params[0].seriesName.substring(0,10)+" "+(params[0].value)+"万<br/>"
							+params[1].seriesName.substring(0,10)+" "+params[1].value+"万<br/>"
							+params[2].seriesName.substring(0,10)+" "+params[2].value+"万";
				        	}
				      else if(params.length==4){
				      
							var tpstr=(params[0].name.toString().indexOf("30")>-1?params[0].name:params[0].name+":00")
							
						    +"<br/>"+params[0].seriesName.substring(0,10)+" "+(params[0].value)+"万<br/>"
							+params[2].seriesName.substring(0,10)+" "+params[2].value+"万<br/>"
							+params[3].seriesName.substring(0,10)+" "+params[3].value+"万";
							}
							return tpstr;
				        }
				    },
				    legend: {
					show:true,
				    	x:"center",
				    	y:'top',
					     itemGap:3,
				    	itemWidth:20,
						itemHeight:10,
				    	textStyle: {fontWeight:'bold',fontSize:14,color:'#FFFFFF'},
				        data:legdates
				    },
				   /*  legend: {
						
				    	
				    	orient: 'horizontal',
				    	x:'center',
				    	 y:'20', 
				    	icon: 'rect',
						itemGap:2,
				    	itemWidth:20,
						itemHeight:10,
				    	textStyle: {fontWeight:'bold',fontSize:10,color:'#FFFFFF'},
				        data:legdates
				    }, */
				    //calculable : true,
				     grid:{y2:45,x:75,y:50,x2:65},
				    xAxis : [
				        {
				            type : 'category',
				            axisLine: {

                                lineStyle: {

                                    type: 'solid',

                                    color:'#fff',

                                    width:'1'

                                }

                            },
				            axisLabel:{interval:0,rotate:-30,textStyle: {fontWeight:'bold',fontSize:14,color:'#FFFFFF'}},
				            scale:true,
				            boundaryGap: true,
				            data : time_period_tp
				        }
				    ],
				    yAxis : [
				        {
				            type : 'value',
                           /*  name: '单位：万人次',
                            nameTextStyle: {
                                color: '#fff',
                                fontSize :'8'
                            }, */
				           
				             splitLine:{
                                show: true,
                                lineStyle: {

                                    type: 'dashed',

                                    color:'#008769',

                                    width:'0.5'

                                }
                                },
				            axisLabel:{formatter:'{value}万',textStyle: {fontWeight:'bold',fontSize:15,color:'#FFFFFF'}}
				        }
				    ],
				    series : [
				        {
				            name:dates3,
				            type:'line',
				            symbolSize:function(param){if(param){return 2;}return 0;},
				            itemStyle:{normal: {color:'red',lineStyle: {width: 3}}},
				            data:today_times
				        },
				        {
				            name:'预测',
				            type:'line',
				            symbolSize:function(param){if(param){return 4;}return 0;},
				            itemStyle:{
				            	normal: {color:'red',lineStyle:{width: 2,type: 'dashed'}},
				            	emphasis:{color:'red',lineStyle:{width: 1,type: 'dashed'}}
				            },
				            data:pre_times
				        },
				        {
				            name:dates1,
				            type:'line',
				            symbolSize:function(param){if(param){return 2;}return 0;},
				            itemStyle:{normal: {color:'yellow',lineStyle: {width: 3}}},
				            data:fir_times
				        },
				    	{
				            name:dates2,
				            type:'line',
				            symbolSize:function(param){if(param){return 2;}return 0;},
				            itemStyle:{normal: {color:'blue',lineStyle: {width: 3}}},
				            data:sec_times
				        }
				    ]
				};
				myChart.setOption(option);
		  	}


 
    
 
  
 
   
    

 
  


   
 //延迟加载“运营日期”的数据
       /*  setTimeout(function () {
            
        }, 1000); */
  
</script>
</body>
</html>