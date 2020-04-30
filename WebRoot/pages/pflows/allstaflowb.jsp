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
            width: 900px;
            margin-left: -4%;

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
            height: 550px;
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
                    <div id="czklchar" class="srank"></div>

                    <div data-v-c5b8f8b4 class="filter">
                        <input type="button" value=">>" class="btn" style="font-weight: bold">

                        <div class="prm">
                            运营日期：<input type="text" name="start_date" id="start_date1" value="<%=start_date %>"
                                        style="width:70px;height: 25px">

                            <input type="checkbox" style="" name="flux_flag1" value="1" checked="checked">进
                            <input type="checkbox" name="flux_flag1" value="2">出
                            <input type="checkbox" name="flux_flag1" value="3" checked="checked">换
                            <div id="ones" style="display: inline-block">
                                <!--<select name="line_id" id="line_id1" style="width:70px;height: 25px">
                                    <option value="00">全路网</option>
                                </select>-->
                                <select name="station_id" id="ranking1" style="width:70px;height: 25px">
                                    <!--<option value="外高桥东北方向站">外高桥东北方向站</option>-->
                                    <option value="10">前10</option>
                                    <option value="5">前5</option>
                                    
                                </select>
                            </div>

                            <input type="button" value="查询" onclick="searchStationRankData()" class="searchbtn">
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
        makedate();
         loadLineAndStation();
		chzchartbars();
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
    var kldata,pmtitle,klcateData,klseriData,data_name,data_val;
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
        var dat=datas.stalist;
        var hsl=datas.hst;
      				 data_name = [];
					 data_val = [];
					for (var i=dat.length-1;i>=0;i--){
						data_name.push(dat[i]['STATION_NM_CN']);
						data_val.push({value:dat[i]['IN_PASS_NUM'],hst:hsl[i].times,hsday:hsl[i].stmt_day});					}
					//vueThis.chzLine=data_name;
					Createchart();
					
    }
    function Createchart(){
    	chzchartbars();
    
    	optionAll.yAxis[0].data = data_name;
					optionAll.series[0].data = data_val;
					myChart.setOption(optionAll);
    }
	 //d3生成客流排名图表
     
	
  
        
         //判断当前时间 产生日期
		  var adate;var aweekdate;
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
                console.log('修改后日期：'+adate+'xiug'+aweekdate);
                $("#start_date1").val(adate);
                
               
		  
		  }
    //加载车站客流排名数据
	var datas;
    function loadStationRankData() {
        $(".prm").hide();
        $(".btn").val(">>");
       // $(".tab").hide();
		
        var start_date = $("#start_date1").val();//选择日期
        var flux_flag = $('input[name="flux_flag1"]:checked');//选择进出站方式
        var tp = [];
        if (flux_flag && flux_flag.length > 0) {
            $(flux_flag).each(function (i, v) {
                tp.push($(v).val());
            });
        } else {
            alert("请选择进出站方式！");
            return;
        }

        var line_id =00;//选择线路
        var line_nm = $("#line_id1 option:selected").text();//选择线路
        var ranking = $("#ranking1").val();//排名
		 if(ranking==''){
        	ranking=10;
        }

		$.post("sheete/get_all_passe.action",{"id":0,"type":0,"date":start_date,"size":ranking,"selType":tp}, function(data){
         //doPost("station/get_station_fluxrank.action", {"start_date": start_date, "flux_flag": tp}, function (data) {
             datas = data;
             stationRankData(line_id, ranking, datas, line_nm, tp);



         //添加chang事件
        /*  $("#line_id1").change(function () {
             stationRankData($("#line_id1").val(), $("#ranking1").val(), datas, $("#line_id1 option:selected").text(), tp);
         }); */
       /*   $("#ranking1").change(function () {
             stationRankData(line_id,$("#ranking1").val(), datas, $("#line_id1 option:selected").text(), tp);
         }); */
         });
    }
   
