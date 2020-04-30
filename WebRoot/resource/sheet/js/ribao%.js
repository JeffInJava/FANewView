var chartGauge;
var optionGauge;
var chartAll;
var optionAll;
var chartLineFlux;
var optionLineFlux;
var chartPeriod;
var optionPeriod;

/**线路客流**/
//横坐标
var xAsixLineName= [];
//客流值
var lineFluxData = [];
//显示客流值
var viewLineNow = [];
var viewLineControl = [];

var nowDate;		//当前日期
var controlDate;	//对比日期


$(function(){  
	//nowDate = getBeforeDate(1);
	//controlDate = getBeforeDate(8);
	nowDate =$("#date1").val();
	controlDate =$("#date2").val();
	//nowDate="20151022";
	//controlDate="20151015";
	$('#date').val(nowDate);
	$('#controlDate').val(controlDate);

	$('#date,#controlDate').each(function (index, element) {
		$(element).bind('click', bindDatepicker(this));
	});

	$('#compareData').click(function(){
		nowDate = $('#date').val();
		controlDate = $('#controlDate').val();
		showInfo(0,0,"全路网");
	});

	// 路径配置
	require.config({
      paths: {
          echarts: 'resource/echarts/build/dist'
      }
  	});
     	     	
   	/**************图表属性开始*****************/
	/**客流营收**/
	optionGauge = {
		tooltip : {
			formatter: "{a} <br/>{c} {b}"
		},
		series : [
			{
				name:'当前总客流',
				type:'gauge',
				center : ['72%', '50%'],    // 默认全局居中
				radius : '95',
				z: 2,
				min:0,
				max:1400,
				splitNumber:7,
				axisLine: {            // 坐标轴线
					lineStyle: {       // 属性lineStyle控制线条样式
						color: [[0.22, '#2ec7c9'],[0.78, '#5ab1ef'],[1, '#d8797f']], 
						width: 5
					}
				},
				axisTick: {            // 坐标轴小标记
					length :10,        // 属性length控制线长
					lineStyle: {       // 属性lineStyle控制线条样式
						color: 'auto',
						width: 1
					}
				},
				splitLine: {           // 分隔线
					length :15,         // 属性length控制线长
					lineStyle: {       // 属性lineStyle（详见lineStyle）控制线条样式
						color: 'auto'
					}
				},
				pointer: {
					width:5
				},
				title : {
					textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
						fontWeight: 'bolder',
						fontSize: 15
					}
				},
				detail : {
					textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
						fontWeight: 'bolder',
						fontSize : 18
					},
					formatter:function(p){
						return "当前:"+p;
					},
					offsetCenter:[0, '5%']
				},
				data:[{value: 0, name: '万人次'}]
			},
			{
				name:'对比总客流',
				type:'gauge',
				center : ['72%', '50%'],    // 默认全局居中
				radius : '100',
				z: 2,
				min:0,
				max:1400,
				splitNumber:7,
				axisLabel:{show:false},
				axisLine: {            // 坐标轴线
					lineStyle: {       // 属性lineStyle控制线条样式
						color: [[0.2,'#B3B3B3'],[0.8,'#B3B3B3'],[1,'#fff']], 
						width:3
					}
				},
				axisTick: {    
					show:false// 坐标轴小标记
				},
				splitLine: {
					show: false
				},
				pointer: {
					width:0,
					color:'rgba(114,139,119,0.5)'
				},
				title : {
					show:false
				},
				detail : {
					textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
						fontWeight: 'bolder',
						fontSize :12,
						color:'rgba(114,139,119,0.5)'
					},
					formatter:function(p){
						return "对比:"+p;
					},
					offsetCenter:[0, '20%']
				},
				data:[{value: 0, name: '万人次'}]
			},
			{
				name:'当前总营收',
				type:'gauge',
				center : ['30%', '50%'],    // 默认全局居中
				radius : '95%',
				min:0,
				max:3000,
				endAngle:45,
				splitNumber:5,
				axisLine: {            // 坐标轴线
					lineStyle: {       // 属性lineStyle控制线条样式
						color: [[0.2, '#5ab1ef'],[0.8, '#5ab1ef'],[1, '#5ab1ef']], 
						width: 5
					}
				},
				axisTick: {            // 坐标轴小标记
					length :10,        // 属性length控制线长
					lineStyle: {       // 属性lineStyle控制线条样式
						color: 'auto',
						width: 1
					}
				},
				splitLine: {           // 分隔线
					length :15,         // 属性length控制线长
					lineStyle: {       // 属性lineStyle（详见lineStyle）控制线条样式
						color: 'auto'
					}
				},
				pointer: {
					width:5
				},
				title : {
					textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
						fontWeight: 'bolder',
						fontSize: 15
					}
				},
				detail : {
					textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
						fontWeight: 'bolder',
						fontSize : 18
					},
					formatter:function(p){
						return "当前:"+p;
					},
					offsetCenter:[0, '5%']
				},
				data:[{value: 0, name: '万元'}]
			},
			{
				name:'对比总营收',
				type:'gauge',
				center : ['30%', '50%'],    // 默认全局居中
				radius : '100%',
				min:0,
				max:3000,
				endAngle:45,
				splitNumber:5,
				axisLabel:{show:false},
				axisLine: {            // 坐标轴线
					lineStyle: {       // 属性lineStyle控制线条样式
						color: [[0.2,'#B3B3B3'],[0.8,'#B3B3B3'],[1,'#fff']], 
						width:3
					}
				},
				axisTick: {    
					show:false// 坐标轴小标记
				},
				splitLine: {
					show: false
				},
				pointer: {
					width:0,
					color:'rgba(114,139,119,0.5)'
				},
				title : {
					show:false
				},
				detail : {
					textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
						fontWeight: 'bolder',
						fontSize :12,
						color:'rgba(114,139,119,0.5)'
					},
					formatter:function(p){
						return "对比:"+p;
					},
					offsetCenter:[0, '20%']
				},
				data:[{value: 0, name: '万元'}]
			}
		]
	};


   	/**站点客流排名**/
   	optionAll = {
	    tooltip : {
	        trigger: 'axis',
	        formatter:function(param){
	        	var tpstr = "";
	        	tpstr += param[0].seriesName  + "：" +param[0].value+ "万";
	        	return tpstr;
	        }
	    },
	    legend: {
	        data:['客流'],
	        show:false
	    },
	    grid: {
			x: 100,
			x2:20,
			y: 5,
			y2:30
		},
	    xAxis : [
	        {
	            type : 'value',
	            axisLabel:{formatter:'{value}万'},
	            boundaryGap : [0, 0.01],
				splitNumber:4,
				splitArea:{show:true},
				scale:15,
				min:0
	        }
	    ],
	    yAxis : [
	        {
	            type : 'category',
	            data : []
	        }
	    ],
	    series : [
	        {
	            name:'客流',
	            type:'bar',
	            data:[]
	        }
	    ]
	};
	
	/*线路客流*/
	optionLineFlux =  {
	    title : {
	        text: ''
	    },
	    tooltip : {
	        trigger: 'axis',
			formatter:function(param){
	        	var tpstr = "";
	        	tpstr += param[0].seriesName  + "：" +(param[0].value*1).toFixed(2)+ "万<br/>";
	        	tpstr += param[1].seriesName  + "：" +(param[1].value*1).toFixed(2)+ "万";
	        	return tpstr;
	        },
			feature : {
				saveAsImage : {show: true}
			}
	    },
		toolbox: {
			show : false
		},
	    legend: {
	        data:['当前客流','对比客流']
	    },
		grid: {
			x:'8%',
			x2:'2%',
			y: 30,
			y2:25
		},
	    xAxis : [
	        {
	            type : 'category',
				data:[],
				splitLine: {show:false}
	        }
	    ],
	    yAxis : [
	        {
	            type : 'value',
	            axisLabel:{formatter:'{value}万'},
				splitArea:{show:true},
				splitNumber:4,
				scale:40,
				min:0,
				max:200
	        }
	    ],
	    series : [
	        {
	            name:'当前客流',
	            type:'bar',
	            itemStyle:{normal: {color:'#fe5e06',label : {show: true, position: 'top',formatter:function(p){return (p.value*1).toFixed(0);}}}},
				data:[]
	        },
			{
	            name:'对比客流',
	            type:'bar',
	            itemStyle:{normal: {color:'rgba(114,139,119,0.5)',label : {show: false, position: 'insideTop'}}},
				data:[]
	        }
	    ]
	};
	/**客流占比**/
	optionPeriod =  {
			title : {
				text: '客流占比',
				show: false
			},
			tooltip : {
				trigger: 'item',
				formatter: "{a} <br/>{b} : {c}万 ({d}%)"
			},
			color:['#d97a80','#2ec8ca','#b6a2df','#5bb0f0','#ffb880'],
			legend: {
				orient : 'vertical',
				x : 'right',
				y:20,
				show:true,
				data:[]
			},
			series : [
				{
					name:'客流占比',
					type:'pie',
					radius : ['50%','80%'],
					center: ['37%',105],
					itemStyle:{
						normal:{
							label:{formatter:'{d}%'}
						}
					},
					data:[]
				}
			]
		};
	/**************图表属性结束*****************/

   	
	showInfo(0,0,"全路网");
	
}) 

