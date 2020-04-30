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
    <script src="resource/js/moment.min.js"></script>
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
	background: url("resource/images/pasflw/nbg.png") no-repeat;
	background-size:100% 100%;
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
	background: url(resource/images/pasflw/sjzlbgd.png) no-repeat;
	width: 658px;
	height: 159px;
}
#sjzll {
	background: url(resource/images/pasflw/zlbga.png) no-repeat;
	background-size:100% 100%;
	width: 1000px;
	height: 247px;
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
	top: 172px;
	left: 312px;
	width: 1248px;
	height: 690px;
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
 		.tab{
		  float:right;
		  margin-left:10px;
		  height:24px;
		  width:128px;
		  background-color: rgb(50, 91, 105);
		  border-radius:10px;
		  color:#fff;
		}
		.tab span{
		  margin:2px 5px;
		  padding:3px 15px;
		  line-height: 24px;
		  border-radius:10px;
		  background: rgb(50, 91, 105);
		}
		.tab .act{
		  background: #2f96b4;
		}
		 /*定义滚动条高宽及背景 高宽分别对应横竖滚动条的尺寸*/
        ::-webkit-scrollbar
        {
            width: 7px;
            height: 16px;
            background-color: rgba(29,144,230,0);
        }

        /*定义滚动条轨道 内阴影+圆角*/
        ::-webkit-scrollbar-track
        {
            -webkit-box-shadow: inset 0 0 6px rgba(255,255,255,0.1);
            border-radius: 10px;
            background-color:rgba(255,255,255,0.1);
        }

        /*定义滑块 内阴影+圆角*/
        ::-webkit-scrollbar-thumb
        {
            border-radius: 10px;
            -webkit-box-shadow: inset 0 0 6px rgba(255,255,255,0.1);
            background-color: rgba(0,140,111,1);
        }
        .titleText{
        	font-size: 22px;
        	font-weight: bolder;
        	color:#ffffff;
        	margin-top: 30px;
        	margin-left: 0px;
        }
        .secTitleText{
        	font-size: 22px;
        	font-weight: bolder;
        	color:#ffffff;
        	margin-top: 10px;
        	margin-left: 0px;
        }
        .chartCon{
        	margin-left: -16px;
        }
        .chartCon iframe{
        	border:0px;
        	width:560px;
        	height:280px;
        }
        .maggin1{
        	margin-left: -20px;
        }
        .bigChart{
        	height:650px;
        	width:1248px;
        	padding: 2% 2%;
        }
        .bigChart iframe{
        	border:0px;
        	width:1200px;
        	height:620px;
        }
        .btn {
            width: 40px;
            height:25px;
            color: #fff;
            background-color:#2f96b4;
            text-align: center;
            border-radius:4px;
            border:0px;
            font-size: 12px;
        }