function searchStationRankData() {
        $(".prm").hide();
        $(".btn").val(">>");
       // $(".tab").hide();
		
        var start_date = $("#start_date1").val();//选择日期
        var flux_flag = $('input[name="flux_flag1"]:checked');//选择进出站方式
        var tp = [];
        if (flux_flag && flux_flag.length > 0) {
            $(flux_flag).each(function (i, v) {
                tp.push($(v).val());
            });
        } else {
            alert("请选择进出站方式！");
            return;
        }

        var line_id =00;//选择线路
        var line_nm = $("#line_id1 option:selected").text();//选择线路
        var ranking = $("#ranking1").val();//排名
		 if(ranking==''){
        	ranking=10;
        }

		$.post("sheete/get_all_passe.action",{"id":0,"type":0,"date":start_date,"size":ranking,"selType":tp}, function(data){
         //doPost("station/get_station_fluxrank.action", {"start_date": start_date, "flux_flag": tp}, function (data) {
             datas = data;
             stationRankData(line_id, ranking, datas, line_nm, tp);
			callparent("allsta",data);


         //添加chang事件
        /*  $("#line_id1").change(function () {
             stationRankData($("#line_id1").val(), $("#ranking1").val(), datas, $("#line_id1 option:selected").text(), tp);
         }); */
       /*   $("#ranking1").change(function () {
             stationRankData(line_id,$("#ranking1").val(), datas, $("#line_id1 option:selected").text(), tp);
         }); */
         });
    }


 
    function callparent(type,params){
    	parent.notifyifram(type,params);
    }
 
  
  //车站客流柱状图表初始化放大
   var  myChart;
   var optionAll;
		 function chzchartbars(){
		  
		   myChart = echarts.init(document.querySelector('#czklchar'));
		
		  	/**站点客流排名**/
		   	optionAll = {
			    tooltip : {
			        trigger: 'axis',
			        formatter:function(param){
			        	var tpstr = "";
			        	tpstr += param[0].seriesName  + "：" +param[0].value+ "万"+"<br/>"
			        	+"峰值日期："+param[0].data.hsday+"<br/>"
			        	+ "历史峰值：" +param[0].data.hst+ "万";
			        	return tpstr;
			        }
			    },
			    legend: {
			        data:['客流'],
			        show:false
			    },
			    grid: {
					x: 130,
					x2:90,
					y: 5,
					y2:60
				},
			    xAxis : [
			    	{
			            type : 'value',
			             axisLine: {

                                lineStyle: {


                                    type: 'solid',

                                    color:'#01A47E',

                                    width:'1'
                                    }

                                },
			            axisLabel:{ textStyle: {
                                    color: '#fff',
                                    fontSize :'16',
                                    fontWeight: 'bold'
                                },
                                formatter:'{value}万'
                                },
			            boundaryGap : [0, 0.01],
						splitNumber:4,
						
						 splitLine:{
                                show: true,
                                lineStyle: {

                                    type: 'dashed',

                                    color:'#008769',

                                    width:'0.5'

                                }
                                },
						splitArea:{show:false},
						scale:15,
						min:0
			        }
			       
			    ],
			    yAxis : [
			        {
			            type : 'category',
			            axisLabel:{ textStyle: {
                                    color: '#fff',
                                    fontSize :'16',
                                    fontWeight: 'bold'
                                    }
                                },
			             axisLine: {

                                lineStyle: {


                                    type: 'solid',

                                    color:'#01A47E',

                                    width:'1'
									}
                                },
			            data : []
			        }
			    ],
			    series : [
			        {
			            name:'客流',
			            type:'bar',
			            /*设置柱状图颜色*/

                            itemStyle: {
                          
                                    normal: {
					                        color: new echarts.graphic.LinearGradient(0, 0, 1, 0, [{
					                            offset: 0,
					                            color: '#0B406D'
					                        }, {
					                            offset: 1,
					                            color: '#228CF7'
					                        }])
					                        }
					                    },



                                    /*信息显示方式*/

                                    label: {

                                        show: false,

                                        position: 'top',

                                        formatter: '{b}\n{c}'

                            },
			            barWidth:23,
			            data:[]
			        }
			       
			    ]
			};
	myChart.setOption(optionAll);
			
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
        setTimeout(function () {
            
        }, 1000);
  
</script>
</body>
</html>