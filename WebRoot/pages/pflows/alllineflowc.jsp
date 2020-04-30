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
                                <!--  <select name="line_id" id="line_id3" style="width:70px;height: 25px">
                                    <option value="00">全路网</option>
                                </select>-->
                                <select name="station_id" id="ranking3" style="width:70px;height: 25px">
                                    <option value="20" selected="selected">全路网</option>
                                    <option value="5">前5</option>
                                    <option value="8">前8</option>
                                </select>
                            </div>

                            <input type="button" value="查询" onclick="searchAllLineRankData()" class="searchbtn">
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
        loadAllLineRankData();
      

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
                
               $("#start_date3").val(adate);
		  
		  }
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
        var  params={"start_date": start_date, "flux_flag": tp};
        
        doPost("pflw/get_line_flux_max.action", {"start_date": start_date, "flux_flag": tp}, function (data) {
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
      //加载所有线路客流排名数据
    function searchAllLineRankData() {
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
        var  params={"start_date": start_date, "flux_flag": tp};
        
        
        doPost("pflw/get_line_flux_max.action", {"start_date": start_date, "flux_flag": tp}, function (data) {
            var datas = data;
            AlllineRankData(line_id, ranking, datas, line_nm, tp);
			callparent("allline",datas);


        //添加chang事件
        $("#line_id3").change(function () {
        	AlllineRankData($("#line_id3").val(), $("#ranking3").val(), datas, $("#line_id3 option:selected").text(), tp);
        });
        $("#ranking3").change(function () {
        	AlllineRankData($("#line_id3").val(), $("#ranking3").val(), datas, $("#line_id3 option:selected").text(), tp);
        });
        });

      
    }
    function callparent(type,params){
    	parent.notifyifram(type,params);
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
        var hs=datas.hst;
     var tep=datas.tep;
        for (var i=0;i<tep.length;i++){
            if (i<18) {
                //aldata.push(v);
                var v=tep[i];
               
		 for (var j=0;j<hs.length;j++){
		 		 var h=hs[j];
                //alcateData.push(v.LINE_ID);
                if(v.LINE_ID==h.lineId){
                alseriData.push({y:parseFloat(v.TOTAL_TIMES.toFixed(1)),description:h.times,labelrank:h.stmt_day});
                }
                }
          
                
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
        };
        $('#mainChartZL').empty();

        alpm();
    }
    function alpm() {
    	
        var data=new Array();
        data=aldata;
        var title=altitle;
        
        var  chart = new Highcharts.Chart({
            chart: {
                height:550,
                width:1200,
                spacingLeft: 45,
                spacingRight: 15,
                spacingTop: 45,
                spacingBottom: 55,
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
                categories: alcateData,

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
                        fontSize: '16px',
 			display:"none",
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
                 pointFormat: '<tr><td style="color:{series.color};padding:0;"> </td>' +'<td style="padding:0;font-size:17px"><b>客流：{point.y:.1f} 万</b></td></tr>'+
                '<tr><td style="color:{series.color};padding:0;"> </td>' +'<td style="padding:0;font-size:16px"><b>峰值客流：{point.description:.2f} 万</b></td></tr>'+
                '<tr><td style="color:{series.color};padding:0;"> </td>' +'<td style="padding:0;font-size:16px"><b>峰值日期：{point.labelrank} </b></td></tr>',
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
                        x:-15,
                        y:-20,
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
               /*  animation: {
				duration: 3000,
				easing: 'ease-out'
			}, */
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
   
 //延迟加载“运营日期”的数据
       /*  setTimeout(function () {
            
        }, 1000); */
  
</script>
</body>
</html>