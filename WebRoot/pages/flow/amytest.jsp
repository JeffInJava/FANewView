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
	<style type="text/css">
		 .mainApp {
            position: absolute;
            height: 100%;
            width: 100%;
            color: #fff;
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
            top: 52px;
            position: relative;
            width: 120%;
            margin-left: -10.5%;

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
            margin-left: 5%;
            margin-top: 16%;
            margin-bottom: 20px;
            width: 100%;
            height: calc(100% - 250px);
        }
        .sranks {
            margin-left: 9%;
            margin-top: 15%;
            margin-bottom: 20px;
            width: 100%;
            height: calc(100% - 220px);
        }
        .filters {
            top: 26px;
            margin-left: -9%;
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
            margin-left: 10px;
            color: #fff;
            text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25);
            background-color: #1134A8;
            text-align: center;
            border-radius: 4px;
            padding: 2px 10px;
            margin-bottom: 0;
            font-size: 14px;
        }

        .btn, .searchbtn {
            margin-left: 10px;
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
    <div data-v-0b39df2e class="dashboard router-view">
        <div data-v-0b39df2e class="flex-container column">

            <div data-v-0b39df2e class="item one" data-order="1"
                 style="transform: translate(-34%,-36.5%) scale(0.28)">
                <div data-v-3e377044 data-v-0b39df2e class="multipleColumn">
                    <div class="main " id="mainStationRank">
                        <img src="resource/images/leftbgno.png" id="klkllxy"
                             style="height: 65%; width: 65%;z-index: 3;position: absolute;top:76%;margin-left: 2%;display: none"
                             alt=""/>
                        <img src="resource/images/leftbgyes.png" id="klkllxn"
                             style="height: 65%; width: 65%;z-index: 3;position: absolute;top: 76%;margin-left: 2%;"
                             alt=""/>
                        <img src="resource/images/chezklpmy.png" id="klkllxo" onclick="clickChart('1',this)"
                             style="position: absolute; height: 32%;width: 39%;z-index: 5;top: 95%;right: 49%" alt=""/>
                        <img src="resource/images/chezklpms.png" id="klkllx" onclick="clickChart('1',this)"
                             style="position: absolute; display:none;height: 32%;width: 39%;z-index: 5;top: 95%;right: 49%" alt=""/>
                    </div>

                </div>
            </div>

            <div data-v-0b39df2e class="item two" data-order="2"
                 style="transform: translate(-34%,1%) scale(0.28)">
                <div data-v-6ba29944 data-v-0b39df2e class="columnChart">
                    <div class="main" id="mainStationZF">
                        <img src="resource/images/leftbgno.png" id="klzfy"
                             style="height: 65%; width: 65%;z-index: 3;margin-left: 2%;" alt=""/>
                        <img src="resource/images/leftbgyes.png" id="klzfn"
                             style="height: 65%; width: 65%;z-index: 3;margin-left: 2%;display: none" alt=""/>
                        <img src="resource/images/chezklzfy.png" id="klzf" onclick="clickChart('2',this)"
                             style="position: absolute;display:none; height: 32%;width: 39%;z-index: 5;top: 15%;right: 49%" alt=""/>
                        <img src="resource/images/chezhklzfn.png" id="klzfo" onclick="clickChart('2',this)"
                             style="position: absolute; height: 32%;width: 39%;z-index: 5;top: 15%;right: 49%" alt=""/>
                    </div>

                </div>
            </div>

            <div data-v-0b39df2e class="item three" data-order="3"
                 style="transform: translate(-34%,16.5%) scale(0.28)">
                <div data-v-581634c4 data-v-0b39df2e class="line">
                    <div class="main" id="mainStationZL">
                        <img src="resource/images/leftbgno.png" id="klzly"
                             style="height: 65%; width: 65%;z-index: 3;margin-left: 2%;" alt=""/>
                        <img src="resource/images/leftbgyes.png" id="klzln"
                             style="height: 65%; width: 65%;z-index: 3;margin-left: 2%;display: none" alt=""/>
                        <img src="resource/images/chezklzl.png" id="klzl" onclick="clickChart('3',this)"
                             style="position: absolute; height: 32%;width: 39%;z-index: 5;top: 15%;right: 49%" alt=""/>
                        <img src="resource/images/chezklzly.png" id="klzli" onclick="clickChart('3',this)"
                             style="position: absolute; display:none; height: 32%;width: 39%;z-index: 5;top: 15%;right: 49%" alt=""/>
                    </div>

                </div>
            </div>
            <div data-v-0b39df2e class="item three" data-order="4"
                 style="transform: translate(-34%,32%) scale(0.28)">
                <div data-v-581634c4 data-v-0b39df2e class="line">
                    <div class="main" id="mainStationPZL">
                        <img src="resource/images/leftbgyes.png" id="klfsy"
                             style="height: 65%; width: 65%;z-index: 3;margin-left: 2%;display: none" alt=""/>
                        <img src="resource/images/leftbgno.png" id="klfsn"
                             style="height: 65%; width: 65%;z-index: 3;margin-left: 2%;" alt=""/>
                        <img src="resource/images/chezklffs.png" id="klfs" onclick="clickChart('4',this)"
                             style="position: absolute; height: 32%;width: 39%;z-index: 5;top: 15%;right: 49%" alt=""/>
                        <img src="resource/images/chezklfsy.png" id="klfsi" onclick="clickChart('4',this)"
                             style="position: absolute;display:none; height: 32%;width: 39%;z-index: 5;top: 15%;right: 49%" alt=""/>
                    </div>

                </div>
            </div>
            <div data-v-0b39df2e class="item four" data-order=""
                 style="transform: translate(16%, 0) scale(1)">
                <div data-v-c5b8f8b4 data-v-0b39df2e class="point" id="kllx">
                    <div id="mainChart" class="srank"></div>

                    <div data-v-c5b8f8b4 class="filter">
                        <input type="button" value=">>" class="btn" style="font-weight: bold">

                        <div class="prm">
                            运营日期：<input type="text" name="start_date" id="start_date1" value="<%=start_date %>"
                                        style="width:70px;height: 25px">

                            <input type="checkbox" style="" name="flux_flag1" value="1" checked="checked">进
                            <input type="checkbox" name="flux_flag1" value="2">出
                            <input type="checkbox" name="flux_flag1" value="3" checked="checked">换
                            <div id="ones" style="display: inline-block">
                                <select name="line_id" id="line_id1" style="width:70px;height: 25px">
                                    <option value="00">全路网</option>
                                </select>
                                <select name="station_id" id="ranking1" style="width:70px;height: 25px">
                                    <!--<option value="外高桥东北方向站">外高桥东北方向站</option>-->
                                    <option value="5">前5</option>
                                    <option value="8" selected="selected">前8</option>
                                </select>
                            </div>

                            <input type="button" value="查询" onclick="loadStationRankData()" class="searchbtn">
                        </div>

                    </div>
                </div>

                <div data-v-c5b8f8b4 data-v-0b39df2e class="point" id="zf">

                    <div id="mainChartZF" class="srank" style=""></div>

                    <div data-v-c5b8f8b4 class="filter">
                        <input type="button" value=">>" class="btn" style="font-weight: bold">

                        <div class="prm">
                            运营日期：<input type="text" name="start_date" id="start_date2" value="<%=start_date %>"
                                        style="width:70px;height: 25px">

                            <input type="checkbox" style="" name="flux_flag2" value="1" checked="checked">进
                            <input type="checkbox" name="flux_flag2" value="2">出
                            <input type="checkbox" name="flux_flag2" value="3" checked="checked">换
                            <div id="onesa" style="display: inline-block">
                                <select name="line_id" id="line_id2" style="width:70px;height: 25px">
                                    <option value="01">1号线</option>
                                </select>
                                <select name="station_id" id="ranking2" style="width:70px;height: 25px">
                                    <!--<option value="外高桥东北方向站">外高桥东北方向站</option>-->
                                    <option value="5">前5</option>
                                    <option value="8" selected="selected">前8</option>
                                </select>
                            </div>
                            <input type="button" value="查询" onclick="loadLineRankData()" class="searchbtn">
                        </div>

                    </div>
                </div>

                <div data-v-c5b8f8b4 data-v-0b39df2e class="point" id="zl">
                    <div id="mainChartZL" class="srank"></div>

                    <div data-v-c5b8f8b4 class="filter">
                        <input type="button" value=">>" class="btn" style="font-weight: bold">

                        <div class="prm">
                            运营日期：<input type="text" name="start_date" id="start_date3" value="<%=start_date %>"
                                        style="width:70px;height: 25px">

                            <input type="checkbox" style="" name="flux_flag3" value="1" checked="checked">进
                            <input type="checkbox" name="flux_flag3" value="2">出
                            <input type="checkbox" name="flux_flag3" value="3" checked="checked">换
                            <div id="ones" style="display: inline-block">
                                <select name="line_id" id="line_id3" style="width:70px;height: 25px">
                                    <option value="00">全路网</option>
                                </select>
                                <select name="station_id" id="ranking3" style="width:70px;height: 25px">
                                    <!--<option value="外高桥东北方向站">外高桥东北方向站</option>-->
                                    <option value="5">前5</option>
                                    <option value="8" selected="selected">前8</option>
                                </select>
                            </div>

                            <input type="button" value="查询" onclick="loadAllLineRankData()" class="searchbtn">
                        </div>

                    </div>
                </div>

                <div data-v-c5b8f8b4 data-v-0b39df2e class="point" id="fs">
                    <div id="mainChartFS" class="sranks"></div>

                    <div data-v-c5b8f8b4 class="filters">
                        <input type="button" value=">>" class="btns">

                        <div class="prm">
                            运营日期:<input type="text" name="start_date" id="start_date4" value="<%=start_date %>"
                                        style="width:65px;">
                            对比日期:<input type="text" name="com_date" id="com_date4" value="<%=yesterday %>"
                                        style="width:65px;">
                            <input type="checkbox" name="flux_flag4" value="1" checked="checked">进
                            <input type="checkbox" name="flux_flag4" value="2">出
                            <input type="checkbox" name="flux_flag4" value="3" checked="checked">换
                            线路:<select name="line_id" id="line_id4" style="width:100px;"></select>
                            车站:<select name="station_id" id="station_id4" style="width:100px;"></select>
                            <input type="button" value="查询" onclick="loadFluxPeriodData()" class="searchbtns">
                        </div>
                        <div class="tab">
                            <span onclick="change(this,'period_tb')">同&nbsp;比</span>
                            <span class="act" onclick="change(this,'period_hb')" id="period_hb">环&nbsp;比</span>
                            <span onclick="change(this,'period_zdy')">自定义</span>
                        </div>
                    </div>


                </div>
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
         loadLineAndStation();

        loadStationRankData();
        loadLineRankData();
        loadAllLineRankData();
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
        $(".btn").click(function () {
            if (this.value == ">>") {
                if (klty == 'klzf') {
                    $('#one').hide();
                }
                $(".prm").show();

                $(".tab").hide();
                this.value = "<<";
            } else if (this.value == "<<") {
                $(".prm").hide();
                if (klty == "klkllx") {
                    $(".tab").hide();
                } else {
                    $(".tab").show();
                }

                this.value = ">>";
            }
        });


    });

    //同环比切换事件
    var kllx,zftp,zltp,fstp;
    function change(obj, pm) {
        $(obj).siblings().removeClass("act");
        $(obj).addClass("act");
        if (pm == "zf_tb") {
            kllx = 'zf_tb';
            zftp=kllx;
            $('#mainChartZF').empty();
            zfchart(kllx);
        } else if (pm == "zf_hb") {
            kllx = 'zf_hb';
            zftp=kllx;
            $('#mainChartZF').empty();
            zfchart(kllx);
        } else if (pm == "zf_zdy") {
            kllx = 'zf_zdy';
            zftp=kllx;
            $('#mainChartZF').empty();
            zfchart(kllx);
        } else if (pm == "zl_tb") {
            kllx = 'zl_tb';
            zltp=kllx;
            $('#mainChartZL').empty();
            zlchart(kllx);
        } else if (pm == "zl_hb") {
            kllx = 'zl_hb';
            zltp=kllx;

            $('#mainChartZL').empty();
            zlchart(kllx);
        } else if (pm == "zl_zdy") {
            kllx = 'zl_zdy';
            zltp=kllx;

            $('#mainChartZL').empty();
            zlchart(kllx);

        } else if (pm == "period_tb") {
            periodData = periodAllData.tb_data.periodData;
            dt1 = periodAllData.tb_data.start_date;
            dt2 = periodAllData.tb_data.com_date;
            $('#mainChartFS').empty();
            kllx = 'period_tb';
            fstp=kllx;
            setPeriodOption(periodAllData.tb_data.periodData, periodAllData.tb_data.start_date, periodAllData.tb_data.com_date);
        } else if (pm == "period_hb") {
            periodData = periodAllData.hb_data.periodData;
            dt1 = periodAllData.hb_data.start_date;
            dt2 = periodAllData.hb_data.com_date;
            $('#mainChartFS').empty();
            kllx = 'period_hb';
            fstp=kllx;
            setPeriodOption(periodAllData.hb_data.periodData, periodAllData.hb_data.start_date, periodAllData.hb_data.com_date);
        } else if (pm == "period_zdy") {
            periodData = periodAllData.zdy_data.periodData;
            dt1 = periodAllData.zdy_data.start_date;
            dt2 = periodAllData.zdy_data.com_date;
            $('#mainChartFS').empty();
            kllx = 'period_zdy';
            fstp=kllx;
            setPeriodOption(periodAllData.zdy_data.periodData, periodAllData.zdy_data.start_date, periodAllData.zdy_data.com_date);
        }
    }
    //根据同环比事件加载数据

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

    //重新搜索数据
    function queryData() {

    }
    var dt1, dt2;
    var klty;
    //图表切换
    function clickChart(t, obj) {

        //图表切换时，重新加载
        if (t == 1) {
            $('#klkllxy').hide();
            $('#klkllxn').show();
            $('#klkllxo').show();
            $('#klkllx').hide();
            $('#klzf').hide();
            $('#klzfo').show();
            $('#klzli').hide();
            $('#klzl').show();
            $('#klfsi').hide();
            $('#klfs').show();
            $('#klzfy').show();
            $('#klzfn').hide();
            $('#klzly').show();
            $('#klzln').hide();
            $('#klfsy').hide();
            $('#klfsn').show();
            $('#kllx').show();
            $('#zf').hide();
            $('#zl').hide();
            $('#fs').hide();
            $('#mainChart').empty();
            $(".prm").hide();
            $(".btn").val(">>");
            klpm();
        } else if (t == 2) {
            $('#klkllxy').show();
            $('#klkllxn').hide();
            $('#klkllxo').hide();
            $('#klkllx').show();
            $('#klzf').show();
            $('#klzfo').hide();
            $('#klzli').hide();
            $('#klzl').show();
            $('#klfsi').hide();
            $('#klfs').show();

            $('#klzfy').hide();
            $('#klzfn').show();
            $('#klzly').show();
            $('#klzln').hide();
            $('#klfsy').hide();
            $('#klfsn').show();
            $('#kllx').hide();
            $('#zf').show();
            $('#zl').hide();
            $('#fs').hide();
            $('#mainChartZF').empty();
            $(".prm").hide();
            $(".btn").val(">>");
           xlpm();

        } else if (t == 3) {
            $('#klkllxy').show();
            $('#klkllxn').hide();
            $('#klzfy').show();
            $('#klkllxo').hide();
            $('#klkllx').show();
            $('#klzf').hide();
            $('#klzfo').show();
            $('#klzli').show();
            $('#klzl').hide();
            $('#klfsi').hide();
            $('#klfs').show();

            $('#klzfn').hide();
            $('#klzly').hide();
            $('#klzln').show();
            $('#klfsy').hide();
            $('#klfsn').show();
            $('#kllx').hide();
            $('#zf').hide();
            $('#zl').show();
            $('#fs').hide();
            $('#mainChartZL').empty();
            $(".prm").hide();
            $(".btn").val(">>");
            alpm();

        } else if (t == 4) {
            $('#klkllxy').show();
            $('#klkllxn').hide();
            $('#klzfy').show();
            $('#klzfn').hide();
            $('#klzly').show();
            $('#klkllxo').hide();
            $('#klkllx').show();
            $('#klzf').hide();
            $('#klzfo').show();
            $('#klzli').hide();
            $('#klzl').show();
            $('#klfsi').show();
            $('#klfs').hide();
            $('#klzln').hide();
            $('#klfsy').show();
            $('#klfsn').hide();
            $('#kllx').hide();
            $('#zf').hide();
            $('#zl').hide();
            $('#fs').show();
            $('#mainChartFS').empty();
            $(".prm").hide();
            $(".btn").val(">>");
            $(".tab").show();
            if(fstp==''||fstp==null){
                kllx="period_hb"
            }else{
                kllx=fstp;
            }
            if (kllx == 'period_hb') {
                changeData(kllx);
            }
        else if (kllx== "period_tb") {
                changeData(kllx);
            }
            else if (kllx== "period_zdy") {
                changeData(kllx);
            }


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


    //使用d3加载车站客流排名数据
    var kldata,pmtitle;
    function stationRankData(line_id, ranking, datas, line_nm, tp) {
        //定义数据
         kldata = new Array();
        var title = "车站客流排名";
        if (tp.indexOf("1") > -1 && tp.indexOf("3") > -1 && tp.length == 2) {
            title = line_nm + "客流排名";
        } else if (tp.indexOf("1") > -1 && tp.length == 1) {
            title = line_nm + "进站客流排名";
        } else if (tp.indexOf("2") > -1 && tp.length == 1) {
            title = line_nm + "出站客流排名";
        } else if (tp.indexOf("3") > -1 && tp.length == 1) {
            title = line_nm + "换乘客流排名";
        } else {

            var tp = (tp.indexOf("1") > -1 ? "进站+" : "") + (tp.indexOf("2") > -1 ? "出站+" : "") + (tp.indexOf("3") > -1 ? "换乘+" : "");
            title = tp.substring(0, tp.length - 1);

        }
        pmtitle=title;
        $.each(datas, function (i, v) {
            if (v.LINE_ID == line_id && parseInt(v.RN) <= parseInt(ranking)) {
                kldata.push(datas[i]);
            }
        });
        $('#mainChart').empty();

        klpm();
    }
    //d3生成客流排名图表
        function klpm() {
        klty == "klkllx";
        var data=new Array();
        data=kldata;
        var title=pmtitle;
        //使用d3画出图表
        var svg = d3.select('#mainChart')
                .append('svg')
                .attr('width', svgWidth)
                .attr('height', svgHeight)
                .attr('id', 'svg-column');
        addXAxis();
        addYScale();
        addColumn();

        var dastr=new Array();
        function addXAxis() {
            var transform = d3.geoTransform({
                point: function (x, y) {
                    this.stream.point(x, y)
                }
            });
            //定义几何路径
            var path = d3.geoPath()
                    .projection(transform);

            xLinearScale = d3.scaleBand()
                    .domain(data.map(function (d) {
                        return d.STATION_NM;
                       // return d.STATION_NM.length > 4 ? d.STATION_NM.substring(0, 4) + "\n" + d.STATION_NM.substring(4, d.STATION_NM.length) : d.STATION_NM;

                    }))
                    .range([0, svgWidth - margin.right - margin.left], 0.1);
            var xAxis = d3.axisBottom(xLinearScale)
                    .ticks(data.length);
            //绘制X轴
            var xAxisG = svg.append("g")
                    .call(xAxis)
                    .attr("transform", "translate(" + (margin.left) + "," + (svgHeight - margin.bottom) + ")");

            //删除原X轴
            xAxisG.select("path").remove();
            xAxisG.selectAll('line').remove();

            dastr=data.map(function (d) {
                return d.STATION_NM;});
            var tex;

            //绘制新的立体X轴
            xAxisG.append("path")
                    .datum({
                        type: "Polygon",
                        coordinates: [
                            [
                                [20, 0],
                                [0, 15],
                                [svgWidth - margin.right - margin.left, 15],
                                [svgWidth + 20 - margin.right - margin.left, 0],
                                [20, 0]
                            ]
                        ]
                    })
                    .attr("d", path)
                    .attr('fill', 'rgb(187,187,187)');
            xAxisG.selectAll('text')
                    .attr('font-size', '12px')
                // .attr('transform', rotate(45))
                    .attr("dy", "10")
                    .attr("dx", "4")
                    .attr('fill', 'rgb(255,255,255)')
                    .attr('transform', 'translate(0,20)');







            dataProcessing(xLinearScale)//核心算法
        }
//向字符串指定位置中插入字符
        function insert_flg(str,flg,sn){
            var newstr="";
            for(var i=0;i<str.length;i+=sn){
                var tmp=str.substring(i, i+sn);
                newstr+=tmp+flg;
            }
            return newstr;
        }
        //创建y轴的比例尺渲染y轴
        function addYScale() {

            yLinearScale = d3.scaleLinear()
                    .domain([0, d3.max(data, function (d, i) {
                        return ((d.TIMES / 10000).toFixed(2)) * 1;
                    }) * 1.2])
                    .range([svgHeight - margin.top - margin.bottom, 0]);

            //定义Y轴比例尺以及刻度
            var yAxis = d3.axisLeft(yLinearScale)
                    .ticks(6);

            //绘制Y轴
            var yAxisG = svg.append("g")
                    .call(yAxis)
                    .attr('transform', 'translate(' + (margin.left + 10) + "," + (margin.top + 13) + ")");
            yAxisG.selectAll('text')
                    .attr('font-size', '18px')
                    .attr('fill', 'rgb(255,255,255)')
            yAxisG.selectAll('line')
                    .attr('stroke', '#1DADFD')
                   // .attr("transform", 'rotate(-37)');
            yAxisG.append("g")
                    .append("text")
                    .text("单位：万人次")
                    .attr("transform", "translate(85,3)")
                    .attr("text-anchor", "end")
                    .attr('font-size', '13px')
                    .attr("stroke", "white")
                    .attr("dy", "1em")


            svg.append("g")
                    .append("text")
                    .text(title)
                    .attr("class", "title")
                    .attr('font-size', '26px')
                    .attr('font-weight', 'bold')
                    .attr('fill', '#9EC5FF')
                    .attr("x", 20)
                    .attr("y", 23);
            yAxisG.select('path')
                    .attr('stroke', '#1DADFD')

            // yAxisG.select('line')
            // .attr('stroke','rgb(255,255,255)');
            //删除原Y轴路径和tick
            //yAxisG.select("path").remove();
            //yAxisG.selectAll('line').remove();
        }

        function dataProcessing(xLinearScale) {
            var angle = Math.PI / 2.4;
            for (var i = 0; i < data.length; i++) {
                var d = data[i];
                var depth = 10;
                d.ow = xLinearScale.bandwidth() * 0.5;
                d.ox = xLinearScale(d.STATION_NM);
                d.oh = 1;
                d.p1 = {
                    x: Math.cos(angle) * d.ow,
                    y: -Math.sin(angle) - depth
                };
                d.p2 = {
                    x: d.p1.x + d.ow,
                    y: d.p1.y
                };
                d.p3 = {
                    x: d.p2.x,
                    y: d.p2.y + d.oh
                };
            }
        }

        var tipTimerConfig = {
            longer: 0,
            target: null,
            exist: false,
            winEvent: window.event,
            boxHeight: 398,
            boxWidth: 376,
            maxWidth: 376,
            maxHeight: 398,
            tooltip: null,

            showTime: 3500,
            hoverTime: 300,
            displayText: "",
            show: function (val, e) {
                "use strict";
                var me = this;

                if (e != null) {
                    me.winEvent = e;
                }

                me.displayText = val;

                me.calculateBoxAndShow();

                me.createTimer();
            },
            calculateBoxAndShow: function () {
                "use strict";
                var me = this;
                var _x = 0;
                var _y = 0;
                var _w = document.documentElement.scrollWidth;
                var _h = document.documentElement.scrollHeight;
                var wScrollX = window.scrollX || document.body.scrollLeft;
                var wScrollY = window.scrollY || document.body.scrollTop;
                var xMouse = me.winEvent.x + wScrollX;
                if (_w - xMouse < me.boxWidth) {
                    _x = xMouse - me.boxWidth - 10;
                } else {
                    _x = xMouse;
                }

                var _yMouse = me.winEvent.y + wScrollY;
                if (_h - _yMouse < me.boxHeight + 18) {
                    _y = _yMouse - me.boxHeight - 25;
                } else {

                    _y = _yMouse + 18;
                }

                me.addTooltip(_x, _y);
            },
            addTooltip: function (page_x, page_y) {
                "use strict";
                var me = this;

                me.tooltip = document.createElement("div");
                me.tooltip.style.left = page_x + "px";
                me.tooltip.style.top = page_y + "px";
                me.tooltip.style.position = "absolute";

                me.tooltip.style.width = me.boxWidth + "px";
                me.tooltip.style.height = me.boxHeight + "px";
                me.tooltip.className = "three-tooltip";

                var divInnerHeader = me.createInner();
                divInnerHeader.innerHTML = me.displayText;
                me.tooltip.appendChild(divInnerHeader);

                document.body.appendChild(me.tooltip);
            },
            createInner: function () {
                "use strict";
                var me = this;
                var divInnerHeader = document.createElement('div');
                divInnerHeader.style.width = me.boxWidth + "px";
                divInnerHeader.style.height = me.boxHeight + "px";
                return divInnerHeader;
            },
            ClearDiv: function () {
                "use strict";
                var delDiv = document.body.getElementsByClassName("three-tooltip");
                for (var i = delDiv.length - 1; i >= 0; i--) {
                    document.body.removeChild(delDiv[i]);
                }
            },
            createTimer: function (delTarget) {
                "use strict";
                var me = this;
                var delTip = me.tooltip;
                var delTarget = tipTimerConfig.target;
                var removeTimer = window.setTimeout(function () {
                    try {
                        if (delTip != null) {
                            document.body.removeChild(delTip);
                            if (tipTimerConfig.target == delTarget) {
                                me.exist = false;
                            }
                        }
                        clearTimeout(removeTimer);
                    } catch (e) {
                        clearTimeout(removeTimer);
                    }
                }, me.showTime);
            },
            hoverTimerFn: function (showTip, showTarget) {
                "use strict";
                var me = this;

                var showTarget = tipTimerConfig.target;

                var hoverTimer = window.setInterval(function () {
                    try {
                        if (tipTimerConfig.target != showTarget) {
                            clearInterval(hoverTimer);
                        } else if (!tipTimerConfig.exist && (new Date()).getTime() - me.longer > me.hoverTime) {
                            //show
                            tipTimerConfig.show(showTip);
                            tipTimerConfig.exist = true;
                            clearInterval(hoverTimer);
                        }
                    } catch (e) {
                        clearInterval(hoverTimer);
                    }
                }, tipTimerConfig.hoverTime);
            }
        };

        var createTooltipTableData = function (info) {
            var ary = [];
            ary.push("<div class='tip-hill-div'>");
            ary.push("<h1>站台信息：" + info.STATION_NM + "</h1>");
            ary.push("<h2>客流量: " + (info.TIMES / 10000).toFixed(2) + '万');
            ary.push("</div>");
            return ary.join("");
        };

        function addColumn() {
            function clumnMouseover(d) {
                d3.select(this).selectAll(".transparentPath").attr("opacity", 0.8);
                // 添加 div
                tipTimerConfig.target = this;
                tipTimerConfig.longer = new Date().getTime();
                tipTimerConfig.exist = false;
                //获取坐标
                tipTimerConfig.winEvent = {
                    x: event.clientX - 100,
                    y: event.clientY
                };
                tipTimerConfig.boxHeight = 50;
                tipTimerConfig.boxWidth = 140;

                //hide
                tipTimerConfig.ClearDiv();
                //show
                tipTimerConfig.hoverTimerFn(createTooltipTableData(d));
            }

            function clumnMouseout(d) {
                d3.select(this).selectAll(".transparentPath").attr("opacity", 1);
                tipTimerConfig.target = null;
                tipTimerConfig.ClearDiv();
            }

            //定义一种颜色
            var c= d3.rgb(255,255,255);
            var b = d3.rgb(152,156,237);

            //定义一个线性渐变
            var defs = svg.append("defs");

            var linearGradient = defs.append("linearGradient")
                    .attr("id","linearColor")
                    .attr("x1","0%")
                    .attr("y1","0%")
                    .attr("x2","100%")
                    .attr("y2","0%");

            var stop1 = linearGradient.append("stop")
                    .attr("offset","10%")
                    .style("stop-color",b.toString());
            var stop2 = linearGradient.append("stop")
                    .attr("offset","50%")
                    .style("stop-color",c.toString());

            var stop3 = linearGradient.append("stop")
                    .attr("offset","90%")
                    .style("stop-color",b.toString());
            var g = svg.selectAll('.g')
                    .data(data)
                    .enter()
                    .append('g')
                    .on("mouseover", clumnMouseover)
                    .on("mouseout", clumnMouseout)
                    .attr('transform', function (d) {
                        return "translate(" + (d.ox + margin.left + 15) + "," + (svgHeight - margin.bottom + 15) + ")"
                    });
            g.transition()
                    .duration(2500)
                    .attr("transform", function (d) {
                        return "translate(" + (d.ox + margin.left + 20) + ", " + (yLinearScale((d.TIMES / 10000).toFixed(2)) + margin.bottom - 15) + ")"
                    });

            g.append('rect')
                    .attr('x', 0)
                    .attr('y', 0)
                    .attr("class", "transparentPath")
                    .attr('width', function (d, i) {
                        return d.ow;
                    })
                    .attr('height', function (d) {
                        return d.oh;
                    })
                    .style('fill', function (d, i) {
                        return mainColorList[i]
                    })
                    .style('stroke','#BBBBBB')
                    .style('stroke-width','0.2')
                    //.style('fill',"url(#" + linearGradient.attr("id") + ")")
                    //.style('fill','#ebec5b')
                    .transition()
                    .duration(2500)
                    .attr("height", function (d, i) {
                        return svgHeight - margin.bottom - margin.top - yLinearScale((d.TIMES / 10000).toFixed(2));
                    });

           g.append('path')
                    .attr("class", "transparentPath")
                    .attr('d', function (d) {
                        return "M0,0 L" + d.p1.x + "," + d.p1.y + " L" + d.p2.x + "," + d.p2.y + " L" + d.ow + ",0 L0,0";
                    })
                    .style('fill', function (d, i) {
                        return topColorList[i]
                    })
                    .style('stroke','#BBBBBB')
                    .style('stroke-width','0.2');
                    //.style('fill','#ebec5b');

           g.append('path')
                    .attr("class", "transparentPath")
                    .attr('d', function (d) {
                        return "M" + d.ow + ",0 L" + d.p2.x + "," + d.p2.y + " L" + d.p3.x + "," + d.p3.y + " L" + d.ow + "," + d.oh + " L" + d.ow + ",0"
                    })
                   .style('fill', function (d, i) {
                        return rightColorList[i]
                    })
                    .style('stroke','#BBBBBB')
                    .style('stroke-width','0.2')
                   // .style('fill','#ebec5b')
                    .transition()
                    .duration(2500)
                    .attr("d", function (d, i) {
                        return "M" + d.ow + ",0 L" + d.p2.x + "," + d.p2.y + " L" + d.p3.x + "," + (d.p3.y + svgHeight - margin.top - margin.bottom - yLinearScale((d.TIMES / 10000).toFixed(2))) + " L" + d.ow + "," + (svgHeight - margin.top - margin.bottom - yLinearScale((d.TIMES / 10000).toFixed(2))) + " L" + d.ow + ",0"
                    });
            //添加文字元素
            g.append("text").attr("class", "myText")
                    .attr("x", 5)
                    .attr("y", -28)
                    .attr("dy", '10')
                    .attr("dx", '10')
                    .attr('font-size', '17px')
                    .attr("width", '40px')
                    .attr("height", '30px')
                    .text(function (d) {
                        return ((d.TIMES / 10000).toFixed(2)) + '万';
                    })
                    .attr('fill', 'rgb(255,255,255)');


        }

        //使用d3.js绘制图表

    }

    //加载车站客流排名数据
    function loadStationRankData() {
        $(".prm").hide();
        $(".btn").val(">>");
       // $(".tab").hide();

        var start_date = $("#start_date1").val();//选择日期
        var flux_flag = $('input[name="flux_flag1"]:checked');//选择进出站方式
        var tp = "";
        if (flux_flag && flux_flag.length > 0) {
            $(flux_flag).each(function (i, v) {
                tp += $(v).val();
            });
        } else {
            alert("请选择进出站方式！");
            return;
        }

        var line_id = $("#line_id1").val();//选择线路
        var line_nm = $("#line_id1 option:selected").text();//选择线路
        var ranking = $("#ranking1").val();//排名



         doPost("station/get_station_fluxrank.action", {"start_date": start_date, "flux_flag": tp}, function (data) {
             var datas = data;
             stationRankData(line_id, ranking, datas, line_nm, tp);



         //添加chang事件
         $("#line_id1").change(function () {
             stationRankData($("#line_id1").val(), $("#ranking1").val(), datas, $("#line_id1 option:selected").text(), tp);
         });
         $("#ranking1").change(function () {
             stationRankData($("#line_id1").val(), $("#ranking1").val(), datas, $("#line_id1 option:selected").text(), tp);
         });
         });
    }
    //加载单个线路客流排名数据
    function loadLineRankData() {
        $(".prm").hide();
         $(".btn").val(">>");
      //   $(".tab").hide();

        var start_date = $("#start_date2").val();//选择日期
        var flux_flag = $('input[name="flux_flag2"]:checked');//选择进出站方式
        var tp = "";
        if (flux_flag && flux_flag.length > 0) {
            $(flux_flag).each(function (i, v) {
                tp += $(v).val();
            });
        } else {
            alert("请选择进出站方式！");
            return;
        }

        var line_id = $("#line_id2").val();//选择线路
        var line_nm = $("#line_id2 option:selected").text();//选择线路
        var ranking = $("#ranking2").val();//排名
        
        doPost("station/get_station_fluxrank.action", {"start_date": start_date, "flux_flag": tp}, function (data) {
            var datas = data;
            lineRankData(line_id, ranking, datas, line_nm, tp);



        //添加chang事件
        $("#line_id2").change(function () {
        	lineRankData($("#line_id2").val(), $("#ranking2").val(), datas, $("#line_id2 option:selected").text(), tp);
        });
        $("#ranking2").change(function () {
        	lineRankData($("#line_id2").val(), $("#ranking2").val(), datas, $("#line_id2 option:selected").text(), tp);
        });
        });

      
    }

	//单条线路车站排名
    var xldata,xltitle;
    function lineRankData(line_id, ranking, datas, line_nm, tp) {
        //定义数据
        xldata = new Array();
        var title = "客流排名";
        if (tp.indexOf("1") > -1 && tp.indexOf("3") > -1 && tp.length == 2) {
            title = line_nm + "客流排名";
        } else if (tp.indexOf("1") > -1 && tp.length == 1) {
            title = line_nm + "进站客流排名";
        } else if (tp.indexOf("2") > -1 && tp.length == 1) {
            title = line_nm + "出站客流排名";
        } else if (tp.indexOf("3") > -1 && tp.length == 1) {
            title = line_nm + "换乘客流排名";
        } else {

            var tp = (tp.indexOf("1") > -1 ? "进站+" : "") + (tp.indexOf("2") > -1 ? "出站+" : "") + (tp.indexOf("3") > -1 ? "换乘+" : "");
            title = tp.substring(0, tp.length - 1);

        }

        xltitle=title;
        $.each(datas, function (i, v) {
            if (v.LINE_ID == line_id && parseInt(v.RN) <= parseInt(ranking)) {
                xldata.push(datas[i]);
            }
        });
        $('#mainChartZF').empty();

        xlpm();
    }
  //加载所有线路客流排名数据
    function loadAllLineRankData() {
        $(".prm").hide();
         $(".btn").val(">>");
      //   $(".tab").hide();

        var start_date = $("#start_date3").val();//选择日期
        var flux_flag = $('input[name="flux_flag2"]:checked');//选择进出站方式
        var tp = "";
        if (flux_flag && flux_flag.length > 0) {
            $(flux_flag).each(function (i, v) {
                tp += $(v).val();
            });
        } else {
            alert("请选择进出站方式！");
            return;
        }

        var line_id = $("#line_id3").val();//选择线路
        var line_nm = $("#line_id3 option:selected").text();//选择线路
        var ranking = $("#ranking3").val();//排名
        
        doPost("station/get_line_fluxrank.action", {"start_date": start_date, "flux_flag": tp}, function (data) {
            var datas = data;
            AlllineRankData(line_id, ranking, datas, line_nm, tp);



        //添加chang事件
        $("#line_id3").change(function () {
        	AlllineRankData($("#line_id3").val(), $("#ranking3").val(), datas, $("#line_id3 option:selected").text(), tp);
        });
        $("#ranking3").change(function () {
        	AlllineRankData($("#line_id3").val(), $("#ranking3").val(), datas, $("#line_id3 option:selected").text(), tp);
        });
        });

      
    }
    
  //所有线路车站排名
    var aldata,altitle;
    function AlllineRankData(line_id, ranking, datas, line_nm, tp) {
        //定义数据
        xldata = new Array();
        var title = "全路网线路客流排名";
        if (tp.indexOf("1") > -1 && tp.indexOf("3") > -1 && tp.length == 2) {
            title = line_nm + "客流排名";
        } else if (tp.indexOf("1") > -1 && tp.length == 1) {
            title = line_nm + "进站客流排名";
        } else if (tp.indexOf("2") > -1 && tp.length == 1) {
            title = line_nm + "出站客流排名";
        } else if (tp.indexOf("3") > -1 && tp.length == 1) {
            title = line_nm + "换乘客流排名";
        } else {

            var tp = (tp.indexOf("1") > -1 ? "进站+" : "") + (tp.indexOf("2") > -1 ? "出站+" : "") + (tp.indexOf("3") > -1 ? "换乘+" : "");
            title = tp.substring(0, tp.length - 1);

        }

        altitle=title;
        $.each(datas, function (i, v) {
            if (v.LINE_ID == line_id && parseInt(v.RN) <= parseInt(ranking)) {
                aldata.push(datas[i]);
            }
        });
        $('#mainChartZL').empty();

        alpm();
    }
    function alpm() {
    	
        var data=new Array();
        data=aldata;
        var title=altitle;
        //使用d3画出图表
        var svg = d3.select('#mainChartZF')
                .append('svg')
                .attr('width', svgWidth)
                .attr('height', svgHeight)
                .attr('id', 'svg-column');
        addXAxis();
        addYScale();
        addColumn();

        var dastr=new Array();
        function addXAxis() {
            var transform = d3.geoTransform({
                point: function (x, y) {
                    this.stream.point(x, y)
                }
            });
            //定义几何路径
            var path = d3.geoPath()
                    .projection(transform);

            xLinearScale = d3.scaleBand()
                    .domain(data.map(function (d) {
                        return d.LINE_ID;
                        // return d.STATION_NM.length > 4 ? d.STATION_NM.substring(0, 4) + "\n" + d.STATION_NM.substring(4, d.STATION_NM.length) : d.STATION_NM;

                    }))
                    .range([0, svgWidth - margin.right - margin.left], 0.1);
            var xAxis = d3.axisBottom(xLinearScale)
                    .ticks(data.length);
            //绘制X轴
            var xAxisG = svg.append("g")
                    .call(xAxis)
                    .attr("transform", "translate(" + (margin.left) + "," + (svgHeight - margin.bottom) + ")");

            //删除原X轴
            xAxisG.select("path").remove();
            xAxisG.selectAll('line').remove();

            dastr=data.map(function (d) {
                return d.STATION_NM;});
            var tex;

            //绘制新的立体X轴
            xAxisG.append("path")
                    .datum({
                        type: "Polygon",
                        coordinates: [
                            [
                                [20, 0],
                                [0, 15],
                                [svgWidth - margin.right - margin.left, 15],
                                [svgWidth + 20 - margin.right - margin.left, 0],
                                [20, 0]
                            ]
                        ]
                    })
                    .attr("d", path)
                    .attr('fill', 'rgb(187,187,187)');
            xAxisG.selectAll('text')
                    .attr('font-size', '12px')
                // .attr('transform', rotate(45))
                    .attr("dy", "10")
                    .attr("dx", "4")
                    .attr('fill', 'rgb(255,255,255)')
                    .attr('transform', 'translate(0,20)');







            dataProcessing(xLinearScale)//核心算法
        }
//向字符串指定位置中插入字符
        function insert_flg(str,flg,sn){
            var newstr="";
            for(var i=0;i<str.length;i+=sn){
                var tmp=str.substring(i, i+sn);
                newstr+=tmp+flg;
            }
            return newstr;
        }
        //创建y轴的比例尺渲染y轴
        function addYScale() {

            yLinearScale = d3.scaleLinear()
                    .domain([0, d3.max(data, function (d, i) {
                        return d.TOTAL_TIMES* 1.2;
                    }])
                    .range([svgHeight - margin.top - margin.bottom, 0]);

            //定义Y轴比例尺以及刻度
            var yAxis = d3.axisLeft(yLinearScale)
                    .ticks(6);

            //绘制Y轴
            var yAxisG = svg.append("g")
                    .call(yAxis)
                    .attr('transform', 'translate(' + (margin.left + 10) + "," + (margin.top + 13) + ")");
            yAxisG.selectAll('text')
                    .attr('font-size', '18px')
                    .attr('fill', 'rgb(255,255,255)')
            yAxisG.selectAll('line')
                    .attr('stroke', '#1DADFD')
            // .attr("transform", 'rotate(-37)');
            yAxisG.append("g")
                    .append("text")
                    .text("单位：万人次")
                    .attr("transform", "translate(85,3)")
                    .attr("text-anchor", "end")
                    .attr('font-size', '13px')
                    .attr("stroke", "white")
                    .attr("dy", "1em")


            svg.append("g")
                    .append("text")
                    .text(title)
                    .attr("class", "title")
                    .attr('font-size', '26px')
                    .attr('font-weight', 'bold')
                    .attr('fill', '#9EC5FF')
                    .attr("x", 20)
                    .attr("y", 23);
            yAxisG.select('path')
                    .attr('stroke', '#1DADFD')

            // yAxisG.select('line')
            // .attr('stroke','rgb(255,255,255)');
            //删除原Y轴路径和tick
            //yAxisG.select("path").remove();
            //yAxisG.selectAll('line').remove();
        }

        function dataProcessing(xLinearScale) {
            var angle = Math.PI / 2.4;
            for (var i = 0; i < data.length; i++) {
                var d = data[i];
                var depth = 10;
                d.ow = xLinearScale.bandwidth() * 0.5;
                d.ox = xLinearScale(d.LINE_ID);
                d.oh = 1;
                d.p1 = {
                    x: Math.cos(angle) * d.ow,
                    y: -Math.sin(angle) - depth
                };
                d.p2 = {
                    x: d.p1.x + d.ow,
                    y: d.p1.y
                };
                d.p3 = {
                    x: d.p2.x,
                    y: d.p2.y + d.oh
                };
            }
        }

        var tipTimerConfig = {
            longer: 0,
            target: null,
            exist: false,
            winEvent: window.event,
            boxHeight: 398,
            boxWidth: 376,
            maxWidth: 376,
            maxHeight: 398,
            tooltip: null,

            showTime: 3500,
            hoverTime: 300,
            displayText: "",
            show: function (val, e) {
                "use strict";
                var me = this;

                if (e != null) {
                    me.winEvent = e;
                }

                me.displayText = val;

                me.calculateBoxAndShow();

                me.createTimer();
            },
            calculateBoxAndShow: function () {
                "use strict";
                var me = this;
                var _x = 0;
                var _y = 0;
                var _w = document.documentElement.scrollWidth;
                var _h = document.documentElement.scrollHeight;
                var wScrollX = window.scrollX || document.body.scrollLeft;
                var wScrollY = window.scrollY || document.body.scrollTop;
                var xMouse = me.winEvent.x + wScrollX;
                if (_w - xMouse < me.boxWidth) {
                    _x = xMouse - me.boxWidth - 10;
                } else {
                    _x = xMouse;
                }

                var _yMouse = me.winEvent.y + wScrollY;
                if (_h - _yMouse < me.boxHeight + 18) {
                    _y = _yMouse - me.boxHeight - 25;
                } else {

                    _y = _yMouse + 18;
                }

                me.addTooltip(_x, _y);
            },
            addTooltip: function (page_x, page_y) {
                "use strict";
                var me = this;

                me.tooltip = document.createElement("div");
                me.tooltip.style.left = page_x + "px";
                me.tooltip.style.top = page_y + "px";
                me.tooltip.style.position = "absolute";

                me.tooltip.style.width = me.boxWidth + "px";
                me.tooltip.style.height = me.boxHeight + "px";
                me.tooltip.className = "three-tooltip";

                var divInnerHeader = me.createInner();
                divInnerHeader.innerHTML = me.displayText;
                me.tooltip.appendChild(divInnerHeader);

                document.body.appendChild(me.tooltip);
            },
            createInner: function () {
                "use strict";
                var me = this;
                var divInnerHeader = document.createElement('div');
                divInnerHeader.style.width = me.boxWidth + "px";
                divInnerHeader.style.height = me.boxHeight + "px";
                return divInnerHeader;
            },
            ClearDiv: function () {
                "use strict";
                var delDiv = document.body.getElementsByClassName("three-tooltip");
                for (var i = delDiv.length - 1; i >= 0; i--) {
                    document.body.removeChild(delDiv[i]);
                }
            },
            createTimer: function (delTarget) {
                "use strict";
                var me = this;
                var delTip = me.tooltip;
                var delTarget = tipTimerConfig.target;
                var removeTimer = window.setTimeout(function () {
                    try {
                        if (delTip != null) {
                            document.body.removeChild(delTip);
                            if (tipTimerConfig.target == delTarget) {
                                me.exist = false;
                            }
                        }
                        clearTimeout(removeTimer);
                    } catch (e) {
                        clearTimeout(removeTimer);
                    }
                }, me.showTime);
            },
            hoverTimerFn: function (showTip, showTarget) {
                "use strict";
                var me = this;

                var showTarget = tipTimerConfig.target;

                var hoverTimer = window.setInterval(function () {
                    try {
                        if (tipTimerConfig.target != showTarget) {
                            clearInterval(hoverTimer);
                        } else if (!tipTimerConfig.exist && (new Date()).getTime() - me.longer > me.hoverTime) {
                            //show
                            tipTimerConfig.show(showTip);
                            tipTimerConfig.exist = true;
                            clearInterval(hoverTimer);
                        }
                    } catch (e) {
                        clearInterval(hoverTimer);
                    }
                }, tipTimerConfig.hoverTime);
            }
        };

        var createTooltipTableData = function (info) {
            var ary = [];
            ary.push("<div class='tip-hill-div'>");
            ary.push("<h1>站台信息：" + infoLINE_ID + "</h1>");
            ary.push("<h2>客流量: " + info.TOTAL_TIMES + '万');
            ary.push("</div>");
            return ary.join("");
        };

        function addColumn() {
            function clumnMouseover(d) {
                d3.select(this).selectAll(".transparentPath").attr("opacity", 0.8);
                // 添加 div
                tipTimerConfig.target = this;
                tipTimerConfig.longer = new Date().getTime();
                tipTimerConfig.exist = false;
                //获取坐标
                tipTimerConfig.winEvent = {
                    x: event.clientX - 100,
                    y: event.clientY
                };
                tipTimerConfig.boxHeight = 50;
                tipTimerConfig.boxWidth = 140;

                //hide
                tipTimerConfig.ClearDiv();
                //show
                tipTimerConfig.hoverTimerFn(createTooltipTableData(d));
            }

            function clumnMouseout(d) {
                d3.select(this).selectAll(".transparentPath").attr("opacity", 1);
                tipTimerConfig.target = null;
                tipTimerConfig.ClearDiv();
            }

            //定义一种颜色
            var c= d3.rgb(255,255,255);
            var b = d3.rgb(152,156,237);

            //定义一个线性渐变
            var defs = svg.append("defs");

            var linearGradient = defs.append("linearGradient")
                    .attr("id","linearColor")
                    .attr("x1","0%")
                    .attr("y1","0%")
                    .attr("x2","100%")
                    .attr("y2","0%");

            var stop1 = linearGradient.append("stop")
                    .attr("offset","10%")
                    .style("stop-color",b.toString());
            var stop2 = linearGradient.append("stop")
                    .attr("offset","50%")
                    .style("stop-color",c.toString());

            var stop3 = linearGradient.append("stop")
                    .attr("offset","90%")
                    .style("stop-color",b.toString());
            var g = svg.selectAll('.g')
                    .data(data)
                    .enter()
                    .append('g')
                    .on("mouseover", clumnMouseover)
                    .on("mouseout", clumnMouseout)
                    .attr('transform', function (d) {
                        return "translate(" + (d.ox + margin.left + 15) + "," + (svgHeight - margin.bottom + 15) + ")"
                    });
            g.transition()
                    .duration(2500)
                    .attr("transform", function (d) {
                        return "translate(" + (d.ox + margin.left + 20) + ", " + (yLinearScale(d.TOTAL_TIMES) + margin.bottom - 15) + ")"
                    });

            g.append('rect')
                    .attr('x', 0)
                    .attr('y', 0)
                    .attr("class", "transparentPath")
                    .attr('width', function (d, i) {
                        return d.ow;
                    })
                    .attr('height', function (d) {
                        return d.oh;
                    })
                    .style('fill', function (d, i) {
                        return mainColorList[i]
                    })
                    .style('stroke','#BBBBBB')
                    .style('stroke-width','0.2')
                //.style('fill',"url(#" + linearGradient.attr("id") + ")")
                //.style('fill','#ebec5b')
                    .transition()
                    .duration(2500)
                    .attr("height", function (d, i) {
                        return svgHeight - margin.bottom - margin.top - yLinearScale(d.TOTAL_TIMES);
                    });

            g.append('path')
                    .attr("class", "transparentPath")
                    .attr('d', function (d) {
                        return "M0,0 L" + d.p1.x + "," + d.p1.y + " L" + d.p2.x + "," + d.p2.y + " L" + d.ow + ",0 L0,0";
                    })
                    .style('fill', function (d, i) {
                        return topColorList[i]
                    })
                    .style('stroke','#BBBBBB')
                    .style('stroke-width','0.2');
            //.style('fill','#ebec5b');

            g.append('path')
                    .attr("class", "transparentPath")
                    .attr('d', function (d) {
                        return "M" + d.ow + ",0 L" + d.p2.x + "," + d.p2.y + " L" + d.p3.x + "," + d.p3.y + " L" + d.ow + "," + d.oh + " L" + d.ow + ",0"
                    })
                    .style('fill', function (d, i) {
                        return rightColorList[i]
                    })
                    .style('stroke','#BBBBBB')
                    .style('stroke-width','0.2')
                // .style('fill','#ebec5b')
                    .transition()
                    .duration(2500)
                    .attr("d", function (d, i) {
                        return "M" + d.ow + ",0 L" + d.p2.x + "," + d.p2.y + " L" + d.p3.x + "," + (d.p3.y + svgHeight - margin.top - margin.bottom - yLinearScale(d.TOTAL_TIMES)) + " L" + d.ow + "," + (svgHeight - margin.top - margin.bottom - yLinearScale(d.TOTAL_TIMES)) + " L" + d.ow + ",0"
                    });
            //添加文字元素
            g.append("text").attr("class", "myText")
                    .attr("x", 5)
                    .attr("y", -28)
                    .attr("dy", '10')
                    .attr("dx", '10')
                    .attr('font-size', '17px')
                    .attr("width", '40px')
                    .attr("height", '30px')
                    .text(function (d) {
                        return (d.TOTAL_TIMES) + '万';
                    })
                    .attr('fill', 'rgb(255,255,255)');


        }

        //使用d3.js绘制图表

    }
    //d3绘制按单个线路的图表
    function xlpm() {
    	$(".prm").hide();
        $(".btn").val(">>");
        var data=new Array();
        data=xldata;
        var title=xltitle;
        //使用d3画出图表
        var svg = d3.select('#mainChartZF')
                .append('svg')
                .attr('width', svgWidth)
                .attr('height', svgHeight)
                .attr('id', 'svg-column');
        addXAxis();
        addYScale();
        addColumn();

        var dastr=new Array();
        function addXAxis() {
            var transform = d3.geoTransform({
                point: function (x, y) {
                    this.stream.point(x, y)
                }
            });
            //定义几何路径
            var path = d3.geoPath()
                    .projection(transform);

            xLinearScale = d3.scaleBand()
                    .domain(data.map(function (d) {
                        return d.STATION_NM;
                        // return d.STATION_NM.length > 4 ? d.STATION_NM.substring(0, 4) + "\n" + d.STATION_NM.substring(4, d.STATION_NM.length) : d.STATION_NM;

                    }))
                    .range([0, svgWidth - margin.right - margin.left], 0.1);
            var xAxis = d3.axisBottom(xLinearScale)
                    .ticks(data.length);
            //绘制X轴
            var xAxisG = svg.append("g")
                    .call(xAxis)
                    .attr("transform", "translate(" + (margin.left) + "," + (svgHeight - margin.bottom) + ")");

            //删除原X轴
            xAxisG.select("path").remove();
            xAxisG.selectAll('line').remove();

            dastr=data.map(function (d) {
                return d.STATION_NM;});
            var tex;

            //绘制新的立体X轴
            xAxisG.append("path")
                    .datum({
                        type: "Polygon",
                        coordinates: [
                            [
                                [20, 0],
                                [0, 15],
                                [svgWidth - margin.right - margin.left, 15],
                                [svgWidth + 20 - margin.right - margin.left, 0],
                                [20, 0]
                            ]
                        ]
                    })
                    .attr("d", path)
                    .attr('fill', 'rgb(187,187,187)');
            xAxisG.selectAll('text')
                    .attr('font-size', '12px')
                // .attr('transform', rotate(45))
                    .attr("dy", "10")
                    .attr("dx", "4")
                    .attr('fill', 'rgb(255,255,255)')
                    .attr('transform', 'translate(0,20)');







            dataProcessing(xLinearScale)//核心算法
        }
//向字符串指定位置中插入字符
        function insert_flg(str,flg,sn){
            var newstr="";
            for(var i=0;i<str.length;i+=sn){
                var tmp=str.substring(i, i+sn);
                newstr+=tmp+flg;
            }
            return newstr;
        }
        //创建y轴的比例尺渲染y轴
        function addYScale() {

            yLinearScale = d3.scaleLinear()
                    .domain([0, d3.max(data, function (d, i) {
                        return ((d.TIMES / 10000).toFixed(2)) * 1;
                    }) * 1.2])
                    .range([svgHeight - margin.top - margin.bottom, 0]);

            //定义Y轴比例尺以及刻度
            var yAxis = d3.axisLeft(yLinearScale)
                    .ticks(6);

            //绘制Y轴
            var yAxisG = svg.append("g")
                    .call(yAxis)
                    .attr('transform', 'translate(' + (margin.left + 10) + "," + (margin.top + 13) + ")");
            yAxisG.selectAll('text')
                    .attr('font-size', '18px')
                    .attr('fill', 'rgb(255,255,255)')
            yAxisG.selectAll('line')
                    .attr('stroke', '#1DADFD')
            // .attr("transform", 'rotate(-37)');
            yAxisG.append("g")
                    .append("text")
                    .text("单位：万人次")
                    .attr("transform", "translate(85,3)")
                    .attr("text-anchor", "end")
                    .attr('font-size', '13px')
                    .attr("stroke", "white")
                    .attr("dy", "1em")


            svg.append("g")
                    .append("text")
                    .text(title)
                    .attr("class", "title")
                    .attr('font-size', '26px')
                    .attr('font-weight', 'bold')
                    .attr('fill', '#9EC5FF')
                    .attr("x", 20)
                    .attr("y", 23);
            yAxisG.select('path')
                    .attr('stroke', '#1DADFD')

            // yAxisG.select('line')
            // .attr('stroke','rgb(255,255,255)');
            //删除原Y轴路径和tick
            //yAxisG.select("path").remove();
            //yAxisG.selectAll('line').remove();
        }

        function dataProcessing(xLinearScale) {
            var angle = Math.PI / 2.4;
            for (var i = 0; i < data.length; i++) {
                var d = data[i];
                var depth = 10;
                d.ow = xLinearScale.bandwidth() * 0.5;
                d.ox = xLinearScale(d.STATION_NM);
                d.oh = 1;
                d.p1 = {
                    x: Math.cos(angle) * d.ow,
                    y: -Math.sin(angle) - depth
                };
                d.p2 = {
                    x: d.p1.x + d.ow,
                    y: d.p1.y
                };
                d.p3 = {
                    x: d.p2.x,
                    y: d.p2.y + d.oh
                };
            }
        }

        var tipTimerConfig = {
            longer: 0,
            target: null,
            exist: false,
            winEvent: window.event,
            boxHeight: 398,
            boxWidth: 376,
            maxWidth: 376,
            maxHeight: 398,
            tooltip: null,

            showTime: 3500,
            hoverTime: 300,
            displayText: "",
            show: function (val, e) {
                "use strict";
                var me = this;

                if (e != null) {
                    me.winEvent = e;
                }

                me.displayText = val;

                me.calculateBoxAndShow();

                me.createTimer();
            },
            calculateBoxAndShow: function () {
                "use strict";
                var me = this;
                var _x = 0;
                var _y = 0;
                var _w = document.documentElement.scrollWidth;
                var _h = document.documentElement.scrollHeight;
                var wScrollX = window.scrollX || document.body.scrollLeft;
                var wScrollY = window.scrollY || document.body.scrollTop;
                var xMouse = me.winEvent.x + wScrollX;
                if (_w - xMouse < me.boxWidth) {
                    _x = xMouse - me.boxWidth - 10;
                } else {
                    _x = xMouse;
                }

                var _yMouse = me.winEvent.y + wScrollY;
                if (_h - _yMouse < me.boxHeight + 18) {
                    _y = _yMouse - me.boxHeight - 25;
                } else {

                    _y = _yMouse + 18;
                }

                me.addTooltip(_x, _y);
            },
            addTooltip: function (page_x, page_y) {
                "use strict";
                var me = this;

                me.tooltip = document.createElement("div");
                me.tooltip.style.left = page_x + "px";
                me.tooltip.style.top = page_y + "px";
                me.tooltip.style.position = "absolute";

                me.tooltip.style.width = me.boxWidth + "px";
                me.tooltip.style.height = me.boxHeight + "px";
                me.tooltip.className = "three-tooltip";

                var divInnerHeader = me.createInner();
                divInnerHeader.innerHTML = me.displayText;
                me.tooltip.appendChild(divInnerHeader);

                document.body.appendChild(me.tooltip);
            },
            createInner: function () {
                "use strict";
                var me = this;
                var divInnerHeader = document.createElement('div');
                divInnerHeader.style.width = me.boxWidth + "px";
                divInnerHeader.style.height = me.boxHeight + "px";
                return divInnerHeader;
            },
            ClearDiv: function () {
                "use strict";
                var delDiv = document.body.getElementsByClassName("three-tooltip");
                for (var i = delDiv.length - 1; i >= 0; i--) {
                    document.body.removeChild(delDiv[i]);
                }
            },
            createTimer: function (delTarget) {
                "use strict";
                var me = this;
                var delTip = me.tooltip;
                var delTarget = tipTimerConfig.target;
                var removeTimer = window.setTimeout(function () {
                    try {
                        if (delTip != null) {
                            document.body.removeChild(delTip);
                            if (tipTimerConfig.target == delTarget) {
                                me.exist = false;
                            }
                        }
                        clearTimeout(removeTimer);
                    } catch (e) {
                        clearTimeout(removeTimer);
                    }
                }, me.showTime);
            },
            hoverTimerFn: function (showTip, showTarget) {
                "use strict";
                var me = this;

                var showTarget = tipTimerConfig.target;

                var hoverTimer = window.setInterval(function () {
                    try {
                        if (tipTimerConfig.target != showTarget) {
                            clearInterval(hoverTimer);
                        } else if (!tipTimerConfig.exist && (new Date()).getTime() - me.longer > me.hoverTime) {
                            //show
                            tipTimerConfig.show(showTip);
                            tipTimerConfig.exist = true;
                            clearInterval(hoverTimer);
                        }
                    } catch (e) {
                        clearInterval(hoverTimer);
                    }
                }, tipTimerConfig.hoverTime);
            }
        };

        var createTooltipTableData = function (info) {
            var ary = [];
            ary.push("<div class='tip-hill-div'>");
            ary.push("<h1>站台信息：" + info.STATION_NM + "</h1>");
            ary.push("<h2>客流量: " + (info.TIMES / 10000).toFixed(2) + '万');
            ary.push("</div>");
            return ary.join("");
        };

        function addColumn() {
            function clumnMouseover(d) {
                d3.select(this).selectAll(".transparentPath").attr("opacity", 0.8);
                // 添加 div
                tipTimerConfig.target = this;
                tipTimerConfig.longer = new Date().getTime();
                tipTimerConfig.exist = false;
                //获取坐标
                tipTimerConfig.winEvent = {
                    x: event.clientX - 100,
                    y: event.clientY
                };
                tipTimerConfig.boxHeight = 50;
                tipTimerConfig.boxWidth = 140;

                //hide
                tipTimerConfig.ClearDiv();
                //show
                tipTimerConfig.hoverTimerFn(createTooltipTableData(d));
            }

            function clumnMouseout(d) {
                d3.select(this).selectAll(".transparentPath").attr("opacity", 1);
                tipTimerConfig.target = null;
                tipTimerConfig.ClearDiv();
            }

            //定义一种颜色
            var c= d3.rgb(255,255,255);
            var b = d3.rgb(152,156,237);

            //定义一个线性渐变
            var defs = svg.append("defs");

            var linearGradient = defs.append("linearGradient")
                    .attr("id","linearColor")
                    .attr("x1","0%")
                    .attr("y1","0%")
                    .attr("x2","100%")
                    .attr("y2","0%");

            var stop1 = linearGradient.append("stop")
                    .attr("offset","10%")
                    .style("stop-color",b.toString());
            var stop2 = linearGradient.append("stop")
                    .attr("offset","50%")
                    .style("stop-color",c.toString());

            var stop3 = linearGradient.append("stop")
                    .attr("offset","90%")
                    .style("stop-color",b.toString());
            var g = svg.selectAll('.g')
                    .data(data)
                    .enter()
                    .append('g')
                    .on("mouseover", clumnMouseover)
                    .on("mouseout", clumnMouseout)
                    .attr('transform', function (d) {
                        return "translate(" + (d.ox + margin.left + 15) + "," + (svgHeight - margin.bottom + 15) + ")"
                    });
            g.transition()
                    .duration(2500)
                    .attr("transform", function (d) {
                        return "translate(" + (d.ox + margin.left + 20) + ", " + (yLinearScale((d.TIMES / 10000).toFixed(2)) + margin.bottom - 15) + ")"
                    });

            g.append('rect')
                    .attr('x', 0)
                    .attr('y', 0)
                    .attr("class", "transparentPath")
                    .attr('width', function (d, i) {
                        return d.ow;
                    })
                    .attr('height', function (d) {
                        return d.oh;
                    })
                    .style('fill', function (d, i) {
                        return mainColorList[i]
                    })
                    .style('stroke','#BBBBBB')
                    .style('stroke-width','0.2')
                //.style('fill',"url(#" + linearGradient.attr("id") + ")")
                //.style('fill','#ebec5b')
                    .transition()
                    .duration(2500)
                    .attr("height", function (d, i) {
                        return svgHeight - margin.bottom - margin.top - yLinearScale((d.TIMES / 10000).toFixed(2));
                    });

            g.append('path')
                    .attr("class", "transparentPath")
                    .attr('d', function (d) {
                        return "M0,0 L" + d.p1.x + "," + d.p1.y + " L" + d.p2.x + "," + d.p2.y + " L" + d.ow + ",0 L0,0";
                    })
                    .style('fill', function (d, i) {
                        return topColorList[i]
                    })
                    .style('stroke','#BBBBBB')
                    .style('stroke-width','0.2');
            //.style('fill','#ebec5b');

            g.append('path')
                    .attr("class", "transparentPath")
                    .attr('d', function (d) {
                        return "M" + d.ow + ",0 L" + d.p2.x + "," + d.p2.y + " L" + d.p3.x + "," + d.p3.y + " L" + d.ow + "," + d.oh + " L" + d.ow + ",0"
                    })
                    .style('fill', function (d, i) {
                        return rightColorList[i]
                    })
                    .style('stroke','#BBBBBB')
                    .style('stroke-width','0.2')
                // .style('fill','#ebec5b')
                    .transition()
                    .duration(2500)
                    .attr("d", function (d, i) {
                        return "M" + d.ow + ",0 L" + d.p2.x + "," + d.p2.y + " L" + d.p3.x + "," + (d.p3.y + svgHeight - margin.top - margin.bottom - yLinearScale((d.TIMES / 10000).toFixed(2))) + " L" + d.ow + "," + (svgHeight - margin.top - margin.bottom - yLinearScale((d.TIMES / 10000).toFixed(2))) + " L" + d.ow + ",0"
                    });
            //添加文字元素
            g.append("text").attr("class", "myText")
                    .attr("x", 5)
                    .attr("y", -28)
                    .attr("dy", '10')
                    .attr("dx", '10')
                    .attr('font-size', '17px')
                    .attr("width", '40px')
                    .attr("height", '30px')
                    .text(function (d) {
                        return ((d.TIMES / 10000).toFixed(2)) + '万';
                    })
                    .attr('fill', 'rgb(255,255,255)');


        }

        //使用d3.js绘制图表

    }


 
  

    var flowPeriodOption;
    var periodData;
    var periodAllData;
    var fslx;
    //加载分时客流对比数据
    function loadFluxPeriodData() {
        $(".prm").hide();
        $(".btn").val(">>");
        $(".tab").show();
        $("#period_hb").siblings().removeClass("act");
        $("#period_hb").addClass("act");

        var start_date = $("#start_date4").val();//选择日期
        var com_date = $("#com_date4").val();//对比日期
        var flux_flag = $('input[name="flux_flag4"]:checked');//选择进出站方式
        var tp = "";

        if (flux_flag && flux_flag.length > 0) {
            $(flux_flag).each(function (i, v) {
                tp += $(v).val();
            });
        } else {
            alert("请选择进出站方式！");
            return;
        }

        var line_id = $("#line_id4").val();//线路
        if (line_id == null || typeof(line_id) == "undefined") {
            line_id = "00";
        }
        var station_id = $("#station_id4").val();//车站

        var line_nm = $("#line_id4 option:selected").text();//选择线路名称
        periodAllData = {
            title: [{
                text: '客流分时比较',
                x: 'left',
                y:'-6',
                textStyle: {fontSize: 27, fontWeight: 'bolder', color: '#9EC5FF'}
            }]
        };
        var tp_title = "";
        if (station_id) {
            periodAllData.selectedStation = true;
            tp_title = $("#station_id4 option:selected").text();
        } else {
            periodAllData.selectedStation = false;
            tp_title = $("#line_id4 option:selected").text();
        }
        if (tp.indexOf("1") > -1 && tp.indexOf("3") > -1 && tp.length == 2) {
            periodAllData.title[0].text = tp_title + "客流分时比较";
        } else if (tp.indexOf("1") > -1 && tp.length == 1) {
            periodAllData.title[0].text = tp_title + "进站客流分时比较";
        } else if (tp.indexOf("2") > -1 && tp.length == 1) {
            periodAllData.title[0].text = tp_title + "出站客流分时比较";
        } else if (tp.indexOf("3") > -1 && tp.length == 1) {
            periodAllData.title[0].text = tp_title + "换乘客流分时比较";
        } else {
            periodAllData.title[0].text = tp_title + "客流分时比较";
            var tp_str = (tp.indexOf("1") > -1 ? "进站+" : "") + (tp.indexOf("2") > -1 ? "出站+" : "") + (tp.indexOf("3") > -1 ? "换乘+" : "");
            periodAllData.title.push({
                text: "(" + tp_str.substring(0, tp_str.length - 1) + ")",
                x: '450',
                y: '15',
                textStyle: {fontSize: 12, color: '#FFF'}
            });
        }
        $('#mainChartFS').empty();
        if(kllx=='period_tb'||kllx=='period_hb'||kllx=='period_zdy'){
            
        }else{
            kllx = 'period_hb';
        }


        //同比数据
         doPost("station/get_fluxperiod.action", {
         "start_date": "<%=start_date %>",
         "com_date": "<%=tb_date%>",
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
           doPost("station/get_fluxperiod.action", {
         "start_date": "<%=start_date %>",
         "com_date": "<%=hb_date%>",
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
         doPost("station/get_fluxperiod.action", {
         "start_date": start_date,
         "com_date": com_date,
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

    }

    function setPeriodOption(data, start_date, com_date) {
        flowPeriodOption = {
            title: periodAllData.title,
            tooltip: {
                trigger: 'axis',
                textStyle: {fontWeight: 'bold', fontSize: 18},
                formatter: function (p) {
                    var tp_str = p[0].name + "<br/>" + p[0].seriesName + "：";
                    if (isNaN(p[0].value) || typeof(p[0].value) == "undefined") {
                        tp_str += "--";
                    } else {
                        tp_str += (periodAllData.selectedStation ? p[0].value : p[0].value + "万");
                    }
                    tp_str += "<br/>" + p[1].seriesName + "：" + (periodAllData.selectedStation ? p[1].value : p[1].value) + "万";
                    return tp_str;
                }
            },
            legend: {
                selectedMode: false,
                x: 'center',
                y: '25',
                textStyle: {fontWeight: 'bold', fontSize: 18},
                data: []
            },
            calculable: true,
            grid: {'y': 55, 'y2': 30, 'x': 70, 'x2': 25},
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
                    name: '人次',
                    splitLine: {lineStyle: {type: 'dashed',color:'#0462FF',width:0.7}},
                    axisLine: {lineStyle: {color: '#0462FF', width: 2}},
                    axisLabel: {
                        textStyle: {fontWeight: 'bold', fontSize: 18, color: '#FFF'},
                        formatter: periodAllData.selectedStation ? '{value}' : '{value}万'
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

        flowPeriodOption.legend.data = [{name: dateFt0, textStyle: {color: '#0462FF'}}];
        flowPeriodOption.series[0].name = dateFt0;

        var times = [], com_times = [], period = [];
        $.each(data, function (i, v) {
            if (periodAllData.selectedStation) {
                times.push(v.TIMES);
                com_times.push(v.COM_TIMES);
            } else {
                times.push((v.TIMES / 10000).toFixed(2));
                com_times.push((v.COM_TIMES / 10000).toFixed(2));
            }

            if (parseInt(v.TIME_PERIOD.toString().substr(3, 2)) % 15 == 0) {
                if (v.TIME_PERIOD.toString().substr(v.TIME_PERIOD.toString().length - 1, 1) == "5") {
                    period.push({
                        value: v.TIME_PERIOD,
                        textStyle: {fontSize: 12}
                    });
                } else {
                    period.push({
                        value: v.TIME_PERIOD,
                        textStyle: {fontSize: 16, fontWeight: 'bold'}
                    });
                }

            } else {
                period.push({
                    value: v.TIME_PERIOD,
                    textStyle: {fontSize: 0, fontWeight: 0, color: 'rgba(32,32,35,0)'}
                });
            }

        });

        //销毁图例
        if (chartPeriodCom) {
            chartPeriodCom.dispose();
        }

        flowPeriodOption.series[0].data = times;
        flowPeriodOption.xAxis[0].data = period;

        chartPeriodCom = echarts.init(document.getElementById('mainChartFS'));
        chartPeriodCom.setOption(flowPeriodOption, true);

        //延迟加载“运营日期”的数据
        setTimeout(function () {
            secLoad(dateFt1, com_times);
        }, 1000);
    }
    function loadlineAndstas() {
        $.ajax({
            //请求方式为get
            type: "GET",
            //json文件位置
            url: "linesta.json",
            //返回数据格式为json
            dataType: "json",
            //请求成功完成后要执行的方法
            success: function (data) {
                var line = eval(data);
                var tp_line = "<option value='00'>全路网</option>";
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

                $("#line_id2").html(tp_line);
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

            }
        });

    }
    //加载线路车站
    function loadLineAndStation() {
        doPost("station/get_fluxperiod.action", {"sel_flag": "1"}, function (data) {
            var line = eval(data);
            //var tp_line = "<option value='00'>全路网</option>";
            var tp_line = "";
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

            $("#line_id2").html(tp_line);
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
        flowPeriodOption.legend.data.push({name: dateFt1, textStyle: {color: '#FFC001'}});
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
</script>
</body>
</html>