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
    	String start_date = df.format(calendar.getTime());//当前日期
		calendar.add(Calendar.DAY_OF_MONTH, -2);  
		sec_date=df.format(calendar.getTime());
	
    
        calendar.add(Calendar.DAY_OF_MONTH, -1);  
        fir_date=df.format(calendar.getTime());
        
        calendar.add(Calendar.DAY_OF_MONTH, -3);  
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
	<link rel="stylesheet" href="resource/bootstrap/bootstrap3.css" />
	
	<script src="resource/anime/jquery-1.11.1.min.js"></script> 
	<!-- <script src="resource/bootstrap/jquery2.1.1.js"></script> -->
	<script src="resource/bootstrap/bootstrap3.js"></script>
	<script src="resource/fontactive/js/modernizr.js"></script>
	<script src="resource/fontactive/js/main.js"></script>
	
	<!-- <script src="resource/jquery/js/jquery-1.9.1.min.js"></script> -->
	<script src="resource/anime/anime.min.js"></script>
	
	<script src="resource/anime/countUp.min.js"></script> 
	<script src="resource/vue/vue.min.js"></script>
    <script src="resource/element-ui/index.js"></script>
    <script src="resource/js/common.js"></script>
    
    <script src="resource/echarts3/echarts.min.js"></script>
    <script src="resource/js/hammer.js"></script>
    <script src="resource/js/jquery.drag.js"></script>
   
   
    
  
	<style type="text/css">
/*定义思源字体*/
@font-face {
	font-family: "SourceHanSansCN-Light";
	src: url("resource/SourceHanSansCNLight/SourceHanSansCN-Light.woff2")
		format("woff2"),
		url("resource/SourceHanSansCNLight/SourceHanSansCN-Light.woff")
		format("woff"),
		url("resource/SourceHanSansCNLight/SourceHanSansCN-Light.ttf")
		format("truetype"),
		url("resource/SourceHanSansCNLight/SourceHanSansCN-Light.eot")
		format("embedded-opentype"),
		url("resource/SourceHanSansCNLight/SourceHanSansCN-Light.svg")
		format("svg");
	font-weight: normal;
	font-style: normal;
}

html, body {
	margin: 0;
	padding: 0;
	font-family: 'SourceHanSansCN-Light'
}

body {
	background: url("resource/images/pasflw/background.png") no-repeat;
	min-width: 1920px;
	min-height: 1080px;
}
/* 定义液晶字体 */
@font-face {
	font-family: 'LCD_Font';
	src: url('resource/lcd_num_font/digital-7-italic.eot');
	/* IE9 Compat Modes */
	src: url('resource/lcd_num_font/digital-7-italic.eot?#iefix')
		format('embedded-opentype'), /* IE6-IE8 */ 
		 url('resource/lcd_num_font/digital-7-italic.woff') format('woff'),
		/* Modern Browsers */ 
		 url('resource/lcd_num_font/digital-7-italic.ttf') format('truetype'),
		/* Safari, Android, iOS */ 
		 url('resource/lcd_num_font/digital-7-italic.svg') format('svg');
	/* Legacy iOS */
}
/* 使用液晶字体 */
.lcd {
	font-family: "LCD_Font";
}

#sjzl {
	background: url(resource/images/pasflw/sjzlbgt.png) no-repeat;
	width: 658px;
	height: 159px;
}

/* eltable修改样式*/
.el-table--border td:first-child .cell {
	padding-left: 5px;
}

.el-input__icon {
	line-height: 30px;
}

.el-table tr {
	background-color: transparent;
}

.el-table th {
	background-color: transparent;
}

#zdcz .el-table th {
	background-color: transparent;
	height: 60px;
}

#zdcz .el-table tr {
	background-color: transparent;
	height: 35px;
}

#zdcz .el-table td {
	height: 35px;
}

#zdcz .el-table {
	background-color: transparent;
	border-left: 1px solid #008C6F;
	border-top: 1px solid #008C6F;
	border-right: 1px solid #008C6F;
	color: white;
	font-size: 1rem;
	max-height: 430px;
	overflow-y: auto;
}

#zdcz .el-table::after, .el-table::before {
	content: '';
	position: absolute;
	background-color: rgba(255, 255, 255, 0);
	z-index: 1;
}

#zdcz .el-table .el-table__header-wrapper table tbody tr td, .el-table th.is-leaf
	{
	border-bottom: 1px solid #008C6F;
}

#zdcz .el-table td, .el-table th.is-leaf {
	border-bottom: 1px solid #008C6F;
}

.el-table__header-wrapper thead div {
	background-color: transparent;
	color: white;
}

.el-table .cell, .el-table th>div {
	padding-left: 5px;
	padding-right: 5px;
}

.el-table--enable-row-hover .el-table__body tr:hover>td {
	background-color: transparent;
}

/** 修改浏览器字体*/
.small-font {
	　　　 font-size: 12px;
	-webkit-transform-origin-x: 0;
	-webkit-transform: scale(0.60);
}

.smallsize-font {
	　　　　font-size: 7.2px;
	　　
}
@-webkit-keyframes zoomsc {
	0%{
	 	font-size: 15px;
	}
	50%{
	 	font-size: 30px;
	 	
	}
	100%{
	 	font-size: 24px;
	}
}
@-webkit-keyframes zoomsb {
	0%{
	 	font-size: 16px;
	}
	50%{
	 	font-size: 32px;
	 	
	}
	100%{
	 	font-size: 28px;
	}
}
@-webkit-keyframes zoomsa {
	0%{
	 	font-size: 15px;
	}
	50%{
	 	font-size: 30px;
	 	
	}
	100%{
	 	font-size: 24px;
	}
}
@-webkit-keyframes zooms {
	0%{
	 	font-size: 16px;
	}
	50%{
	 	font-size: 32px;
	 	
	}
	100%{
	 	font-size: 28px;
	}
}
@keyframes zooms {
	0%{
	 	font-size: 16px;
	}
	50%{
	 	font-size: 32px;
	 	
	}
	100%{
	 	font-size: 28px;
	}
}

 @-webkit-keyframes twinkling{
            0%{
                opacity: 0.5;
            }
            100%{
                opacity: 1;
            }
        }
        @keyframes twinkling{
            0%{
                opacity: 0.5;
            }
            100%{
                opacity: 1;
            }
        }
  .zoom{
  		animation: twinkling 1s ease-out  5;
  		-webkit-animation: twinkling 1s ease-out  5;
  }

 @-webkit-keyframes rotation {
	from {-webkit-transform: rotate(0deg);
}

to {
	-webkit-transform: rotate(360deg);
}

}
.an {
	-webkit-transform: rotate(360deg);
	animation: rotation 3s linear infinite;
	-moz-animation: rotation 3s linear infinite;
	-webkit-animation: rotation 3s linear infinite;
	-o-animation: rotation 3s linear infinite;
}

.img {
	border-radius: 100px;
}

.dialog-modal {
	position: absolute;
	z-index: 5;
}

.dialog-wrapper {
	position: fixed;
	height: 100%;
	width: 100%;
	z-index: 5;
	top: 0;
	left: 0;
	bottom: 0;
	right: 0;
}

.dialog-wrapper {
	background-color: #000;
	opacity: 0.7;
}

.dialog-container {
	position: fixed;
	z-index: 80;
	top: 80px;
	left: 320px;
	width: 1280px;
	height: 720px;
	background-color: #eee;
	border-radius: 5px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, .5);
}

