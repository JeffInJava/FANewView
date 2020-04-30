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
            margin-left: 3%;
            margin-top: 15%;
            margin-bottom: 12px;
            width: 1600px;
            height: 700px;
        }
        .sranks {
           
            margin-bottom: 20px;
            width: 400px;
            height: 220px;
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
            margin-left: 95px;
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
            width: 1500px;
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
                <div data-v-c5b8f8b4 data-v-0b39df2e class="point" id="fs">
                    <div id="mainChartFS" class="sranks" style="width: 470px;height:260px"></div>

                    <%-- <div data-v-c5b8f8b4 class="filters" style="width: 1550px;">
                        <input type="button" value=">>" class="btns">

                        <div class="prm" style="margin-left: 53px">
                            运营日期:<input type="text" name="start_date" id="start_date4" value="<%=start_date %>"
                                        style="width:65px;">
                            对比日期:<input type="text" name="com_date" id="com_date4" value="<%=yesterday %>"
                                        style="width:65px;">
				 开始时间： <select name="fir_hour" id="fir_hour">

                                <option value="05" >05</option>
                                <option value="06" selected="selected">06</option>
                                <option value="07" >07</option>
                                <option value="08">08</option>
                                <option value="09" >09</option>
                                <option value="10" >10</option>
                                <option value="11" >11</option>
                                <option value="12" >12</option>
                                <option value="13" >13</option>
                                <option value="14" >14</option>
                                <option value="15" >15</option>
                                <option value="16" >16</option>
                                <option value="17" >17</option>
                                <option value="18" >18</option>
                                <option value="19" >19</option>
                                <option value="20" >20</option>
                                <option value="21" >21</option>
                                <option value="22" >22</option>
                                <option value="23" >23</option>
                                <option value="00+" >00+</option>
                                <option value="01+" >01+</option>
                                <option value="02+" >02+</option>
                                <option value="03+" >03+</option>
                            </select>
                            : <select name="fir_min" id="fir_min">
                                <option value="00" selected="selected">00</option>
                                <option value="30" >30</option>
                            </select>
                            结束时间： <select name="fir_hour" id="end_hour">

                            <option value="05" >05</option>
                            <option value="06">06</option>
                            <option value="07" >07</option>
                            <option value="08" selected="selected">08</option>
                            <option value="09" >09</option>
                            <option value="10" >10</option>
                            <option value="11" >11</option>
                            <option value="12" >12</option>
                            <option value="13" >13</option>
                            <option value="14" >14</option>
                            <option value="15" >15</option>
                            <option value="16" >16</option>
                            <option value="17" >17</option>
                            <option value="18" >18</option>
                            <option value="19" >19</option>
                            <option value="20" >20</option>
                            <option value="21" >21</option>
                            <option value="22" >22</option>
                            <option value="23" >23</option>
                            <option value="00+" >00+</option>
                            <option value="01+" >01+</option>
                            <option value="02+" >02+</option>
                            <option value="03+" >03+</option>
                        </select>
                           : <select name="fir_min" id="end_min">
                                <option value="05" >00</option>
                                <option value="35" selected="selected">30</option>
                            </select>
                            <input type="checkbox" name="flux_flag4" value="1" checked="checked">进
                            <input type="checkbox" name="flux_flag4" value="2">出
                            <input type="checkbox" name="flux_flag4" value="3" checked="checked">换
                            线路:<select name="line_id" id="line_id4" style="width:100px;"></select>
                            车站:<select name="station_id" id="station_id4" style="width:100px;"></select>
                            <input type="button" value="查询" onclick="loadFluxPeriodData()" class="searchbtns" style="margin-top: 7px">
                        </div>
                        <div class="tab">
                            <span onclick="change(this,'period_tb')">同&nbsp;比</span>
                            <span class="act" onclick="change(this,'period_hb')" id="period_hb">环&nbsp;比</span>
                            <span onclick="change(this,'period_zdy')">自定义</span>
                        </div>
                    </div> --%>


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

        loadFluxPeriodData();
      

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
         var pmtp;
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


  
//根据同环比事件加载数据
var kllx;
    function changeData(kllx) {
        // $(obj).siblings().removeClass("act");
        //$(obj).addClass("act");
        if (kllx == "zf_tb") {
            var zftb = 'zf_tb';
            zfchart(zftb);
        } else if (kllx == "zf_hb") {
            var zfhb = 'zf_hb';
            zfchart(zfhb);
        } else if (kllx == "zf_zdy") {
            var zfzdy = 'zf_zdy';
            zfchart(zfzdy);
        } else if (kllx == "zl_tb") {
            var zltb = 'zl_tb';
            zlchart(zltb);
        } else if (kllx == "zl_hb") {
            var zlhb = 'zl_hb';
            zlchart(zlhb);
        } else if (kllx == "zl_zdy") {
            var zlzdy = 'zl_zdy';
            zlchart(zlzdy);
        } else if (kllx == "period_tb") {
            periodData = periodAllData.tb_data.periodData;
            dt1 = periodAllData.tb_data.start_date;
            dt2 = periodAllData.tb_data.com_date;
            setPeriodOption(periodAllData.tb_data.periodData, periodAllData.tb_data.start_date, periodAllData.tb_data.com_date);
        } else if (kllx == "period_hb") {
            periodData = periodAllData.hb_data.periodData;
            dt1 = periodAllData.hb_data.start_date;
            dt2 = periodAllData.hb_data.com_date;
            setPeriodOption(periodAllData.hb_data.periodData, periodAllData.hb_data.start_date, periodAllData.hb_data.com_date);
        } else if (kllx == "period_zdy") {
            periodData = periodAllData.zdy_data.periodData;
            dt1 = periodAllData.zdy_data.start_date;
            dt2 = periodAllData.zdy_data.com_date;
            setPeriodOption(periodAllData.zdy_data.periodData, periodAllData.zdy_data.start_date, periodAllData.zdy_data.com_date);
        }
    }
  
   
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


   
    
      var flowPeriodOption;
    var periodData;
    var periodAllData;
    var fslx;
    var startTime;
    var endTime;
    //加载分时客流对比数据
    function loadFluxPeriodData() {
        $(".prm").hide();
        $(".btn").val(">>");
        $(".tab").show();
	
        

        var start_date = "<%=start_date %>";//选择日期
        var com_date = "<%=hb_date %>";//对比日期

        var tp ='13';

       

       
            line_id = "00";
        
        var station_id ='';//车站

        var line_nm ='00';

	     startTime='0600';
         endTime='0830';
        periodAllData = {
            title: [{
                text: '客流分时比较',
                x: 'center',
                y:'0',
                textStyle: {fontSize: 16, fontWeight: 'bolder', color: '#9EC5FF'}
            }]
        };
        var tp_title = "";
        
            periodAllData.title[0].text = tp_title + "客流分时比较";
            /* var tp_str = (tp.indexOf("1") > -1 ? "进站+" : "") + (tp.indexOf("2") > -1 ? "出站+" : "") + (tp.indexOf("3") > -1 ? "换乘+" : "");
            periodAllData.title.push({
                text: "(" + tp_str.substring(0, tp_str.length - 1) + ")",
                x: '150',
                y: '-6',
                textStyle: {fontSize: 12, color: '#FFF'}
            }); */
        
        $('#mainChartFS').empty();
        if(kllx=='period_tb'||kllx=='period_hb'||kllx=='period_zdy'){
            
        }else{
            kllx = 'period_hb';
        }
	if(kllx=='period_hb'){
            $("#period_hb").siblings().removeClass("act");
        $("#period_hb").addClass("act");
        
        };

        //同比数据
         doPost("station/get_fluxperiods.action", {
         "start_date": "<%=start_date %>",
         "com_date": "<%=tb_date%>",
	"startTime":startTime,
	"endTime":endTime,
         "sel_flag": "2",
         "flux_flag": tp,
         "line_id": line_id,
         "station_id": station_id
         }, function (data) {
         periodAllData.tb_data = {};
         periodAllData.tb_data.periodData = data;
         periodAllData.tb_data.start_date = "<%=start_date %>";
         periodAllData.tb_data.com_date = "<%=tb_date%>";
             if(kllx=='period_tb'){
                 changeData(kllx);
             }
         });

        //环比数据
           doPost("station/get_fluxperiods.action", {
         "start_date": "<%=start_date %>",
         "com_date": "<%=hb_date%>",
	    "startTime":startTime,
	    "endTime":endTime,
         "sel_flag": "2",
         "flux_flag": tp,
         "line_id": line_id,
         "station_id": station_id
         }, function (data) {
         periodData = data;
        

         periodAllData.hb_data = {};
         periodAllData.hb_data.periodData = data;
         periodAllData.hb_data.start_date = "<%=start_date %>";
         periodAllData.hb_data.com_date = "<%=hb_date%>";

         dt1 = start_date;
         dt2 = "<%=hb_date%>";
               if(kllx=='period_hb'){
                   changeData(kllx);
               }
         });

        //自定义日期数据
         doPost("station/get_fluxperiods.action", {
         "start_date": start_date,
         "com_date": com_date,
	    "startTime":startTime,
	    "endTime":endTime,
         "sel_flag": "2",
         "flux_flag": tp,
         "line_id": line_id,
         "station_id": station_id
         }, function (data) {
         periodAllData.zdy_data = {};
         periodAllData.zdy_data.periodData = data;
         periodAllData.zdy_data.start_date = start_date;
         periodAllData.zdy_data.com_date = com_date;
             if(kllx=='period_zdy'){
                 changeData(kllx);
             }
         });

    };
	var unit='单位：万人次';
    function setPeriodOption(data, start_date, com_date) {
        flowPeriodOption = {
            //title: periodAllData.title,
         
            tooltip: {
                trigger: 'axis',
                textStyle: {fontWeight: 'bold', fontSize: 16},
                formatter: function (p) {
                    var tp_str = p[0].name + "<br/>" + p[0].seriesName + "：";
                    if (isNaN(p[0].value) || typeof(p[0].value) == "undefined") {
                        tp_str += "--";
                    } else {
                        tp_str += (periodAllData.selectedStation ? p[0].value : p[0].value + "万");
                    }
                    tp_str += "<br/>" + p[1].seriesName + "：" + (periodAllData.selectedStation ? p[1].value : p[1].value+ "万" ) ;
                    return tp_str;
                }
            },
            legend: {
                selectedMode: false,
                x: 'center',
                y: '28',
                textStyle: {fontWeight: 'bold', fontSize: 16},
                data: []
            },
            calculable: true,
            grid: {'y':50, 'y2': 30, 'x': 30, 'x2': 25},
            xAxis: [
                {
                    type: 'category',
                    boundaryGap: false,
                    axisLine: {lineStyle: {color: '#0462FF', width: 3}},
                    axisLabel: {interval: 0, textStyle: {color: '#FFF'}},
                    data: []
                }
            ],
            yAxis: [
                {
                    type: 'value',
                    name: unit,
			nameTextStyle:{
                        color:"#FFF",
                        fontSize:'10'

                    },
                    splitLine: {lineStyle: {type: 'dashed',color:'#0462FF',width:0.7}},
                    axisLine: {lineStyle: {color: '#0462FF', width: 2}},
                    axisLabel: {
                        textStyle: {fontWeight: 'bold', fontSize: 9, color: '#FFF'},
                        formatter: periodAllData.selectedStation ? '{value}' : '{value}'
                    }
                }
            ],
            series: [
                {
                    name: '',
                    type: 'line',
                    smooth: true,
                    itemStyle: {normal: {color: '#0462FF',width: 2.5}},
                    areaStyle: {normal: {}},
                    data: []
                }
            ]
        };


        var dateFt0 = start_date.substring(0, 4) + "/" + start_date.substring(4, 6) + "/" + start_date.substring(6);
        var dateFt1 = com_date.substring(0, 4) + "/" + com_date.substring(4, 6) + "/" + com_date.substring(6);

        flowPeriodOption.legend.data = [{name: dateFt0, textStyle: {fontSize: 10,color: '#0462FF'}}];
        flowPeriodOption.series[0].name = dateFt0;

        var times = [], com_times = [], period = [],sumti=[],sumct=[],sum=[];
        $.each(data, function (i, v) {
            if(v.hasOwnProperty("TIMES")){
		sumti.push(v.TIMES);
            sumct.push(v.COM_TIMES);
            if (periodAllData.selectedStation) {
		    unit='单位：人次';
                times.push(v.TIMES);
                com_times.push(v.COM_TIMES);
            } else {
                times.push((v.TIMES / 10000).toFixed(1));
                com_times.push((v.COM_TIMES / 10000).toFixed(1));
            }
        }
           //alert(startime+endtime);
           if((parseInt(endTime.substr(0, 2)) - parseInt(startTime.substr(0, 2))) > 10){

// if (parseInt(v.TIME_PERIOD.toString().substr(3, 2))=="00") {

     if(parseInt(v.TIME_PERIOD.toString().substr(1, 1)) % 2== 0 && parseInt(v.TIME_PERIOD.toString().substr(3, 2))=="00"){
         //alert("wwww");
         period.push({
             value: v.TIME_PERIOD,
             textStyle: {fontSize: 9, fontWeight: 'bold'}
         });
     }else{

         period.push({
             value: v.TIME_PERIOD,
             textStyle: {fontSize: 7, color: 'rgba(32,32,35,0)'}
         });
     }

 //}
} else {

 if (parseInt(v.TIME_PERIOD.toString().substr(3, 2)) % 15 == 0) {


     if ((parseInt(endTime.substr(0, 2)) - parseInt(startTime.substr(0, 2))) > 4) {


         if (v.TIME_PERIOD.toString().substr(v.TIME_PERIOD.toString().length - 1, 1) == "5") {
             period.push({
                 value: v.TIME_PERIOD,
                 textStyle: {fontSize: 12, color: 'rgba(32,32,35,0)'}
             });
         } else if (v.TIME_PERIOD.toString().substr(v.TIME_PERIOD.toString().length - 2, 1) == "3") {
             period.push({
                 value: v.TIME_PERIOD,
                 textStyle: {fontSize: 12, color: 'rgba(32,32,35,0)'}
             });
         } else {
             period.push({
                 value: v.TIME_PERIOD,
                 textStyle: {fontSize: 9, fontWeight: 'bold'}
             });
         }

     } else {
         // alert(222);


         if (v.TIME_PERIOD.toString().substr(v.TIME_PERIOD.toString().length - 1, 1) == "5") {
             period.push({
                 value: v.TIME_PERIOD,
                 textStyle: {fontSize: 9}
             });
         } else {
             period.push({
                 value: v.TIME_PERIOD,
                 textStyle: {fontSize: 7, fontWeight: 'bold'}
             });
         }
     }

 } else {
     period.push({
         value: v.TIME_PERIOD,
         textStyle: {fontSize: 0, fontWeight: 0, color: 'rgba(32,32,35,0)'}
     });
 }
}

        });
	//对比折线数据总和
	 var stm=eval(sumti.join('+'));
        var sct=eval(sumct.join('+'));
        

        //销毁图例
        if (chartPeriodCom) {
            chartPeriodCom.dispose();
        }
 	if(parseInt(stm)>parseInt(sct)){
            flowPeriodOption.series[0].data = times;
            sum=com_times;
        }else{
            flowPeriodOption.series[0].data = com_times;
            sum=times;
        }
        //flowPeriodOption.series[0].data = times;
        flowPeriodOption.xAxis[0].data = period;

        chartPeriodCom = echarts.init(document.getElementById('mainChartFS'));
        chartPeriodCom.setOption(flowPeriodOption, true);

        //延迟加载“运营日期”的数据
        setTimeout(function () {
            secLoad(dateFt1, sum);
        }, 1000);
    }
 
    //加载线路车站
    function loadLineAndStation() {
        doPost("station/get_fluxperiods.action", {"sel_flag": "1"}, function (data) {
            var line = eval(data);
            var tp_line = "<option value='00'>全路网</option>";
            //var tp_line = "";
            var tp = "";
            for (var i = 0; i < line.length; i++) {
                if (i == 0) {
                    tp_line += "<option value='" + line[i].LINE_ID + "'>" + line[i].LINE_NM + "</option>";
                } else {
                    if (line[i - 1].LINE_ID != line[i].LINE_ID) {
                        tp_line += "<option value='" + line[i].LINE_ID + "'>" + line[i].LINE_NM + "</option>";
                    }
                }
            }

           // $("#line_id2").html(tp_line);
            $("#line_id4").html(tp_line);
            $("#station_id4").html(tp);

            //添加事件
            $("#line_id4").change(function () {
                var sel_line = $("#line_id4").val();
                tp = "<option></option>";
                for (var i = 0; i < line.length; i++) {
                    if (sel_line == line[i].LINE_ID) {
                        tp += "<option value='" + line[i].STATION_ID + "'>" + line[i].STATION_NM + "</option>";
                    }
                }
                $("#station_id4").html(tp);
            });

        });
    }
    //延迟加载“运营日期”的数据
    function secLoad(dateFt1, com_times) {
        flowPeriodOption.legend.data.push({name: dateFt1, textStyle: {fontSize: 10,color: '#FFC001'}});
        flowPeriodOption.series.push({
            name: dateFt1,
            type: 'line',
            smooth: true,
            itemStyle: {normal: {color: '#FFC001',width: 2.5}},
            areaStyle: {normal: {}},
            data: com_times
        });
        chartPeriodCom = echarts.init(document.getElementById('mainChartFS'));
        chartPeriodCom.setOption(flowPeriodOption, true);
    }
   
 //延迟加载“运营日期”的数据
       /*  setTimeout(function () {
            
        }, 1000); */
  
</script>
</body>
</html>