//显示相关图表信息
function showInfo(id,type,opps){

	//getIncome(id,type);			//营收
	//getFlux(id,type,0);			//获得客流总量
	getIncomeFlux(id,type,0);		//获得客流、营收

	getAllPassNum(id,type);			//站点客流排名
	getLineFlux(id,type);			//线路客流
	loadPeriodFlux(id,type);		//客流占比
	
	getInNumIncrease(id,type);		//进站增幅
	getOutNumIncrease(id,type);		//出站增幅
	getChangeNumIncrease(id,type);	//换乘增幅
	getInNumValueAdd(id,type);		//进站增量
	getOutNumValueAdd(id,type);		//出站增量
	getChangeNumValueAdd(id,type);	//换乘增量
	
	getInNumReduce(id,type);		//进站减幅
	getOutNumReduce(id,type);		//出站减幅
	getChangeNumReduce(id,type);	//换乘减幅
	getInNumValueReduce(id,type);		//进站减量
	getOutNumValueReduce(id,type);		//出站减量
	getChangeNumValueReduce(id,type);	//换乘减量
	
	getMaxFlux();					//历史最大客流
}
//获取历史最大客流
function getMaxFlux(){
	doPost("sheet/get_max_flux.action",function(data){
		$("#maxFlowId").html(data[0].MILESTONE);
		$("#maxFlowDayId").html("&nbsp;&nbsp;"+data[0].STMT_DAY);
	});
}
//获得运营收入
function getIncome(data){
	var income = data[0]["INCOME"];
	$('#inCome').html(income);
}
//获得客流
function getFlux(data){
	$('#fluxTimes').html(data[0]['FLUX']);
	$("#arrowId").html(Math.abs(data[0]['ARROW'])+"%");
	if (data[0]['ARROW']>=0){
		$("#arrowId").css("color","red");
		$('#fluxArrow').attr("src","style/dailysheet/images/up_arrow.png");
	}else{
		$("#arrowId").css("color","#06b358");
		$('#fluxArrow').attr("src","style/dailysheet/images/down_arrow.png");
	}
	$('#enterTimes').html((data[0]['ENTER_TIMES']/10000).toFixed(1));
	$('#chgTimes').html(data[0]['CHG_TIMES']);
	$('#controlFluxTimes').html(data[0]['CONTROL_FLUX']);
	$('#avgLine').html(data[0]['AVGLINE']);
	$('#avgPrice').html(data[0]['AVGPRICE']);
	$('#control_avgLine').html("对比:"+data[0]['CONTROL_AVGLINE']);
	$('#control_avgPrice').html("对比:"+data[0]['CONTROL_AVGPRICE']);
	var _totalLine = (data[0]['AVGLINE']*data[0]['ENTER_TIMES']/10000).toFixed(0);
	$('#totalLine').html(_totalLine);
}

