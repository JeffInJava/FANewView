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
                            运营日期：<input type="text" name="start_date" id="start_date2" value="<%=start_date %>"
                                        style="width:70px;height: 25px">

                            <input type="checkbox" style="" name="flux_flag2" value="1" checked="checked">进
                            <input type="checkbox" name="flux_flag2" value="2">出
                            <input type="checkbox" name="flux_flag2" value="3" checked="checked">换
                            <div id="onesa" style="display: inline-block">
                                
                                <select name="station_id" id="ranking2" style="width:70px;height: 25px">
                                    <!--<option value="外高桥东北方向站">外高桥东北方向站</option>-->
                                    <option value="15">前15</option>
                                     <option value="8">前8</option>
                                    <option value="5">前5</option>
                                   
                                </select>
                            </div>
                            <input type="button" value="查询" onclick="loadLineRankData()" class="searchbtn">
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

                if(pmtp=='czpm') {
                    $('.tabs').hide();
                }
                    $(".tab").hide();
                    this.value = "<<";

            } else if (this.value == "<<") {
                $(".prm").hide();
                    $(".tab").show();
                if(pmtp=='czpm'){
                    $('.tabs').show();
                }




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
        aicolor='#FF8888';
        aocolor='#ED3229';
        line_id='01';
        line_nm='1号线';

        lineRankData(line_id, $("#ranking2").val(), datas,line_nm , tpa);
    });
    $('#l2').click(function(){
        aicolor='#99FF99';
        aocolor='#36B854';
       
        line_id='02';
        line_nm='2号线';

       lineRankData(line_id, $("#ranking2").val(), datas,line_nm , tpa);
    });
    $('#l3').click(function(){
        aicolor='#FFEE99';
        aocolor='#FFD823';
        line_id='03';
        line_nm='3号线';
        console.log(tpa);

        lineRankData(line_id, $("#ranking2").val(), datas,line_nm , tpa);
    });
    $('#l4').click(function(){
        aicolor='#B088FF';
        aocolor='#320176';
        line_id='04';
        line_nm='4号线';

        lineRankData(line_id, $("#ranking2").val(), datas,line_nm , tpa);
    });
    $('#l5').click(function(){
        aicolor='#E38EFF';
        aocolor='#823094';
        line_id='05';
        line_nm='5号线';

        lineRankData(line_id, $("#ranking2").val(), datas,line_nm , tpa);
    });
    $('#l6').click(function(){
        aicolor='#FF88C2';
        aocolor='#CF047A';
        line_id='06';
        line_nm='6号线';

        lineRankData(line_id, $("#ranking2").val(), datas,line_nm , tpa);
    });
    $('#l7').click(function(){
        aicolor='#FFBB66';
        aocolor='#F3560F';
        line_id='07';
        line_nm='7号线';

        lineRankData(line_id, $("#ranking2").val(), datas,line_nm , tpa);
    });
    $('#l8').click(function(){
        aicolor='#99BBFF';
        aocolor='#008CC1';
        line_id='08';
        line_nm='8号线';

        lineRankData(line_id, $("#ranking2").val(), datas,line_nm , tpa);
    });
    $('#l9').click(function(){
        aicolor='#CCEEFF';
        aocolor='#91C5DB';
        line_id='09';
        line_nm='9号线';

        lineRankData(line_id, $("#ranking2").val(), datas,line_nm , tpa);
    });
    $('#l10').click(function(){
        aicolor='#CCBBFF';
        aocolor='#C7AFD3';
        line_id='10';
        line_nm='10号线';

        lineRankData(line_id, $("#ranking2").val(), datas,line_nm , tpa);
    });
    $('#l11').click(function(){
        aicolor='#FF8888';
        aocolor='#842223';
        line_id='11';
        line_nm='11号线';

        lineRankData(line_id, $("#ranking2").val(), datas,line_nm , tpa);
    });
    $('#l12').click(function(){
        aicolor='#77FF00';
        aocolor='#007C64';
        line_id='12';
        line_nm='12号线';

        lineRankData(line_id, $("#ranking2").val(), datas,line_nm , tpa);
    });
    $('#l13').click(function(){
        aicolor='#FFCCCC';
        aocolor='#DC87C2';
        line_id='13';
        line_nm='13号线';

        lineRankData(line_id, $("#ranking2").val(), datas,line_nm , tpa);
    });
    $('#l16').click(function(){
        aicolor='#99FFFF';
        aocolor='#33D4CC';
        line_id='16';
        line_nm='16号线';

        lineRankData(line_id, $("#ranking2").val(), datas,line_nm , tpa);
    });
    $('#l17').click(function(){
        aicolor='#FFC0CB';
        aocolor='#BC7970';
        line_id='17';
        line_nm='17号线';

        lineRankData(line_id, $("#ranking2").val(), datas,line_nm , tpa);
    });
    $('#l18').click(function(){
        aicolor='#FFFFFF';
        aocolor='#DDDDDD';
        line_id='41';
        line_nm='浦江线';

        lineRankData(line_id, $("#ranking2").val(), datas,line_nm , tpa);
    });
   //加载单个线路客流排名数据
