<%@ page language="java" import="java.util.*,java.lang.*,net.sf.json.*,java.sql.*,java.text.*,java.io.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
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
<!DOCTYPE html>
<html>
  <head>
  <base href="<%=basePath%>">
    <title>上海地铁客流实时显示系统</title>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link rel="stylesheet" href="resource/element-ui/index.css" />
	
	
	<script src="resource/anime/jquery-1.11.1.min.js"></script> 
	<script src="resource/fontactive/js/modernizr.js"></script>
	<script src="resource/fontactive/js/main.js"></script>
	
	<!-- <script src="resource/jquery/js/jquery-1.9.1.min.js"></script> -->
	<script src="resource/anime/anime.min.js"></script>
	
	<script src="resource/anime/countUp.min.js"></script> 
	<script src="resource/vue/vue.min.js"></script>
    <script src="resource/element-ui/index.js"></script>
    <script src="resource/js/common.js"></script>
    <script src="resource/js/moment.min.js"></script>
    
    <script src="resource/echarts3/echarts.min.js"></script>
    <script src="resource/js/hammer.js"></script>
    <script src="resource/js/jquery.drag.js"></script>
   
   
    
  
	<style type="text/css">
	
		body{
			//background:#043735;
			 background:none;
		}
		#pfwd{
			 background:none;
		}