span.close-btn {
	padding: 5px 10px;
	float: right;
	cursor: pointer;
	font-size: 16px;
	font-weight: bold;
}

 
</style>
  </head>
  
  <body>
  	  <div id="pfwd">
  	  	<el-row>
  	  		<div style="margin-left: 43px;
					    margin-top: 5px;
					    color: #ffffff;
					    float: left;">
  	  			{{dates}} {{whens}}
  	  		</div>
  	  		<div style="margin-left: 867px;
				    margin-top: 8px;
				    color: #02FFBB;
				    font-size: 30px;
				    font-weight: 550;
				    float: left;
				    position: absolute;">
  	  			客 流 量 详 情
  	  		</div>
  	  	</el-row>
  	  	<el-row>
	  	  	<el-col :span="8">
		  	  	<el-row>
	  	  			<div id="modalBtn" style="float: left;margin-top: 17px;margin-left: 33px;" @click="xlpmDetl()">
	                	<img src="resource/images/pasflw/xlklbiaoti.png" alt=""/>
	           		 </div>		
	  	  		</el-row>
	  	  		<el-row>
	  	  			<div id="xlklpmbar" style="float: left;
						    margin-left: 33px;
						    width: 500px;
						    height: 240px;">
	           		 </div>		
	  	  		</el-row>
	  	  		<el-row>
	  	  			<div style="float: left;margin-top: 0px;margin-left: 33px;" @click="klzfDetl()">
	                	<!-- <img src="resource/images/pasflw/xzqklbiaoti.png" alt=""/> -->
	                	<div class="" style="float: left;margin-top: 10px;margin-left: 15px;font-size: 24px;font-weight: bolder;color:#ffffff">
								  	  				分时客流
								  	  			</div>
	           		 </div>		
	  	  		</el-row>
	  	  		<el-row>
	  	  			<div id="" style="float: left;
						    margin-left: 33px;
						    width: 480px;
						    height: 220px;">
						    	<div id="" style="float: left;position:absolute;
								    margin-left: 33px;
								    width: 480px;
								    height: 220px;">
								    <iframe src="pages/pflows/timecompflw.jsp" frameBorder="0" width="480" height="220"></iframe>
	           		 			</div>	
	           		 </div>		
	  	  		</el-row>
	  	  			  
	  	  	</el-col>
	  	  	<el-col :span="8">
	  	  		<el-row>
	  	  			<div style="float: left;margin-top: 45px;margin-left: 260px;">
	                	<img src="resource/images/pasflw/sjzlbiaoti.png" alt=""/>
	           		 </div>		
	  	  		</el-row>
	  	  		<el-row>
	  	  			<div style="float: left;margin-top: 5px;margin-left: 0px;width:660px;height:430px">
	                	<iframe src="pages/tosnew/odflux_sel31.jsp" frameBorder="0" width="640" height="430"></iframe>
	           		 </div>		
	  	  		</el-row>
	  	  		
	  	  	</el-col>
	  	  	<el-col :span="8">
	  	  		<el-row>
	  	  			<div style="float: left;margin-top: 17px;margin-left: 103px;height: 40px" @click="czklDetl()">
	                	<img src="resource/images/pasflw/chzpmbiaoti.png" alt=""/>
	           		 </div>		
	  	  		</el-row>
	  	  		<div id="czkl">
	  	  		
	  	  		<el-row>
	  	  			<!-- <div style="float: left;margin-top: 0px;margin-left: 133px;height: 40px">
	                	<div style="float: left;margin-top: 10px;margin-left: 65px;height: 30px">
	                		<div v-if="cztype" style="float: left;margin-top: 0px;margin-left: 0px;height: 20px" @click="switcha('yes')">
			                    <img src="resource/images/pasflw/jinzhan.png" alt=""/>
			                 </div>
			                 <div v-else id="squarea" style="float: left;background-color: #ffffff;width: 14px;height: 14px;margin-top: 3px;" @click="switcha('no')"></div>
			                 <div style="float: left;margin-top: 0px;margin-left: 3px;height: 30px;color: #4D6C83;font-size: 13px">
			                   		 进站
			                 </div>
	           		 	</div>
	           		 	<div style="float: left;margin-top: 10px;margin-left: 25px;height: 30px">
	                		<div v-if="czbtype" style="float: left;margin-top: 0px;margin-left: 0px;height: 20px" @click="switchb('yes')">
			                    <img src="resource/images/pasflw/chuzhan.png" alt=""/>
			                 </div>
			                 <div v-else id="squarea" style="float: left;background-color: #ffffff;width: 14px;height: 14px;margin-top: 3px;" @click="switchb('no')"></div>
			                 <div style="float: left;margin-top: 0px;margin-left: 3px;height: 30px;color: #4D6C83;font-size: 13px">
			                   		 出站
			                 </div>
	           		 	</div>
	           		 	<div style="float: left;margin-top: 10px;margin-left: 25px;height: 30px">
	                		<div v-if="czctype" style="float: left;margin-top: 0px;margin-left: 0px;height: 20px" @click="switchc('yes')">
			                    <img src="resource/images/pasflw/huancheng.png" alt=""/>
			                 </div>
			                 <div v-else id="squarea" style="float: left;background-color: #ffffff;width: 14px;height: 14px;margin-top: 3px;" @click="switchc('no')"></div>
			                 <div style="float: left;margin-top: 0px;margin-left: 3px;height: 30px;color: #4D6C83;font-size: 13px">
			                   		 换乘
			                 </div>
	           		 	</div>		
	           		 </div>	 -->	
	  	  		</el-row>
	  	  		<el-row>
	  	  			<div id="chzklpmbar" style="float: left;
						    margin-left: 103px;
						    width: 500px;
						    height: 240px;">
	           		 </div>		
	  	  		</el-row>
	  	  		</div>
	  	  		<el-row>
	  	  			<div style="float: left;margin-top: 0px;margin-left: 103px;" @click="czydDetl()">
	                	<!-- <img src="resource/images/pasflw/yjzsbiaoti.png" alt=""/> -->
	                	<div class="" style="float: left;margin-top: 10px;margin-left: 15px;font-size: 24px;font-weight: bolder;color:#ffffff">
								  	  				重点车站客流
								  	  			</div>
	           		 </div>		
	  	  		</el-row>
	  	  	<el-row>
	  	  			<div style="float: left;
						    margin-left: 100px;
						    width: 500px;
						    height: 210px;">
						    
							    <iframe src="pages/pflows/prmstaflow.jsp" frameBorder="0" width="500" height="210"></iframe>
	           		 		
						  </div>
	  	  				
	  	  		</el-row>
	  	  		
	  	  	</el-col>
  	  	</el-row>
  	  	
		<el-row>
	  	  	<el-col :span="8">
	  	  		<el-row>
	  	  			<div style="float: left;margin-top: -6px;margin-left: 33px;" @click="zdczDetl()">
	                	<!-- <img src="resource/images/pasflw/zdchzbiaoti.png" alt=""/> -->
	                	<div class="" style="float: left;margin-top: 10px;margin-left: 15px;font-size: 24px;font-weight: bolder;color:#ffffff">
								  	  				线路车站客流
								  	  			</div>
	           		 </div>		
	  	  		</el-row>
	  	  		<el-row>
	  	  			<div id="zdcz" style="float: left;margin-top: 16px;margin-left: 33px;width: 530px;height: 355px;margin: 40px 23px 30px 40px;">
	                	  <iframe src="pages/pflows/linestaflow.jsp" frameBorder="0" width="670" height="350"></iframe>
	           		 </div>		
	  	  		</el-row>
	  	  	</el-col>
	  	  	<el-col :span="8">
	  	  		<el-row>
	  	  			<div style="float: left;margin-top: -7px;margin-left: 240px;font-size: 24px;font-weight: bolder;color:#ffffff" @click="vssiDetl()">
	                	<!-- <img src="resource/images/pasflw/hotvisitsite.png" alt=""/> -->
	                	<div class="" style="float: left;margin-top: 10px;margin-left: 15px;font-size: 24px;font-weight: bolder;color:#ffffff">
								  	  				线路车站客流
								  	  			</div>
	           		 </div>		
	  	  		</el-row>
	  	  		<el-row>
	  	  			<div id="vssi" style="float: left;margin-top: 16px;margin-left: 33px;width: 699px;height: 383px;margin: 20px 0px 10px -30px;
	  	  				border-top: 2px solid #008C6F;border-left: 2px solid #008C6F;border-right: 2px solid #008C6F;border-bottom: 2px solid #008C6F;">
	  	  				
	  	  			</div>
	  	  		</el-row>
	  	  	</el-col>
	  	  	<el-col :span="8">
	  	  		<el-row>
	  	  			<div style="float: left;margin-top: 0px;margin-left: 103px;" @click="qyklDetl()">
	                	<!-- <img src="resource/images/pasflw/xzqklbiaoti.png" alt=""/> -->
	                	<div class="" style="float: left;margin-top: 0px;margin-left: 15px;font-size: 24px;font-weight: bolder;color:#ffffff">
								  	  				车站换乘客流
								  	  			</div>
	           		 </div>		
	  	  		</el-row>
	  	  		<el-row>
	  	  			<div id=""  style="float: left;margin-top: 16px;margin-left: 33px;width: 550px;height: 380px;margin: 20px 0px 10px 62px;">
	  	  				<div id="" style="float: left;
						    margin-left: 0px;
						    width: 550px;
						    height: 380px;">
						    	<div id="xzqklpie" style="float: left;position:absolute;
								    margin-left: 33px;
								    width: 500px;
								    height: 330px;">
	           		 			</div>	
	           		 </div>	
	  	  			 </div>	
	  	  		</el-row>
	  	  	</el-col>
  	  	</el-row>
  	  	
  	  	<div class="dialog-modal">
  	  		<div class="dialog-wrapper" @click="onClose" v-show="isShow"></div>
				
				  <div id="fullsc" class="dialog-container " v-show="isShow">
				    <div class="" style="width:100%;height:40px;border-radius:5px 5px 0px 0px;background:#fff">
				      <div style="  float: left;height:100%;width:100%;text-align:center
					    margin-top: 0px;
					    margin-left: 0px;
					    font-size: 26px;
					    font-weight: bolder;
				   		 color: rgb(0, 204, 198);">
				      	{{modalTitle}}
				      </div>
				      <div style="position: absolute;margin-left: 87%;border-radius:5px;background-color:lightgreen;width: 80px;height: 30px;
    					margin-top: 5px;" @click="onFull">
				      		<div style="color: white;text-align: center;    margin-top: 4px;">全屏显示</div>
				      </div>
				      <div style="position: absolute;margin-left: 94%;border-radius:5px;background-color:#33CCFF;width: 60px;height: 30px;
    					margin-top:5px;" @click="onClose">
				      		<div style="color: white;text-align: center;    margin-top: 4px;">关闭</div>
				      </div>
				    </div>
				    
				    <slot>
				      <div class="" style="height:100%;width:100%; background-color: #043735">
				        <div id="modalchar" v-show="xlpmsw" style="height:680px;width:1280px;padding: 2% 3%;"></div>
				        <div id="qyklchar" v-show="qyklsw" style="height:680px;width:1280px;padding: 2% 3%;"></div>
				        
				        <div id="" v-show="czklsw" style="height:680px;width:1280px;padding: 2% 3%;">
				        	<iframe src="pages/pflows/allstaflowb.jsp" frameBorder="0" width="1200" height="620"></iframe>
                    	</div>
				      
				        <div id="" v-show="czydsw" style="height:680px;width:1280px;padding: 2% 3%;">
				        	 <iframe src="pages/pflows/prmstaflowa.jsp" frameBorder="0" width="1200" height="620"></iframe>
				        </div>
				        <div id="" v-show="zdczsw" style="height:720px;width:1280px;position: relative;padding: 2% 3%;">
					        <iframe src="pages/pflows/linestaflowa.jsp" frameBorder="0" width="1200" height="660"></iframe>
						</div>
						
						<div id="" v-show="klzfsw" style="height:680px;width:1280px;position: relative;padding: 15px 26px;">
							<iframe src="pages/pflows/timecompflwa.jsp" frameBorder="0" width="1200" height="660"></iframe>
							
					        <!-- <div id="klzfchar" v-show="klzfsw" style="position: absolute;width:1220px;height:640px;left:50%;top:50%; 
								margin-left:-610px;margin-top:-320px;"></div> -->
						</div>
				      </div>
				    </slot>
				  </div>
				
  	  	</div>	  	 
  	  	
  	  </div>
  	  
 
  
      <script type="text/javascript">
      //自定义一个过滤器，用于在页面上显示年月日格式
		/* 	Vue.filter('numFormat',function(num){
			
				var nums=parseInt(num);
				return nums;
			}); */
			       
		new Vue({
		  el: '#pfwd',
		  data:function(){
			return {
				isShow:false,
				xlpmsw:false,
				qyklsw:false,
				fsklsw:false,
				czklsw:false,
				czydsw:false,
				zdczsw:false,
				vssisw:false,
				klzfsw:false,
				zfjdata:[],
				zfcdata:[],
				zfhdata:[],
				zljdata:[],
				zlcdata:[],
				zlhdata:[],
				timelong:[
				{"SHOW_TIME":"00:00~01:00"},
				{"SHOW_TIME":"01:00~02:00"},
				{"SHOW_TIME":"02:00~03:00"},
				{"SHOW_TIME":"03:00~04:00"},
				{"SHOW_TIME":"04:00~05:00"},
				{"SHOW_TIME":"05:00~06:00"},
				{"SHOW_TIME":"06:00~07:00"},
				{"SHOW_TIME":"07:00~08:00"},
				{"SHOW_TIME":"08:00~09:00"},
				{"SHOW_TIME":"09:00~10:00"},
				{"SHOW_TIME":"10:00~11:00"},
				{"SHOW_TIME":"11:00~12:00"},
				{"SHOW_TIME":"12:00~13:00"},
				{"SHOW_TIME":"13:00~14:00"},
				{"SHOW_TIME":"14:00~15:00"},
				{"SHOW_TIME":"15:00~16:00"},
				{"SHOW_TIME":"16:00~17:00"},
				{"SHOW_TIME":"17:00~18:00"},
				{"SHOW_TIME":"18:00~19:00"},
				{"SHOW_TIME":"19:00~20:00"},
				{"SHOW_TIME":"20:00~21:00"},
				{"SHOW_TIME":"21:00~22:00"},
				{"SHOW_TIME":"22:00~23:00"},
				{"SHOW_TIME":"23:00~00:00"}],
				asato:"世纪大道",
				asatoData:[],
				bsato:"南京东路",
				bsatoData:[],
				csato:"南京东路",
				csatoData:[],
				dsato:"南京东路",
				dsatoData:[],
				esato:"南京东路",
				esatoData:[],
				fsato:"南京东路",
				fsatoData:[],
				atableData: [],
				date:"",
				dates:"",
				whens:'',
				when:'',
				flowType:[1,3],
				cztype:true,
				czbtype:false,
				czctype:true,
				trafjamdata:[],
				trafjam:{
					ashow:true,
					aname:'',
					aline:'',
					avalue:'',
					bshow:false,
					bname:'',
					bline:'',
					bvalue:'',
					cshow:false,
					cname:'',
					cline:'',
					cvalue:'',
					dshow:false,
					dname:'',
					dline:'',
					dvalue:'',
					eshow:false,
					ename:'',
					eline:'',
					evalue:'',
				},
				summary:{
					asshow:false,
					dsshow:false,
					ascRate:"",
					changeTimes:'',
					schangeTimes:'',
					dscRate:"",
					enterTimes:'',
					senterTimes:'',
					pfwAmount:"",
					spfwAmount:"",
					menterTimes:'',
					smenterTimes:'',
					mchangeTimes:'',
					smchangeTimes:'',
					mpfwAmount:"",
					smpfwAmount:"",
					hpfwAmount:"",
					shpfwAmount:""
				},
				modalTitle:"",
				fsklData:'',
				qyklData:[],
				xlklData:{},
				xlpfwpmchar:'',
				xlpfwOption:'',
				xlpmsers:[],
				xlpfwData:'',
				dispfwchar:'',
				dispfwOption:'',
				dispfwData:'',
				ydzjchart:'',
				ydjsOption:'',
				ydzjcharts:'',
				ydjsOptions:'',
				ydjsData:'',
				czklData:[],
				chzchart:"",
				chzchartOption:"",
				chzchartData:"",
				chzLine:[]
			}
		  },
		    mounted: function () {
		  
		this.initData();
		this.timeReload();



        },
		  methods: {
		  //初始化页面
		  initData:function(){
		  	  this.getNowFormatnow();
		    this.getPFWsmy();
		    this.getXlpfwchart();
		     this.getDiscpfw();
		    this.xzqklchar();
		     this.chzchartbar();
				this.getChzchart();
		    this.getFspafl();
		    this.ydjschar();
		   this.getTracjam();
		   this.getZdChzchart();
		   this.getZfuj();
		   this.getZfuc();
		   this.getZfuh();
		   this.getZlaj();
		   this.getZlac();
		   this.getZlah();
		   this.getVisitpfw();
		  },
		  //定时刷新
		  timeReload:function(){
		  	var vueThis=this;
		  	setInterval(function() {
                  vueThis.initData();
                }, 300000);
		  },
		  
		  //数字滚动动画
		  Numcount:function(){
		  	var vueThis=this;
		  	  
		  	 var options = {
			  useEasing : true, 
			  useGrouping : true, 
			  separator : '', 
			  decimal : '.', 
			  prefix : '', 
			  suffix : '' 
			};
			if(vueThis.summary.spfwAmount==0){
					var pfwAmount = new CountUp("pfwAmount", vueThis.summary.spfwAmount,vueThis.summary.pfwAmount, 1, 5,options);
			 		pfwAmount.start();
			 $("#pfwAmount").css("-webkit-animation","zooms 2s ease-out 3");
				
			
			 
			 var changeTimes = new CountUp("changeTimes", vueThis.summary.schangeTimes,vueThis.summary.changeTimes, 1, 5,options);
			 changeTimes.start(); 
			 $("#changeTimes").css("-webkit-animation","zoomsa 2s ease-out 3");
			 var enterTimes = new CountUp("enterTimes", vueThis.summary.senterTimes,vueThis.summary.enterTimes, 1, 5,options);
			 enterTimes.start(); 
			 $("#enterTimes").css("-webkit-animation","zoomsa 2s ease-out 3");
			//var hpfwAmount = new CountUp("hpfwAmount", vueThis.summary.shpfwAmount,vueThis.summary.hpfwAmount, 1, 5,options);
			 //hpfwAmount.start(); 
			 
			  var mchangeTimes = new CountUp("mchangeTimes", vueThis.summary.smchangeTimes,vueThis.summary.mchangeTimes, 1, 5,options);
			 mchangeTimes.start(); 
			 $("#mchangeTimes").css("-webkit-animation","zoomsa 2s ease-out 3");
			 var menterTimes = new CountUp("menterTimes", vueThis.summary.smenterTimes,vueThis.summary.menterTimes, 1, 5,options);
			 menterTimes.start(); 
			 $("#menterTimes").css("-webkit-animation","zoomsa 2s ease-out 3");
			 var mpfwAmount = new CountUp("mpfwAmount", vueThis.summary.smpfwAmount,vueThis.summary.mpfwAmount, 1, 5,options);
			 mpfwAmount.start(); 
			 $("#mpfwAmount").css("-webkit-animation","zooms 2s ease-out 3");
			}else{
				var pfwAmount = new CountUp("pfwAmount", vueThis.summary.spfwAmount,vueThis.summary.pfwAmount, 1, 300,options);
				pfwAmount.start(); 
				 //$("#pfwAmount").css("-webkit-animation","zoomsb 2s ease-out 150");
				 
				 var changeTimes = new CountUp("changeTimes", vueThis.summary.schangeTimes,vueThis.summary.changeTimes, 1, 300,options);
				 changeTimes.start(); 
				 var enterTimes = new CountUp("enterTimes", vueThis.summary.senterTimes,vueThis.summary.enterTimes, 1, 300,options);
				 enterTimes.start(); 
				//var hpfwAmount = new CountUp("hpfwAmount", vueThis.summary.shpfwAmount,vueThis.summary.hpfwAmount, 1, 300,options);
				 //hpfwAmount.start(); 
				 
				  var mchangeTimes = new CountUp("mchangeTimes", vueThis.summary.smchangeTimes,vueThis.summary.mchangeTimes, 1, 300,options);
				 mchangeTimes.start(); 
				 var menterTimes = new CountUp("menterTimes", vueThis.summary.smenterTimes,vueThis.summary.menterTimes, 1, 300,options);
				 menterTimes.start(); 
				 var mpfwAmount = new CountUp("mpfwAmount", vueThis.summary.smpfwAmount,vueThis.summary.mpfwAmount, 1, 300,options);
				 mpfwAmount.start(); 
				  
			 
			 }
		  },
		  //数字缩放
		  Numzoom:function(id){
		  	$("#"+id).css("-webkit-animation","zoomsb 2s ease-out 150");
		  
		  
		  },
		  //数字滚动
		  Numdown:function(id,num,maxNum){
		  
		      var numBox = document.getElementById(id);
		  
		  		  var numText = num;
			        var golb; // 为了清除requestAnimationFrame
			        function numSlideFun(){
			            numText+=(maxNum-num)/60; // 速度的计算可以为小数
			            if(numText >= maxNum){
			                numText = maxNum;
			                cancelAnimationFrame(golb);
			            }else {
			            		
			            	
			
			                golb = requestAnimationFrame(numSlideFun);
			            }
			            numBox.innerHTML = ~~(numText)
			
			        }
			        numSlideFun();
		  
		  
		  },
		  //客流增幅缩放
		  klzfDetl:function(){
		  	var vueThis=this;
		  		 vueThis.isShow=true;
		  		 vueThis.fsklsw=false;
		  		 vueThis.qyklsw=false;
		  		 vueThis.xlpmsw=false;
		  		 vueThis.czklsw=false;
		  		  vueThis.czydsw=false;
		  		  vueThis.zdczsw=false;
		  		  vueThis.vssisw=false;
		  		  vueThis.klzfsw=true;
		  		
		  		vueThis.modalTitle='';
		  	
		  	var czyds=$('#klzfzl').clone(true);
					$('#klzfchar').html(czyds);
					$($("#klzfchar").children("div").get(0)).css('transform','scale(2)');
					$($("#klzfchar").children("div").get(0)).css('margin-left','340px');
					$($("#klzfchar").children("div").get(0)).css('margin-top','155px');
			
		  },
		  //景点客流缩放
		  vssiDetl:function(){
		  	var vueThis=this;
		  		 vueThis.isShow=true;
		  		 vueThis.fsklsw=false;
		  		 vueThis.qyklsw=false;
		  		 vueThis.xlpmsw=false;
		  		 vueThis.czklsw=false;
		  		  vueThis.czydsw=false;
		  		  vueThis.zdczsw=false;
		  		  vueThis.vssisw=true;
		  		  vueThis.klzfsw=false;
		  		
		  		vueThis.modalTitle='';
		  	
		  	var czyds=$('#vssi').clone(true);
					$('#vssichar').html(czyds);
					$($("#vssichar").children("div").get(0)).css('transform','scale(1.5)');
					$($("#vssichar").children("div").get(0)).css('margin-left','260px');
					$($("#vssichar").children("div").get(0)).css('margin-top','145px');
			
		  },
		  //重点车站缩放
		  zdczDetl:function(){
		  	var vueThis=this;
		  		 vueThis.isShow=true;
		  		 vueThis.fsklsw=false;
		  		 vueThis.qyklsw=false;
		  		 vueThis.xlpmsw=false;
		  		 vueThis.czklsw=false;
		  		  vueThis.czydsw=false;
		  		  vueThis.zdczsw=true;
		  		  vueThis.vssisw=false;
		  		vueThis.klzfsw=false;
		  		vueThis.modalTitle='线路车站客流';
		  	
		  
					
		  },
		  
		  //车站拥堵放大
		  czydDetl:function(){
		  	var vueThis=this;
		  		 vueThis.isShow=true;
		  		 vueThis.fsklsw=false;
		  		 vueThis.qyklsw=false;
		  		 vueThis.xlpmsw=false;
		  		 vueThis.czklsw=false;
		  		  vueThis.czydsw=true;
		  		   vueThis.zdczsw=false;
		  		   vueThis.vssisw=false;
		  		vueThis.klzfsw=false;
		  		vueThis.modalTitle='重点车站客流';
		  		
		  },
		   onFull:function(){
			
			$('#fullsc').css('transform','scale(1.5)');
			},
			
			
		  //车站客流放大
		  czklDetl:function(){
		  
		  	var vueThis=this;
		  		 vueThis.isShow=true;
		  		 vueThis.fsklsw=false;
		  		 vueThis.qyklsw=false;
		  		 vueThis.xlpmsw=false;
		  		 vueThis.czklsw=true;
		  		 vueThis.zdczsw=false;
		  		 vueThis.czydsw=false;
		  		 vueThis.vssisw=false;
		  		 vueThis.klzfsw=false;
		  		/* var czkl= $('#czkl').html();
		  		$('#czklcahr').html(czkl); */
		  		vueThis.modalTitle='全路网车站客流排名';
		  	
					
		  },
		  //分时客流
		  fsklDetl:function(){
		  	var vueThis=this;
		  		 vueThis.isShow=true;
		  		 vueThis.fsklsw=true;
		  		 vueThis.qyklsw=false;
		  		 vueThis.xlpmsw=false;
		  		 vueThis.czklsw=false;
		  		 vueThis.zdczsw=false;
		  		 vueThis.vssisw=false;
		  		 vueThis.czydsw=false;
		  		 vueThis.klzfsw=false;
		  		
		      vueThis.modalTitle='全日分时客流累计';
		      vueThis.fsklchars('afsklchar','bfsklchar');
		  },
		  //区域客流放大
		  qyklDetl:function(){
		  	var vueThis=this;
		  		 vueThis.isShow=true;
		  		 vueThis.qyklsw=true;
		  		 vueThis.xlpmsw=false;
		  		 vueThis.fsklsw=false;
		  		 vueThis.czklsw=false;
		  		 vueThis.zdczsw=false;
		  		 vueThis.czydsw=false;
		  		 vueThis.vssisw=false;
		  		 vueThis.klzfsw=false;
		  		
		      vueThis.modalTitle='全路网车站换乘客流';
		      vueThis.xzqklchars();
					var data_name = [];
					var item = {};
					var data=vueThis.qyklData;
					 for (var i=0;i<=data.length-1;i++){
					       item=new Object();
					       item.name=data[i]['STATION_NM_CN'];
					       item.value=data[i]['IN_PASS_NUM'];
					       
						data_name.push(item);
					}
					
		
						
					
					vueThis.dispfwOption.series[0].data = data_name;
				
					vueThis.dispfwchar.setOption(vueThis.dispfwOption); 
		  },
		  //线路排名放大
		  xlpmDetl:function(){
		  var vueThis=this;
		      vueThis.isShow=true;
		      vueThis.qyklsw=false;
		  		 vueThis.xlpmsw=true;
		  		 vueThis.fsklsw=false;
		  		 vueThis.czklsw=false;
		  		 vueThis.zdczsw=false;
		  		 vueThis.vssisw=false;
		  		 vueThis.czydsw=false;
		      vueThis.klzfsw=false;
		      vueThis.modalTitle='线路客流排名';
		      vueThis.xlklpmchars('#modalchar');
		      
		      var data_name = [];
					var data_val = [];
					var data1_val = [];
					
					
						var data=vueThis.xlklData;
					 for (var i=0;i<=data.todayData.length-1;i++){
						data_name.push(data.todayData[i]['LINE_NM_CN'].substring(4));
						data_val.push(data.todayData[i]['IN_PASS_NUM']);
					}
					
					for (var i=0;i<=data.compData.length-1;i++){
						//data_name.push(data[i]['LINE_NM_CN'].substring(4));
						data1_val.push(data.compData[i]['IN_PASS_NUM']);
					}
					      
		               
					vueThis.xlpfwOption.xAxis[0].data = data_name;
					vueThis.xlpfwOption.series[0].data = data_val;
					vueThis.xlpfwOption.series[1].data = data1_val;
		      vueThis.xlpfwpmchar.setOption(vueThis.xlpfwOption);
		  console.log(vueThis.xlpfwOption);
	     
		  },
		  //div 复制填充
		  xlpmDetls:function(){
		  var vueThis=this;
		      vueThis.isShow=true;
		      
		   //var xlpm=  $('#xlklpmbar').clone(true);
		    var xlpm=  $('#zdcz').clone(true);
		   
		   console.log(xlpm);
		   $('#modalchar').html(xlpm);
		      
		  },
		  onClose:function() {
		  	$('#fullsc').css('transform','scale(1)');
			this.isShow = false;
			
			},
		//增幅增量切换
		zlzfswitch:function(sta){
			if(sta=='czzf'){
			$("#chzzf").css("display","block");
			$("#czzf").attr("src","resource/images/pasflw/selected-1.png");
			$("#chzzl").css("display","none");
			$("#czzl").attr("src","resource/images/pasflw/hover-2.png");
			}
			if(sta=="czzl"){
			$("#chzzl").css("display","block");
			$("#czzl").attr("src","resource/images/pasflw/selected-2.png");
			$("#chzzf").css("display","none");
			$("#czzf").attr("src","resource/images/pasflw/hover-1.png");
			}
		
		},
		    //字符串指定位置插入字符串
            //参数说明：str表示原字符串变量，flg表示要插入的字符串，sn表示要插入的位置
            insert_flg:function (str,flg,sn){
                var newstr="";
                for(var i=0;i<str.length;i+=sn){
                    var tmp=str.substring(i, i+sn);
                    newstr+=tmp+flg;
                }
                return newstr;
            },
		   //获取旅游热点车站客流数据
		  getVisitpfw:function(){
		  
		  	var vueThis=this;
		
		  		var week_date="<%=week_date%>";
		  		 var selTypes=[1,3];
				/*$('input[name="selType"]:checked').each(function(){
					selTypes.push($(this).val());
				}); */
				$.post("visitpfw/GetHotChzpflfw.action",{"date":vueThis.date,"size":6}, function(data){
					
					
					
					console.log("外滩两岸客流:"+data);
					
					 for (var i=0;i<=data.length-1;i++){
					      
					      vueThis.astato =data[0].stationName;
			
					      vueThis.asatoData =data[0].tadata;
					      vueThis.bsato =data[1].stationName;
					      vueThis.bsatoData =data[1].tadata;
					      vueThis.csato =data[2].stationName;
					      vueThis.csatoData =data[2].tadata;
					      vueThis.dsato =data[3].stationName;
					      vueThis.dsatoData =data[3].tadata;
					      vueThis.esato =data[4].stationName;
					      vueThis.esatoData =data[4].tadata;
					      vueThis.fsato =data[5].stationName;
					      vueThis.fsatoData =data[5].tadata;
					      
					       
					    
					   
					       
					 
					}
				
			     
				}); 
		  },
		  //获取各车站换乘客流增幅数据
		  getZfuh:function(){
		  
		  	var vueThis=this;
		
		  		var week_date="<%=week_date%>";
		  		
		  		vueThis.zfhdata=[];
		  	
				$.post("zfuchzpfw/GetZfuChzpfw.action",{"date":vueThis.date,"controlDate":week_date,"fluxType":3,"sortType":1,"size":8}, function(data){
					console.log("进站客流总量增幅:"+data);
					for (var i=0;i<=data.length-1;i++){
					 var zfjda=new Object();
					      //{"TOTAL_TIMES":7844,"SYMBOL":1,"INCREASE":198.48,"INCREASE_ABS":198.48,"STATION_NM_CN":"浦电路04","NM":1},
					      zfjda.TOTAL_TIMES =parseInt(data[i].TOTAL_TIMES);
					      zfjda.INCREASE =data[i].INCREASE;
					      zfjda.INCREASE_ABS =data[i].INCREASE_ABS;
					      zfjda.STATION_NM_CN =data[i].STATION_NM_CN;
					      var symbol=data[i].SYMBOL;
					      if(symbol=='1'){
					      	zfjda.isa=true;
					      }else if(symbol=='-1'){
					      zfjda.isa=false;
					      }
					      vueThis.zfhdata.push(zfjda);
					 
					}
				
				}); 
		  },
		   //获取各车站换乘客流增量数据
		  getZlah:function(){
		  
		  	var vueThis=this;
		
		  		var week_date="<%=week_date%>";
		  		
		  		vueThis.zlhdata=[];
		  	
				$.post("zlchzpfw/GetZlaChzpfw.action",{"date":vueThis.date,"controlDate":week_date,"fluxType":3,"sortType":1,"size":8}, function(data){
					console.log("进站客流总量增幅:"+data);
					for (var i=0;i<=data.length-1;i++){
					 var zfjda=new Object();
					      //{"TOTAL_TIMES":7844,"SYMBOL":1,"INCREASE":198.48,"INCREASE_ABS":198.48,"STATION_NM_CN":"浦电路04","NM":1},
					      zfjda.TOTAL_TIMES =parseInt(data[i].TOTAL_TIMES);
					      zfjda.INCREASE =parseInt(data[i].INCREASE_ABS);
					      zfjda.INCREASE_ABS =parseInt(data[i].INCREASE_ABS);
					      zfjda.STATION_NM_CN =data[i].STATION_NM_CN;
					      var symbol=data[i].SYMBOL;
					      if(symbol=='1'){
					      	zfjda.isa=true;
					      }else if(symbol=='-1'){
					      zfjda.isa=false;
					      }
					      vueThis.zlhdata.push(zfjda);
					 
					}
				
				}); 
		  },
		   //获取各车站出站客流增幅数据
		  getZfuc:function(){
		  
		  	var vueThis=this;
		
		  		var week_date="<%=week_date%>";
		  		
		  		vueThis.zfcdata=[];
		  	
				$.post("zfuchzpfw/GetZfuChzpfw.action",{"date":vueThis.date,"controlDate":week_date,"fluxType":2,"sortType":1,"size":8}, function(data){
					console.log("进站客流总量增幅:"+data);
					for (var i=0;i<=data.length-1;i++){
					 var zfjda=new Object();
					      //{"TOTAL_TIMES":7844,"SYMBOL":1,"INCREASE":198.48,"INCREASE_ABS":198.48,"STATION_NM_CN":"浦电路04","NM":1},
					      zfjda.TOTAL_TIMES =data[i].TOTAL_TIMES;
					      zfjda.INCREASE =data[i].INCREASE;
					      zfjda.INCREASE_ABS =data[i].INCREASE_ABS;
					      zfjda.STATION_NM_CN =data[i].STATION_NM_CN;
					      var symbol=data[i].SYMBOL;
					      if(symbol=='1'){
					      	zfjda.isa=true;
					      }else if(symbol=='-1'){
					      zfjda.isa=false;
					      }
					      vueThis.zfcdata.push(zfjda);
					 
					}
				
				}); 
		  },
		   //获取各车站出站客流增量数据
		  getZlac:function(){
		  
		  	var vueThis=this;
		
		  		var week_date="<%=week_date%>";
		  		
		  		vueThis.zlcdata=[];
		  	
				$.post("zlchzpfw/GetZlaChzpfw.action",{"date":vueThis.date,"controlDate":week_date,"fluxType":2,"sortType":1,"size":8}, function(data){
					console.log("进站客流总量增幅:"+data);
					for (var i=0;i<=data.length-1;i++){
					 var zfjda=new Object();
					      //{"TOTAL_TIMES":7844,"SYMBOL":1,"INCREASE":198.48,"INCREASE_ABS":198.48,"STATION_NM_CN":"浦电路04","NM":1},
					      zfjda.TOTAL_TIMES =data[i].TOTAL_TIMES;
					      zfjda.INCREASE =parseInt(data[i].INCREASE_ABS);
					      zfjda.INCREASE_ABS =parseInt(data[i].INCREASE_ABS);
					      zfjda.STATION_NM_CN =data[i].STATION_NM_CN;
					      var symbol=data[i].SYMBOL;
					      if(symbol=='1'){
					      	zfjda.isa=true;
					      }else if(symbol=='-1'){
					      zfjda.isa=false;
					      }
					      vueThis.zlcdata.push(zfjda);
					 
					}
				
				}); 
		  },
		   //获取各车站进站客流增幅数据
		  getZfuj:function(){
		  
		  	var vueThis=this;
		
		  		var week_date="<%=week_date%>";
		  		
		  		vueThis.zfjdata=[];
		  	
				$.post("zfuchzpfw/GetZfuChzpfw.action",{"date":vueThis.date,"controlDate":week_date,"fluxType":1,"sortType":1,"size":8}, function(data){
					console.log("进站客流总量增幅:"+data);
					for (var i=0;i<=data.length-1;i++){
					 var zfjda=new Object();
					      //{"TOTAL_TIMES":7844,"SYMBOL":1,"INCREASE":198.48,"INCREASE_ABS":198.48,"STATION_NM_CN":"浦电路04","NM":1},
					      zfjda.TOTAL_TIMES =data[i].TOTAL_TIMES;
					      zfjda.INCREASE =data[i].INCREASE;
					      zfjda.INCREASE_ABS =data[i].INCREASE_ABS;
					      zfjda.STATION_NM_CN =data[i].STATION_NM_CN;
					      var symbol=data[i].SYMBOL;
					      if(symbol=='1'){
					      	zfjda.isa=true;
					      }else if(symbol=='-1'){
					      zfjda.isa=false;
					      }
					      vueThis.zfjdata.push(zfjda);
					 
					}
				
				}); 
		  },
		   //获取各车站进站客流增量数据
		  getZlaj:function(){
		  
		  	var vueThis=this;
		
		  		var week_date="<%=week_date%>";
		  		
		  		vueThis.zljdata=[];
		  	
				$.post("zlchzpfw/GetZlaChzpfw.action",{"date":vueThis.date,"controlDate":week_date,"fluxType":1,"sortType":1,"size":8}, function(data){
					console.log("进站客流总量增幅:"+data);
					for (var i=0;i<=data.length-1;i++){
					 var zfjda=new Object();
					      //{"TOTAL_TIMES":7844,"SYMBOL":1,"INCREASE":198.48,"INCREASE_ABS":198.48,"STATION_NM_CN":"浦电路04","NM":1},
					      zfjda.TOTAL_TIMES =data[i].TOTAL_TIMES;
					      zfjda.INCREASE =parseInt(data[i].INCREASE_ABS);
					      zfjda.INCREASE_ABS =parseInt(data[i].INCREASE_ABS);
					      zfjda.STATION_NM_CN =data[i].STATION_NM_CN;
					      var symbol=data[i].SYMBOL;
					      if(symbol=='1'){
					      	zfjda.isa=true;
					      }else if(symbol=='-1'){
					      zfjda.isa=false;
					      }
					      vueThis.zljdata.push(zfjda);
					 
					}
				
				}); 
		  },
		   //获取重点车站客流图表数据  
		  getZdChzchart:function(){
		  		var vueThis=this;
		  		 var selTypes=[1,3];
				/*$('input[name="selType"]:checked').each(function(){
					selTypes.push($(this).val());
				}); */
				
				
				 
				$.post("zdchzpfw/GetZdChzpfw.action",{"date":vueThis.date}, function(data){
					console.log("重点车站:"+data);
					vueThis.atableData=data;
						
					/* var data_name = [];
					var data_val = [];
					for (var i=data.length-1;i>=0;i--){
						data_name.push(data[i]['STATION_NM_CN']);
						data_val.push(data[i]['IN_PASS_NUM']);
					}
			
					vueThis.chzchartOption.yAxis[0].data = data_name;
					vueThis.chzchartOption.series[0].data = data_val;
					vueThis.chzchart.setOption(vueThis.chzchartOption); */
					
					
			     
				}); 
		  		
		  },
		  
		  //获取重点车站客流
		  
		  //进站类型切换
		  	switcha:function(stat){
			  var vueThis=this;
			  if(stat=="yes"){
			  vueThis.cztype=false;
			  }
			  
			  if(stat=="no"){
			  vueThis.cztype=true;
			  
			  }
		  
		  },
		   //出站类型切换
		  	switchb:function(stat){
			  var vueThis=this;
			  if(stat=="yes"){
			  vueThis.czbtype=false;
			  }
			  
			  if(stat=="no"){
			  vueThis.czbtype=true;
			  }
		  
		  },
		   //换乘类型切换
		  	switchc:function(stat){
			  var vueThis=this;
			  if(stat=="yes"){
			  vueThis.czctype=false;
			  }
			  
			  if(stat=="no"){
			  vueThis.czctype=true;
			  }
		  
		  },
		  
		  //获取车站客流图表数据  
		  getChzflow:function(){
		  		var vueThis=this;
		  		 var selTypes=[1,3];
				/*$('input[name="selType"]:checked').each(function(){
					selTypes.push($(this).val());
				}); */
				
				
				 
				$.post("sheete/get_all_passe.action",{"id":0,"type":0,"date":vueThis.date,"startTime":vueThis.when,"size":8,"selType":selTypes}, function(data){
						
						vueThis.czklData=data;
					var data_name = [];
					var data_val = [];
					for (var i=data.length-1;i>=0;i--){
						data_name.push(data[i]['STATION_NM_CN']);
						data_val.push(data[i]['IN_PASS_NUM']);
					}
					vueThis.chzLine=data_name;
					vueThis.chzchartOption.yAxis[0].data = data_name;
					vueThis.chzchartOption.series[0].data = data_val;
					vueThis.chzchart.setOption(vueThis.chzchartOption);
					//vueThis.getJams();
			
				}); 
		  		
		  },
		   //切换查看不同车站的拥堵率
		  	ydswitch:function(stat){
			  var vueThis=this;
			  if(stat=="yda"){
				  vueThis.trafjam.ashow=true;
				  vueThis.trafjam.bshow=false;
				  vueThis.trafjam.cshow=false;
				  vueThis.trafjam.dshow=false;
				  vueThis.trafjam.eshow=false;
				
				  $("#yda").css("color","red");
				  $("#ydb").css("color","#ffffff");
				  $("#ydc").css("color","#ffffff");
				  $("#ydd").css("color","#ffffff");
				  $("#yde").css("color","#ffffff");
				  var za=[];
			  		 var zaj={};
			  		 zaj.value=vueThis.trafjam.avalue;
			  		 za.push(zaj);
			  		 
			  		 vueThis.ydjsOption.series[0].data =za;
			  		 vueThis.ydjsOption.series[2].data =za;
						vueThis.ydzjchart.setOption(vueThis.ydjsOption);
			  }
			  
			  if(stat=="ydb"){
				  vueThis.trafjam.bshow=true;
				  vueThis.trafjam.ashow=false;
				   vueThis.trafjam.cshow=false;
				  vueThis.trafjam.dshow=false;
				  vueThis.trafjam.eshow=false;
				  $("#ydb").css("color","red");
				   $("#yda").css("color","#ffffff");
				  $("#ydc").css("color","#ffffff");
				  $("#ydd").css("color","#ffffff");
				  $("#yde").css("color","#ffffff");
				  var zb=[];
			  		 var zbj={};
			  		 zbj.value=vueThis.trafjam.bvalue;
			  		 zb.push(zbj);
			  		 
			  		 vueThis.ydjsOption.series[0].data =zb;
			  		 vueThis.ydjsOption.series[2].data =zb;
						vueThis.ydzjchart.setOption(vueThis.ydjsOption);
			  }
			  
			  if(stat=="ydc"){
				  vueThis.trafjam.cshow=true;
				   vueThis.trafjam.ashow=false;
				   vueThis.trafjam.bshow=false;
				  vueThis.trafjam.dshow=false;
				  vueThis.trafjam.eshow=false;
				  $("#ydc").css("color","red");
				   $("#yda").css("color","#ffffff");
				  $("#ydb").css("color","#ffffff");
				  $("#ydd").css("color","#ffffff");
				  $("#yde").css("color","#ffffff");
				  var zc=[];
			  		 var zcj={};
			  		 zcj.value=vueThis.trafjam.cvalue;
			  		 zc.push(zcj);
			  		 
			  		 vueThis.ydjsOption.series[0].data =zc;
			  		 vueThis.ydjsOption.series[2].data =zc;
						vueThis.ydzjchart.setOption(vueThis.ydjsOption);
			  }
			  
			  if(stat=="ydd"){
				  vueThis.trafjam.dshow=true;
				  vueThis.trafjam.ashow=false;
				   vueThis.trafjam.bshow=false;
				  vueThis.trafjam.cshow=false;
				  vueThis.trafjam.eshow=false;
				  $("#ydd").css("color","red");
				   $("#yda").css("color","#ffffff");
				  $("#ydc").css("color","#ffffff");
				  $("#ydb").css("color","#ffffff");
				  $("#yde").css("color","#ffffff");
				  var zd=[];
			  		 var zdj={};
			  		 zdj.value=vueThis.trafjam.dvalue;
			  		 zd.push(zdj);
			  		 
			  		 vueThis.ydjsOption.series[0].data =zd;
			  		 vueThis.ydjsOption.series[2].data =zd;
						vueThis.ydzjchart.setOption(vueThis.ydjsOption);
			  }
			   if(stat=="yde"){
				  vueThis.trafjam.eshow=true;
				  vueThis.trafjam.ashow=false;
				   vueThis.trafjam.bshow=false;
				  vueThis.trafjam.dshow=false;
				  vueThis.trafjam.cshow=false;
				  $("#yde").css("color","red");
				   $("#yda").css("color","#ffffff");
				  $("#ydc").css("color","#ffffff");
				  $("#ydb").css("color","#ffffff");
				  $("#ydd").css("color","#ffffff");
				  var ze=[];
			  		 var zej={};
			  		 zej.value=vueThis.trafjam.evalue;
			  		 ze.push(zej);
			  		 
			  		 vueThis.ydjsOption.series[0].data =ze;
			  		 vueThis.ydjsOption.series[2].data =ze;
						vueThis.ydzjchart.setOption(vueThis.ydjsOption);
			  }
		  
		  },
		  
		  //获取车站拥堵率
		  getTracjam:function(){
		  	var vueThis=this;
		  	$.post("traffic/GettrafJam.action",{"date":vueThis.date,"size":8}, function(data){
		  		console.log("车站拥堵率:"+data);
		  		
		  		
		  		
		  		
		  		 vueThis.trafjam.aname=data[0].stationName;
		  		 vueThis.trafjam.avalue=data[0].trfcjam;
		  		 vueThis.trafjam.aline=data[0].lineId;
		  		 vueThis.trafjam.bname=data[1].stationName;
		  		 vueThis.trafjam.bline=data[1].lineId;
		  		 vueThis.trafjam.bvalue=data[1].trfcjam;
		  		 vueThis.trafjam.cname=data[2].stationName;
		  		 vueThis.trafjam.cline=data[2].lineId;
		  		 vueThis.trafjam.cvalue=data[2].trfcjam;
		  		 vueThis.trafjam.dname=data[3].stationName;
		  		 vueThis.trafjam.dline=data[3].lineId;
		  		 vueThis.trafjam.dvalue=data[3].trfcjam;
		  		 vueThis.trafjam.ename=data[4].stationName;
		  		 vueThis.trafjam.eline=data[4].lineId;
		  		 vueThis.trafjam.evalue=data[4].trfcjam;
		  		 
		  		 var za=[];
		  		 var zaj={};
		  		 zaj.value=vueThis.trafjam.avalue;
		  		 za.push(zaj);
		  		 
		  		 vueThis.ydjsOption.series[0].data =za;
		  		 vueThis.ydjsOption.series[2].data =za;
					vueThis.ydzjchart.setOption(vueThis.ydjsOption);
					
					
					
				
		  		 		
		  		 	
		  		 
		  			
		  	}); 
		  },
		  
		  //获取车站柱状图中车站的拥堵率
		  	getJams:function(){
		  		var vueThis=this;
		  		 	$.post("traffic/GetSomeJams.action",{"date":vueThis.date,"sites":vueThis.chzLine}, function(data){
		  				console.log("部分车站拥堵率:"+data);
		  				
		  					var data_val = [];
					for (var i=0;i<data.length;i++){
						
						data_val.push(data[i]['trfcjam']);
					}
			
					
					vueThis.chzchartOption.series[1].data = data_val;
					vueThis.chzchart.setOption(vueThis.chzchartOption);
		  			}); 
		  	},
		  //获取数据总览数据
		  getPFWsmy:function(){
		  
		  	var vueThis=this;
		
		  		var week_date="<%=week_date%>";
		  		 var selTypes=[1,3];
				/*$('input[name="selType"]:checked').each(function(){
					selTypes.push($(this).val());
				}); */
				
				if(vueThis.summary.changeTimes==''){
					vueThis.summary.schangeTimes=0;
				}else{
					vueThis.summary.schangeTimes=vueThis.summary.changeTimes;
				}
				if(vueThis.summary.enterTimes==''){
					vueThis.summary.senterTimes=0;
				}else{
					vueThis.summary.senterTimes=vueThis.summary.enterTimes;
				}
				if(vueThis.summary.pfwAmount==''){
					vueThis.summary.spfwAmount=0;
				}else{
					vueThis.summary.spfwAmount=vueThis.summary.pfwAmount;
				}
				if(vueThis.summary.mchangeTimes==''){
					vueThis.summary.smchangeTimes=0;
				}else{
					vueThis.summary.smchangeTimes=vueThis.summary.mchangeTimes;
				}
				if(vueThis.summary.menterTimes==''){
					vueThis.summary.smenterTimes=0;
				}else{
					vueThis.summary.smenterTimes=vueThis.summary.menterTimes;
				}
				if(vueThis.summary.mpfwAmount==''){
					vueThis.summary.smpfwAmount=0;
				}else{
					vueThis.summary.smpfwAmount=vueThis.summary.mpfwAmount;
				}
				if(vueThis.summary.hpfwAmount==''){
					vueThis.summary.shpfwAmount=0;
				}else{
					vueThis.summary.shpfwAmount=vueThis.summary.hpfwAmount;
				}
				$.post("sumflw/GetpfwSmy.action",{"date":vueThis.date,"compDate":week_date,"size":18}, function(data){
					
					
					
					console.log("客流总量:"+data);
					//"ascRate":"2.58","changeTimes":201,"dscRate":"","enterTimes":276.1,"pfwAmount":477.3,
					
					if(data.ascRate!=""){
						vueThis.summary.asshow=true;
						vueThis.summary.dsshow=false;
						vueThis.summary.ascRate=data.ascRate;
						$("#asd").css("color",'red');
					}
					if(data.dscRate!=""){
						vueThis.summary.dsshow=true;
						vueThis.summary.asshow=false;
						vueThis.summary.ascRate=data.dscRate;
						
					}
					
					
					vueThis.summary.changeTimes=data.changeTimes;
					vueThis.summary.enterTimes=data.enterTimes;
					vueThis.summary.pfwAmount=data.pfwAmount;
					vueThis.summary.mchangeTimes=data.mchangeTimes;
					vueThis.summary.menterTimes=data.menterTimes;
					vueThis.summary.mpfwAmount=data.mpfwAmount;
					vueThis.summary.hpfwAmount=data.hpfwAmount;
					
					 vueThis.Numcount();
					
			     
				}); 
		  },
		  
		  //获取当前时间
            getNowFormatnow:function() {
                var vuThis=this;
                var date = new Date();
                //var seperator1 = "-";
                var year = date.getFullYear();
                var month = date.getMonth() + 1;
                var strDate = date.getDate();
                if (month >= 1 && month <= 9) {
                    month = "0" + month;
                }
                if (strDate >= 0 && strDate <= 9) {
                    strDate = "0" + strDate;
                }
                var nowHours= new Date().getHours().toString();       //获取当前小时数(0-23)
               
                if (nowHours >= 0 && nowHours <= 9) {
                    nowHours = "0" + nowHours;
                }
                var nowMins= new Date().getMinutes();     //获取当前分钟数(0-59)
                 var nowHou=Math.floor(nowMins/5);
                var nowMin=(parseInt(nowHou*5)-5).toString();
                if (nowMin >= 0 && nowMin <= 9) {
                    nowMin = "0" + nowMin;
                }
                var currentdate = year + month + strDate+nowHours+nowMin;
                //获取当前时刻
                var now=currentdate+'00';
                console.log("当前时刻"+now);
                vuThis.when=now;
                var nowMina= new Date().getMinutes(); 
                  if (nowMina >= 0 && nowMina <= 9) {
                    nowMina = "0" + nowMina;
                }
                var whens=nowHours+":"+nowMina;
                vuThis.whens=whens;
               console.log("当前准确时刻"+whens);
                var date= year + month + strDate;
                var dates= year +"."+ month +"."+ strDate;
                vuThis.dates=dates;
                 vuThis.date=date;
                   console.log("当前日期"+dates);

              /*   //获取星期
                var a = new Array("日", "一", "二", "三", "四", "五", "六");
                var week = new Date().getDay();
                var str = "星期"+ a[week];
                //alert(str);
                vuThis.day=str;
                console.log(vuThis.now+vuThis.now); */


                return currentdate;
            },
            
             //拥堵指数Top5放大
		  ydjschars:function(){
		  		var vueThis=this;
		  		 var  myChart = echarts.init(document.querySelector('#ydchar'));
		  			vueThis.ydzjcharts=myChart;
		  			var option = {
		  				
				         series: [
				         
				                {
				                 type : "gauge",
				                 center: ["51%", "63%"], // 默认全局居中
				                 radius :'400',
				                 startAngle: 135,
				                 endAngle: 45,
				                 axisLine : {
				                     show : false,
				                     lineStyle : { // 属性lineStyle控制线条样式
				                         color : [ //表盘颜色
				                             [ 0.5, "#EF030B" ],//0-50%处的颜色
				                          
				                             [ 1,"#560D12" ]//90%-100%处的颜色
				                         ],
				                         width : 40//表盘宽度
				                     }
				                 },
				                 splitLine : { //分割线样式（及10、20等长线样式）
				                 show: false,
				                     length : 20,
				                     lineStyle : { // 属性lineStyle控制线条样式
				                         width : 1
				                     }
				                 },
				                 axisTick : { //刻度线样式（及短线样式）
				                 show: false,
				                      length : 6
				                 },
				                 axisLabel : { //文字样式（及“10”、“20”等文字样式）
				                 show: false,
				                 textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
						                    color: '#ffffff'
						                },
				                     
				                     distance : 3 //文字离表盘的距离
				                 },
				                  pointer : { //指针样式
				                		show:true,
				                     length: '60%',
				                       width : 8
               							
				                 }, 
				                 detail: {
				                 show: false,
				                     formatter : "{score|{value}%}",
				                     offsetCenter: [0, "-65%"],
				                     //backgroundColor: '#FFEC45',
				                     height:30,
				                       textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
						                    color: '#2089F2',
						                    fontSize : 30
						                }
				                 },
				                 data: [{
				                     value: 56,
				                     /* label: {
				                         textStyle: {
				                             fontSize: 12
				                         }
				                     } */
				                 }]
				             },
				             {
				                 type: "gauge",
				                 center: ["50%", "103%"], // 仪表位置
				                 radius: "410", //仪表大小
				                 startAngle: 135, //开始角度
				                 endAngle: 45, //结束角度
				                 axisLine: {
				                     show: false,
				                     lineStyle: { // 属性lineStyle控制线条样式
				                         color: [
				                           [ 1,  new echarts.graphic.LinearGradient(0, 0, 1, 0, [{
			                                   offset: 1,
			                                   color: "#E4040C" // 50% 处的颜色
			                               }, {
			                                  offset: 0,
			                                  color: "#3D171D" // 40% 处的颜色
			                              }], false) ]
				                          
				                             ],// 100% 处的颜色
				                              
				                         
				                         width: 26
				                     }
				                 },
				                 splitLine: { 
				                     show: false
				                 },
				                 axisTick: {
				                     show: false
				                 },
				                 axisLabel: {
				                     show: false
				                 },
				                pointer : { //指针样式
				                		show:false
				                     
				                 }, 
				                 detail: {
				                     show: false
				                 }
				             },
				             {
				                 type : "gauge",
				                 center: ["50%", "103%"], // 默认全局居中
				                 radius :'400',
				                 startAngle: 135,
				                 endAngle: 45,
				                 axisLine : {
				                     show : false,
				                     lineStyle : { // 属性lineStyle控制线条样式
				                         color : [ //表盘颜色
				                             [ 0.5, "#EF030B" ],//0-50%处的颜色
				                          
				                             [ 1,"#560D12" ]//90%-100%处的颜色
				                         ],
				                         width : 40//表盘宽度
				                     }
				                 },
				                 splitLine : { //分割线样式（及10、20等长线样式）
				                 
				                     length : 20,
				                     lineStyle : { // 属性lineStyle控制线条样式
				                         width : 1
				                     }
				                 },
				                 axisTick : { //刻度线样式（及短线样式）
				                 
				                      length : 6
				                 },
				                 axisLabel : { //文字样式（及“10”、“20”等文字样式）
				                 show:false,
				                 textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
						                    color: '#ffffff'
						                },
				                     
				                     distance : 4 //文字离表盘的距离
				                 },
				                  pointer : { //指针样式
				                	 show:false,
				                	 length: '0',
				                       width : 0
				                    	
				                 }, 
				                 detail: {
				                     formatter : "{value}%",
				                     offsetCenter: [0, "-65%"],
				                     //backgroundColor: '#FFEC45',
				                     height:30,
				                       textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
						                    color: '#ffffff',
						                    fontSize : 60
						                }
				                 },
				                 data: [{
				                     value: 56,
				                     /* label: {
				                         textStyle: {
				                             fontSize: 12
				                         }
				                     } */
				                 }]
				             }
				         ]
				     };
				     vueThis.ydjsOptions=option;
				     vueThis.ydzjcharts.setOption(vueThis.ydjsOptions);
				     
				     
		  },
		  //拥堵指数Top5
		  ydjschar:function(){
		  		var vueThis=this;
		  		 var  myChart = echarts.init(document.querySelector('#ydjsbar'));
		  			vueThis.ydzjchart=myChart;
		  			var option = {
		  				
				         series: [
				         
				                {
				                 type : "gauge",
				                 center: ["46%", "32%"], // 默认全局居中
				                 radius :'200',
				                 startAngle: 135,
				                 endAngle: 45,
				                 axisLine : {
				                     show : false,
				                     lineStyle : { // 属性lineStyle控制线条样式
				                         color : [ //表盘颜色
				                             [ 0.5, "#EF030B" ],//0-50%处的颜色
				                          
				                             [ 1,"#560D12" ]//90%-100%处的颜色
				                         ],
				                         width : 20//表盘宽度
				                     }
				                 },
				                 splitLine : { //分割线样式（及10、20等长线样式）
				                 show: false,
				                     length : 20,
				                     lineStyle : { // 属性lineStyle控制线条样式
				                         width : 1
				                     }
				                 },
				                 axisTick : { //刻度线样式（及短线样式）
				                 show: false,
				                      length : 6
				                 },
				                 axisLabel : { //文字样式（及“10”、“20”等文字样式）
				                 show: false,
				                 textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
						                    color: '#ffffff'
						                },
				                     
				                     distance : 3 //文字离表盘的距离
				                 },
				                  pointer : { //指针样式
				                		show:true,
				                     length: '60%',
				                       width : 8
               							
				                 }, 
				                 detail: {
				                 show: false,
				                     formatter : "{score|{value}%}",
				                     offsetCenter: [0, "-65%"],
				                     //backgroundColor: '#FFEC45',
				                     height:30,
				                       textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
						                    color: '#2089F2',
						                    fontSize : 30
						                }
				                 },
				                 data: [{
				                     value: 56,
				                     /* label: {
				                         textStyle: {
				                             fontSize: 12
				                         }
				                     } */
				                 }]
				             },
				             {
				                 type: "gauge",
				                 center: ["45%", "53%"], // 仪表位置
				                 radius: "210", //仪表大小
				                 startAngle: 135, //开始角度
				                 endAngle: 45, //结束角度
				                 axisLine: {
				                     show: false,
				                     lineStyle: { // 属性lineStyle控制线条样式
				                         color: [
				                           [ 1,  new echarts.graphic.LinearGradient(0, 0, 1, 0, [{
			                                   offset: 1,
			                                   color: "#E4040C" // 50% 处的颜色
			                               }, {
			                                  offset: 0,
			                                  color: "#3D171D" // 40% 处的颜色
			                              }], false) ]
				                          
				                             ],// 100% 处的颜色
				                              
				                         
				                         width: 10
				                     }
				                 },
				                 splitLine: { 
				                     show: false
				                 },
				                 axisTick: {
				                     show: false
				                 },
				                 axisLabel: {
				                     show: false
				                 },
				                pointer : { //指针样式
				                		show:false
				                     
				                 }, 
				                 detail: {
				                     show: false
				                 }
				             },
				             {
				                 type : "gauge",
				                 center: ["45%", "53%"], // 默认全局居中
				                 radius :'200',
				                 startAngle: 135,
				                 endAngle: 45,
				                 axisLine : {
				                     show : false,
				                     lineStyle : { // 属性lineStyle控制线条样式
				                         color : [ //表盘颜色
				                             [ 0.5, "#EF030B" ],//0-50%处的颜色
				                          
				                             [ 1,"#560D12" ]//90%-100%处的颜色
				                         ],
				                         width : 20//表盘宽度
				                     }
				                 },
				                 splitLine : { //分割线样式（及10、20等长线样式）
				                 
				                     length : 20,
				                     lineStyle : { // 属性lineStyle控制线条样式
				                         width : 1
				                     }
				                 },
				                 axisTick : { //刻度线样式（及短线样式）
				                 
				                      length : 6
				                 },
				                 axisLabel : { //文字样式（及“10”、“20”等文字样式）
				                 show:false,
				                 textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
						                    color: '#ffffff'
						                },
				                     
				                     distance : 4 //文字离表盘的距离
				                 },
				                  pointer : { //指针样式
				                	 show:false,
				                	 length: '0',
				                       width : 0
				                    	
				                 }, 
				                 detail: {
				                     formatter : "{value}%",
				                     offsetCenter: [0, "-65%"],
				                     //backgroundColor: '#FFEC45',
				                     height:30,
				                       textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
						                    color: '#ffffff',
						                    fontSize : 35
						                }
				                 },
				                 data: [{
				                     value: 56,
				                     /* label: {
				                         textStyle: {
				                             fontSize: 12
				                         }
				                     } */
				                 }]
				             }
				         ]
				     };
				     vueThis.ydjsOption=option;
				     vueThis.ydzjchart.setOption(vueThis.ydjsOption);
				     
				     
		  },
		  //车站客流柱状图表初始化放大
		  chzchartbars:function(){
		  var vueThis=this;
		  var  myChart = echarts.init(document.querySelector('#czklchar'));
		  vueThis.chzchart=myChart;
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
					x: 90,
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
                                    fontSize :'14'
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
                                    fontSize :'14'
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
	
			vueThis.chzchartOption=optionAll;
		  },
		  
		  //车站客流柱状图表初始化
		  chzchartbar:function(){
		  var vueThis=this;
		  var  myChart = echarts.init(document.querySelector('#chzklpmbar'));
		  vueThis.chzchart=myChart;
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
					x: 90,
					x2:40,
					y: 5,
					y2:30
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
                                    fontSize :'12'
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
                                    fontSize :'10'
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
			            barWidth:13,
			            data:[]
			        }
			       
			    ]
			};
	
			vueThis.chzchartOption=optionAll;
		  },
		  //获取车站客流图表数据  
		  getChzchart:function(){
		  		var vueThis=this;
		  		 var selTypes=[1,3];
				/*$('input[name="selType"]:checked').each(function(){
					selTypes.push($(this).val());
				}); */
				
				
				 
				$.post("sheete/get_all_passe.action",{"id":0,"type":0,"date":vueThis.date,"startTime":vueThis.when,"size":8,"selType":selTypes}, function(data){
						
						vueThis.czklData=data;
					var data_name = [];
					var data_val = [];
					for (var i=data.length-1;i>=0;i--){
						data_name.push(data[i]['STATION_NM_CN']);
						data_val.push(data[i]['IN_PASS_NUM']);
					}
					vueThis.chzLine=data_name;
					vueThis.chzchartOption.yAxis[0].data = data_name;
					vueThis.chzchartOption.series[0].data = data_val;
					vueThis.chzchart.setOption(vueThis.chzchartOption);
					//vueThis.getJams();
			
				}); 
		  		
		  },
		  
		  //获取分时客流图表的数据
		  getFspafl:function(){
		  		var vueThis=this;
		      /* private String fir_date;//历史日期1
    			String sec_date;//历史日期2 */
    			
    			var fir_date="<%=fir_date%>";
    			var sec_date="<%=sec_date%>";
		  
		  	 /*  doAjax({url:"pasflw/getime_paflw.action",data:{"fir_date":fir_date,"sec_date":sec_date},successCallback:function(data){
	        	  	  if(data&&data.root=="success"){
						 console.log(data);
					  }
				  }}); */
				  
				  $.post("pasflw/getime_paflw.action",{"fir_date":fir_date,"sec_date":sec_date},function(data){
					  
					 console.log(data);
					 vueThis.fsklData=data;
					vueThis.fsklchar('fskla','fsklb');
				  });
		  },
		  
		  		//分时客流图表
		  		
		  		fsklchar: function (elema,elemb) {
		  		
		  		var cda=this.fsklData;
		  		
                var myChart = echarts.init(document.getElementById(elema)); 
              
		    var predict_time=cda.predict_time;
    	var time_period=cda.time_period;
    	var fir_times=cda.fir_times;
    	var sec_times=cda.sec_times;
    	var today_times=cda.today_times;
    	var fir_fen_times=cda.fir_fen_times;
    	var sec_fen_times=cda.sec_fen_times;
    	var fen_times=cda.fen_times;
    	var pre_times=cda.pre_times;
    	var dates=cda.dates;
    	var total_times=cda.total_times;
    	
    	for(var i=0;i<fen_times.length;i++){
    		if(fen_times[i]<=-50){
    			fen_times[i]={
						        value :fen_times[i],
						        itemStyle:{normal: {color:'red'}}
						    }
    		}
    	}
    	
    	for(var i=0;i<today_times.length;i++){pre_times[i]=today_times[i];}
                var time_period_tp=[];
				for(var i=0;i<time_period.length;i++){
					if(time_period[i].toString().indexOf("30")>-1){
						time_period_tp.push({
					        value:time_period[i],            
					        textStyle:{fontSize:6,color: 'rgba(32,32,35,0)'}
					     });
					}else{
						time_period_tp.push(time_period[i]);
					}
				}
				
				var dates1=dates[0].substring(0,4)+"/"+dates[0].substring(4,6)+"/"+dates[0].substring(6)+"("+total_times[dates[0]]+"万"+")";
				var dates2=dates[1].substring(0,4)+"/"+dates[1].substring(4,6)+"/"+dates[1].substring(6)+"("+total_times[dates[1]]+"万"+")";
				var dates3=dates[2].substring(0,4)+"/"+dates[2].substring(4,6)+"/"+dates[2].substring(6)+"("+today_times[today_times.length-1]+"万"+")";
				
				legdates=[
						dates1,dates2,dates3
						/* dates[0].substring(0,4)+"/"+dates[0].substring(4,6)+"/"+dates[0].substring(6)+"("+total_times[dates[0]]+")",
						dates[1].substring(0,4)+"/"+dates[1].substring(4,6)+"/"+dates[1].substring(6)+"("+total_times[dates[1]]+")", */
						//dates[2].substring(0,4)+"/"+dates[2].substring(4,6)+"/"+dates[2].substring(6)+"("+today_times[today_times.length-1]+")"
					  ];
				
				var x_s="center";
				if(predict_time){
					x_s="50";
					
					dates[2]=dates[2]+"  "+predict_time+"点预测("+pre_times[pre_times.length-1]+")";
					//dates[2]=dates[2]+"  12点预测(1023.1)";
				}
                	option = {
                		  title : {
				        text:'全日分时客流累积（万人次）',
				        x:'left',
		        		   
				        textStyle:{fontSize:8,fontWeight:'bold',color:'#FFFFFF'}
				    }, 
				    tooltip : {
				        trigger: 'axis',
				        textStyle: {fontWeight:'bold',fontSize:16,color:'orange'},
				        formatter:function (params){
							if(params.length==2){
				        		
				        		var tpstr=(params[0].name.toString().indexOf("30")>-1?params[0].name:params[0].name+":00")
						    +"<br/>"+params[0].seriesName.substring(0,10)+" "+params[0].value+"万<br/>"
							+params[1].seriesName.substring(0,10)+" "+params[1].value+"万<br/>"
							//params[2].seriesName.substring(0,10)+" "+params[2].value+"万";
				        	}
				        	
				        	else if(params.length==3){
				        		
				        		var tpstr=(params[0].name.toString().indexOf("30")>-1?params[0].name:params[0].name+":00")
						    +"<br/>"+params[0].seriesName.substring(0,10)+" "+(params[0].value)+"万<br/>"
							+params[1].seriesName.substring(0,10)+" "+params[1].value+"万<br/>"
							+params[2].seriesName.substring(0,10)+" "+params[2].value+"万";
				        	}
				      else if(params.length==4){
				      
							var tpstr=(params[0].name.toString().indexOf("30")>-1?params[0].name:params[0].name+":00")
							
						    +"<br/>"+params[0].seriesName.substring(0,10)+" "+(params[0].value)+"万<br/>"
							+params[2].seriesName.substring(0,10)+" "+params[2].value+"万<br/>"
							+params[3].seriesName.substring(0,10)+" "+params[3].value+"万";
							}
							return tpstr;
				        }
				    },
				    legend: {
					show:true,
				    	x:"120",
				    	y:'top',
					     itemGap:3,
				    	itemWidth:20,
						itemHeight:10,
				    	textStyle: {fontWeight:'bold',fontSize:8,color:'#FFFFFF'},
				        data:legdates
				    },
				   /*  legend: {
						
				    	
				    	orient: 'horizontal',
				    	x:'center',
				    	 y:'20', 
				    	icon: 'rect',
						itemGap:2,
				    	itemWidth:20,
						itemHeight:10,
				    	textStyle: {fontWeight:'bold',fontSize:10,color:'#FFFFFF'},
				        data:legdates
				    }, */
				    //calculable : true,
				     grid:{y2:25,x:45,y:30,x2:5},
				    xAxis : [
				        {
				            type : 'category',
				            axisLine: {

                                lineStyle: {

                                    type: 'solid',

                                    color:'#fff',

                                    width:'1'

                                }

                            },
				            axisLabel:{interval:0,rotate:-30,textStyle: {fontWeight:'bold',fontSize:10,color:'#FFFFFF'}},
				            scale:true,
				            boundaryGap: true,
				            data : time_period_tp
				        }
				    ],
				    yAxis : [
				        {
				            type : 'value',
                           /*  name: '单位：万人次',
                            nameTextStyle: {
                                color: '#fff',
                                fontSize :'8'
                            }, */
				            min: 0,
                            max: 1500,


                            interval: 300,
				             splitLine:{
                                show: true,
                                lineStyle: {

                                    type: 'dashed',

                                    color:'#008769',

                                    width:'0.5'

                                }
                                },
				            axisLabel:{formatter:'{value}万',textStyle: {fontWeight:'bold',fontSize:9,color:'#FFFFFF'}}
				        }
				    ],
				    series : [
				        {
				            name:dates3,
				            type:'line',
				            symbolSize:function(param){if(param){return 2;}return 0;},
				            itemStyle:{normal: {color:'red',lineStyle: {width: 3}}},
				            data:today_times
				        },
				        {
				            name:'预测',
				            type:'line',
				            symbolSize:function(param){if(param){return 4;}return 0;},
				            itemStyle:{
				            	normal: {color:'red',lineStyle:{width: 2,type: 'dashed'}},
				            	emphasis:{color:'red',lineStyle:{width: 1,type: 'dashed'}}
				            },
				            data:pre_times
				        },
				        {
				            name:dates1,
				            type:'line',
				            symbolSize:function(param){if(param){return 2;}return 0;},
				            itemStyle:{normal: {color:'yellow',lineStyle: {width: 3}}},
				            data:fir_times
				        },
				    	{
				            name:dates2,
				            type:'line',
				            symbolSize:function(param){if(param){return 2;}return 0;},
				            itemStyle:{normal: {color:'blue',lineStyle: {width: 3}}},
				            data:sec_times
				        }
				    ]
				};
                
				myChart.setOption(option);
				
				
				option1 = {
                				 /*   title : {
				        text:'全日分时客流(万人次)',
				        x:'center',
				        y:'bottom',
		        		        textStyle:{fontSize:8,fontWeight:'bold',color:'#FFFFFF'}
				    },  */
				   /*  legend: {
					show:false,
				    	selectedMode:false,
				    	x:x_s,
				    	y:'310',
					itemGap:100,
				    	itemWidth:80,
						itemHeight:40,
				    	textStyle: {fontWeight:'bold',fontSize:40,color:'#FFFFFF'},
				        data:dates
				    }, */
				    tooltip : {
				        show:false,
				        trigger: 'axis',
				        textStyle: {fontWeight:'bold',fontSize:80,color:'#000000'},
				        formatter:function (params){
				        	var tpstr=(params[0].name.toString().indexOf("30")>-1?params[0].name:params[0].name+":00")
				        	+"<br/>"+params[0].seriesName.substring(0,10)+":"+(params[0].value=="-"?"-":-params[0].value)+"万<br/>"
							+params[1].seriesName.substring(0,10)+":"+(-params[1].value)+"万<br/>"
							+params[2].seriesName.substring(0,10)+":"+(-params[2].value)+"万";
							return tpstr;
				        }
				    },
				   // calculable : true,
				    grid:{y2:14,x:45,y:4,x2:5},
				    
				   xAxis: [
                        {
                            type: 'category',
                            //offset:10,
                            axisLine: {
                            	//show:false,
                                lineStyle: {
                                    type: 'solid',
                                    color:'#fff',
                                    width:'1'
                                }

                            },
                            //去掉刻度线
                            axisTick: {
                                show: true,
                                interval:0,
                                //alignWithLabel: true
                            },
                            //axisLabel:{interval:0,rotate:-30,textStyle: {fontWeight:'bold',fontSize:10,color:'#FFFFFF'}},
                            axisLabel: {
                            show: false,
                               interval:0,
                               margin:2,
                               inside:false,
                                //rotate:-30,
                                textStyle: {
                                    color: '#fff',
                                    fontSize :9
                                }
                            },
                            scale:true,
                            boundaryGap: true,
                            data: time_period_tp

                        }

                    ], 
				    	
				     /* xAxis : [
				        {
				            type : 'category',
				            
				            //去掉刻度线
                            axisTick: {
                                show: true,
                                alignWithLabel: true
                            },
				
				           //                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 axisLabel:{interval:0,textStyle: {fontWeight:'bold',fontSize:9,color:'#FFFFFF'}},
				            //scale:true,
				            boundaryGap: true,
				            data : time_period_tp
				        }
				    ],  */
				    yAxis : [
				        {
				            type : 'value',
				            splitLine:{
                                show: true,
                                lineStyle: {
                                    type: 'dashed',
                                    color:'#008769',
                                    width:'0.5'
                                }
                                },
				            axisLabel:{
				        		textStyle: {fontWeight:'bold',fontSize:9,color:'#FFFFFF'},
				        		formatter: function(v){
									        return v==0?"":-v+"万";
						                }
				        	}
				        }
				    ],
				    series : [
				        {
				            name:dates[2],
				            type:'bar',
				            itemStyle:{normal: {color:'yellow'}},
				            barWidth: 10,
				            data:fen_times
				        }
				    ]
				};
				
				console.log(time_period_tp);
				var myChart1 = echarts.init(document.getElementById(elemb)); 
				myChart1.setOption(option1);
            },
            
            //分时客流图表放大
		  		
		  		fsklchars: function (elema,elemb) {
		  		
		  		var cda=this.fsklData;
		  		
                var myChart = echarts.init(document.getElementById(elema)); 
              
		    var predict_time=cda.predict_time;
    	var time_period=cda.time_period;
    	var fir_times=cda.fir_times;
    	var sec_times=cda.sec_times;
    	var today_times=cda.today_times;
    	var fir_fen_times=cda.fir_fen_times;
    	var sec_fen_times=cda.sec_fen_times;
    	var fen_times=cda.fen_times;
    	var pre_times=cda.pre_times;
    	var dates=cda.dates;
    	var total_times=cda.total_times;
    	
    	for(var i=0;i<fen_times.length;i++){
    		if(fen_times[i]<=-50){
    			fen_times[i]={
						        value :fen_times[i],
						        itemStyle:{normal: {color:'red'}}
						    }
    		}
    	}
    	
    	for(var i=0;i<today_times.length;i++){pre_times[i]=today_times[i];}
                var time_period_tp=[];
				for(var i=0;i<time_period.length;i++){
					if(time_period[i].toString().indexOf("30")>-1){
						time_period_tp.push({
					        value:time_period[i],            
					        textStyle:{fontSize:14,color: 'rgba(32,32,35,0)'}
					     });
					}else{
						time_period_tp.push(time_period[i]);
					}
				}
				
				var dates1=dates[0].substring(0,4)+"/"+dates[0].substring(4,6)+"/"+dates[0].substring(6)+"("+total_times[dates[0]]+"万"+")";
				var dates2=dates[1].substring(0,4)+"/"+dates[1].substring(4,6)+"/"+dates[1].substring(6)+"("+total_times[dates[1]]+"万"+")";
				var dates3=dates[2].substring(0,4)+"/"+dates[2].substring(4,6)+"/"+dates[2].substring(6)+"("+today_times[today_times.length-1]+"万"+")";
				
				legdates=[
						dates1,dates2,dates3
						/* dates[0].substring(0,4)+"/"+dates[0].substring(4,6)+"/"+dates[0].substring(6)+"("+total_times[dates[0]]+")",
						dates[1].substring(0,4)+"/"+dates[1].substring(4,6)+"/"+dates[1].substring(6)+"("+total_times[dates[1]]+")", */
						//dates[2].substring(0,4)+"/"+dates[2].substring(4,6)+"/"+dates[2].substring(6)+"("+today_times[today_times.length-1]+")"
					  ];
				
				var x_s="center";
				if(predict_time){
					x_s="50";
					
					//dates[2]=dates[2]+"  "+predict_time+"点预测("+pre_times[pre_times.length-1]+"万)";
					//dates[2]=dates[2]+"  12点预测(1023.1)";
				}
                	option = {
                		  title : {
				        text:'全日分时客流累积（万人次）',
				        x:'left',
		        		   
				        textStyle:{fontSize:12,fontWeight:'bold',color:'#FFFFFF'}
				    }, 
				    tooltip : {
				        trigger: 'axis',
				        textStyle: {fontWeight:'bold',fontSize:16,color:'orange'},
				        formatter:function (params){
							if(params.length==2){
				        		
				        		var tpstr=(params[0].name.toString().indexOf("30")>-1?params[0].name:params[0].name+":00")
						    +"<br/>"+params[0].seriesName.substring(0,10)+" "+params[0].value+"万<br/>"
							+params[1].seriesName.substring(0,10)+" "+params[1].value+"万<br/>"
							//params[2].seriesName.substring(0,10)+" "+params[2].value+"万";
				        	}
				        	
				        	else if(params.length==3){
				        		
				        		var tpstr=(params[0].name.toString().indexOf("30")>-1?params[0].name:params[0].name+":00")
						    +"<br/>"+params[0].seriesName.substring(0,10)+" "+(params[0].value)+"万<br/>"
							+params[1].seriesName.substring(0,10)+" "+params[1].value+"万<br/>"
							+params[2].seriesName.substring(0,10)+" "+params[2].value+"万";
				        	}
				      else if(params.length==4){
				      
							var tpstr=(params[0].name.toString().indexOf("30")>-1?params[0].name:params[0].name+":00")
							
						    +"<br/>"+params[0].seriesName.substring(0,10)+" "+(params[0].value)+"万<br/>"
							+params[2].seriesName.substring(0,10)+" "+params[2].value+"万<br/>"
							+params[3].seriesName.substring(0,10)+" "+params[3].value+"万";
							}
							return tpstr;
				        }
				    },
				    legend: {
					show:true,
				    	x:"center",
				    	y:'top',
					     itemGap:3,
				    	itemWidth:20,
						itemHeight:10,
				    	textStyle: {fontWeight:'bold',fontSize:14,color:'#FFFFFF'},
				        data:legdates
				    },
				   /*  legend: {
						
				    	
				    	orient: 'horizontal',
				    	x:'center',
				    	 y:'20', 
				    	icon: 'rect',
						itemGap:2,
				    	itemWidth:20,
						itemHeight:10,
				    	textStyle: {fontWeight:'bold',fontSize:10,color:'#FFFFFF'},
				        data:legdates
				    }, */
				    //calculable : true,
				     grid:{y2:25,x:55,y:30,x2:65},
				    xAxis : [
				        {
				            type : 'category',
				            axisLine: {

                                lineStyle: {

                                    type: 'solid',

                                    color:'#fff',

                                    width:'1'

                                }

                            },
				            axisLabel:{interval:0,rotate:-30,textStyle: {fontWeight:'bold',fontSize:13,color:'#FFFFFF'}},
				            scale:true,
				            boundaryGap: true,
				            data : time_period_tp
				        }
				    ],
				    yAxis : [
				        {
				            type : 'value',
                           /*  name: '单位：万人次',
                            nameTextStyle: {
                                color: '#fff',
                                fontSize :'8'
                            }, */
				            min: 0,
                            max: 1500,


                            interval: 300,
				             splitLine:{
                                show: true,
                                lineStyle: {

                                    type: 'dashed',

                                    color:'#008769',

                                    width:'0.5'

                                }
                                },
				            axisLabel:{formatter:'{value}万',textStyle: {fontWeight:'bold',fontSize:12,color:'#FFFFFF'}}
				        }
				    ],
				    series : [
				        {
				            name:dates3,
				            type:'line',
				            symbolSize:function(param){if(param){return 2;}return 0;},
				            itemStyle:{normal: {color:'red',lineStyle: {width: 3}}},
				            data:today_times
				        },
				        {
				            name:'预测',
				            type:'line',
				            symbolSize:function(param){if(param){return 4;}return 0;},
				            itemStyle:{
				            	normal: {color:'red',lineStyle:{width: 2,type: 'dashed'}},
				            	emphasis:{color:'red',lineStyle:{width: 1,type: 'dashed'}}
				            },
				            data:pre_times
				        },
				        {
				            name:dates1,
				            type:'line',
				            symbolSize:function(param){if(param){return 2;}return 0;},
				            itemStyle:{normal: {color:'yellow',lineStyle: {width: 3}}},
				            data:fir_times
				        },
				    	{
				            name:dates2,
				            type:'line',
				            symbolSize:function(param){if(param){return 2;}return 0;},
				            itemStyle:{normal: {color:'blue',lineStyle: {width: 3}}},
				            data:sec_times
				        }
				    ]
				};
                
				myChart.setOption(option);
				
				
				option1 = {
                				 /*   title : {
				        text:'全日分时客流(万人次)',
				        x:'center',
				        y:'bottom',
		        		        textStyle:{fontSize:8,fontWeight:'bold',color:'#FFFFFF'}
				    },  */
				   /*  legend: {
					show:false,
				    	selectedMode:false,
				    	x:x_s,
				    	y:'310',
					itemGap:100,
				    	itemWidth:80,
						itemHeight:40,
				    	textStyle: {fontWeight:'bold',fontSize:40,color:'#FFFFFF'},
				        data:dates
				    }, */
				    tooltip : {
				        show:false,
				        trigger: 'axis',
				        textStyle: {fontWeight:'bold',fontSize:80,color:'#000000'},
				        formatter:function (params){
				        	var tpstr=(params[0].name.toString().indexOf("30")>-1?params[0].name:params[0].name+":00")
				        	+"<br/>"+params[0].seriesName.substring(0,10)+":"+(params[0].value=="-"?"-":-params[0].value)+"万<br/>"
							+params[1].seriesName.substring(0,10)+":"+(-params[1].value)+"万<br/>"
							+params[2].seriesName.substring(0,10)+":"+(-params[2].value)+"万";
							return tpstr;
				        }
				    },
				   // calculable : true,
				    grid:{y2:14,x:55,y:35,x2:65},
				    
				   xAxis: [
                        {
                            type: 'category',
                            //offset:10,
                            axisLine: {
                            	//show:false,
                                lineStyle: {
                                    type: 'solid',
                                    color:'#fff',
                                    width:'1'
                                }

                            },
                            //去掉刻度线
                            axisTick: {
                                show: true,
                                interval:0,
                                //alignWithLabel: true
                            },
                            //axisLabel:{interval:0,rotate:-30,textStyle: {fontWeight:'bold',fontSize:10,color:'#FFFFFF'}},
                            axisLabel: {
                            show: false,
                               interval:0,
                               margin:2,
                               inside:false,
                                //rotate:-30,
                                textStyle: {
                                    color: '#fff',
                                    fontSize :9
                                }
                            },
                            scale:true,
                            boundaryGap: true,
                            data: time_period_tp

                        }

                    ], 
				    	
				     /* xAxis : [
				        {
				            type : 'category',
				            
				            //去掉刻度线
                            axisTick: {
                                show: true,
                                alignWithLabel: true
                            },
				
				           //                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 axisLabel:{interval:0,textStyle: {fontWeight:'bold',fontSize:9,color:'#FFFFFF'}},
				            //scale:true,
				            boundaryGap: true,
				            data : time_period_tp
				        }
				    ],  */
				    yAxis : [
				        {
				            type : 'value',
				            splitLine:{
                                show: true,
                                lineStyle: {
                                    type: 'dashed',
                                    color:'#008769',
                                    width:'0.5'
                                }
                                },
				            axisLabel:{
				        		textStyle: {fontWeight:'bold',fontSize:13,color:'#FFFFFF'},
				        		formatter: function(v){
									        return v==0?"":-v+"万";
						                }
				        	}
				        }
				    ],
				    series : [
				        {
				            name:dates[2],
				            type:'bar',
				            itemStyle:{normal: {color:'yellow'}},
				            barWidth: 22,
				            data:fen_times
				        }
				    ]
				};
				
				console.log(time_period_tp);
				var myChart1 = echarts.init(document.getElementById(elemb)); 
				myChart1.setOption(option1);
            },
            
            //获取区域客流数据
            
            
            getDiscpfw:function(){
            var vueThis=this;
            var week_date="<%=week_date%>";
            
            var colors=['#ff7f50', '#87cefa', '#da70d6', '#32cd32', '#6495ed','#ff69b4', '#ba55d3', '#cd5c5c', '#ffa500', '#40e0d0','#1e90ff', '#ff6347', '#7b68ee', '#00fa9a', '#ffd700','#6b8e23', '#ff00ff', '#3cb371', '#b8860b', '#30e0e0'];
             var selTypes=[3];
				/*$('input[name="selType"]:checked').each(function(){
					selTypes.push($(this).val());
				}); */
				
					$.post("sheete/get_all_passe.action",{"id":0,"type":0,"date":vueThis.date,"size":10,"selType":selTypes}, function(data){
            		//$.post("distrc/GetDstpflw.action",{"date":vueThis.date,"size":20,"selType":selTypes}, function(data){
            		
            		vueThis.qyklData=data;
					var data_name = [];
					var item = {};
					
					 for (var i=0;i<=data.length-1;i++){
					       item=new Object();
					       item.name=data[i]['STATION_NM_CN'];
					       item.value=data[i]['IN_PASS_NUM'];
					       
						data_name.push(item);
					}
					
		
						
					
					vueThis.dispfwOption.series[0].data = data_name;
				
					vueThis.dispfwchar.setOption(vueThis.dispfwOption); 
	
			     
				}); 
            },
		  		// 区域客流排名
		  		xzqklchar:function(){
		  		 var vueThis=this;
		  		 var i=0; 
		  		  var colors=['#ff7f50', '#87cefa', '#da70d6', '#32cd32', '#6495ed','#ff69b4', '#ba55d3', '#cd5c5c', '#ffa500', '#40e0d0','#1e90ff', '#ff6347', '#7b68ee', '#00fa9a', '#ffd700','#6b8e23', '#ff00ff', '#3cb371', '#b8860b', '#30e0e0'];
		  		 
		  			//初始化echarts图表
                var myChart;
                myChart = echarts.init(document.querySelector('#xzqklpie'));
				vueThis.dispfwchar=myChart;
               
                	option = {
					   
				
					    tooltip : {
					        trigger: 'item',
					        formatter: "{a} <br/>{b} : {c}"+"万"+" ({d}%)"
					    },
					
					    
					     grid:{y2:17,x:45,y:0,x2:10},
					    series : [
					        {
					            name:'区域客流',
					            type:'pie',
					            radius : '70%',
					            center: ['47%', '50%'],
					            data:[],					            
					            roseType: 'radius',
					            label: {
					               normal: {
										show: true,
										textStyle: {
											color:'#ffffff',
											fontWeight: 300,
											fontSize: 10 //文字的字体大小
										},
										formatter: '{b}{c}'+'万'+'({d}%)',
										position:'outer'
					                }
					            },
					            labelLine: {
					                normal: {
					                    lineStyle: {
					                        color: 'rgba(255, 255, 255, 0.3)'
					                    },
					                    smooth: 0.2,
					                    length: 10,
					                    length2: 15
					                }
					            },
					             itemStyle: {
					                 normal: {//颜色渐变#278BB0
					                        color: function(params){  
					                        //自定义颜色

                                    var colorList = [           

                                          '#ff7f50', '#87cefa', '#da70d6', '#32cd32', '#6495ed','#ff69b4', '#ba55d3', '#cd5c5c', '#ffa500', '#40e0d0','#1e90ff', '#ff6347', '#7b68ee', '#00fa9a', '#ffd700','#6b8e23'


                                        ];

                                        return colorList[params.dataIndex]; 
					                       }  
					                   
					                    } 
					            },  
					
					            animationType: 'scale',
					            animationEasing: 'elasticOut',
					            animationDelay: function (idx) {
					                return Math.random() * 200;
					            }
					        }
					    ]
					};
                	
                	vueThis.dispfwOption=option;
             
		  		},
		      // 区域客流排名放大
		  		xzqklchars:function(){
		  		 var vueThis=this;
		  		 var i=0; 
		  		  var colors=['#ff7f50', '#87cefa', '#da70d6', '#32cd32', '#6495ed','#ff69b4', '#ba55d3', '#cd5c5c', '#ffa500', '#40e0d0','#1e90ff', '#ff6347', '#7b68ee', '#00fa9a', '#ffd700','#6b8e23', '#ff00ff', '#3cb371', '#b8860b', '#30e0e0'];
		  		 
		  			//初始化echarts图表
                var myChart;
                myChart = echarts.init(document.querySelector('#qyklchar'));
				vueThis.dispfwchar=myChart;
               
                	option = {
					   
				
					    tooltip : {
					        trigger: 'item',
					        formatter: "{a} <br/>{b} : {c}"+"万"+" ({d}%)"
					    },
					
					    
					     grid:{y2:17,x:45,y:10,x2:10},
					    series : [
					        {
					            name:'区域客流',
					            type:'pie',
					            radius : '60%',
					            center: ['47%', '50%'],
					            data:[],					            
					            roseType: 'radius',
					            label: {
					               normal: {
										show: true,
										textStyle: {
											color:'#ffffff',
											fontWeight: 300,
											fontSize: 16 //文字的字体大小
										},
										formatter: '{b}{c}'+'万'+'({d}%)',
										position:'outer'
					                }
					            },
					            labelLine: {
					                normal: {
					                    lineStyle: {
					                        color: 'rgba(255, 255, 255, 0.3)'
					                    },
					                    smooth: 0.2,
					                    length: 10,
					                    length2: 15
					                }
					            },
					             itemStyle: {
					                 normal: {//颜色渐变#278BB0
					                        color: function(params){  
					                        //自定义颜色

                                    var colorList = [           

                                          '#ff7f50', '#87cefa', '#da70d6', '#32cd32', '#6495ed','#ff69b4', '#ba55d3', '#cd5c5c', '#ffa500', '#40e0d0','#1e90ff', '#ff6347', '#7b68ee', '#00fa9a', '#ffd700','#6b8e23'


                                        ];

                                        return colorList[params.dataIndex]; 
					                       }  
					                   
					                    } 
					            },  
					
					            animationType: 'scale',
					            animationEasing: 'elasticOut',
					            animationDelay: function (idx) {
					                return Math.random() * 200;
					            }
					        }
					    ]
					};
                	
                	vueThis.dispfwOption=option;
             
		  		},
		        //获取线路客流图表数据  
		  getXlpfwchart:function(){
		  		var vueThis=this;
		
		  		var week_date="<%=week_date%>";
		  		 var selTypes=[1,3];
				/*$('input[name="selType"]:checked').each(function(){
					selTypes.push($(this).val());
				}); */
				
				
				 
				$.post("lflw/GetLineFlwRank.action",{"date":vueThis.date,"compDate":week_date,"size":19,"selType":selTypes}, function(data){
				
					vueThis.xlklData=data;
					var data_name = [];
					var data_val = [];
					var data1_val = [];
					
					
					console.log("线路客流:"+data);
					 for (var i=0;i<=data.todayData.length-1;i++){
						data_name.push(data.todayData[i]['LINE_NM_CN'].substring(4));
						data_val.push(data.todayData[i]['IN_PASS_NUM']);
					}
					
					for (var i=0;i<=data.compData.length-1;i++){
						//data_name.push(data[i]['LINE_NM_CN'].substring(4));
						data1_val.push(data.compData[i]['IN_PASS_NUM']);
					}
						console.log(data_name);
						
						 var weekdate="<%=week_date%>";
		                 var s1='当前客流('+vueThis.date+')';
		                 var s2='对比客流('+weekdate+')';
		                 var sers = [];
		                 sers.push(s1);
		                 sers.push(s2);
		                 vueThis.xlpmsers=sers;
		                
		                vueThis.xlklpmchar('#xlklpmbar');
					vueThis.xlpfwOption.xAxis[0].data = data_name;
					vueThis.xlpfwOption.series[0].data = data_val;
					vueThis.xlpfwOption.series[1].data = data1_val;
					
					vueThis.xlpfwpmchar.setOption(vueThis.xlpfwOption);
	
			     
				}); 
		  		
		  },
		      
		      //线路客流排名图表
		      
		      
            xlklpmchar: function(csgjda){
            
                 var vueThis=this;
                
                //初始化echarts图表
                var myChart;
                myChart = echarts.init(document.querySelector(csgjda));
                vueThis.xlpfwpmchar=myChart;
                option = {
	                    /* title : {
	                        text: '运营车辆比例',
	                        x:'left',
	                        textStyle:{
	                            color :'#ffffff',
	
	                            fontFamily :'sans-serif',
	                            fontSize :'13'
	                        }
	
	                    }, */

                        tooltip : {
                            //enterable:true,
                            trigger: 'axis',
                            axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                                type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                            },
                            formatter:function(params)//数据格式
                            {
                                var relVal = params[0].name+"<br/>";
                                relVal += params[0].seriesName+ ' : ' + params[0].value+"万"+"<br/>";
                              
                                relVal += params[1].seriesName+ ' : ' + params[1].value+"万";
                                return relVal;
                            }
                        },


                    legend: {
                        orient: 'horizontal',
                        x: '155',
                        y:'0',
                        icon: 'rect',
                        itemWidth: 20,
                        itemHeight: 10,
                        itemGap: 3,
                        data:vueThis.xlpmsers,
                        textStyle:{
                            color :'#ffffff',
                            fontFamily :'sans-serif',
                            fontSize :'11'
                        }


                    },

                    xAxis: [

                        {

                            type: 'category',
                            //offset:10,

                            axisLine: {

                                lineStyle: {


                                    type: 'solid',

                                    color:'#01A47E',

                                    width:'2'

                                }

                            },
                            //去掉刻度线
                            axisTick: {
                                show: false,
                                alignWithLabel: true
                            },
                            axisLabel: {
                               interval:0,
                                rotate:-30,
                                textStyle: {
                                    color: '#fff',
                                    fontSize :'9'
                                }

                            },
                            scale:true,
                            boundaryGap: true,
                            data: []

                        }

                    ],

                    yAxis: [

                        {

                            type: 'value',

                            name: '单位：万',
                            nameTextStyle: {
                                color: '#fff',
                                fontSize :'9'
                            },
                            min: 0,

                            max: 150,


                            interval: 30,
                             axisLine: {

                                lineStyle: {


                                    type: 'solid',

                                    color:'#01A47E',

                                    width:'2'

                                }

                            },
                            splitLine:{
                                show: true,
                                lineStyle: {

                                    type: 'dashed',

                                    color:'#008769',

                                    width:'0.5'

                                }

                            },//去除网格线
                            
                            axisLabel: {

                                formatter: '{value}',
                                textStyle: {
                                    color: '#fff',
                                    fontSize :'9'
                                }

                            }

                        }

                    ],

                    series: [
                    	

                        {

                            name:vueThis.xlpmsers[0],

                            type:'bar',


                            /*设置柱状图颜色*/

                            itemStyle: {

                                normal: {

                                    color: function(params) {

                                        // build a color map as your need.

                                        var colorList = [

                                            '#02FFBB'

                                        ];

                                        return colorList[params.dataIndex]

                                    },

                                    /*信息显示方式*/

                                    label: {

                                        show: false,

                                        position: 'top',

                                        formatter: '{b}\n{c}'

                                    }

                                }

                            },
                            barWidth: 8,
                           
                            //label: labelOption,

                            data:[]

                        },
                        {

                            name:vueThis.xlpmsers[1],

                            type:'bar',


                            /*设置柱状图颜色*/

                            itemStyle: {

                                normal: {

                                    color: function(params) {

                                        // build a color map as your need.

                                        var colorList = [
                                            '#01624C'


                                        ];

                                        return colorList[params.dataIndex]

                                    },

                                    /*信息显示方式*/

                                    label: {

                                        show: false,

                                        position: 'top',

                                        formatter: '{b}\n{c}'

                                    }

                                }

                            },
                            barWidth: 8,
                            //barGap: 2,
                            //label: labelOption,
                            data:[]

                        }
                      


                    ]
                }
                vueThis.xlpfwOption=option;
			
                   
                myChart.setOption(vueThis.xlpfwOption );



            },
            //线路客流图表放大
             xlklpmchars: function(csgjda){
            
                 var vueThis=this;
                
                //初始化echarts图表
                var myChart;
                myChart = echarts.init(document.querySelector(csgjda));
                vueThis.xlpfwpmchar=myChart;
                option = {
	                    /* title : {
	                        text: '运营车辆比例',
	                        x:'left',
	                        textStyle:{
	                            color :'#ffffff',
	
	                            fontFamily :'sans-serif',
	                            fontSize :'13'
	                        }
	
	                    }, */

                        tooltip : {
                            //enterable:true,
                            trigger: 'axis',
                            axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                                type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                            },
                            formatter:function(params)//数据格式
                            {
                                var relVal = params[0].name+"<br/>";
                                relVal += params[0].seriesName+ ' : ' + params[0].value+"万"+"<br/>";
                              
                                relVal += params[1].seriesName+ ' : ' + params[1].value+"万";
                                return relVal;
                            }
                        },
                        


                    legend: {
                        orient: 'horizontal',
                        x: 'center',
                        y:'0',
                        icon: 'rect',
                        itemWidth: 20,
                        itemHeight: 10,
                        itemGap: 3,
                        data:vueThis.xlpmsers,
                        textStyle:{
                            color :'#ffffff',
                            fontFamily :'sans-serif',
                            fontSize :'18'
                        }


                    },
					grid:{x:30,y:40,x2:80,y2:70},
                    xAxis: [

                        {

                            type: 'category',
                            //offset:10,

                            axisLine: {

                                lineStyle: {


                                    type: 'solid',

                                    color:'#01A47E',

                                    width:'2'

                                }

                            },
                            //去掉刻度线
                            axisTick: {
                                show: false,
                                alignWithLabel: true
                            },
                            axisLabel: {
                               interval:0,
                                rotate:-30,
                                textStyle: {
                                    color: '#fff',
                                    fontSize :'14'
                                }

                            },
                            scale:true,
                            boundaryGap: true,
                            data: []

                        }

                    ],

                    yAxis: [

                        {

                            type: 'value',

                            name: '单位：万',
                            nameTextStyle: {
                                color: '#fff',
                                fontSize :'11'
                            },
                            min: 0,

                            max: 150,


                            interval: 30,
                             axisLine: {

                                lineStyle: {


                                    type: 'solid',

                                    color:'#01A47E',

                                    width:'2'

                                }

                            },
                            splitLine:{
                                show: true,
                                lineStyle: {

                                    type: 'dashed',

                                    color:'#008769',

                                    width:'0.5'

                                }

                            },//去除网格线
                            
                            axisLabel: {

                                formatter: '{value}',
                                textStyle: {
                                    color: '#fff',
                                    fontSize :'14'
                                }

                            }

                        }

                    ],

                    series: [
                    	

                        {

                            name:vueThis.xlpmsers[0],

                            type:'bar',


                            /*设置柱状图颜色*/

                            itemStyle: {

                                normal: {

                                    color: function(params) {

                                        // build a color map as your need.

                                        var colorList = [

                                            '#02FFBB'

                                        ];

                                        return colorList[params.dataIndex]

                                    },

                                    /*信息显示方式*/

                                    label: {

                                        show: false,

                                        position: 'top',

                                        formatter: '{b}\n{c}'

                                    }

                                }

                            },
                            barWidth: 16,
                           
                            //label: labelOption,

                            data:[]

                        },
                        {

                            name:vueThis.xlpmsers[1],

                            type:'bar',


                            /*设置柱状图颜色*/

                            itemStyle: {

                                normal: {

                                    color: function(params) {

                                        // build a color map as your need.

                                        var colorList = [
                                            '#01624C'


                                        ];

                                        return colorList[params.dataIndex]

                                    },

                                    /*信息显示方式*/

                                    label: {

                                        show: false,

                                        position: 'top',

                                        formatter: '{b}\n{c}'

                                    }

                                }

                            },
                            barWidth: 16,
                            //barGap: 2,
                            //label: labelOption,
                            data:[]

                        }
                      


                    ]
                }
                vueThis.xlpfwOption=option;
			
                   
                myChart.setOption(vueThis.xlpfwOption );



            },
		    },
		  filters: {
		  	amendNum:function(value){
		  		var val=parseInt(value);
		  		return val;
		  	}
			
		}
		});
		

      </script>
  </body>
</html>