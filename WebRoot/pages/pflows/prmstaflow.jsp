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
                <div data-v-c5b8f8b4 data-v-0b39df2e class="point" id="kllx">
                    <div id="mainChart" class=""></div>

                   <%--  <div data-v-c5b8f8b4 class="filter">
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
                                    <option value="8">前8</option>
                                     <option value="15" selected="selected">全路网</option>
                                </select>
                            </div>

                            <input type="button" value="查询" onclick="loadStationRankData()" class="searchbtn">
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

        loadStationRankData();
      

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
    function stationRankData(datas) {
        //定义数据
         kldata = new Array();
        var title = "重点车站客流排名";
       
        

          

        
        pmtitle=title;
      //X轴上的数据
        klcateData=new Array();
       //Y轴上的数据
        klseriData=[];
        
        $.each(datas, function (i, v) {
            
                //kldata.push(datas[i]);
                klcateData.push(v.STATION_NM_CN);
                klseriData.push(parseFloat(v.PASS_NUM));
            
            
        });
        $('#mainChart').empty();

        klpm();
    }
	 //d3生成客流排名图表
        function klpm() {
       // klty == "klkllx";
        var data=new Array();
        data=kldata;
        var title=pmtitle;
        var  chart = new Highcharts.Chart({
            chart: {
                height:260,
                width:430,
                spacingTop: -17, 
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
                    fontSize: '20px',
                    fontWeight:"bold",

                    color:'rgba(248,248,255,0)',
                    fontFamily: ' sans-serif'
                }
            }, 
	subtitle: {

              align: 'left',
              y:40,
              x:15,
              text: '单位：万人次',
              style: {
                  fontSize: '10px',
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
                        fontSize: '9px',
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
                        fontSize: '10px',
			display:"none",
                        color:'rgb(255,255,255)',
                        fontFamily: 'Verdana, sans-serif'
                    }
                },
                labels:{
                    style: {
                        fontSize: '10px',
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
                    pointWidth:25,
                    pointPadding: 0.05,
                    borderWidth: 0,
                    shadow: false,            //不显示阴影
                    dataLabels: {                //柱状图数据标签
                        enabled: true,              //是否显示数据标签
                        //color: '#FFFFFF',        //数据标签字体颜色
                        style: {
                            fontSize: '10px',
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
                            [0, Highcharts.Color('#B94FFF ').setOpacity(1).get('rgba')],
                            //[0, Highcharts.Color(colorArr[i]).setOpacity(1).get('rgba')],
			[0.5, Highcharts.Color('#E8CCFF').setOpacity(1).get('rgba')],                          
			//[0.5, 'rgb(255, 255, 255)'],
                            [1, Highcharts.Color('#B94FFF ').setOpacity(1).get('rgba')]
                            //[1, Highcharts.Color(colorArr[i]).setOpacity(1).get('rgba')]
                        ]
                    }
                });
            }
        }
    //加载车站客流排名数据

    function loadStationRankData() {
      

        var start_date ="<%=start_date %>";
       
        var tp = 13;
        

        //var line_id = $("#line_id1").val();//选择线路
        var line_id = '';
       // var line_nm = $("#line_id1 option:selected").text();//选择线路
        var line_nm = '';
      //  var ranking = $("#ranking1").val();//排名
        var ranking ='';


			$.post("zdchzpfw/GetZdChzpfws.action",{"date":start_date,"type":tp}, function(data){
         //doPost("station/get_station_fluxrank.action", {"start_date": start_date, "flux_flag": tp}, function (data) {
             var datas = data;
             stationRankData( datas);



     
         });
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
       /*  setTimeout(function () {
            
        }, 1000); */
  
</script>
</body>
</html>