var coloro,colorin,pmtp,datas,tpa;
    function loadLineRankData() {
        $(".prm").hide();
         $(".btn").val(">>");
         $(".tabs").show();

        var start_date = $("#start_date2").val();//选择日期
        var flux_flag = $('input[name="flux_flag2"]:checked');//选择进出站方式
         tpa = "";
        if (flux_flag && flux_flag.length > 0) {
            $(flux_flag).each(function (i, v) {
                tpa += $(v).val();
            });
        } else {
            alert("请选择进出站方式！");
            return;
        }

        //var line_id = $("#line_id2").val();//选择线路
       // var line_nm = $("#line_id2 option:selected").text();//选择线路
	aicolor='#FF8888';
        aocolor='#ED3229';
        line_id='01';
        line_nm='1号线';
		pmtp ="czpm";
        var ranking = $("#ranking2").val();//排名
        if(ranking==''){
        	ranking=15;
        }
        
        doPost("station/get_station_fluxrank.action", {"start_date": start_date, "flux_flag": tpa}, function (data) {
             datas = data;
            lineRankData(line_id, ranking, datas, line_nm, tpa);



        //添加chang事件
       // $("#line_id2").change(function () {
        //	lineRankData($("#line_id2").val(), $("#ranking2").val(), datas, $("#line_id2 option:selected").text(), tp);
       // });
        $("#ranking2").change(function () {
        	lineRankData($("#line_id2").val(), $("#ranking2").val(), datas, $("#line_id2 option:selected").text(), tpa);
        });
        });

      
    }
		//单条线路车站排名
    var xldata,xltitle,xlcateData,xlseriData;
    function lineRankData(line_id, ranking, datas, line_nm, tp) {
        //定义数据
        console.log(ranking);
        console.log(datas);
        xldata = new Array();
        var title = "车站客流排名";
        if (tp.indexOf("1") > -1 && tp.indexOf("3") > -1 && tp.length == 2) {
            title = line_nm + "车站客流排名";
        } else if (tp.indexOf("1") > -1 && tp.length == 1) {
            title = line_nm + "车站进站客流排名";
        } else if (tp.indexOf("2") > -1 && tp.length == 1) {
            title = line_nm + "车站出站客流排名";
        } else if (tp.indexOf("3") > -1 && tp.length == 1) {
            title = line_nm + "车站换乘客流排名";
        } else {

            var tp = (tp.indexOf("1") > -1 ? "进站+" : "") + (tp.indexOf("2") > -1 ? "出站+" : "") + (tp.indexOf("3") > -1 ? "换乘+" : "");
            title = tp.substring(0, tp.length - 1);

        }

        xltitle=title;
      //X轴上的数据
        xlcateData=new Array();
       //Y轴上的数据
        xlseriData=[];
        $.each(datas, function (i, v) {
            if (v.LINE_ID == line_id && parseInt(v.RN) <= parseInt(ranking)) {
                xldata.push(datas[i]);
                xlcateData.push(v.STATION_NM);
                xlseriData.push(parseFloat((v.TIMES / 10000).toFixed(1)));
            }
        });
        $('#mainChartZF').empty();

        xlpm();
        
    }
   //绘制按单个线路的图表
    function xlpm() {
	//alert(ocolor+icolor);
    	$(".prm").hide();
        $(".btn").val(">>");
        var data=new Array();
        data=xldata;
        var title=xltitle;
        var  chart = new Highcharts.Chart({
            chart: {
               height:490,
                width:1200,
               // spacingTop: -13,  
                /* spacingRight: 10,
				spacingBottom: 105, */
				spacingLeft: 15,
                backgroundColor: 'rgba(0,0,0,0)',
               // backgroundColor: '#ff0000',
                renderTo: 'mainChartZF',
                type: 'column'
            },
            title: {

                align: 'center',
                y:15,
                text: title,
                style: {
                    fontSize: '30px',
                    fontWeight:"bold",

                    color:'#FFFFFF',
                    fontFamily: ' sans-serif'
                }
            }, 
	subtitle: {

              align: 'left',
              y:10,
              x:15,
              text: '单位：万人次',
              style: {
                  fontSize: '15px',
                  fontWeight:"bold",

                  color:'rgb(255,255,255)',
                  fontFamily: ' sans-serif'
              }
          },

            xAxis: {
                categories: xlcateData,

                labels: {
                    rotation: -30,

                    align: 'right',
                    style: {
                        fontSize: '16px',
                        fontWeight: 'bold',
                        color:'rgb(255,255,255)',
                        fontFamily: 'Verdana, sans-serif'
                    }
                }
            },
            yAxis: {
                tickWidth:1,
                gridLineWidth: 0,
                lineWidth:1,
                min: 0,
                title: {
                    text: '单位：万人次',
                    style: {
			 display:"none",
                        fontSize: '15px',
                        color:'rgb(255,255,255)',
                        fontFamily: 'Verdana, sans-serif'
                    }
                },
                labels:{
                    style: {
                        fontSize: '16px',
                        fontWeight: 'bold',
                        color:'rgb(255,255,255)',
                        fontFamily: 'Verdana, sans-serif'
                    }

        }
            },
            tooltip: {
                headerFormat: '<span style="font-size:16px;">{point.key}</span><table>',
                pointFormat: '<tr><td style="color:{series.color};padding:0;"> </td>' +
                '<td style="padding:0;font-size:17px"><b>{point.y:.2f} 万</b></td></tr>',
                footerFormat: '</table>',
                shared: true,
                useHTML: true
            },
            plotOptions: {
                column: {
                    pointWidth:40,
                    pointPadding: 0.2,
                    borderWidth: 0,
                    shadow: false,            //不显示阴影
                    dataLabels: {                //柱状图数据标签
                        enabled: true,              //是否显示数据标签
                        //color: '#FFFFFF',        //数据标签字体颜色
                        //x:-15,
                        style: {
                            fontSize: '14px',
                            color:'rgb(255,255,255)',
                            fontFamily: 'Verdana, sans-serif'
                        },
                        formatter: function () {        //格式化输出显示
                            return  this.y;
                        }
                    }
                }
            },
          credits: {
              enabled: false
          },
          legend: {
              enabled: false
          },

              series: [{
                name: 'Tokyo',
               // data: [49.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 95.6, 54.4]
                 data: xlseriData
            }]


        }, function (chart) {
            SetEveryOnePointColorc(chart);
        });

        chart.series[0].update({
            data:xlseriData
        });

    }
      //设置每一个数据点的颜色值
	var aicolor,aocolor;
    function SetEveryOnePointColorc(chart) {
        //获得第一个序列的所有数据点
        var pointsList = chart.series[0].points;
        //遍历设置每一个数据点颜色
        for (var i = 0; i < pointsList.length; i++) {
            chart.series[0].points[i].update({
                color: {
                    linearGradient: { x1: 0, y1: 0, x2: 1, y2: 0 }, //横向渐变效果 如果将x2和y2值交换将会变成纵向渐变效果
                    stops: [
                        [0, Highcharts.Color(aocolor).setOpacity(1).get('rgba')],
                        //[0, Highcharts.Color(colorArr[i]).setOpacity(1).get('rgba')],
			[0.5, Highcharts.Color(aicolor).setOpacity(1).get('rgba')],
                        //[0.5, 'rgb(255, 255, 255)'],
                        [1, Highcharts.Color(aocolor).setOpacity(1).get('rgba')]
                        //[1, Highcharts.Color(colorArr[i]).setOpacity(1).get('rgba')]
                    ]
                }
            });
        }
    }
        
    


 
    
 
  
 
   
    

 
  


   
 //延迟加载“运营日期”的数据
       /*  setTimeout(function () {
            
        }, 1000); */
  
</script>
</body>
</html>