</style>
  </head>
  
  <body>
  	  <div id="pfwd">
  	  	<el-row>
  	  		<div style="margin-left: 43px;margin-top: 5px;color: #ffffff;float: left;">{{dates}} {{whens}}</div>
  	  		<div style="margin-right:30px;margin-top: 5px;color: #ffffff;float:right;">
  	  			<input type="button" value=">>" class="btn" onclick="javascript:location.href='pages/cocc/festival.jsp'">
  	  		</div>
  	  	</el-row>
  	  	<el-row>
	  	  	<el-col :span="10">
	  	  		<el-row>
	  	  			<div style="margin-top: 15px;margin-left: 260px;" @click="fsklDetl()">
	                	<div class="" style="float: left;margin-top: 6px;margin-left: 105px;font-size: 23px;font-weight: bolder;color:#ffffff">
								  	  				数据总览
								  	  			</div>
	           		 </div>		
	  	  		</el-row>
	  	  		<el-row>
	  	  			<div id="shujuzl" style="float: left;margin-top: 5px;margin-left: 90px;width:660px;height:160px">
	  	  			
	  	  			<div id="sjzl" style="float: left;margin-top: 2px;margin-left: -7px;">
	  	  				<div  id="xuanzhuan" style="float: left;margin-top: 12px;margin-left: 251px;position:absolute">
	                		<img class="an"  src="resource/images/pasflw/xzhuan.png" alt=""/>
	           		 	</div>	
	                	<el-row>
	                		<el-col :span="8">
	                			<el-row>
						  	  		<el-col :span="12">
								  	  	<el-row>
								  	  		<div style="width:112px;height:40px;float: left;margin-top: 25px;margin-left: 22px;">
								  	  			<div style="float: left;margin-top: 11px;margin-left: 0px;font-size: 10px;color:#ffffff">
								  	  				进站
								  	  			</div>
								  	  			<div id="enterTimes" class="lcd " style="float: left;margin-top: 0px;margin-left: 13px;font-size: 24px;color:#02FAB8">
								  	  				{{summary.enterTimes}}
								  	  			</div>
								  	  			<div class="lcd" style="float: left;margin-top: 13px;margin-left: 13px;font-size: 12px;color:#ffffff">
								  	  				万
								  	  			</div>
								  	  			<div style="float: left;position: absolute;margin-top: 17px;">
							                		<img src="resource/images/pasflw/sjzltiao.png" alt=""/>
							           		 	</div>	
								  	  		</div>
							  	  				
							  	  		</el-row>
							  	  		<el-row>
								  	  		<div style="width:112px;height:40px;float: left;margin-top: 0px;margin-left: 22px;">
								  	  			<div style="float: left;margin-top: 11px;margin-left: 0px;font-size: 10px;color:#ffffff">
								  	  				换乘
								  	  			</div>
								  	  			<div id="changeTimes" class="lcd" style="float: left;margin-top: 0px;margin-left: 13px;font-size: 24px;color:#02FAB8">
								  	  				{{summary.changeTimes}}
								  	  			</div>
								  	  			<div class="lcd" style="float: left;margin-top: 13px;margin-left: 13px;font-size: 12px;color:#ffffff">
								  	  				万
								  	  			</div>
								  	  			<div style="float: left;position: absolute;margin-top: 17px;">
							                		<img src="resource/images/pasflw/sjzltiao.png" alt=""/>
							           		 	</div>	
								  	  		</div>
							  	  				
							  	  		</el-row>
					  	  		
					  	  			</el-col>
					  	  			<el-col :span="12">
					  	  				<el-row>
					  	  					<div style="color: #ffffff;font-size: 16px;font-weight: bold;
											    width: 80px;margin-left: 40px;margin-top: 30px;
											    text-align: center;
											    height: 30px;">
					                		历史最高
					                	</div>
					                	<div style="color: #ffffff;font-size: 16px;font-weight: bold;
											    width: 60px;margin-left: 50px;margin-top: -10px;
											    text-align: center;
											    height: 30px;">
					                		总客流
					                	</div>
					  	  				</el-row>
					  	  				<el-row>
					  	  					<div id="hpfwAmount" class="lcd " style="float: left;margin-top: -5px;margin-left: 45px;font-size: 28px;color:#02FAB8">
								  	  				{{summary.hpfwAmount}}
								  	  			</div>
								  	  			<div class="lcd" style="float: left;margin-top: -25px;margin-left: 110px;font-size: 13px;color:#ffffff">
								  	  				万
								  	  			</div>
					  	  				</el-row>
					  	  			</el-col>
					  	  		</el-row>		  
					  	  	</el-col>
					  	  	<el-col :span="8">
						  	  	<el-row>
					  	  			<div style="float: left;width:100px;
									    
									    margin-top: 52px;
									    margin-left: 58px;">
					                	<div style="color: #ffffff;font-size: 16px;font-weight: bold;
											    width: 100px;
											    text-align: center;
											    height: 30px;">
					                		总客流
					                	</div>
					                	<div style="width: 100px;height:50px;">
					                		<div id="pfwAmount" class="lcd" style="    margin-left: 16px;
											    margin-top: -13px;
											    float: left;
											    width: 56px;
											    font-size: 28px;
											    color: rgb(2, 209, 158);
											    height: 40px;">
					                			{{summary.pfwAmount}}
					                		</div>
					                			<div style="    margin-left: 3px;
												    float: left;
												    font-size: 11px;
												    color: rgb(255, 255, 255);
												    height: 30px;
												    width: 20px;">
					                				万
					                			</div>
					                	</div>
					           		 	<div style="width:62px;height:40px;float: left;margin-top: -32px;margin-left: 25px;">
						  	  			
						  	  			<div id="asd" class="" style="float: left;margin-top: 3px;margin-left: 0px;font-size: 12px;color:#03A781">
						  	  				{{summary.ascRate}}
						  	  			</div>
						  	  			<div  v-show="summary.asshow" style="float: left;margin-top: 0px;margin-left: 2px;">
					                		<img src="resource/images/pasflw/asce.png" alt=""/>
					           		 	</div>
					           		 	<div v-show="summary.dsshow" style="float: left;margin-top: 0px;margin-left: 2px;">
					                		<img src="resource/images/pasflw/desc.png" alt=""/>
					           		 	</div>		
						  	  		</div>
					           		 </div>		
					  	  		</el-row>	  
					  	  	</el-col>
					  	  	<el-col :span="8">
						  	  	<el-row>
					  	  			<div style="float: left;margin-top: 17px;margin-left: 33px;">
					                	<el-row>
					                		<el-col :span="12">
					                			<el-row>
					  	  					<div style="color: #ffffff;font-size: 16px;font-weight: bold;
											    width: 80px;margin-left: -50px;margin-top: 12px;
											    text-align: center;
											    height: 30px;">
					                		同期对比
					                	</div>
					                	<div style="color: #ffffff;font-size: 16px;font-weight: bold;
											    width: 60px;margin-left: -45px;margin-top: -10px;
											    text-align: center;
											    height: 30px;">
					                		总客流
					                	</div>
					  	  				</el-row>
					  	  				<el-row>
					  	  					<div id="mpfwAmount" class="lcd" style="float: left;margin-top: -5px;margin-left: -45px;font-size: 28px;color:#02FAB8">
								  	  				{{summary.mpfwAmount}}
								  	  			</div>
								  	  			<div class="lcd" style="float: left;margin-top: 7px;margin-left: 5px;font-size: 13px;color:#ffffff">
								  	  				万
								  	  			</div>
					  	  				</el-row>
					                		</el-col>
					                		<el-col :span="12">
					                			<el-row>
										  	  		<div style="width:112px;height:40px;float: left;margin-top: 5px;margin-left: -12px;">
										  	  			<div style="float: left;margin-top: 11px;margin-left: 0px;font-size: 10px;color:#ffffff">
										  	  				进站
										  	  			</div>
										  	  			<div id="menterTimes" class="lcd" style="float: left;margin-top: 0px;margin-left: 13px;font-size: 24px;color:#02FAB8">
										  	  				{{summary.menterTimes}}
										  	  			</div>
										  	  			<div class="lcd" style="float: left;margin-top: 13px;margin-left: 13px;font-size: 12px;color:#ffffff">
										  	  				万
										  	  			</div>
										  	  			<div style="float: left;position: absolute;margin-top: 17px;">
									                		<img src="resource/images/pasflw/sjzltiao.png" alt=""/>
									           		 	</div>	
										  	  		</div>
									  	  				
									  	  		</el-row>
									  	  		<el-row>
										  	  		<div style="width:112px;height:40px;float: left;margin-top: 0px;margin-left: -12px;">
										  	  			<div style="float: left;margin-top: 11px;margin-left: 0px;font-size: 10px;color:#ffffff">
										  	  				换乘
										  	  			</div>
										  	  			<div id="mchangeTimes" class="lcd" style="float: left;margin-top: 0px;margin-left: 13px;font-size: 24px;color:#02FAB8">
										  	  				{{summary.mchangeTimes}}
										  	  			</div>
										  	  			<div class="lcd" style="float: left;margin-top: 13px;margin-left: 13px;font-size: 12px;color:#ffffff">
										  	  				万
										  	  			</div>
										  	  			<div style="float: left;position: absolute;margin-top: 17px;">
									                		<img src="resource/images/pasflw/sjzltiao.png" alt=""/>
									           		 	</div>	
										  	  		</div>
									  	  				
									  	  		</el-row>
					                		</el-col>
					                	</el-row>
					                	
					           		 </div>		
					  	  		</el-row>	  
					  	  		<el-row>
					  	  			
					  	  		</el-row>
					  	  	</el-col>
	                	</el-row>
	            	</div>
	  	  			<div id="" style="float: left;margin-top: -23px;margin-left: 0px;width:660px;height:40px">
	  	  				<div id="" style="float: left;margin-top: 5px;margin-left: 15px;width:150px;height:30px">
	  	  					<div id="" style="float: left;margin-top: 0px;margin-left: 0px;width:70px;height:30px;font-size: 13px;font-weight: bolder;color:#ffffff">
	  	  						运营日期：
	  	  					</div>
	  	  					<div id="" style="float: left;margin-top: 0px;margin-left: 7px;width:60px;height:30px;font-size: 13px;font-weight: bolder;color:#02FAB8">
	  	  						{{temDt}}
	  	  					</div>
	  	  				</div>
	  	  				<div id="" style="float: right;margin-top: 5px;margin-right: 30px;width:150px;height:30px">
	  	  					<div id="" style="float: left;margin-top: 0px;margin-left: 0px;width:70px;height:30px;font-size: 13px;font-weight: bolder;color:#ffffff">
	  	  						对比日期：
	  	  					</div>
	  	  					<div id="" style="float: left;margin-top: 0px;margin-left: 7px;width:60px;height:30px;font-size: 13px;font-weight: bolder;color:#02FAB8">
	  	  						{{compDt}}
	  	  					</div>
	  	  				</div>
	  	  			</div>
	  	  			</div>	
	  	  		</el-row>
	  	  		<el-row>
	  	  			<div style="float: left;margin-top: 23px;margin-left: 342px;" @click=" vssiDetl()">
	                	<div class="" style="float: left;margin-top: 7px;margin-left: 15px;font-size: 22px;font-weight: bolder;color:#ffffff">
								  	  				实  时  客  流
								  	  			</div>
	           		 </div>		
	  	  		</el-row>
	  	  		<el-row>
	  	  			<div style="float: left;margin-top: 16px;margin-left: 60px;width:700px;height:630px">
	                	<iframe id="tosa" src="pages/tosnew/odflux_sel31a.jsp" frameBorder="0" width="700" height="630"></iframe>
	           		 </div>		
	  	  		</el-row>
	  	  		
	  	  	</el-col>
	  	  	<el-col :span="7">
		  	  	<el-row>
	  	  			<div id="modalBtn" class="titleText" @click="xlpmDetl()">车站分时客流</div>		
	  	  		</el-row>
	  	  		<el-row>
	  	  			<div class="chartCon">
						 <iframe id="alinea" src="pages/jinbo/station_seg_flow.jsp"></iframe>
	           		</div>		
	  	  		</el-row>
	  	  		<el-row>
	  	  			<div class="secTitleText"  @click="coccLineDetl()">进博会OD客流排名</div>		
	  	  		</el-row>
	  	  		<el-row>
	  	  			<div class="chartCon">
						<iframe id="odrank" src="pages/jinbo/od_rank.jsp?viewFlag=true"></iframe>
					</div>
	  	  		</el-row>
	  	  		<el-row>
	  	  			<div class="secTitleText" @click="klzfDetl()">分时累计客流</div>		
	  	  		</el-row>
	  	  		<el-row>
	  	  			<div class="chartCon">
						<iframe id="isnflwa"src="pages/jinbo/instantFlw.jsp"></iframe>
	           		</div>		
	  	  		</el-row>
	  	  	</el-col>
	  	  	
	  	  	<el-col :span="7">
	  	  		<el-row>
	  	  			<div class="titleText maggin1" @click="czklDetl()">进博会“三站”客流占比</div>		
	  	  		</el-row>
	  	  		<el-row>
	  	  			<div class="chartCon maggin1">
						<iframe id="fluxCom" src="pages/jinbo/flux_compare.jsp?viewFlag=true"></iframe>
					</div>
	  	  		</el-row>
	  	  		<el-row>
	  	  			<div class="secTitleText maggin1" @click="qyklDetl()">实时在网客流</div>		
	  	  		</el-row>
	  	  		<el-row>
	  	  			<div class="chartCon maggin1">
						<iframe id="onlfla" src="pages/jinbo/onlineFlw.jsp"></iframe>
					</div>
	  	  		</el-row>
	  	  		<el-row>
	  	  			<div class="secTitleText maggin1" @click="czydDetl()">重点关注车站客流</div>		
	  	  		</el-row>
	  	  		<el-row>
	  	  			<div class="chartCon maggin1">
						<iframe id="gqcza" src="pages/jinbo/station_flow_model.jsp?viewFlag=true"></iframe>
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
<!-- 				      <div v-show="zklquery" style="position: absolute;margin-left: 80%;border-radius:5px;background-color:orange;width: 80px;height: 30px; -->
<!--     					margin-top: 5px;" @click="openDate"> -->
<!-- 				      		<div style="color: white;text-align: center;    margin-top: 4px;">客流查询</div> -->
<!-- 				      </div> -->
				      <div style="position: absolute;margin-left: 87%;border-radius:5px;background-color:lightgreen;width: 80px;height: 30px;
    					margin-top: 5px;" @click="onFull">
				      		<div style="color: white;text-align: center;    margin-top: 4px;">全屏显示</div>
				      </div>
				      <div style="position: absolute;margin-left: 94%;border-radius:5px;background-color:#33CCFF;width: 60px;height: 30px;
    					margin-top:5px;" @click="onClose">
				      		<div style="color: white;text-align: center;    margin-top: 4px;">关闭</div>
				      </div>
				    </div>
				    
				      <div class="" style="height:100%;width:100%; background-color: #043735">
				        <div id="" v-show="xlpmsw" style="height:650px;width:1248px;padding: 2% 2%;">
				        	<iframe id="xlrank" src="pages/jinbo/station_seg_flow_full.jsp" frameBorder="0" width="1200" height="620"></iframe>
				        </div>
				        <div id="" v-show="qyklsw" style="height:650px;width:1248px;padding: 2% 1%;">
				        	<iframe id="qyklsw" src="pages/jinbo/olflow.jsp" frameBorder="0" width="1200" height="620"></iframe>
				        </div>
				        
				        <div id="" v-show="czklsw" style="height:650px;width:1248px;padding: 2% 2%;">
				        	<iframe id="fluxsw" src="pages/jinbo/flux_compare.jsp" frameBorder="0" width="1200" height="620"></iframe>
                    	</div>
				      
				        <div v-show="czydsw" style="height:650px;width:1248px;padding: 2% 2%;">
				        	<iframe id="zdczrk" src="pages/jinbo/station_flow_model.jsp" frameBorder="0" width="1200" height="620"></iframe>
				        </div>
				        <div id="" v-show="zdczsw" style="height:650px;width:1248px;position: relative;padding: 2% 2%;">
					        <iframe id="odrk" src="pages/jinbo/od_rank.jsp" frameBorder="0" width="1200" height="620"></iframe>
						</div>