//线路客流
function getLineFlux(id,type){

	doPost("sheet/get_avg_flux.action", {"type":type,"date":nowDate,"controlDate":controlDate,"id":id}, function(data2){
		
		viewLineNow = [];
		viewLineControl = [];
		xAsixLineName = [];
		
		for (var i=0;i<data2.length;i++ ){
			viewLineNow[i]  = (data2[i]["INNUM"]*1+data2[i]["CHANGENUM"]*1+data2[i]["FLUXNUM"]*1).toFixed(4);
			viewLineControl[i]  = (data2[i]["INNUM_C"]*1+data2[i]["CHANGENUM_C"]*1+data2[i]["FLUXNUM_C"]*1).toFixed(4);
			xAsixLineName.push(data2[i]['LINE_ID']);
		}
		optionLineFlux.xAxis[0].data = xAsixLineName;
		optionLineFlux.series[0].data = viewLineNow;
		optionLineFlux.series[1].data = viewLineControl;
		
		// 使用
	  	require(
	      [
	          'echarts',
	          'echarts/chart/bar'
	      ],
	      
	     function (ec) {
	    	if(chartLineFlux){
	   		  chartLineFlux.clear();
	    	  chartLineFlux.dispose();
	   	    }    	
			chartLineFlux = ec.init(document.getElementById('mainLineFlux')); 
			chartLineFlux.setOption(optionLineFlux, true);
	     });
	
		
		//表格
		var _tempHtml = "<table align='left' width='90%'><tr align='center'>"
		for (var i=0;i<viewLineNow.length ;i++ ){
			
			var tp_per=Math.abs(((viewLineNow[i]-viewLineControl[i])/viewLineControl[i]*100).toFixed(1));
			var _color = "";
			_tempHtml += "<td>";
			if(tp_per||tp_per==0){
				if(tp_per.toString().indexOf(".")<0){
					tp_per+=".0%";
				}else{
					tp_per +="%";
				}
			}else{
				tp_per ="--%";
			}
			
			if (viewLineControl[i]*1 <= viewLineNow[i]*1){
				_color = "red";
			}else{
				_color = "#06b358";
			}
			_tempHtml += "<label style='color:" + _color + "'>" + tp_per + "</label>"
			_tempHtml += "</td>";
		}
		_tempHtml +="</tr></table>";
		$('#mainLineFluxData').html(_tempHtml);
	});
}

