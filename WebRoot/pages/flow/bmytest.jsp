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
	<script src="http://code.highcharts.com/highcharts.js"></script>
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
            top: 25px;
            position: relative;
            width: 900px;
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
            margin-left: 7%;
            margin-top: 20%;
            margin-bottom: 12px;
            width: 100%;
            height: calc(100% - 250px);
        }
        .sranks {
            margin-left: 4%;
            margin-top: 18%;
            margin-bottom: 20px;
            width: 850px;
            height: calc(100% - 220px);
        }
        .filters {
            top: 8px;
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
            width: 71px;
            height: 30px;
            color: #fff;
            text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25);
            background-color: #1134A8;
            text-align: center;
            border-radius: 9px;
            padding: 2px 15px;
            margin-bottom: 0;
            font-size: 15px;
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
 .tabs {
            float: right;
            margin-left: 10px;
            height: 45px;
            width: 900px;
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
                            <input id="l13" type="button" value="13" class="searchbtns" style="background-color: #DC87C2">
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
                                    <option value="20">全路网</option>
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

                    <div data-v-c5b8f8b4 class="filters" style="width: 850px">
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
             
            $(".tabs").show();
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
    var kldata,pmtitle,klcateData,klseriData;
    function stationRankData(line_id, ranking, datas, line_nm, tp) {
        //定义数据
         kldata = new Array();
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
        pmtitle=title;
      //X轴上的数据
        klcateData=new Array();
       //Y轴上的数据
        klseriData=[];
        $.each(datas, function (i, v) {
            if (v.LINE_ID == line_id && parseInt(v.RN) <= parseInt(ranking)) {
                kldata.push(datas[i]);
                klcateData.push(v.STATION_NM);
                klseriData.push(parseFloat((v.TIMES / 10000).toFixed(1)));
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
        var  chart = new Highcharts.Chart({
            chart: {
                height:500,
                width:830,
                backgroundColor: 'rgba(0,0,0,0)',
               // backgroundColor: '#ff0000',
                renderTo: 'mainChart',
                type: 'column'
            },
            title: {

                align: 'center',
                y:15,
                text: title,
                style: {
                    fontSize: '30px',
                    fontWeight:"bold",

                    color:'#9EC5FF',
                    fontFamily: ' sans-serif'
                }
            },
	subtitle: {

              align: 'left',
              y:40,
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
                categories: klcateData,

                labels: {
                    rotation: -30,

                    align: 'right',
                    style: {
                        fontSize: '15px',
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
                        fontSize: '14px',
			display:"none",
                        color:'rgb(255,255,255)',
                        fontFamily: 'Verdana, sans-serif'
                    }
                },
                labels:{
                    style: {
                        fontSize: '17px',
                        color:'rgb(255,255,255)',
                        fontFamily: 'Verdana, sans-serif'
                    }

        }
            },
            tooltip: {
                headerFormat: '<span style="font-size:16px;">{point.key}</span><table>',
                pointFormat: '<tr><td style="color:{series.color};padding:0;"> </td>' +
                '<td style="padding:0;font-size:17px"><b>{point.y:.2f}</b></td></tr>',
                footerFormat: '</table>',
                shared: true,
                useHTML: true
            },
            plotOptions: {
                column: {
                    pointWidth:48,
                    pointPadding: 0.2,
                    borderWidth: 0,
                    shadow: false,            //不显示阴影
                    dataLabels: {                //柱状图数据标签
                        enabled: true,              //是否显示数据标签
                        //color: '#FFFFFF',        //数据标签字体颜色
                        style: {
                            fontSize: '16px',
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
                 data: klseriData
            }]


        }, function (chart) {
            SetEveryOnePointColora(chart);
        });

        chart.series[0].update({
            data:klseriData
        });

    }
      //设置每一个数据点的颜色值
	
        function SetEveryOnePointColora(chart) {
            //获得第一个序列的所有数据点
            var pointsList = chart.series[0].points;
            //遍历设置每一个数据点颜色
            for (var i = 0; i < pointsList.length; i++) {
                chart.series[0].points[i].update({
                    color: {
                        linearGradient: { x1: 0, y1: 0, x2: 1, y2: 0 }, //横向渐变效果 如果将x2和y2值交换将会变成纵向渐变效果
                        stops: [
                            [0, Highcharts.Color('#880000').setOpacity(1).get('rgba')],
                            //[0, Highcharts.Color(colorArr[i]).setOpacity(1).get('rgba')],
			[0.5, Highcharts.Color('#FF8888').setOpacity(1).get('rgba')],                          
			//[0.5, 'rgb(255, 255, 255)'],
                            [1, Highcharts.Color('#880000').setOpacity(1).get('rgba')]
                            //[1, Highcharts.Color(colorArr[i]).setOpacity(1).get('rgba')]
                        ]
                    }
                });
            }
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

 //线路切换
	 $('#l1').click(function(){
        aicolor='#FF8888';
        aocolor='#ED3229';
        line_id='01';
        line_nm='1号线';

        lineRankData(line_id, $("#ranking1").val(), datas,line_nm , tpa);
    });
    $('#l2').click(function(){
        aicolor='#99FF99';
        aocolor='#36B854';
       
        line_id='02';
        line_nm='2号线';

       lineRankData(line_id, $("#ranking1").val(), datas,line_nm , tpa);
    });
    $('#l3').click(function(){
        aicolor='#FFEE99';
        aocolor='#FFD823';
        line_id='03';
        line_nm='3号线';

        lineRankData(line_id, $("#ranking1").val(), datas,line_nm , tpa);
    });
    $('#l4').click(function(){
        aicolor='#B088FF';
        aocolor='#320176';
        line_id='04';
        line_nm='4号线';

        lineRankData(line_id, $("#ranking1").val(), datas,line_nm , tpa);
    });
    $('#l5').click(function(){
        aicolor='#E38EFF';
        aocolor='#823094';
        line_id='05';
        line_nm='5号线';

        lineRankData(line_id, $("#ranking1").val(), datas,line_nm , tpa);
    });
    $('#l6').click(function(){
        aicolor='#FF88C2';
        aocolor='#CF047A';
        line_id='06';
        line_nm='6号线';

        lineRankData(line_id, $("#ranking1").val(), datas,line_nm , tpa);
    });
    $('#l7').click(function(){
        aicolor='#FFBB66';
        aocolor='#F3560F';
        line_id='07';
        line_nm='7号线';

        lineRankData(line_id, $("#ranking1").val(), datas,line_nm , tpa);
    });
    $('#l8').click(function(){
        aicolor='#99BBFF';
        aocolor='#008CC1';
        line_id='08';
        line_nm='8号线';

        lineRankData(line_id, $("#ranking1").val(), datas,line_nm , tpa);
    });
    $('#l9').click(function(){
        aicolor='#CCEEFF';
        aocolor='#91C5DB';
        line_id='09';
        line_nm='9号线';

        lineRankData(line_id, $("#ranking1").val(), datas,line_nm , tpa);
    });
    $('#l10').click(function(){
        aicolor='#CCBBFF';
        aocolor='#C7AFD3';
        line_id='10';
        line_nm='10号线';

        lineRankData(line_id, $("#ranking1").val(), datas,line_nm , tpa);
    });
    $('#l11').click(function(){
        aicolor='#FF8888';
        aocolor='#842223';
        line_id='11';
        line_nm='11号线';

        lineRankData(line_id, $("#ranking1").val(), datas,line_nm , tpa);
    });
    $('#l12').click(function(){
        aicolor='#77FF00';
        aocolor='#007C64';
        line_id='12';
        line_nm='12号线';

        lineRankData(line_id, $("#ranking1").val(), datas,line_nm , tpa);
    });
    $('#l13').click(function(){
        aicolor='#FFCCCC';
        aocolor='#DC87C2';
        line_id='13';
        line_nm='13号线';

        lineRankData(line_id, $("#ranking1").val(), datas,line_nm , tpa);
    });
    $('#l16').click(function(){
        aicolor='#99FFFF';
        aocolor='#33D4CC';
        line_id='16';
        line_nm='16号线';

        lineRankData(line_id, $("#ranking1").val(), datas,line_nm , tpa);
    });
    $('#l17').click(function(){
        aicolor='#FFC0CB';
        aocolor='#BC7970';
        line_id='17';
        line_nm='17号线';

        lineRankData(line_id, $("#ranking1").val(), datas,line_nm , tpa);
    });
    $('#l18').click(function(){
        aicolor='#FFFFFF';
        aocolor='#DDDDDD';
        line_id='41';
        line_nm='浦江线';

        lineRankData(line_id, $("#ranking1").val(), datas,line_nm , tpa);
    });
  //加载所有线路客流排名数据
    function loadAllLineRankData() {
        $(".prm").hide();
         $(".btn").val(">>");
      //   $(".tab").hide();

        var start_date = $("#start_date3").val();//选择日期
        var flux_flag = $('input[name="flux_flag3"]:checked');//选择进出站方式
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
    var aldata,altitle,alcateData,alseriData,colowid,icolor,ocolor;
    function AlllineRankData(line_id, ranking, datas, line_nm, tp) {
        //定义数据
        aldata = new Array();
        var title = "全路网线路客流排名";
        if (tp.indexOf("1") > -1 && tp.indexOf("3") > -1 && tp.length == 2) {
            title = line_nm + "线路客流排名";
        } else if (tp.indexOf("1") > -1 && tp.length == 1) {
            title = line_nm + "线路进站客流排名";
        } else if (tp.indexOf("2") > -1 && tp.length == 1) {
            title = line_nm + "线路出站客流排名";
        } else if (tp.indexOf("3") > -1 && tp.length == 1) {
            title = line_nm + "线路换乘客流排名";
        } else {

            var tp = (tp.indexOf("1") > -1 ? "进站+" : "") + (tp.indexOf("2") > -1 ? "出站+" : "") + (tp.indexOf("3") > -1 ? "换乘+" : "");
            title = tp.substring(0, tp.length - 1);

        }

        altitle=title;
	//柱子宽度
	var ran=ranking;
	if(ran=='20'){
	colowid='35';
	}else{
	colowid='48';
	};
      //X轴上的数据
        alcateData=new Array();
       //Y轴上的数据
        alseriData=[];
		ocolorArr=[];
                icolorArr=[];
        $.each(datas, function (i, v) {
            if (i<ranking) {
                aldata.push(v);
		
                //alcateData.push(v.LINE_ID);
                alseriData.push(parseFloat(v.TOTAL_TIMES.toFixed(1)));
                
                if(v.LINE_ID=='02'){
                   alcateData.push('2号线');
                   icolor='#66FF66';
                   ocolor='#36B854';
                   ocolorArr.push(ocolor);
                   icolorArr.push(icolor);
               }
               if(v.LINE_ID=='01'){
                   alcateData.push('1号线');
                   icolor='#FF8888';
                   ocolor='#ED3229';
                   ocolorArr.push(ocolor);
                   icolorArr.push(icolor);
               }
               if(v.LINE_ID=='08'){
                   alcateData.push('8号线');
                   icolor='#99BBFF';
                   ocolor='#008CC1';
                   ocolorArr.push(ocolor);
                   icolorArr.push(icolor);
               }
               if(v.LINE_ID=='09'){
                   alcateData.push('9号线');
                   icolor='#CCEEFF';
                   ocolor='#91C5DB';
                   ocolorArr.push(ocolor);
                   icolorArr.push(icolor);
               }
               if(v.LINE_ID=='10'){
                   alcateData.push('10号线');
                   icolor='#CCBBFF';
                   ocolor='#C7AFD3';
                   ocolorArr.push(ocolor);
                   icolorArr.push(icolor);
               }
               if(v.LINE_ID=='04'){
                   alcateData.push('4号线');
                   icolor='#B088FF';
                   ocolor='#320176';
                   ocolorArr.push(ocolor);
                   icolorArr.push(icolor);
               }
               if(v.LINE_ID=='11'){
                   alcateData.push('11号线');
                   icolor='#FF8888';
                   ocolor='#842223';
                   ocolorArr.push(ocolor);
                   icolorArr.push(icolor);
               }
               if(v.LINE_ID=='07'){
                   alcateData.push('7号线');
                   icolor='#FFBB66';
                   ocolor='#F3560F';
                   ocolorArr.push(ocolor);
                   icolorArr.push(icolor);
               }
               if(v.LINE_ID=='12'){
                   alcateData.push('12号线');
                   icolor='#77FF00';
                   ocolor='#007C64';
                   ocolorArr.push(ocolor);
                   icolorArr.push(icolor);
               }
               if(v.LINE_ID=='03'){
                   alcateData.push('3号线');
                   icolor='#FFEE99';
                   ocolor='#FFD823';
                   ocolorArr.push(ocolor);
                   icolorArr.push(icolor);
               }
               if(v.LINE_ID=='06'){
                   alcateData.push('6号线');
                   icolor='#FF88C2';
                   ocolor='#CF047A';
                   ocolorArr.push(ocolor);
                   icolorArr.push(icolor);
               }
               if(v.LINE_ID=='13'){
                   alcateData.push('13号线');
                   icolor='#FFCCCC';
                   ocolor='#DC87C2';
                   ocolorArr.push(ocolor);
                   icolorArr.push(icolor);
               }
               if(v.LINE_ID=='16'){
                   alcateData.push('16号线');
                   icolor='#99FFFF';
                   ocolor='#33D4CC';
                   ocolorArr.push(ocolor);
                   icolorArr.push(icolor);
               }
               if(v.LINE_ID=='05'){
                   alcateData.push('5号线');
                   icolor='#E38EFF';
                   ocolor='#823094';
                   ocolorArr.push(ocolor);
                   icolorArr.push(icolor);
               }
               if(v.LINE_ID=='17'){
                   alcateData.push('17号线');
                   icolor='#FFC0CB';
                   ocolor='#BC7970';
                   ocolorArr.push(ocolor);
                   icolorArr.push(icolor);
               }
               if(v.LINE_ID=='浦江线'){
                   alcateData.push('浦江线');
                   icolor='#FFFFFF';
                   ocolor='#DDDDDD';
                   ocolorArr.push(ocolor);
                   icolorArr.push(icolor);
               }
            }
        });
        $('#mainChartZL').empty();

        alpm();
    }
    function alpm() {
    	
        var data=new Array();
        data=aldata;
        var title=altitle;
        
        var  chart = new Highcharts.Chart({
            chart: {
                height:500,
                width:830,
                backgroundColor: 'rgba(0,0,0,0)',
               // backgroundColor: '#ff0000',
                renderTo: 'mainChartZL',
                type: 'column'
            },
            title: {

                align: 'center',
                y:15,
                text: title,
                style: {
                    fontSize: '30px',
                    fontWeight:"bold",

                    color:'#9EC5FF',
                    fontFamily: ' sans-serif'
                }
            },
		subtitle: {

              align: 'left',
              y:40,
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
                categories: alcateData,

                labels: {
                    rotation: -30,

                    align: 'right',
                    style: {
                        fontSize: '16px',
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
                        fontSize: '14px',
 			display:"none",
                        color:'rgb(255,255,255)',
                        fontFamily: 'Verdana, sans-serif'
                    }
                },
                labels:{
                    style: {
                        fontSize: '17px',
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
                    pointWidth:colowid,
                    pointPadding: 0.2,
                    borderWidth: 0,
                    shadow: false,            //不显示阴影
                    dataLabels: {                //柱状图数据标签
                        enabled: true,              //是否显示数据标签
                        //color: '#FFFFFF',        //数据标签字体颜色
                        style: {
                            fontSize: '16px',
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
                 data: alseriData
            }]


        }, function (chart) {
            SetEveryOnePointColord(chart);
        });

        chart.series[0].update({
            data:alseriData
        });
    }
    
  //设置每一个数据点的颜色值
	var icolorArr=new Array();
	var ocolorArr=new Array();
    function SetEveryOnePointColord(chart) {
        //获得第一个序列的所有数据点
        var pointsList = chart.series[0].points;
        //遍历设置每一个数据点颜色
        for (var i = 0; i < pointsList.length; i++) {
            chart.series[0].points[i].update({
                color: {
                    linearGradient: { x1: 0, y1: 0, x2: 1, y2: 0 }, //横向渐变效果 如果将x2和y2值交换将会变成纵向渐变效果
                    stops: [
                       
                        [0, Highcharts.Color(ocolorArr[i]).setOpacity(1).get('rgba')],
			[0.5, Highcharts.Color(icolorArr[i]).setOpacity(1).get('rgba')],
			[1, Highcharts.Color(ocolorArr[i]).setOpacity(1).get('rgba')]
			
                    ]
                }
            });
        }
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
                height:500,
                width:830,
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

                    color:'#9EC5FF',
                    fontFamily: ' sans-serif'
                }
            },
	subtitle: {

              align: 'left',
              y:40,
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
                        fontSize: '15px',
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
                        fontSize: '14px',
                        color:'rgb(255,255,255)',
                        fontFamily: 'Verdana, sans-serif'
                    }
                },
                labels:{
                    style: {
                        fontSize: '17px',
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
                    pointWidth:48,
                    pointPadding: 0.2,
                    borderWidth: 0,
                    shadow: false,            //不显示阴影
                    dataLabels: {                //柱状图数据标签
                        enabled: true,              //是否显示数据标签
                        //color: '#FFFFFF',        //数据标签字体颜色
                        style: {
                            fontSize: '16px',
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

	     startTime=$("#fir_hour").val()+$("#fir_min").val();
         endTime=$("#end_hour").val()+$("#end_min").val();
        periodAllData = {
            title: [{
                text: '客流分时比较',
                x: 'center',
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
                    tp_str += "<br/>" + p[1].seriesName + "：" + (periodAllData.selectedStation ? p[1].value : p[1].value+ "万" ) ;
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
                    name: unit,
			nameTextStyle:{
                        color:"#FFF",
                        fontSize:'15'

                    },
                    splitLine: {lineStyle: {type: 'dashed',color:'#0462FF',width:0.7}},
                    axisLine: {lineStyle: {color: '#0462FF', width: 2}},
                    axisLabel: {
                        textStyle: {fontWeight: 'bold', fontSize: 18, color: '#FFF'},
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

        flowPeriodOption.legend.data = [{name: dateFt0, textStyle: {color: '#0462FF'}}];
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
             textStyle: {fontSize: 16, fontWeight: 'bold'}
         });
     }else{

         period.push({
             value: v.TIME_PERIOD,
             textStyle: {fontSize: 12, color: 'rgba(32,32,35,0)'}
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
                 textStyle: {fontSize: 16, fontWeight: 'bold'}
             });
         }

     } else {
         // alert(222);


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