<!-- 						<div id="" v-show="coccStationsw" style="height:650px;width:1248px;position: relative;padding: 2% 2%;"> -->
<!-- 							<input id="cocc_view" value="1" type="text" hidden> -->
<!-- 					        <iframe id="coccstation" src="pages/jinbo/station_flux_all.jsp" frameBorder="0" width="1200" height="620"></iframe> -->
<!-- 						</div> -->
						<div id="" v-show="fsklsw" style="height:650px;width:1248px;position: relative;padding: 2% 2%;">
					        <div id="sjzla"  style="height:620px;width:1200px;position: relative;">
					        	<div id="sjzll" style="float: left;margin-top: 62px;margin-left: 100px;">
	  	  				<div  id="xuanzhuan" style="float: left;margin-top: 4px;margin-left: 375px;height:249px;width:249px;position:absolute">
	                		<img class="an"  src="resource/images/pasflw/xzs.png" style="height:100%;width:100%;" alt=""/>
	           		 	</div>	
	                	<el-row>
	                		<el-col :span="8">
	                			<el-row>
						  	  		<el-col :span="12">
								  	  	<el-row>
								  	  		<div style="width:160px;height:50px;float: left;margin-top: 42px;margin-left: 39px;">
								  	  			<div style="float: left;margin-top: 11px;margin-left: 0px;font-size: 20px;color:#ffffff">
								  	  				进站
								  	  			</div>
								  	  			<div id="enterTimesa" class="lcd " style="float: left;margin-top: 0px;margin-left: 13px;font-size: 36px;color:#02FAB8">
								  	  				{{summary.enterTimes}}
								  	  			</div>
								  	  			<div class="lcd" style="float: left;margin-top: 15px;margin-left: 8px;font-size: 18px;color:#ffffff">
								  	  				万
								  	  			</div>
								  	  			<div style="float: left;position: absolute;margin-top: 29px;height:8px;width:160px;">
							                		<img src="resource/images/pasflw/dts.png" style="height:100%;width:100%;" alt=""/>
							           		 	</div>	
								  	  		</div>
							  	  				
							  	  		</el-row>
							  	  		<el-row>
								  	  		<div style="width:160px;height:50px;float: left;margin-top: 0px;margin-left: 39px;">
								  	  			<div style="float: left;margin-top: 11px;margin-left: 0px;font-size: 20px;color:#ffffff">
								  	  				换乘
								  	  			</div>
								  	  			<div id="changeTimesa" class="lcd" style="float: left;margin-top: 0px;margin-left: 13px;font-size: 36px;color:#02FAB8">
								  	  				{{summary.changeTimes}}
								  	  			</div>
								  	  			<div class="lcd" style="float: left;margin-top: 13px;margin-left: 8px;font-size: 18px;color:#ffffff">
								  	  				万
								  	  			</div>
								  	  			<div style="float: left;position: absolute;margin-top: 29px;height:8px;width:160px;">
							                		<img src="resource/images/pasflw/dts.png" style="height:100%;width:100%;" alt=""/>
							           		 	</div>		
								  	  		</div>
							  	  				
							  	  		</el-row>
					  	  		
					  	  			</el-col>
					  	  			<el-col :span="12">
					  	  				<el-row>
					  	  					<div style="color: #ffffff;font-size: 28px;font-weight: bold;
											    width: 160px;margin-left: 40px;margin-top: 55px;
											    text-align: center;
											    height: 40px;">
					                		历史最高
					                	</div>
					                	<div style="color: #ffffff;font-size: 28px;font-weight: bold;
											    width: 120px;margin-left: 50px;margin-top: -5px;
											    text-align: center;
											    height: 40px;">
					                		总客流
					                	</div>
					  	  				</el-row>
					  	  				<el-row>
					  	  					<div id="hpfwAmounta" class="lcd " style="float: left;margin-top: -5px;margin-left: 45px;font-size: 45px;color:#02FAB8">
								  	  				{{summary.hpfwAmount}}
								  	  			</div>
								  	  			<div class="lcd" style="float: left;margin-top: -42px;margin-left: 148px;font-size: 22px;color:#ffffff">
								  	  				万
								  	  			</div>
					  	  				</el-row>
					  	  			</el-col>
					  	  		</el-row>		  
					  	  	</el-col>
					  	  	<el-col :span="8">
						  	  	<el-row>
					  	  			<div style="float: left;width:100px;
									    
									    margin-top: 74px;
									    margin-left: 88px;">
					                	<div style="color: #ffffff;font-size: 29px;font-weight: bold;
											    width: 150px;
											    text-align: center;
											    height: 40px;">
					                		总客流
					                	</div>
					                	<div style="width: 130px;height:50px;margin-left: 6px;">
					                		<div id="pfwAmounta" class="lcd" style="    margin-left: 13px;
											    margin-top: -7px;
											    float: left;
											    width: 60px;
											    font-size: 46px;
											    color: rgb(2, 209, 158);
											    height: 45px;">
					                			{{summary.pfwAmount}}
					                		</div>
					                			<div style="    margin-left: 37px;
												    float: left;
												    font-size: 22px;
												    margin-top: 13px;
												    color: rgb(255, 255, 255);
												    height: 30px;
												    width: 20px;">
					                				万
					                			</div>
					                	</div>
					           		 	<div style="width:82px;height:40px;float: left;margin-top: -7px;margin-left: 55px;">
						  	  			
						  	  			<div id="asds" class="" style="float: left;margin-top: 3px;margin-left: 0px;font-size: 18px;color:#03A781">
						  	  				{{summary.ascRate}}
						  	  			</div>
						  	  			<div  v-show="summary.asshow" style="float: left;margin-top: 3px;margin-left: 2px;height:18px;width:9px;">
					                		<img src="resource/images/pasflw/asce.png" style="height:100%;width:100%;" alt=""/>
					           		 	</div>
					           		 	<div v-show="summary.dsshow" style="float: left;margin-top: 3px;margin-left: 2px;height:18px;width:9px;">
					                		<img src="resource/images/pasflw/desc.png" style="height:100%;width:100%;" alt=""/>
					           		 	</div>		
						  	  		</div>
					           		 </div>		
					  	  		</el-row>	  
					  	  	</el-col>
					  	  	<el-col :span="8">
						  	  	<el-row>
					  	  			<div style="float: left;margin-top: 17px;margin-left: 33px;">
					                	<el-row>
					                		<el-col :span="12">
					                			<el-row>
					  	  					<div style="color: #ffffff;font-size: 28px;font-weight: bold;
											    width: 160px;margin-left: -55px;margin-top: 40px;
											    text-align: center;
											    height: 40px;">
					                		同期对比
					                	</div>
					                	<div style="color: #ffffff;font-size: 28px;font-weight: bold;
											    width: 120px;margin-left: -42px;margin-top: -5px;
											    text-align: center;
											    height: 40px;">
					                		总客流
					                	</div>
					  	  				</el-row>
					  	  				<el-row>
					  	  					<div id="mpfwAmounta" class="lcd" style="float: left;margin-top: -5px;margin-left: -45px;font-size: 45px;color:#02FAB8">
								  	  				{{summary.mpfwAmount}}
								  	  			</div>
								  	  			<div class="lcd" style="float: left;margin-top:15px;margin-left: 5px;font-size: 22px;color:#ffffff">
								  	  				万
								  	  			</div>
					  	  				</el-row>
					                		</el-col>
					                		<el-col :span="12">
					                			<el-row>
										  	  		<div style="width:160px;height:50px;float: left;margin-top: 25px;margin-left: -22px;">
										  	  			<div style="float: left;margin-top: 11px;margin-left: 0px;font-size: 20px;color:#ffffff">
										  	  				进站
										  	  			</div>
										  	  			<div id="menterTimesa" class="lcd" style="float: left;margin-top: 0px;margin-left: 13px;font-size: 36px;color:#02FAB8">
										  	  				{{summary.menterTimes}}
										  	  			</div>
										  	  			<div class="lcd" style="float: left;margin-top: 15px;margin-left: 8px;font-size: 18px;color:#ffffff">
										  	  				万
										  	  			</div>
										  	  			<div style="float: left;position: absolute;margin-top: 29px;height:8px;width:160px;">
							                		<img src="resource/images/pasflw/dts.png" style="height:100%;width:100%;" alt=""/>
							           		 	</div>	
										  	  		</div>
									  	  				
									  	  		</el-row>
									  	  		<el-row>
										  	  		<div style="width:160px;height:50px;float: left;margin-top: 0px;margin-left: -22px;">
										  	  			<div style="float: left;margin-top: 11px;margin-left: 0px;font-size: 20px;color:#ffffff">
										  	  				换乘
										  	  			</div>
										  	  			<div id="mchangeTimesa" class="lcd" style="float: left;margin-top: 0px;margin-left: 13px;font-size: 36px;color:#02FAB8">
										  	  				{{summary.mchangeTimes}}
										  	  			</div>
										  	  			<div class="lcd" style="float: left;margin-top: 15px;margin-left: 8px;font-size: 18px;color:#ffffff">
										  	  				万
										  	  			</div>
										  	  			<div style="float: left;position: absolute;margin-top: 29px;height:8px;width:160px;">
							                		<img src="resource/images/pasflw/dts.png" style="height:100%;width:100%;" alt=""/>
							           		 	</div>	
										  	  		</div>
									  	  				
									  	  		</el-row>
					                		</el-col>
					                	</el-row>
					                	
					           		 </div>		
					  	  		</el-row>	  
					  	  		<el-row>
					  	  			
					  	  		</el-row>
					  	  	</el-col>
	                	</el-row>
	            	</div>
	            	<div id="" style="float: left;margin-top: -73px;margin-left: 0px;width:1200px;height:60px">
	  	  				<div id="" style="float: left;margin-top: 5px;margin-left: 202px;width:170px;height:50px">
	  	  					<div id="" style="float: left;margin-top: 0px;margin-left: 0px;width:80px;height:50px;font-size: 16px;font-weight: bolder;color:#ffffff">
	  	  						运营日期：
	  	  					</div>
	  	  					<div id="" style="float: left;margin-top: 0px;margin-left: 7px;width:80px;height:50px;font-size: 16px;font-weight: bolder;color:#02FAB8">
	  	  						{{temDt}}
	  	  					</div>
	  	  				</div>
	  	  				<div id="" style="float: right;margin-top: 5px;margin-right: 208px;width:170px;height:50px">
	  	  					<div id="" style="float: left;margin-top: 0px;margin-left: 0px;width:80px;height:50px;font-size: 16px;font-weight: bolder;color:#ffffff">
	  	  						对比日期：
	  	  					</div>
	  	  					<div id="" style="float: left;margin-top: 0px;margin-left: 7px;width:80px;height:50px;font-size: 16px;font-weight: bolder;color:#02FAB8">
	  	  						{{compDt}}
	  	  					</div>
	  	  				</div>
	  	  			</div>
								<div v-show="datechos" style="height:60px;width:1200px;float: left;padding-top: 20px;margin-left: 150px;">
									<el-row style="    padding-top: 1%;padding-left: 2%;">
									 <el-col :span="4">
									 	<div style="font-size: 16px;color:#ffffff;font-weight: bolder;margin-top: 7px; ">
									 		总客流查询：
									 	</div>
									 </el-col>
									  <el-col :span="6">
									  <div class="block">
									    <span class="demonstration" style="font-size: 14px;color:#ffffff ">当前日期&nbsp&nbsp </span>
									    <el-date-picker
									      v-model="temDate"
									      align="right"
									      type="date"
									      placeholder="当前日期 "
									      format="yyyyMMdd"
									      value-format="yyyyMMdd"
									      >
									    </el-date-picker>
									  </div></el-col>
									  <el-col :span="6"><div class="block">
									    <span class="demonstration" style="font-size: 14px;color:#ffffff ">对比日期&nbsp&nbsp </span>
									    <el-date-picker
									      v-model="compDate"
									      align="right"
									      type="date"
									      placeholder="对比日期 "
									      format="yyyyMMdd"
									      value-format="yyyyMMdd"
									      >
									    </el-date-picker>
									  </div></el-col>
									  <el-col :span="8"><el-button type="primary" @click="getFlow()">查询</el-button></el-col>
									 
									</el-row>
									<el-row style="    padding-top: 2%;padding-left: 2%;">
									 <el-col :span="4">
									 	<div style="font-size: 16px;color:#ffffff;font-weight: bolder;margin-top: 7px; ">
									 		分时客流查询：
									 	</div>
									 </el-col>
									  <el-col :span="6">
									  <div class="block">
									    <span class="demonstration" style="font-size: 14px;color:#ffffff ">对比日期1</span>
									    <el-date-picker
									      v-model="fsDate1"
									      align="right"
									      type="date"
									      placeholder="对比日期1"
									      format="yyyyMMdd"
									      value-format="yyyyMMdd"
									      >
									    </el-date-picker>
									  </div></el-col>
									  <el-col :span="6"><div class="block">
									    <span class="demonstration" style="font-size: 14px;color:#ffffff ">对比日期2</span>
									    <el-date-picker
									      v-model="fsDate2"
									      align="right"
									      type="date"
									      placeholder="对比日期2"
									      format="yyyyMMdd"
									      value-format="yyyyMMdd"
									      >
									    </el-date-picker>
									  </div></el-col>
									  <el-col :span="8"><el-button type="primary" @click="getFsflow()">查询</el-button></el-col>
									 
									</el-row>
									<el-row style="    padding-top: 2%;padding-left: 2%;">
									 <el-col :span="4">
									 	<div style="font-size: 16px;color:#ffffff;font-weight: bolder;margin-top: 7px; ">
									 		实时在网客流查询：
									 	</div>
									 </el-col>
									  <el-col :span="6">
									  <div class="block">
									    <span class="demonstration" style="font-size: 14px;color:#ffffff ">当前日期&nbsp&nbsp </span>
									    <el-date-picker
									      v-model="olDate1"
									      align="right"
									      type="date"
									      placeholder="对比日期 "
									      format="yyyyMMdd"
									      value-format="yyyyMMdd"
									      >
									    </el-date-picker>
									  </div></el-col>
									  <el-col :span="6"><div class="block">
									    <span class="demonstration" style="font-size: 14px;color:#ffffff ">对比日期&nbsp&nbsp </span>
									    <el-date-picker
									      v-model="olDate2"
									      align="right"
									      type="date"
									      placeholder="对比日期2"
									      format="yyyyMMdd"
									      value-format="yyyyMMdd"
									      >
									    </el-date-picker>
									  </div></el-col>
									  <el-col :span="8"><el-button type="primary" @click="getOlflow()">查询</el-button></el-col>
									 
									</el-row>
									<el-row style="    padding-top: 2%;padding-left: 2%;">
									 <el-col :span="4">
									 	<div style="font-size: 16px;color:#ffffff;font-weight: bolder;margin-top: 7px; ">
									 		重点关注线路客流查询：
									 	</div>
									 </el-col>
									  <el-col :span="6">
									  <div class="block">
									    <span class="demonstration" style="font-size: 14px;color:#ffffff ">当前日期&nbsp&nbsp</span>
									    <el-date-picker
									      v-model="gqlDate1"
									      align="right"
									      type="date"
									      placeholder="对比日期"
									      format="yyyyMMdd"
									      value-format="yyyyMMdd"
									      >
									    </el-date-picker>
									  </div></el-col>
									  <el-col :span="6"><div class="block">
									    <span class="demonstration" style="font-size: 14px;color:#ffffff ">对比日期&nbsp&nbsp</span>
									    <el-date-picker
									      v-model="gqlDate2"
									      align="right"
									      type="date"
									      placeholder="对比日期2"
									      format="yyyyMMdd"
									      value-format="yyyyMMdd"
									      >
									    </el-date-picker>
									  </div></el-col>
									  <el-col :span="8"><el-button type="primary" @click="getGqlflow()">查询</el-button></el-col>
									 
									</el-row>
									<el-row style="    padding-top: 2%;padding-left: 2%;">
									 <el-col :span="4">
									 	<div style="font-size: 16px;color:#ffffff;font-weight: bolder;margin-top: 7px; ">
									 		重点关注车站客流查询：
									 	</div>
									 </el-col>
									  <el-col :span="6">
									  <div class="block">
									    <span class="demonstration" style="font-size: 14px;color:#ffffff ">当前日期&nbsp&nbsp</span>
									    <el-date-picker
									      v-model="gqzDate1"
									      align="right"
									      type="date"
									      placeholder="对比日期"
									      format="yyyyMMdd"
									      value-format="yyyyMMdd"
									      >
									    </el-date-picker>
									  </div></el-col>
									  <el-col :span="6"><div class="block">
									    <span class="demonstration" style="font-size: 14px;color:#ffffff ">对比日期&nbsp&nbsp</span>
									    <el-date-picker
									      v-model="gqzDate2"
									      align="right"
									      type="date"
									      placeholder="对比日期2"
									      format="yyyyMMdd"
									      value-format="yyyyMMdd"
									      >
									    </el-date-picker>
									  </div></el-col>
									  <el-col :span="8"><el-button type="primary" @click="getGqzflow()">查询</el-button></el-col>
									 
									</el-row>
								</div>
							</div>
						</div>
						<div id="" v-show="vssisw" style="height:650px;width:1248px;position: relative;padding: 2% 2%;">
					        <iframe id="tosb" src="pages/tosnew/odflux_sel31b.jsp" frameBorder="0" width="1200" height="620"></iframe>
						</div>
						
						<div id="" v-show="klzfsw" style="height:650px;width:1248px;position: relative;padding: 15px 20px;">
							<iframe id="fsklrk" src="pages/jinbo/instFlwa.jsp" frameBorder="0" width="1200" height="620"></iframe>
						</div>
				      </div>
				  </div>
				
  	  	</div>	  	 
  	  	
  	  </div>
  	  
  
      <script type="text/javascript">
	       
		var ftlvue = new Vue({
		  el: '#pfwd',
		  data:function(){
			return {
				hournow:'now',
				datechos:false,
				zklquery:false,
				temDate:Date.now(),
				compDate:'',
				tmdtms:'',
				cpdtms:'',
				temDates:"",
				compDates:'',
				temDt:'',
				compDt:'',
				fsDate1:'',
				fsDate2:'',
				fsdt1ms:'',
				fsdt2ms:'',
				olDate1:'',
				olDate2:'',
				oldt1ms:'',
				oldt2ms:'',
				gqlDate1:'',
				gqlDate2:'',
				gqldtms1:'',
				gqldtms2:'',
				gqzDate1:'',
				gqzDate2:'',
				gqzdtms1:'',
				gqzdtms2:'',
				isShow:false,
				xlpmsw:false,
				qyklsw:false,
				fsklsw:false,
				czklsw:false,
				czydsw:false,
				zdczsw:false,
				coccStationsw:false,
				vssisw:false,
				klzfsw:false,
				adate:"",
				aweekdate:"",
				firdate:"",
				secdate:"",
				dates:"",
				whens:'',
				when:'',
				flowType:[1,3],
				cztype:true,
				czbtype:false,
				czctype:true,
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
				modalTitle:""
			};
		  },
		  mounted: function () {
		  
			this.initData();
			this.timeReload();
	      },
		  methods: {
		  //初始化页面
		  initData:function(){
		  	  this.getNowFormatnow();
		  	  this.makedate();
		      this.getPFWsmy();
		      window.notifyifram=this.notifyifram;
// 		   	  this.ifresh();
		  },
		  //子页面刷新
		  ifresh:function(){
			  document.getElementById('tosa').contentWindow.location.reload(true);
			  document.getElementById('tosb').contentWindow.location.reload(true);
			  document.getElementById('alinea').contentWindow.location.reload(true);
			  document.getElementById('xlrank').contentWindow.location.reload(true);
			  
			  document.getElementById('odrk').contentWindow.getData(true);
			  document.getElementById('fsklrk').contentWindow.searchLineRankData();
			  document.getElementById('fluxsw').contentWindow.getData();
			  document.getElementById('qyklsw').contentWindow.searchLineRankData();
			  document.getElementById('zdczrk').contentWindow.search();
			  
// 			  document.getElementById('onlfla').contentWindow.location.reload(true);
// 	  		  document.getElementById('isnflwa').contentWindow.location.reload(true);
// 	  		  document.getElementById('gqcza').contentWindow.location.reload(true);
	  		  
// 	  		  document.getElementById('qyklsw').contentWindow.location.reload(true);
// 	  		  document.getElementById('czklrk').contentWindow.location.reload(true);
// 	  		  document.getElementById('zdczrk').contentWindow.location.reload(true);
// 	  		  document.getElementById('xlczrk').contentWindow.location.reload(true);
// 	  		  document.getElementById('coccstation').contentWindow.location.reload(true);
// 	  		  
// 	  		  document.getElementById('fsklrk').contentWindow.location.reload(true);
		  
		  },
		  //定时刷新
		  timeReload:function(){
		  	var vueThis=this;
		  	setInterval(function() {
                  vueThis.initData();
                  vueThis.ifresh();
                }, 300000);
		  },
		  //通知各iframe 刷新数据
		  notifyifram:function(type,params){
		  	 if(type=="fsflw"){
				document.getElementById('isnflwa').contentWindow.setChart(params);
			 }
			 if(type=="gqz"){
				document.getElementById('gqcza').contentWindow.upDate(params);
			 }
			 if(type=="onlineflw"){
				document.getElementById('onlfla').contentWindow.setChart(params);
			 }
		  	 if(type=="odrank"){
		  		document.getElementById('odrank').contentWindow.dataRefresh(params);
		  	 }
		  	 if(type=="fluxCom"){
		  		document.getElementById('fluxCom').contentWindow.dataRefresh(params);
		  	 }
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
			 
			 var changeTimes = new CountUp("changeTimes", vueThis.summary.schangeTimes,vueThis.summary.changeTimes, 1, 5,options);
			 changeTimes.start(); 
			 var enterTimes = new CountUp("enterTimes", vueThis.summary.senterTimes,vueThis.summary.enterTimes, 1, 5,options);
			 enterTimes.start(); 
			 
			  var mchangeTimes = new CountUp("mchangeTimes", vueThis.summary.smchangeTimes,vueThis.summary.mchangeTimes, 1, 5,options);
			 mchangeTimes.start(); 
			// $("#mchangeTimes").css("-webkit-animation","zoomsa 2s ease-out 3");
			 var menterTimes = new CountUp("menterTimes", vueThis.summary.smenterTimes,vueThis.summary.menterTimes, 1, 5,options);
			 menterTimes.start(); 
			// $("#menterTimes").css("-webkit-animation","zoomsa 2s ease-out 3");
			 var mpfwAmount = new CountUp("mpfwAmount", vueThis.summary.smpfwAmount,vueThis.summary.mpfwAmount, 1, 5,options);
			 mpfwAmount.start(); 
			 //$("#mpfwAmount").css("-webkit-animation","zooms 2s ease-out 3");
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
		  Numcounts:function(){
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
					var pfwAmount = new CountUp("pfwAmounta", vueThis.summary.spfwAmount,vueThis.summary.pfwAmount, 1, 5,options);
			 		pfwAmount.start();
			 
			 var changeTimes = new CountUp("changeTimesa", vueThis.summary.schangeTimes,vueThis.summary.changeTimes, 1, 5,options);
			 changeTimes.start(); 
			 //$("#changeTimes").css("-webkit-animation","zoomsa 2s ease-out 3");
			 var enterTimes = new CountUp("enterTimesa", vueThis.summary.senterTimes,vueThis.summary.enterTimes, 1, 5,options);
			 enterTimes.start(); 
			 //$("#enterTimes").css("-webkit-animation","zoomsa 2s ease-out 3");
			//var hpfwAmount = new CountUp("hpfwAmount", vueThis.summary.shpfwAmount,vueThis.summary.hpfwAmount, 1, 5,options);
			 //hpfwAmount.start(); 
			 
			  var mchangeTimes = new CountUp("mchangeTimesa", vueThis.summary.smchangeTimes,vueThis.summary.mchangeTimes, 1, 5,options);
			 mchangeTimes.start(); 
			// $("#mchangeTimes").css("-webkit-animation","zoomsa 2s ease-out 3");
			 var menterTimes = new CountUp("menterTimesa", vueThis.summary.smenterTimes,vueThis.summary.menterTimes, 1, 5,options);
			 menterTimes.start(); 
			// $("#menterTimes").css("-webkit-animation","zoomsa 2s ease-out 3");
			 var mpfwAmount = new CountUp("mpfwAmounta", vueThis.summary.smpfwAmount,vueThis.summary.mpfwAmount, 1, 5,options);
			 mpfwAmount.start(); 
			 //$("#mpfwAmount").css("-webkit-animation","zooms 2s ease-out 3");
			}else{
				var pfwAmount = new CountUp("pfwAmounta", vueThis.summary.spfwAmount,vueThis.summary.pfwAmount, 1, 300,options);
				pfwAmount.start(); 
				 //$("#pfwAmount").css("-webkit-animation","zoomsb 2s ease-out 150");
				 
				 var changeTimes = new CountUp("changeTimesa", vueThis.summary.schangeTimes,vueThis.summary.changeTimes, 1, 300,options);
				 changeTimes.start(); 
				 var enterTimes = new CountUp("enterTimesa", vueThis.summary.senterTimes,vueThis.summary.enterTimes, 1, 300,options);
				 enterTimes.start(); 
				//var hpfwAmount = new CountUp("hpfwAmount", vueThis.summary.shpfwAmount,vueThis.summary.hpfwAmount, 1, 300,options);
				 //hpfwAmount.start(); 
				 
				  var mchangeTimes = new CountUp("mchangeTimesa", vueThis.summary.smchangeTimes,vueThis.summary.mchangeTimes, 1, 300,options);
				 mchangeTimes.start(); 
				 var menterTimes = new CountUp("menterTimesa", vueThis.summary.smenterTimes,vueThis.summary.menterTimes, 1, 300,options);
				 menterTimes.start(); 
				 var mpfwAmount = new CountUp("mpfwAmounta", vueThis.summary.smpfwAmount,vueThis.summary.mpfwAmount, 1, 300,options);
				 mpfwAmount.start(); 
				  
			 
			 }
		  },
		  //客流查询打开
		  openDate:function(){
		  	var vueThis=this;
		  	vueThis.datechos=true;
		  },
		  //按日期查询国庆线路客流
		  getGqlflow:function(){
		  
		  },
		  getRefreshStationData:function(startTime,compareTime,modelId,subModelName){
			  
		  },
		  //按日期查询国庆车站客流
		  getGqzflow:function(){
		  	 var vueThis=this;
		  	 vueThis.fsDate1=moment(vueThis.fsDate1).format("YYYYMMDD");
		  		 vueThis.fsDate2=moment(vueThis.fsDate2).format("YYYYMMDD");
		  		 document.getElementById('isnflwa').contentWindow.upOnlineFlow(vueThis.fsDate1,vueThis.fsDate2);
		  },
		  //按日期查询分时客流
		  getFsflow:function(){
		  var vueThis=this;
		  vueThis.fsdt1ms=vueThis.fsDate1;
		  vueThis.fsdt2ms=vueThis.fsDate2;
		  	vueThis.fsDate1=moment(vueThis.fsDate1).format("YYYYMMDD");
		  		 vueThis.fsDate2=moment(vueThis.fsDate2).format("YYYYMMDD");
		  		 document.getElementById('isnflwa').contentWindow.upOnlineFlow(vueThis.fsDate1,vueThis.fsDate2);
		  		 document.getElementById('fsklrk').contentWindow.upLineRankData(vueThis.fsDate1,vueThis.fsDate2);
		  	console.log('分时日期1'+vueThis.fsDate1+'分时日期2'+vueThis.fsDate2);
		  	vueThis.fsDate1=vueThis.fsdt1ms;
		  	vueThis.fsDate2=vueThis.fsdt2ms;
		  },
		   //按日期查询实时在网客流
		  getOlflow:function(){
		  		var vueThis=this;
		  		vueThis.oldt1ms=vueThis.olDate1;
		  		vueThis.oldt2ms=vueThis.olDate2;
		  		vueThis.olDate1=moment(vueThis.olDate1).format("YYYYMMDD");
		  		vueThis.olDate2=moment(vueThis.olDate2).format("YYYYMMDD");
		  		document.getElementById('onlfla').contentWindow.upFlow(vueThis.olDate1,vueThis.olDate2);
		  		document.getElementById('qyklsw').contentWindow.upLineRankData(vueThis.olDate1,vueThis.olDate2);
		  		vueThis.olDate1=vueThis.oldt1ms;
		  		vueThis.olDate2=vueThis.oldt2ms;
		  },
		  //总客流查询
		  getFlow:function(){
		  		var vueThis=this;
		  		if(vueThis.compDate==''){
		  		  		vueThis.compDate=vueThis.aweekdate;
		  		  }
		  		vueThis.tmdtms=vueThis.temDate;
		  		vueThis.cpdtms=vueThis.compDate;
		  		vueThis.temDates=moment(vueThis.temDate).format("YYYYMMDD");
		  		 vueThis.compDates=moment(vueThis.compDate).format("YYYYMMDD");
		  		 
		  		 vueThis.temDt=vueThis.temDates.substring(0, 4) + "." + vueThis.temDates.substring(4, 6) + "." + vueThis.temDates.substring(6);
				vueThis.compDt=vueThis.compDates.substring(0, 4) + "." + vueThis.compDates.substring(4, 6) + "." +vueThis.compDates.substring(6);
		  		  
		  		$.post("sumflw/GetpfwSmy.action",{"hour":vueThis.hournow,"date":vueThis.temDates,"compDate":vueThis.compDates,"size":18}, function(data){
					
					if(data.ascRate!=""){
						vueThis.summary.asshow=true;
						vueThis.summary.dsshow=false;
						vueThis.summary.ascRate=data.ascRate;
						$("#asds").css("color",'red');
						$("#asd").css("color",'red');
					}
					if(data.dscRate!=""){
						vueThis.summary.dsshow=true;
						vueThis.summary.asshow=false;
						vueThis.summary.ascRate=data.dscRate;
						$("#asds").css("color",'#03A781');
						$("#asd").css("color",'#03A781');
						
					}
					
					vueThis.datechos=false;
					vueThis.summary.changeTimes=data.changeTimes;
					vueThis.summary.enterTimes=data.enterTimes;
					vueThis.summary.pfwAmount=data.pfwAmount;
					vueThis.summary.mchangeTimes=data.mchangeTimes;
					vueThis.summary.menterTimes=data.menterTimes;
					vueThis.summary.mpfwAmount=data.mpfwAmount;
					vueThis.summary.hpfwAmount=data.hpfwAmount;
					
					 vueThis.Numcounts();
					 vueThis.Numcount();
					 
					
			     
				}); 
		  
		  			vueThis.temDate=vueThis.tmdtms;
		  			vueThis.compDate=vueThis.cpdtms;
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
		  czklDetl:function(){
		  		var vueThis=this;
		  		vueThis.isShow=true;
		  		vueThis.fsklsw=false;
		  		vueThis.qyklsw=false;
		  		vueThis.xlpmsw=false;
		  		vueThis.czklsw=true;
		  		vueThis.zdczsw=false;
		  		vueThis.cocclinesw=false;
		  		vueThis.coccStationsw=false;
		  		vueThis.czydsw=false;
		  		vueThis.vssisw=false;
		  		vueThis.klzfsw=false;
		  		vueThis.modalTitle='进博会“三站”客流占比';
		  		vueThis.zklquery=false;
		  },
		  coccLineDetl:function(){
			  	var vueThis=this;
		  		vueThis.isShow=true;
		  		vueThis.fsklsw=false;
		  		vueThis.qyklsw=false;
		  		vueThis.xlpmsw=false;
		  		vueThis.czklsw=false;
	  		    vueThis.czydsw=false;
	  		    vueThis.zdczsw=false;
	  		    vueThis.zdczsw=true;
		  		vueThis.coccStationsw=false;
		  		vueThis.vssisw=false;
		  		vueThis.klzfsw=false;
		  		vueThis.modalTitle='进博会OD客流排名';
		  		vueThis.zklquery=false;
		  },
		  //分时客流缩放
		  klzfDetl:function(){
		  	var vueThis=this;
		  		 vueThis.isShow=true;
		  		 vueThis.fsklsw=false;
		  		 vueThis.qyklsw=false;
		  		 vueThis.xlpmsw=false;
		  		 vueThis.czklsw=false;
		  		  vueThis.czydsw=false;
		  		  vueThis.zdczsw=false;
		  		vueThis.coccStationsw=false;
		  		  vueThis.vssisw=false;
		  		  vueThis.klzfsw=true;
		  		
		  		vueThis.modalTitle='分时累计客流';
		  },
		  //实  时  客  流
		  vssiDetl:function(){
		  	var vueThis=this;
		  		 vueThis.isShow=true;
		  		 vueThis.fsklsw=false;
		  		 vueThis.qyklsw=false;
		  		 vueThis.xlpmsw=false;
		  		 vueThis.czklsw=false;
		  		  vueThis.czydsw=false;
		  		  vueThis.zdczsw=false;
		  		vueThis.coccStationsw=false;
		  		  vueThis.vssisw=true;
		  		  vueThis.klzfsw=false;
		  		
		  		vueThis.modalTitle='上海地铁实时客流';
		  },
		  //进博会OD客流排名
		  czydDetl:function(){
		  	 var vueThis=this;
		  	 vueThis.isShow=true;
		  	 vueThis.fsklsw=false;
	  		 vueThis.qyklsw=false;
	  		 vueThis.xlpmsw=false;
	  		 vueThis.czklsw=false;
	  		 vueThis.czydsw=true;
		  	 vueThis.zdczsw=false;
		  	 vueThis.coccStationsw=false;
		  	 vueThis.vssisw=false;
		  	 vueThis.klzfsw=false;
		  	 vueThis.modalTitle='重点关注车站客流';
		  	 vueThis.zklquery=false;
		  	 
// 		  	$("#zdczrk").html($("#aaa").html());
// 		  	setTimeout(function(){
// 		  		$(".gqcza")[1].contentWindow.showParam();
// 		  	},500);
		  	
		  	//$("#zdczrk").children()[0].contentWindow.showParam();
// 		  	document.getElementById('gqcza').contentWindow.showParam();
// 		  	document.getElementById('gqcza').contentWindow.klpm();  
		  },
		  onFull:function(){
			 $('#fullsc').css('left','312px');
			 $('#fullsc').css('transform','scale(1.5)');
		  },
		  //数据总览
		  fsklDetl:function(){
		  	var vueThis=this;
		  		 vueThis.isShow=true;
		  		 vueThis.fsklsw=true;
		  		 vueThis.qyklsw=false;
		  		 vueThis.xlpmsw=false;
		  		 vueThis.czklsw=false;
		  		 vueThis.zdczsw=false;
		  		vueThis.coccStationsw=false;
		  		 vueThis.vssisw=false;
		  		 vueThis.czydsw=false;
		  		 vueThis.klzfsw=false;
		  		
		      vueThis.modalTitle='数据总览';
		      vueThis.zklquery=true;
		  },
		  qyklDetl:function(){
		  	var vueThis=this;
		  		 vueThis.isShow=true;
		  		 vueThis.qyklsw=true;
		  		 vueThis.xlpmsw=false;
		  		 vueThis.fsklsw=false;
		  		 vueThis.czklsw=false;
		  		 vueThis.zdczsw=false;
		  		 //vueThis.cocclinesw=false;
		  		vueThis.coccStationsw=false;
		  		 vueThis.czydsw=false;
		  		 vueThis.vssisw=false;
		  		 vueThis.klzfsw=false;
		  		
		      vueThis.modalTitle='实时在网客流';
		      vueThis.zklquery=false;
				
					
		  },
		  //车站分时客流放大
		  xlpmDetl:function(){
		  	var vueThis=this;
		      vueThis.isShow=true;
		      vueThis.qyklsw=false;
		  		 vueThis.xlpmsw=true;
		  		 vueThis.fsklsw=false;
		  		 vueThis.czklsw=false;
		  		 vueThis.zdczsw=false;
		  		 vueThis.vssisw=false;
		  		vueThis.coccStationsw=false;
		  		 vueThis.czydsw=false;
		      vueThis.klzfsw=false;
		      vueThis.modalTitle='';
		     vueThis.zklquery=false;
	      	//document.getElementById('xlrank').contentWindow.alpm();  
		  },
		  onClose:function() {
				$('#cocc_view').val('1');
			    $('#fullsc').css('left','312px');
			  	$('#fullsc').css('transform','scale(1)');
				this.isShow = false;
				this.datechos=false;
		  },
		  //获取数据总览数据
		  getPFWsmy:function(){
		  		var vueThis=this;
		
		  		var week_date="<%=week_date%>";
		  		var selTypes=[1,3];
				
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
				vueThis.temDt=vueThis.adate;
				vueThis.compDt=vueThis.aweekdate;
				vueThis.temDt=vueThis.temDt.substring(0, 4) + "." + vueThis.temDt.substring(4, 6) + "." + vueThis.temDt.substring(6);
				vueThis.compDt=vueThis.compDt.substring(0, 4) + "." + vueThis.compDt.substring(4, 6) + "." + vueThis.compDt.substring(6);
				$.post("sumflw/GetpfwSmy.action",{"hour":vueThis.hournow,"date":vueThis.adate,"compDate":vueThis.aweekdate,"size":18}, function(data){
					if(data.ascRate!=""){
						vueThis.summary.asshow=true;
						vueThis.summary.dsshow=false;
						vueThis.summary.ascRate=data.ascRate;
						$("#asd").css("color",'red');
						$("#asds").css("color",'red');
					}
					if(data.dscRate!=""){
						vueThis.summary.dsshow=true;
						vueThis.summary.asshow=false;
						vueThis.summary.ascRate=data.dscRate;
						$("#asd").css("color",'#03A781');
						$("#asds").css("color",'#03A781');
						
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
		  
		  //判断当前时间 产生日期
		  makedate:function(){
		  		var datesc =  Date.now();
		  		var date;
		  		date= new Date(parseInt(Date.now()));
               var nowHours= new Date().getHours().toString();       //获取当前小时数(0-23)
               if(nowHours >= 0 && nowHours <= 2){
                		this.hournow="last";
                		
                	
                	 var sed=datesc- 3600 * 1000 * 24;
                	 this.temDate=sed;
                	  date=new Date(parseInt(sed));
                }
                var year = date.getFullYear();
                var month = (date.getMonth() + 1).toString();;
                var strDate = date.getDate().toString();
                 if(month >= 1 && month <= 9){
                    month = "0" + month;
                }
                 
                if (strDate >= 0 && strDate <= 9) {
                    strDate = "0" + strDate;
                }
                 var cpd;
                 if(nowHours >= 0 && nowHours <= 2){
                  cpd=datesc- 3600 * 1000 * 24*8;
                 	var cpyear=new Date(parseInt(datesc- 3600 * 1000 * 24*8)).getFullYear();
                var cpDate=new Date(parseInt(datesc- 3600 * 1000 * 24*8)).getDate().toString();
                var cpmonth=(new Date(parseInt(datesc- 3600 * 1000 * 24*8)).getMonth() + 1).toString();
                 }else{
                  cpd=datesc- 3600 * 1000 * 24*7;
                 cpyear=new Date(parseInt(datesc- 3600 * 1000 * 24*7)).getFullYear();
                 cpDate=new Date(parseInt(datesc- 3600 * 1000 * 24*7)).getDate().toString();
                 cpmonth=(new Date(parseInt(datesc- 3600 * 1000 * 24*7)).getMonth() + 1).toString();
                 }
                 this.compDate=cpd;
                if(cpmonth >= 1 && cpmonth <= 9){
                    cpmonth = "0" + cpmonth;
                }
                 if (cpDate >= 0 && cpDate <= 9) {
                    cpDate = "0" + cpDate;
                }
                var secd;
                if(nowHours >= 0 && nowHours <= 2){
                	secd=datesc- 3600 * 1000 * 24*3;
                var secyear=new Date(parseInt(datesc- 3600 * 1000 * 24*3)).getFullYear();
                var secDate=new Date(parseInt(datesc- 3600 * 1000 * 24*3)).getDate().toString();
                var secmonth=(new Date(parseInt(datesc- 3600 * 1000 * 24*3)).getMonth() + 1).toString();
                	
                }else{
                secd=datesc- 3600 * 1000 * 24*2;
                 secyear=new Date(parseInt(datesc- 3600 * 1000 * 24*2)).getFullYear();
                 secDate=new Date(parseInt(datesc- 3600 * 1000 * 24*2)).getDate().toString();
                 secmonth=(new Date(parseInt(datesc- 3600 * 1000 * 24*2)).getMonth() + 1).toString();
                 }
                 this.fsDate2=secd;
                if(secmonth >= 1 && secmonth <= 9){
                    secmonth = "0" + secmonth;
                }
                 if (secDate >= 0 && secDate <= 9) {
                    secDate = "0" + secDate;
                }
                 var fird;
                if(nowHours >= 0 && nowHours <= 2){
                fird=datesc- 3600 * 1000 * 24*2;
                	var firyear=new Date(parseInt(datesc- 3600 * 1000 * 24*2)).getFullYear();
                var firDate=new Date(parseInt(datesc- 3600 * 1000 * 24*2)).getDate().toString();
                var firmonth=(new Date(parseInt(datesc- 3600 * 1000 * 24*2)).getMonth() + 1).toString();
                }else{
                fird=datesc- 3600 * 1000 * 24;
                  firyear=new Date(parseInt(datesc- 3600 * 1000 * 24)).getFullYear();
                firDate=new Date(parseInt(datesc- 3600 * 1000 * 24)).getDate().toString();
               firmonth=(new Date(parseInt(datesc- 3600 * 1000 * 24)).getMonth() + 1).toString();
               }
                this.fsDate1=fird;
                if(firmonth >= 1 && firmonth <= 9){
                    firmonth = "0" + firmonth;
                }
                 if (firDate >= 0 && firDate <= 9) {
                    firDate = "0" + firDate;
                }
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
                this.firdate=firyear + firmonth + firDate;
               this.secdate=secyear + secmonth + secDate;
                
               this.adata=this.temDate;
               this.olDate1=Date.now();
               this.olDate2=cpd;
		  },
		  
		  //获取当前时间
            getNowFormatnow:function() {
                var vuThis=this;
                var date = new Date();
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
                vuThis.when=now;
                var nowMina= new Date().getMinutes(); 
                  if (nowMina >= 0 && nowMina <= 9) {
                    nowMina = "0" + nowMina;
                }
                var whens=nowHours+":"+nowMina;
                vuThis.whens=whens;
                var date= year + month + strDate;
                var dates= year +"."+ month +"."+ strDate;
                vuThis.dates=dates;
                 vuThis.date=date;
                return currentdate;
            }
            
		    }
		  
		});
		

      </script>
  </body>
</html>