//根据选择的车站类型获得相应的客流
function getAllPassNum(id,type){
	var selTypes=[];
	$('input[name="selType"]:checked').each(function(){
		selTypes.push($(this).val());
	});
	doPost("sheet/get_all_pass.action",{"id":id,"type":type,"date":nowDate,"size":8,"selType":selTypes}, function(data){
		var data_name = [];
		var data_val = [];
		for (var i=data.length-1;i>=0;i--){
			data_name.push(data[i]['STATION_NM_CN']);
			data_val.push(data[i]['IN_PASS_NUM']);
		}

		optionAll.yAxis[0].data = data_name;
		optionAll.series[0].data = data_val;
		// 使用
	  	require(
	      [
	          'echarts',
	          'echarts/chart/bar'
	      ],
	      
	     function (ec) {
	   	    if(chartAll){
	   		  chartAll.clear();
	   		  chartAll.dispose();
	   	    }
	     	chartAll = ec.init(document.getElementById('mainAll')); 
	     	chartAll.setOption(optionAll, true);
	     });
     
	});
}
//客流占比
function loadPeriodFlux(id,type){
	doPost("sheet/get_period.action", {"type":type,"date":nowDate,"controlDate":controlDate,"id":id}, function(data){
		serialName = [];
		viewTotalData = [];
		for (var i=0;i<data.length;i++){
			serialName.push(data[i]['PERIOD_NAME']);
		}
		
		viewTotalData.push({"value":(data[4]['ENTERS']*1 + data[4]['CHANGES']*1).toFixed(1),"name":data[4]['PERIOD_NAME']});
		viewTotalData.push({"value":(data[1]['ENTERS']*1 + data[1]['CHANGES']*1).toFixed(1),"name":data[1]['PERIOD_NAME']});
		viewTotalData.push({"value":(data[0]['ENTERS']*1 + data[0]['CHANGES']*1).toFixed(1),"name":data[0]['PERIOD_NAME']});
		viewTotalData.push({"value":(data[2]['ENTERS']*1 + data[2]['CHANGES']*1).toFixed(1),"name":data[2]['PERIOD_NAME']});
		viewTotalData.push({"value":(data[3]['ENTERS']*1 + data[3]['CHANGES']*1).toFixed(1),"name":data[3]['PERIOD_NAME']});
		
		optionPeriod.legend.data = serialName;
		optionPeriod.series[0].data = viewTotalData;
		
		// 使用
	  	require(
	      [
	          'echarts',
	          'echarts/chart/pie'
	      ],
	      
	     function (ec) {

	     	chartPeriod = ec.init(document.getElementById('mainPeriod')); 
	     	chartPeriod.setOption(optionPeriod, true);
	     });
	});
}
//获得增幅
function getInNumIncrease(id,type){
	
	doPost("sheet/get_flux_increase.action", {"type":type,"date":nowDate,"controlDate":controlDate,"id":id,"size":5,"fluxType":1,"sortType":1}, function(data){
		$('#inNumIncrease tbody').empty();
		for (var i=data.length-1;i>=0;i--){
			var _color = "";
			if (data[i]['SYMBOL']=="1"){
				_color = "red";
			}else{
				_color = "#06b358";
			}
			var _html = "<tr>";
			_html += "<td align='center' class='border_bottom'>" + data[i]['STATION_NM_CN'] + "</td>";
			_html += "<td align='center' class='border_bottom'>" + data[i]['TOTAL_TIMES'] + "</td>";
			_html += "<td align='center' class='border_bottom' style='color:" + _color + "'>" + data[i]['INCREASE_ABS']*data[i]['SYMBOL'] + "%</td>";
			_html += "</tr>"
			$("#inNumIncrease tbody").prepend(_html);
		}
	});

}

