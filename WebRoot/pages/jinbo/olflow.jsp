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
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
		
		String start_date = fmt.format(cal.getTime());//当前日期
		cal.add(Calendar.DATE, -7);
		String hb_date = fmt.format(cal.getTime());//环比日期
		
		cal = Calendar.getInstance();
		cal.add(Calendar.YEAR, -1);
		String tb_date = fmt.format(cal.getTime());//同比日期
		
		cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -1);
		String yesterday = fmt.format(cal.getTime());//昨天
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
                            对比日期1：<input type="text" name="start_date" id="start_date2" value="<%=start_date %>"
                                        style="width:70px;height: 25px">
                                         对比日期2：<input type="text" name="start_date" id="comp_date" value="<%=hb_date %>"
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
 initChart();
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
     myChart.clear();
      option.series=[];
       option.title.text="1号线在网客流";
		  		 option.series.push(
		  		   	 {
				            name:comp_date,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#32d2ca'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:datas.lineT[0].cpTimes
				        }
		  		   );
		  		   option.series.push(
		  		   	 {
				            name:start_date,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#ED3229'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:datas.lineT[0].times
				        }
		  		   );
		  		 
		  		  
		  		   myChart.setOption(option);
    });
	
    $('#l2').click(function(){
        myChart.clear();
        option.series=[];
       option.title.text="2号线在网客流";
		  		 option.series.push(
		  		   	 {
				            name:comp_date,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#32d2ca'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:datas.lineT[1].cpTimes
				        }
		  		   );
		  		   option.series.push(
		  		   	 {
				            name:start_date,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#ED3229'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:datas.lineT[1].times
				        }
		  		   );
		  		 
		  		  
		  		   myChart.setOption(option);
    });
    $('#l3').click(function(){
         myChart.clear();
         option.series=[];
       option.title.text="3号线在网客流";
		  		 option.series.push(
		  		   	 {
				            name:comp_date,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#32d2ca'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:datas.lineT[2].cpTimes
				        }
		  		   );
		  		   option.series.push(
		  		   	 {
				            name:start_date,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#ED3229'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:datas.lineT[2].times
				        }
		  		   );
		  		 
		  		  
		  		   myChart.setOption(option);
    });
    $('#l4').click(function(){
       myChart.clear();
       option.series=[];
       option.title.text="4号线在网客流";
		  		 option.series.push(
		  		   	 {
				            name:comp_date,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#32d2ca'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:datas.lineT[3].cpTimes
				        }
		  		   );
		  		   option.series.push(
		  		   	 {
				            name:start_date,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#ED3229'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:datas.lineT[3].times
				        }
		  		   );
		  		 
		  		  
		  		   myChart.setOption(option);
    });
    $('#l5').click(function(){
         myChart.clear();
         option.series=[];
       option.title.text="5号线在网客流";
		  		 option.series.push(
		  		   	 {
				            name:comp_date,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#32d2ca'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:datas.lineT[4].cpTimes
				        }
		  		   );
		  		   option.series.push(
		  		   	 {
				            name:start_date,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#ED3229'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:datas.lineT[4].times
				        }
		  		   );
		  		 
		  		  
		  		   myChart.setOption(option);
    });
    $('#l6').click(function(){
        myChart.clear();
        option.series=[];
       option.title.text="6号线在网客流";
		  		 option.series.push(
		  		   	 {
				            name:comp_date,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#32d2ca'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:datas.lineT[5].cpTimes
				        }
		  		   );
		  		   option.series.push(
		  		   	 {
				            name:start_date,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#ED3229'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:datas.lineT[5].times
				        }
		  		   );
		  		 
		  		  
		  		   myChart.setOption(option);
    });
    $('#l7').click(function(){
       myChart.clear();
       option.series=[];
       option.title.text="7号线在网客流";
		  		 option.series.push(
		  		   	 {
				            name:comp_date,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#32d2ca'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:datas.lineT[6].cpTimes
				        }
		  		   );
		  		   option.series.push(
		  		   	 {
				            name:start_date,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#ED3229'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:datas.lineT[6].times
				        }
		  		   );
		  		 
		  		  
		  		   myChart.setOption(option);
    });
    $('#l8').click(function(){
         myChart.clear();
         option.series=[];
       option.title.text="8号线在网客流";
		  		 option.series.push(
		  		   	 {
				            name:comp_date,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#32d2ca'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:datas.lineT[7].cpTimes
				        }
		  		   );
		  		   option.series.push(
		  		   	 {
				            name:start_date,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#ED3229'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:datas.lineT[7].times
				        }
		  		   );
		  		 
		  		  
		  		   myChart.setOption(option);
    });
    $('#l9').click(function(){
         myChart.clear();
         option.series=[];
       option.title.text="9号线在网客流";
		  		 option.series.push(
		  		   	 {
				            name:comp_date,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#32d2ca'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:datas.lineT[8].cpTimes
				        }
		  		   );
		  		   option.series.push(
		  		   	 {
				            name:start_date,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#ED3229'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:datas.lineT[8].times
				        }
		  		   );
		  		 
		  		  
		  		   myChart.setOption(option);
    });
    $('#l10').click(function(){
         myChart.clear();
         option.series=[];
       option.title.text="10号线在网客流";
		  		 option.series.push(
		  		   	 {
				            name:comp_date,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#32d2ca'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:datas.lineT[9].cpTimes
				        }
		  		   );
		  		   option.series.push(
		  		   	 {
				            name:start_date,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#ED3229'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:datas.lineT[9].times
				        }
		  		   );
		  		 
		  		  
		  		   myChart.setOption(option);
    });
    $('#l11').click(function(){
         myChart.clear();
         option.series=[];
       option.title.text="11号线在网客流";
		  		 option.series.push(
		  		   	 {
				            name:comp_date,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#32d2ca'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:datas.lineT[10].cpTimes
				        }
		  		   );
		  		   option.series.push(
		  		   	 {
				            name:start_date,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#ED3229'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:datas.lineT[10].times
				        }
		  		   );
		  		 
		  		  
		  		   myChart.setOption(option);
    });
    $('#l12').click(function(){
         myChart.clear();
         option.series=[];
       option.title.text="12号线在网客流";
		  		 option.series.push(
		  		   	 {
				            name:comp_date,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#32d2ca'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:datas.lineT[11].cpTimes
				        }
		  		   );
		  		   option.series.push(
		  		   	 {
				            name:start_date,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#ED3229'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:datas.lineT[11].times
				        }
		  		   );
		  		 
		  		  
		  		   myChart.setOption(option);
    });
    $('#l13').click(function(){
        myChart.clear();
        option.series=[];
       option.title.text="13号线在网客流";
		  		 option.series.push(
		  		   	 {
				            name:comp_date,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#32d2ca'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:datas.lineT[12].cpTimes
				        }
		  		   );
		  		   option.series.push(
		  		   	 {
				            name:start_date,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#ED3229'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:datas.lineT[12].times
				        }
		  		   );
		  		 
		  		  
		  		   myChart.setOption(option);
    });
    $('#l16').click(function(){
        myChart.clear();
        option.series=[];
       option.title.text="16号线在网客流";
		  		 option.series.push(
		  		   	 {
				            name:comp_date,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#32d2ca'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:datas.lineT[13].cpTimes
				        }
		  		   );
		  		   option.series.push(
		  		   	 {
				            name:start_date,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#ED3229'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:datas.lineT[13].times
				        }
		  		   );
		  		 
		  		  
		  		   myChart.setOption(option);
    });
    $('#l17').click(function(){
         myChart.clear();
         option.series=[];
       option.title.text="17号线在网客流";
		  		 option.series.push(
		  		   	 {
				            name:comp_date,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#32d2ca'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:datas.lineT[14].cpTimes
				        }
		  		   );
		  		   option.series.push(
		  		   	 {
				            name:start_date,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#ED3229'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:datas.lineT[14].times
				        }
		  		   );
		  		 
		  		  
		  		   myChart.setOption(option);
    });
    $('#l18').click(function(){
         myChart.clear();
         option.series=[];
       option.title.text="浦江线在网客流";
		  		 option.series.push(
		  		   	 {
				            name:comp_date,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#32d2ca'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:datas.lineT[15].cpTimes
				        }
		  		   );
		  		   option.series.push(
		  		   	 {
				            name:start_date,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#ED3229'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:datas.lineT[15].times
				        }
		  		   );
		  		 
		  		  
		  		   myChart.setOption(option);
    });
    $('#l00').click(function(){
    myChart.clear();
    option.series=[];
    option.title.text="全路网在网客流";
		  		//vueThis.olcharOption.legend.data=[];
		  		
		  		
		  		
		  		    option.series.push(
		  		   	 {
				            name:comp_date+"在网总客流  ",
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#32d2ca',width: 4}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:datas.lineT[16].cpalline
				        });
				        
				         option.series.push(
		  		   	 {
				            name:start_date+"在网总客流",
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#ED3229',width: 4}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:datas.lineT[16].alline
				        });  
		  		   
		  		  
		  		   myChart.setOption(option);
    })
    
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
                $("#start_date2").val(adate);	
				$("#comp_date").val(aweekdate);
               
		  
		  }
   //加载单个线路客流排名数据