</style>
  </head>
  
  <body>
  	  <div id="pfwd">
			
			<el-row>
				<div id="olfc" style="width:460px;height:240px;"></div>
			</el-row>	
  	  </div>
  	</body>  
      <script type="text/javascript">
			       
		new Vue({
		  el: '#pfwd',
		  data:function(){
			return {
				
        temDate: Date.now(),
        compDate:'',
        todayda:'',
        timeDt:'',
        wktimeDt:'',
        adate:'',
        aweekdate:'',
        legen:[],
        olchar:'',
        olflData:'',
        olcharOption:''
  
			
			}
		  },
		    mounted: function () {
		    this.makedate();
		    this.getDate();
		    
		    
		  	
			this.getOnlineFlow();
			window.setChart=this.setChart;
			window.upFlow=this.upFlow;


        },
		  methods: {
		  
		  //获取日期
		  getDate:function(){
		  	var vueThis=this;
		  	var date = new Date();
		    var seperator1 = "-";
		    var seperator2 = ":";
		    var month = date.getMonth() + 1;
		    var strDate = date.getDate();
		    if (month >= 1 && month <= 9) {
		        month = "0" + month;
		    }
		    if (strDate >= 0 && strDate <= 9) {
		        strDate = "0" + strDate;
		    }
		    
		    
		    var currentdate = date.getFullYear() + month + strDate;
		    vueThis.todayda=currentdate;
		    var today = new Date();
		     today.setTime(today.getTime() - 3600 * 1000 * 24*7);
		    
		      var wkmonth = today.getMonth() + 1;
		    var wkDate = today.getDate();
		    if (wkmonth >= 1 && wkmonth <= 9) {
		        wkmonth = "0" + wkmonth;
		    }
		    if (wkDate >= 0 && wkDate <= 9) {
		        wkDate = "0" + wkDate;
		    }
		    var wda=today.getFullYear()+wkmonth+wkDate;
		    var wknow=today.getTime()- 3600 * 1000 * 24*7
		    vueThis.compDate=wknow;
		    
		         
		    return currentdate;
		  },
		   //判断当前时间 产生日期
		  
		  makedate:function(){
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
                this.adate=year + month + strDate;
               this.aweekdate=cpyear + cpmonth + cpDate;
                console.log('修改后日期：'+this.adate+'xiug'+this.aweekdate);
                
               
		  
		  },
		  
		  //更新图表数据
		  upFlow:function(olDate1,olDate2){
		  var vueThis=this;
		  		vueThis.adate=olDate1;
		  		vueThis.aweekdate=olDate2;
		  		vueThis.getOnlineFlow();
		  },
		  	//获取图表数据
		  	getOnlineFlow:function(){
		  	
		  			
		  		 var vueThis=this;
		  		 if(vueThis.olchar!=''){
		  		 	vueThis.olchar.clear();
		  		 }
		  		 
		  		  vueThis.timeDt=moment(vueThis.temDate).format("YYYYMMDD");
		  		  vueThis.wktimeDt="<%=week_date%>";
		  		   vueThis.legen.push(vueThis.adate);
		  		   vueThis.legen.push(vueThis.aweekdate); 
		  		  vueThis.initChart();
		  		$.post("lflw/GetonLineFlow.action",{"date":vueThis.adate,"compDate":vueThis.aweekdate}, function(data){
		  		
		  				vueThis.olchar.clear();
		  				vueThis.olflData=data;
		  		   var tim=[];
		  		   vueThis.olcharOption.series=[];
		  		   for (var i=0;i<=data.times.length-1;i++){
		  		   
		  		   	var  it=data.times[i];
		  		   	
		  		   		 tim.push({
				                 value: it,
				                 textStyle: {fontSize: 9, color: 'rgba(255,255,255,1)'}
				             });
		  		   	
		  		   }
		  		   
		  		   vueThis.olcharOption.xAxis[0].data=tim;
		  		   vueThis.olcharOption.title.text="全路网在网客流";
		  		
		  		   vueThis.olcharOption.series.push(
		  		   	 {
				            name:vueThis.aweekdate,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#32d2ca'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:data.lineT[16].cpalline
				        }
		  		   );
		  		  vueThis.olcharOption.series.push(
		  		   	 {
				            name:vueThis.adate,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#ED3229'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:data.lineT[16].alline
				        }
		  		   );
		  		   vueThis.olchar.setOption(vueThis.olcharOption);
		  	
		  			
		  		});
		  	},
		  	setChart:function(param){
		  	var vueThis=this;
		  	var data=param.data;
		  	var dates=param.date;
		  	
		  				vueThis.olchar.clear();
		  				
		  				vueThis.olflData=data;
		  		   var tim=[];
		  		   vueThis.olcharOption.series=[];
		  		   for (var i=0;i<=data.times.length-1;i++){
		  		   
		  		   	var  it=data.times[i];
		  		   	
		  		   		 tim.push({
				                 value: it,
				                 textStyle: {fontSize: 9, color: 'rgba(255,255,255,1)'}
				             });
		  		   	
		  		   }
		  		   
		  		   vueThis.olcharOption.xAxis[0].data=tim;
		  		   vueThis.olcharOption.title.text="全路网在网客流";
		  		   vueThis.olcharOption.legend.data=[dates.compDate,dates.date];
		  		
		  		   vueThis.olcharOption.series.push(
		  		   	 {
				            name:dates.compDate,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#32d2ca'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:data.lineT[16].cpalline
				        }
		  		   );
		  		  vueThis.olcharOption.series.push(
		  		   	 {
				            name:dates.date,
				            type:'line',
				            smooth: true,
				            itemStyle: {normal: {color: '#ED3229'}},
                    		areaStyle: {normal: {}},
				            //stack: '总量',
				            data:data.lineT[16].alline
				        }
		  		   );
		  		   vueThis.olchar.setOption(vueThis.olcharOption);
		  	
		  	},
		  	//绘制折线图
		  	initChart:function(){
		  		 var vueThis=this;
                //初始化echarts图表
                var myChart;
               myChart = echarts.init(document.querySelector('#olfc'));
				vueThis.olchar=myChart;
				option = {
				    title: {
				        text: '客流折线图',
				        textStyle: { fontStyle:'normal',fontWeight:'bold',fontSize:16,color:'#FFFfff'}
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
				        data:vueThis.legen
				    },
				    grid: {
				      
				        left: '12%',
				        right: '7%',
				        bottom: '13%'
				        //containLabel: true
				    },
				   
				    xAxis: [{
				        type: 'category',
				        boundaryGap: false,
				         axisLine: {lineStyle: {color: '#01A47E', width: 1}},
                   
				        data: []
				    }],
				    yAxis: {
				        type: 'value',
				        name: '单位：万人次',
				        nameTextStyle:{
                        color:"#FFF",
                        fontSize:'10'

                    },
                    splitLine: {lineStyle: {type: 'dashed',color:'#01A47E',width:0.7}},
                    axisLine: {lineStyle: {color: '#01A47E', width: 2}},
                    axisLabel: {
                        textStyle: {fontWeight: 'bold', fontSize: 9, color: '#FFFfff'}
                        
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
				vueThis.olcharOption=option;
				vueThis.olchar.setOption(vueThis.olcharOption);
		  	}
		  
		    },
		  filters: {
		  	amendNum:function(value){
		  		var val=parseInt(value);
		  		return val;
		  	}
			
		}
		});
		
      </script>
  
</html>