//获得减幅
function getInNumReduce(id,type){
	
	doPost("sheet/get_flux_reduce.action", {"type":type,"date":nowDate,"controlDate":controlDate,"id":id,"size":5,"fluxType":1,"sortType":1}, function(data){
		$('#inNumReduce tbody').empty();
		for (var i=data.length-1;i>=0;i--){
			var _color = "";
			if (data[i]['SYMBOL']=="1"){
				_color = "red";
			}else{
				_color = "#06b358";
			}
			var _html = "<tr>";
			_html += "<td align='center' class='border_bottom'>" + data[i]['STATION_NM_CN'] + "</td>";
			_html += "<td align='center' class='border_bottom'>" + data[i]['TOTAL_TIMES'] + "</td>";
			_html += "<td align='center' class='border_bottom' style='color:" + _color + "'>" + data[i]['INCREASE_ABS']*data[i]['SYMBOL'] + "%</td>";
			_html += "</tr>"
			$("#inNumReduce tbody").prepend(_html);
		}
	});

}

function getOutNumIncrease(id,type){
	doPost("sheet/get_flux_increase.action", {"type":type,"date":nowDate,"controlDate":controlDate,"id":id,"size":5,"fluxType":2,"sortType":1}, function(data){
		$('#outNumIncrease tbody').empty();
		for (var i=data.length-1;i>=0;i--){
			var _color = "";
			if (data[i]['SYMBOL']=="1"){
				_color = "red";
			}else{
				_color = "#06b358";
			}
			var _html = "<tr>";
			_html += "<td align='center' class='border_bottom'>" + data[i]['STATION_NM_CN'] + "</td>";
			_html += "<td align='center' class='border_bottom'>" + data[i]['TOTAL_TIMES'] + "</td>";
			_html += "<td align='center' class='border_bottom' style='color:" + _color + "'>" + data[i]['INCREASE_ABS']*data[i]['SYMBOL'] + "%</td>";
			_html += "</tr>"
			$("#outNumIncrease tbody").prepend(_html);
		}
	});
}