var coloro,colorin,pmtp,datas,tpa,start_date,comp_date,leng;
    function loadLineRankData() {
    ptmp='czpm';
        $(".prm").hide();
         $(".btn").val(">>");
         $(".tabs").show();
			var leng=[];
			
         start_date = $("#start_date2").val();//选择日期
         comp_date = $("#comp_date").val();//选择日期
      	leng.push(start_date);
			leng.push(comp_date);
        
      $.post("lflw/GetonLineFlow.action",{"date":start_date,"compDate":comp_date}, function(data){
		  		if(myChart){
		  		myChart.clear();
		  		}
		  				
		  				datas=data;
		  		   var tim=[];
		  		  option.series=[];
		  		   for (var i=0;i<=data.times.length-1;i++){
		  		   
		  		   	var  it=data.times[i];
		  		   	
		  		   
		  		   	
		  		   		 tim.push({
				                 value: it,
				                 textStyle: {fontSize: 12, color: 'rgba(168,168,168,1)'}
				             });
		  		   
		  		   	
		  		   }
		  		   
		  		   option.xAxis[0].data=tim;
		  		   option.title.text="1号线在网客流";
		  		   option.legend.data=leng;
		  		   option.series.push(
		  		   	 {
				            name:comp_date,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#32d2ca'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:datas.lineT[0].cpTimes
				        }
		  		   );
		  		   option.series.push(
		  		   	 {
				            name:start_date,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#ED3229'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:datas.lineT[0].times
				        }
		  		   );
					myChart.setOption(option);


        });

      
    }
 function upLineRankData(olDate1,olDate2) {
    ptmp='czpm';
        $(".prm").hide();
         $(".btn").val(">>");
         $(".tabs").show();
			var leng=[];
			$("#start_date2").val(olDate1);	
				$("#comp_date").val(olDate2);
         start_date = $("#start_date2").val();//选择日期
         comp_date = $("#comp_date").val();//选择日期
      	leng.push(start_date);
			leng.push(comp_date);
        var dates={"date":start_date,"compDate":comp_date};
      $.post("lflw/GetonLineFlow.action",{"date":start_date,"compDate":comp_date}, function(data){
		  		if(myChart){
		  		myChart.clear();
		  		}
		  		var datas={"date":dates,"data":data};
		  						callparent("onlineflw",datas);
		  				
		  				datas=data;
		  		   var tim=[];
		  		  option.series=[];
		  		   for (var i=0;i<=data.times.length-1;i++){
		  		   
		  		   	var  it=data.times[i];
		  		   	
		  		   
		  		   	
		  		   		 tim.push({
				                 value: it,
				                 textStyle: {fontSize: 12, color: 'rgba(168,168,168,1)'}
				             });
		  		   
		  		   	
		  		   }
		  		   
		  		   option.xAxis[0].data=tim;
		  		   option.title.text="1号线在网客流";
		  		   option.legend.data=leng;
		  		   option.series.push(
		  		   	 {
				            name:comp_date,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#32d2ca'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:datas.lineT[0].cpTimes
				        }
		  		   );
		  		   option.series.push(
		  		   	 {
				            name:start_date,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#ED3229'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:datas.lineT[0].times
				        }
		  		   );
					myChart.setOption(option);


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
      	leng.push(start_date);
			leng.push(comp_date);
        var dates={"date":start_date,"compDate":comp_date};
      $.post("lflw/GetonLineFlow.action",{"date":start_date,"compDate":comp_date}, function(data){
		  		if(myChart){
		  		myChart.clear();
		  		}
		  		var datas={"date":dates,"data":data};
		  						callparent("onlineflw",datas);
		  				
		  				datas=data;
		  		   var tim=[];
		  		  option.series=[];
		  		   for (var i=0;i<=data.times.length-1;i++){
		  		   
		  		   	var  it=data.times[i];
		  		   	
		  		   
		  		   	
		  		   		 tim.push({
				                 value: it,
				                 textStyle: {fontSize: 12, color: 'rgba(168,168,168,1)'}
				             });
		  		   
		  		   	
		  		   }
		  		   
		  		   option.xAxis[0].data=tim;
		  		   option.title.text="1号线在网客流";
		  		   option.legend.data=leng;
		  		   option.series.push(
		  		   	 {
				            name:comp_date,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#32d2ca'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:datas.lineT[0].cpTimes
				        }
		  		   );
		  		   option.series.push(
		  		   	 {
				            name:start_date,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#ED3229'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:datas.lineT[0].times
				        }
		  		   );
					myChart.setOption(option);


        });

      
    }
     function callparent(type,params){
    	parent.notifyifram(type,params);
    }
        
    	//绘制折线图
    	 var myChart;
    	 var option;
		  	function initChart(){
		  		$(".prm").hide();
        	$(".btn").val(">>");
                //初始化echarts图表
               
               myChart = echarts.init(document.querySelector('#mainChartZF'));
				
				option = {
				    title: {
				        text: '客流折线图',
				        textStyle: { fontStyle:'normal',fontWeight:'bold',fontSize:23,color:'#FFFfff'}
				    },
				    tooltip: {
				        trigger: 'axis',
				        textStyle: {fontWeight:'bold',fontSize:15},
				        formatter:function (p){
				        	if(p.length==2){
				        	var tp_str = p[0].name + "<br/>" + p[0].seriesName + "： "+p[0].value+"万"
				        		+"<br/>"+ p[1].seriesName + "： "+p[1].value+"万";
				        	}else{
				        		var tp_str = p[0].name + "<br/>" + p[0].seriesName + "： "+p[0].value+"万";
				        		
				        	}
				        	
				        	return tp_str;
				        }
				        
				    },
				    legend: {
				    	 orient: 'horizontal', // 'vertical'
					        x: 'center', // 'center' | 'left' | {number},
					        y: 'top', // 'center' | 'bottom' | {number}
					        textStyle: {color: '#ffffff'},
				        data:leng
				    },
				    grid: {
				      
				        left: '5%',
				        right: '4%',
				        bottom: '8%'
				        //containLabel: true
				    },
				   
				    xAxis: [{
				        type: 'category',
				        boundaryGap: false,
				         axisLine: {lineStyle: {color: '#ffffff', width: 2}},
                   
				        data: []
				    }],
				    yAxis: {
				        type: 'value',
				        name: '单位：万人次',
				        nameTextStyle:{
                        color:"#FFF",
                        fontSize:'15'

                    },
                    splitLine: {lineStyle: {type: 'dashed',color:'#FFFfff',width:0.7}},
                    axisLine: {lineStyle: {color: '#FFFfff', width: 2}},
                    axisLabel: {
                        textStyle: {fontWeight: 'bold', fontSize: 13, color: '#FFFfff'}
                        
                    },
				        data: []
				    },
				    series: [
				        {
				            name:'',
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {}},
                    		areaStyle: {normal: {}},
				           // stack: '总量',
				            data:[]
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