function getOutNumReduce(id,type){
	doPost("sheet/get_flux_reduce.action", {"type":type,"date":nowDate,"controlDate":controlDate,"id":id,"size":5,"fluxType":2,"sortType":1}, function(data){
		$('#outNumReduce tbody').empty();
		for (var i=data.length-1;i>=0;i--){
			var _color = "";
			if (data[i]['SYMBOL']=="1"){
				_color = "red";
			}else{
				_color = "#06b358";
			}
			var _html = "<tr>";
			_html += "<td align='center' class='border_bottom'>" + data[i]['STATION_NM_CN'] + "</td>";
			_html += "<td align='center' class='border_bottom'>" + data[i]['TOTAL_TIMES'] + "</td>";
			_html += "<td align='center' class='border_bottom' style='color:" + _color + "'>" + data[i]['INCREASE_ABS']*data[i]['SYMBOL'] + "%</td>";
			_html += "</tr>"
			$("#outNumReduce tbody").prepend(_html);
		}
	});
}

function getChangeNumIncrease(id,type){
	doPost("sheet/get_flux_increase.action", {"type":type,"date":nowDate,"controlDate":controlDate,"id":id,"size":5,"fluxType":3,"sortType":1}, function(data){
		$('#changeNumIncrease tbody').empty();
		for (var i=data.length-1;i>=0;i--){
			var _color = "";
			if (data[i]['SYMBOL']=="1"){
				_color = "red";
			}else{
				_color = "#06b358";
			}
			var _html = "<tr>";
			_html += "<td align='center' class='border_bottom'>" + data[i]['STATION_NM_CN'] + "</td>";
			_html += "<td align='center' class='border_bottom'>" + data[i]['TOTAL_TIMES'] + "</td>";
			_html += "<td align='center' class='border_bottom' style='color:" + _color + "'>" + data[i]['INCREASE_ABS']*data[i]['SYMBOL'] + "%</td>";
			_html += "</tr>"
			$("#changeNumIncrease tbody").prepend(_html);
		}
	});
}

function getChangeNumReduce(id,type){
	doPost("sheet/get_flux_reduce.action", {"type":type,"date":nowDate,"controlDate":controlDate,"id":id,"size":5,"fluxType":3,"sortType":1}, function(data){
		$('#changeNumReduce tbody').empty();
		for (var i=data.length-1;i>=0;i--){
			var _color = "";
			if (data[i]['SYMBOL']=="1"){
				_color = "red";
			}else{
				_color = "#06b358";
			}
			var _html = "<tr>";
			_html += "<td align='center' class='border_bottom'>" + data[i]['STATION_NM_CN'] + "</td>";
			_html += "<td align='center' class='border_bottom'>" + data[i]['TOTAL_TIMES'] + "</td>";
			_html += "<td align='center' class='border_bottom' style='color:" + _color + "'>" + data[i]['INCREASE_ABS']*data[i]['SYMBOL'] + "%</td>";
			_html += "</tr>"
			$("#changeNumReduce tbody").prepend(_html);
		}
	});
}

//获得增值
function getInNumValueAdd(id,type){
	doPost("sheet/get_flux_value_add.action", {"type":type,"date":nowDate,"controlDate":controlDate,"id":id,"size":5,"fluxType":1,"sortType":1}, function(data){
		$('#inNumValueAdd tbody').empty();
		for (var i=data.length-1;i>=0;i--){
			var _color = "";
			if (data[i]['SYMBOL']=="1"){
				_color = "red";
			}else{
				_color = "#06b358";
			}
			var _html = "<tr>";
			_html += "<td align='center' class='border_bottom'>" + data[i]['STATION_NM_CN'] + "</td>";
			_html += "<td align='center' class='border_bottom'>" + data[i]['TOTAL_TIMES'] + "</td>";
			_html += "<td align='center' class='border_bottom' style='color:" + _color + "'>" + data[i]['VALUEADD_ABS']*data[i]['SYMBOL'] + "</td>";
			_html += "</tr>"
			$("#inNumValueAdd tbody").prepend(_html);
		}
	});
}

//获得减值
function getInNumValueReduce(id,type){
	doPost("sheet/get_flux_value_reduce.action", {"type":type,"date":nowDate,"controlDate":controlDate,"id":id,"size":5,"fluxType":1,"sortType":1}, function(data){
		$('#inNumValueReduce tbody').empty();
		for (var i=data.length-1;i>=0;i--){
			var _color = "";
			if (data[i]['SYMBOL']=="1"){
				_color = "red";
			}else{
				_color = "#06b358";
			}
			var _html = "<tr>";
			_html += "<td align='center' class='border_bottom'>" + data[i]['STATION_NM_CN'] + "</td>";
			_html += "<td align='center' class='border_bottom'>" + data[i]['TOTAL_TIMES'] + "</td>";
			_html += "<td align='center' class='border_bottom' style='color:" + _color + "'>" + data[i]['VALUEADD_ABS']*data[i]['SYMBOL'] + "</td>";
			_html += "</tr>"
			$("#inNumValueReduce tbody").prepend(_html);
		}
	});
}

function getOutNumValueAdd(id,type){
	doPost("sheet/get_flux_value_add.action", {"type":type,"date":nowDate,"controlDate":controlDate,"id":id,"size":5,"fluxType":2,"sortType":1}, function(data){
		$('#outNumValueAdd tbody').empty();
		for (var i=data.length-1;i>=0;i--){
			var _color = "";
			if (data[i]['SYMBOL']=="1"){
				_color = "red";
			}else{
				_color = "#06b358";
			}
			var _html = "<tr>";
			_html += "<td align='center' class='border_bottom'>" + data[i]['STATION_NM_CN'] + "</td>";
			_html += "<td align='center' class='border_bottom'>" + data[i]['TOTAL_TIMES'] + "</td>";
			_html += "<td align='center' class='border_bottom' style='color:" + _color + "'>" + data[i]['VALUEADD_ABS']*data[i]['SYMBOL'] + "</td>";
			_html += "</tr>"
			$("#outNumValueAdd tbody").prepend(_html);
		}
	});
}

function getOutNumValueReduce(id,type){
	doPost("sheet/get_flux_value_reduce.action", {"type":type,"date":nowDate,"controlDate":controlDate,"id":id,"size":5,"fluxType":2,"sortType":1}, function(data){
		$('#outNumValueReduce tbody').empty();
		for (var i=data.length-1;i>=0;i--){
			var _color = "";
			if (data[i]['SYMBOL']=="1"){
				_color = "red";
			}else{
				_color = "#06b358";
			}
			var _html = "<tr>";
			_html += "<td align='center' class='border_bottom'>" + data[i]['STATION_NM_CN'] + "</td>";
			_html += "<td align='center' class='border_bottom'>" + data[i]['TOTAL_TIMES'] + "</td>";
			_html += "<td align='center' class='border_bottom' style='color:" + _color + "'>" + data[i]['VALUEADD_ABS']*data[i]['SYMBOL'] + "</td>";
			_html += "</tr>"
			$("#outNumValueReduce tbody").prepend(_html);
		}
	});
}


function getChangeNumValueAdd(id,type){
	doPost("sheet/get_flux_value_add.action", {"type":type,"date":nowDate,"controlDate":controlDate,"id":id,"size":5,"fluxType":3,"sortType":1}, function(data){
		$('#changeNumValueAdd tbody').empty();
		for (var i=data.length-1;i>=0;i--){
			var _color = "";
			if (data[i]['SYMBOL']=="1"){
				_color = "red";
			}else{
				_color = "#06b358";
			}
			var _html = "<tr>";
			_html += "<td align='center' class='border_bottom'>" + data[i]['STATION_NM_CN'] + "</td>";
			_html += "<td align='center' class='border_bottom'>" + data[i]['TOTAL_TIMES'] + "</td>";
			_html += "<td align='center' class='border_bottom' style='color:" + _color + "'>" + data[i]['VALUEADD_ABS']*data[i]['SYMBOL'] + "</td>";
			_html += "</tr>"
			$("#changeNumValueAdd tbody").prepend(_html);
		}
	});
}

function getChangeNumValueReduce(id,type){
	doPost("sheet/get_flux_value_reduce.action", {"type":type,"date":nowDate,"controlDate":controlDate,"id":id,"size":5,"fluxType":3,"sortType":1}, function(data){
		$('#changeNumValueReduce tbody').empty();
		for (var i=data.length-1;i>=0;i--){
			var _color = "";
			if (data[i]['SYMBOL']=="1"){
				_color = "red";
			}else{
				_color = "#06b358";
			}
			var _html = "<tr>";
			_html += "<td align='center' class='border_bottom'>" + data[i]['STATION_NM_CN'] + "</td>";
			_html += "<td align='center' class='border_bottom'>" + data[i]['TOTAL_TIMES'] + "</td>";
			_html += "<td align='center' class='border_bottom' style='color:" + _color + "'>" + data[i]['VALUEADD_ABS']*data[i]['SYMBOL'] + "</td>";
			_html += "</tr>"
			$("#changeNumValueReduce tbody").prepend(_html);
		}
	});
}
//显示客流营收表
function getIncomeFlux(id,type,isDetail){
	var _income = 0;
	var _fluxTimes = 0
	//获得营收
	doPost("sheet/get_income.action", {"id":id,"type":type,"date":nowDate,"controlDate":controlDate}, function(dt){
		getIncome(dt);

		_income = dt[0]["INCOME"];
		//获得客流
		doPost("sheet/get_flux.action", {"id":id,"type":type,"date":nowDate,"controlDate":controlDate,"isDetail":isDetail}, function(data){

			getFlux(data);
			
			_fluxTimes = data[0]['FLUX'];
			optionGauge.series[0].data[0].value = _fluxTimes;
			optionGauge.series[1].data[0].value = data[0]['CONTROL_FLUX'];
			var per1=(data[0]['CONTROL_FLUX']/1400).toFixed(4);
			var per2=(dt[1]["INCOME"]/3000).toFixed(4);
			optionGauge.series[1].axisLine.lineStyle.color=[[0.001,'#B3B3B3'],[per1,'#B3B3B3'],[1,'#fff']];
			optionGauge.series[2].data[0].value = _income;
			optionGauge.series[3].data[0].value = dt[1]["INCOME"];
			optionGauge.series[3].axisLine.lineStyle.color=[[0.001,'#B3B3B3'],[per2,'#B3B3B3'],[1,'#fff']];
			
			// 使用
			require(
			  [
				  'echarts',
				  'echarts/chart/gauge'
			  ],
			  
			 function (ec) {
				chartGauge = ec.init(document.getElementById('mainGauge')); 
	     		chartGauge.setOption(optionGauge, true);
			 });

		});
	});

}

//计算日期
function getBeforeDate(n){
    var n = n;
    var newDate = new Date(new Date()-1000*60*60*24*n);
    var year = newDate.getFullYear();
    var mon=newDate.getMonth()+1;
    var day=newDate.getDate();
    s = year+""+(mon<10?('0'+mon):mon)+""+(day<10?('0'+day):day);
    return s;
}