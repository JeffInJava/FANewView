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
	
	<script src="resource/jquery/js/jquery-1.9.1.min.js"></script>
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
			src: url("resource/SourceHanSansCNLight/SourceHanSansCN-Light.woff2") format("woff2"),
			url("resource/SourceHanSansCNLight/SourceHanSansCN-Light.woff") format("woff"),
			url("resource/SourceHanSansCNLight/SourceHanSansCN-Light.ttf") format("truetype"),
			url("resource/SourceHanSansCNLight/SourceHanSansCN-Light.eot") format("embedded-opentype"),
			url("resource/SourceHanSansCNLight/SourceHanSansCN-Light.svg") format("svg");
			font-weight: normal;
			font-style: normal;
		}
		html,body{margin: 0;padding: 0;font-family:'SourceHanSansCN-Light' }
   	
   	body{background: url("resource/images/syntheboard/bg-02.png") no-repeat;min-width: 1920px;min-height: 1080px;}
   	/* 定义液晶字体 */
	@font-face {
		font-family: 'LCD_Font';
		src: url('resource/lcd_num_font/digital-7-italic.eot'); /* IE9 Compat Modes */
		src: url('resource/lcd_num_font/digital-7-italic.eot?#iefix') format('embedded-opentype'), /* IE6-IE8 */
		url('resource/lcd_num_font/digital-7-italic.woff') format('woff'), /* Modern Browsers */
		url('resource/lcd_num_font/digital-7-italic.ttf')  format('truetype'), /* Safari, Android, iOS */
		url('resource/lcd_num_font/digital-7-italic.svg') format('svg'); /* Legacy iOS */

	}
	/* 使用液晶字体 */
	.lcd{
		font-family: "LCD_Font";
	}
	#sjzl{
		background: url(resource/images/pasflw/sjzlbackground.png) no-repeat;
		 width: 658px;
            height: 159px;
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
	top: 180px;
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
	 .animate {
        padding-left: 20px;
        font-size: 12px;
        color: #000;
        display: inline-block;
        white-space: nowrap;
        animation: 10s wordsLoop linear infinite normal;
    }

    @keyframes wordsLoop {
        0% {
            transform: translateX(150px);
            -webkit-transform: translateX(150px);
        }
        100% {
            transform: translateX(-100%);
            -webkit-transform: translateX(-100%);
        }
    }

    @-webkit-keyframes wordsLoop {
        0% {
            transform: translateX(150px);
            -webkit-transform: translateX(150px);
        }
        100% {
            transform: translateX(-100%);
            -webkit-transform: translateX(-100%);
        }
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
        
         @-webkit-keyframes twinkling{
            0%{
                opacity: 0;
            }
            50%{
                opacity: 0.6;
            }
            100%{
                opacity: 1;
            }
        }
        @keyframes twinkling{
            0%{
                opacity: 0;
            }
            50%{
                opacity: 0.6;
            }
            100%{
                opacity: 1;
            }
        }
        
        .wave{
  		animation: twinkling 1.5s ease-out  5;
  		-webkit-animation: twinkling 1.5s ease-out  5;
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
  	  		<div style="margin-left: 895px;
				    margin-top: 8px;
				    color: #02FFBB;
				    font-size: 30px;
				    font-weight: 550;
				    float: left;
				    position: absolute;">
  	  			综 合 看 板
  	  		</div>
  	  	</el-row>
  	  	<el-row>
	  	  	<el-col :span="8">
		  	  	<el-row>
	  	  			<div style="float: left;margin-top: 17px;margin-left: 33px;">
	                	<img src="resource/images/syntheboard/shujuzonglan_title.png" alt=""/>
	           		 </div>		
	  	  		</el-row>
	  	  		<el-row>
	  	  			<div style="float: left;margin-top: 0px;margin-left: 46px;background: url(resource/images/syntheboard/shujuzonglan_label.png) no-repeat; width: 370px;
							height: 155px;">
						<el-row>
							<div style="color: #ffffff;font-size: 16px;float: left;
											    width: 180px;margin-left: 0px;margin-top: 0px;
											    text-align: center;
											    height:105px;">
									<el-row>
					  	  				<div id="pfwAmount" class="lcd" style="float: left;margin-top: 35px;margin-left: 45px;font-size: 36px;color:#00FF73">
								  	  				{{summary.pfwAmount}}
								  	  	</div>
								  	  		<div class="lcd" style="float: left;margin-top: 50px;margin-left: 5px;font-size: 16px;color:#ffffff">
								  	  				万
								  	  		</div>
					  	  			</el-row>
					  	  			<el-row>
								  	  		<div class="" style="float: left;margin-top: 50px;margin-left: 5px;font-size: 16px;color:#6CA797;text-align: center;
								  	  				font-weight: bold;width: 180px;">
								  	  				总 客 流
								  	  		</div>
					  	  			</el-row>
					                		
					           </div>
					           <div style="color: #ffffff;font-size: 16px;float: left;
											    width: 180px;margin-left: 0px;margin-top: 0px;
											    text-align: center;
											    height:105px;">
					           					<el-row>
										  	  		<div style="width:130px;height:40px;float: left;margin-top: 5px;margin-left: 32px;">
										  	  			<div style="float: left;margin-top: 11px;margin-left: 0px;font-size: 13px;color:#6CA797">
										  	  				进站
										  	  			</div>
										  	  			<div id="enterTimes" class="lcd" style="float: left;margin-top: 5px;margin-left: 13px;font-size: 28px;color:#02FAB8">
										  	  				{{summary.enterTimes}}
										  	  			</div>
										  	  			<div class="lcd" style="float: left;margin-top: 13px;margin-left: 15px;font-size: 12px;color:#ffffff">
										  	  				万
										  	  			</div>
										  	  			<div style="float: left;position: absolute;margin-top: 17px;">
									                		<img src="resource/images/syntheboard/line.png" alt=""/>
									           		 	</div>	
										  	  		</div>
									  	  				
									  	  		</el-row>
									  	  		<el-row>
										  	  		<div style="width:130px;height:40px;float: left;margin-top: 5px;margin-left: 32px;">
										  	  			<div style="float: left;margin-top: 11px;margin-left: 0px;font-size: 13px;color:#6CA797">
										  	  				换乘
										  	  			</div>
										  	  			<div id="changeTimes" class="lcd" style="float: left;margin-top: 5px;margin-left: 13px;font-size: 28px;color:#02FAB8">
										  	  				{{summary.changeTimes}}
										  	  			</div>
										  	  			<div class="lcd" style="float: left;margin-top: 13px;margin-left: 15px;font-size: 12px;color:#ffffff">
										  	  				万
										  	  			</div>
										  	  			<div style="float: left;position: absolute;margin-top: 17px;">
									                		<img src="resource/images/syntheboard/line.png" alt=""/>
									           		 	</div>	
										  	  		</div>
									  	  				
									  	  		</el-row>
									  	  		<el-row>
										  	  		<div style="width:130px;height:40px;float: left;margin-top: 15px;margin-left: 32px;">
										  	  			<div id="asd" class="" style="float: left;margin-top: 3px;margin-left: 66px;font-size: 14px;color:#03A781">
										  	  				{{summary.ascRate}}
										  	  			</div>
										  	  			<div  v-show="summary.asshow" style="float: right;margin-top: 0px;margin-right: 10px;">
									                		<img src="resource/images/pasflw/asce.png" alt=""/>
									           		 	</div>
									           		 	<div v-show="summary.dsshow" style="float: right;margin-top: 0px;margin-right: 10px;">
									                		<img src="resource/images/pasflw/desc.png" alt=""/>
									           		 	</div>
										  	  		</div>
									  	  				
									  	  		</el-row>
									  	 </div>
	                	</el-row>
	           		 </div>
	           		 <div style="float: left;margin-top: 0px;margin-left: 10px;background: url(resource/images/syntheboard/shujuzonglan_label.png) no-repeat; width: 186px;
							height: 155px;">
	                	<div style="color: #ffffff;font-size: 16px;float: left;
											    width: 180px;margin-left: 0px;margin-top: 0px;
											    text-align: center;
											    height:105px;">
									<el-row>
					  	  				<div id="mpfwAmount" class="lcd" style="float: left;margin-top: 35px;margin-left: 45px;font-size: 36px;color:#00FF73">
								  	  				{{summary.mpfwAmount}}
								  	  	</div>
								  	  		<div class="lcd" style="float: left;margin-top: 50px;margin-left: 5px;font-size: 16px;color:#ffffff">
								  	  				万
								  	  		</div>
					  	  			</el-row>
					  	  			<el-row>
								  	  		<div class="" style="float: left;margin-top: 50px;margin-left: 5px;font-size: 16px;color:#6CA797;text-align: center;
								  	  				font-weight: bold;width: 180px;">
								  	  				同 期 客 流 量
								  	  		</div>
					  	  			</el-row>
					                		
					           </div>
	           		 </div>			
	  	  		</el-row>
	  	  		<el-row>
	  	  			<div style="width:260px;height:80px;float: left;margin-top: 15px;margin-left: 48px;">
	  	  				<div style="float: left;margin-top:12px;margin-left: 0px;font-weight: bolder;font-size: 18px;color:#6CA797">
										  	  				客流历史峰值：
										  	  			</div>
										  	  			<div id="hpfwAmount" class="lcd" style="float: left;margin-top: 8px;margin-left: 13px;font-size: 30px;color:#02FAB8">
										  	  				{{summary.hpfwAmount}}
										  	  			</div>
										  	  			<div class="lcd" style="float: left;margin-top: 12px;margin-left: 10px;font-size: 18px;color:#ffffff">
										  	  				万
										  	  			</div>
	  	  				</div>
	  	  				<div style="float: left;margin-top:25px;margin-left: 10px;font-weight: bolder;font-size: 20px;color:#6CA797">
										  	  				{{summary.hdate}}
										  	  			</div>
	  	  				
	  	  		</el-row>
		  	  	<!-- <el-row>
		  	  			<div style="width:190px;height:30px;float: left;margin-top: 5px;margin-left: 48px;">
		  	  				<div style="float: left;margin-top:8px;margin-left: 0px;font-weight: bolder;font-size: 15px;color:#6CA797">
											  	  				平均运距：
											  	  			</div>
											  	  			<div class="lcd" style="float: left;margin-top: 8px;margin-left: 13px;font-size: 20px;color:#02FAB8">
											  	  				591.5
											  	  			</div>
											  	  			<div class="lcd" style="float: left;margin-top: 10px;margin-left: 10px;font-size: 13px;color:#ffffff">
											  	  				万
											  	  			</div>
		  	  				</div>
		  	  				<div style="float: left;margin-top:13px;margin-left: 10px;font-weight: bolder;font-size: 16px;color:#6CA797">
											  	  				对比：
											  	  			</div>
											  	  			<div style="float: left;margin-top:13px;margin-left: 10px;font-weight: bolder;font-size: 16px;color:#ffffff">
											  	  				12.5%
											  	  			</div>
											  	  			<div  v-show="summary.lasshow" style="float: right;margin-top: 0px;margin-left: 5px;">
									                		<img src="resource/images/pasflw/asce.png" alt=""/>
									           		 	</div>
									           		 	<div v-show="summary.ldsshow" style="float: right;margin-top: 0px;margin-left: 5px;">
									                		<img src="resource/images/pasflw/desc.png" alt=""/>
									           		 	</div>
		  	  				
		  	  		</el-row>
		  	  		<el-row>
		  	  			<div style="width:190px;height:30px;float: left;margin-top: 5px;margin-left: 48px;">
		  	  				<div style="float: left;margin-top:8px;margin-left: 0px;font-weight: bolder;font-size: 15px;color:#6CA797">
											  	  				平均票价：
											  	  			</div>
											  	  			<div class="lcd" style="float: left;margin-top: 8px;margin-left: 13px;font-size: 20px;color:#02FAB8">
											  	  				591.5
											  	  			</div>
											  	  			<div class="lcd" style="float: left;margin-top: 10px;margin-left: 10px;font-size: 13px;color:#ffffff">
											  	  				万
											  	  			</div>
		  	  				</div>
		  	  				<div style="float: left;margin-top:13px;margin-left: 10px;font-weight: bolder;font-size: 16px;color:#6CA797">
											  	  				对比：
											  	  			</div>
											  	  			<div style="float: left;margin-top:13px;margin-left: 10px;font-weight: bolder;font-size: 16px;color:#ffffff">
											  	  				12.5%
											  	  			</div>
											  	  			<div  v-show="summary.lasshow" style="float: right;margin-top: 0px;margin-left: 5px;">
									                		<img src="resource/images/pasflw/asce.png" alt=""/>
									           		 	</div>
									           		 	<div v-show="summary.ldsshow" style="float: right;margin-top: 0px;margin-left: 5px;">
									                		<img src="resource/images/pasflw/desc.png" alt=""/>
									           		 	</div>
		  	  				
		  	  		</el-row> -->
		  	  		<el-row>
		  	  			<div style="float: left;margin-top: 17px;margin-left: 33px;">
		                	<img src="resource/images/syntheboard/shebeizhuangkuang_title.png" alt=""/>
		           		 </div>		
	  	  			</el-row>
	  	  			<el-row>
	  	  				<div style="float: left;margin-top: 0px;margin-left: 0px; width: 193px;
							height: 280px;">
	  	  					<div style="float: left;margin-top: 0px;margin-left: 38px;background: url(resource/images/syntheboard/shebgzcount.png) no-repeat; width: 193px;
							height: 250px;">
								<div style="float: left;margin-top: 0px;margin-left: 0px; width: 193px;height: 40px;">
									<div  style="float: left;margin-top: 5px;margin-left: 12px; width: 80px;height: 40px;font-weight: bolder;font-size: 16px;color:#6CA797;text-align: center">
										设备总数
									</div>
									<div class="lcd" style="float: left;margin-top: 7px;margin-left: 12px; width: 50px;height: 40px;font-size: 20px;color:#00FF73;text-align: center">
										{{tot}}
									</div>
									<div style="float: left;margin-top: 7px;margin-left: 0px; width: 30px;height: 30px;font-size: 13px;color:#ffffff;text-align: center">
										台
									</div>
								</div>
								<div style="float: left;margin-top: 33px;margin-left: 5px; width: 193px;height: 40px;">
									<div  style="float: left;margin-top: 5px;margin-left: 17px; width: 60px;height: 40px;font-weight: bolder;font-size: 16px;color:#6CA797;text-align: center">
										闸机
									</div>
									<div class="" style="float: left;margin-top: 0px;margin-left: 0px; width: 50px;height: 30px;border: 1px solid #047C67;">
										<div class="lcd" style="float: left;margin-top: 5px;margin-left: 2px; width: 45px;height: 25px;font-size: 20px;color:#00FF73;text-align: center">
										{{gm}}
										</div>
									</div>
									<div style="float: left;margin-top: 7px;margin-left: 0px; width: 30px;height: 30px;font-size: 13px;color:#ffffff;text-align: center">
										台
									</div>
								</div>
								<div style="float: left;margin-top: 12px;margin-left: 5px; width: 193px;height: 40px;">
									<div  style="float: left;margin-top: 5px;margin-left: 17px; width: 60px;height: 40px;font-weight: bolder;font-size: 16px;color:#6CA797;text-align: center">
										TVM
									</div>
									<div class="" style="float: left;margin-top: 0px;margin-left: 0px; width: 50px;height: 30px;border: 1px solid #047C67;">
										<div class="lcd" style="float: left;margin-top: 5px;margin-left: 2px; width: 45px;height: 25px;font-size: 20px;color:#00FF73;text-align: center">
										{{vm}}
										</div>
									</div>
									<div style="float: left;margin-top: 7px;margin-left: 0px; width: 30px;height: 30px;font-size: 13px;color:#ffffff;text-align: center">
										台
									</div>
								</div>
								<div style="float: left;margin-top: 12px;margin-left: 5px; width: 193px;height: 40px;">
									<div  style="float: left;margin-top: 5px;margin-left: 17px; width: 60px;height: 40px;font-weight: bolder;font-size: 16px;color:#6CA797;text-align: center">
										CVM
									</div>
									<div class="" style="float: left;margin-top: 0px;margin-left: 0px; width: 50px;height: 30px;border: 1px solid #047C67;">
										<div class="lcd" style="float: left;margin-top: 5px;margin-left: 2px; width: 45px;height: 25px;font-size: 20px;color:#00FF73;text-align: center">
										{{cm}}
										</div>
									</div>
									<div style="float: left;margin-top: 7px;margin-left: 0px; width: 30px;height: 30px;font-size: 13px;color:#ffffff;text-align: center">
										台
									</div>
								</div>
								<div style="float: left;margin-top: 15px;margin-left: 5px; width: 193px;height: 40px;">
									<div  style="float: left;margin-top: 5px;margin-left: 17px; width: 60px;height: 40px;font-weight: bolder;font-size: 16px;color:#6CA797;text-align: center">
										BOM
									</div>
									<div class="" style="float: left;margin-top: 0px;margin-left: 0px; width: 50px;height: 30px;border: 1px solid #047C67;">
										<div class="lcd" style="float: left;margin-top: 5px;margin-left: 2px; width: 45px;height: 25px;font-size: 20px;color:#00FF73;text-align: center">
										{{bm}}
										</div>
									</div>
									<div style="float: left;margin-top: 7px;margin-left: 0px; width: 30px;height: 30px;font-size: 13px;color:#ffffff;text-align: center">
										台
									</div>
								</div>
							</div>
	  	  				</div>
	  	  				<div style="float: left;margin-top: 0px;margin-left: 38px; width: 150px;display:none;
							height: 260px;">
								<div style="float: left;margin-top: 0px;margin-left: 15px; width: 150px;
								height: 120px;">
									<div style="float: left;margin-top: 0px;margin-left:0px; width: 150px;
									height: 35px;">
										<div  style="float: left;margin-top: 5px;margin-left: 0px; width: 80px;height: 30px;font-weight: bolder;font-size: 15px;color:#6CA797;text-align: center">
											异常设备
										</div>
									</div>
									<div style="float: left;margin-top: 0px;margin-left:0px; width: 150px;
									height: 25px;">
										<div  style="float: left;margin-top: 0px;margin-left: 0px; width: 60px;height: 30px;font-weight: bolder;font-size: 14px;color:#00FF73;text-align: center">
											12.35
										</div>
									</div>
									<div style="float: left;margin-top: 0px;margin-left:0px; width: 150px;
									height: 25px;">
										<div  style="float: left;margin-top: 0px;margin-left: 0px; width: 60px;height: 30px;font-weight: bolder;font-size: 14px;color:#00FF73;text-align: center">
											12.35
										</div>
									</div>
									<div style="float: left;margin-top: 0px;margin-left:0px; width: 150px;
									height: 25px;">
										<div  style="float: left;margin-top: 0px;margin-left: 0px; width: 60px;height: 30px;font-weight: bolder;font-size: 14px;color:#00FF73;text-align: center">
											12.35
										</div>
									</div>
									<div style="float: left;margin-top: 0px;margin-left:0px; width: 150px;
									height: 25px;">
										<div  style="float: left;margin-top: 0px;margin-left: 0px; width: 60px;height: 30px;font-weight: bolder;font-size: 14px;color:#00FF73;text-align: center">
											12.35
										</div>
									</div>
								</div>
								<div style="float: left;margin-top: 15px;margin-left: 15px; width: 150px;
								height: 120px;">
									<div style="float: left;margin-top: 0px;margin-left:0px; width: 150px;
									height: 35px;">
										<div  style="float: left;margin-top: 5px;margin-left: 0px; width: 80px;height: 30px;font-weight: bolder;font-size: 15px;color:#6CA797;text-align: center">
											异常设备
										</div>
									</div>
									<div style="float: left;margin-top: 0px;margin-left:0px; width: 150px;
									height: 25px;">
										<div  style="float: left;margin-top: 0px;margin-left: 0px; width: 60px;height: 30px;font-weight: bolder;font-size: 14px;color:#00FF73;text-align: center">
											12.35
										</div>
									</div>
									<div style="float: left;margin-top: 0px;margin-left:0px; width: 150px;
									height: 25px;">
										<div  style="float: left;margin-top: 0px;margin-left: 0px; width: 60px;height: 30px;font-weight: bolder;font-size: 14px;color:#00FF73;text-align: center">
											12.35
										</div>
									</div>
									<div style="float: left;margin-top: 0px;margin-left:0px; width: 150px;
									height: 25px;">
										<div  style="float: left;margin-top: 0px;margin-left: 0px; width: 60px;height: 30px;font-weight: bolder;font-size: 14px;color:#00FF73;text-align: center">
											12.35
										</div>
									</div>
									<div style="float: left;margin-top: 0px;margin-left:0px; width: 150px;
									height: 25px;">
										<div  style="float: left;margin-top: 0px;margin-left: 0px; width: 60px;height: 30px;font-weight: bolder;font-size: 14px;color:#00FF73;text-align: center">
											12.35
										</div>
									</div>
								</div>
							</div>
							<div style="float: left;margin-top: 0px;margin-left: 120px; width: 260px;
							height: 280px;">
								<div id="sbstat" style="float: left;margin-top: 0px;margin-left: -10px; width: 260px;
									height: 260px;">
							
								</div>
							</div>
		  	  		</el-row>
	  	  	</el-col>
	  	  	
			<el-col :span="8">
	  	  		<el-row>
	  	  			<div style="float: left;margin-top: 42px;margin-left: 220px;" @click="fsklDetl()">
	                	<img src="resource/images/pasflw/qsfkltj.png" alt=""/>
	           		 </div>		
	  	  		</el-row>
	  	  		<el-row>
	  	  			<div style="float: left;
					    margin-top: 0px;
					    margin-left: 8px;
					    width: 626px;
					    height: 240px;">
					    <div id="fskla" style="width: 626px; height: 70%;"></div>
					    <div id="fsklb" style="width: 626px; height: 30%;"></div>
					   
	                	
	           		 </div>		
	  	  		</el-row>
	  	  		<el-row>
	  	  			<!-- <div style="float: left;margin-top: 3px;margin-left: 0px;">
	                	 <img src="resource/images/syntheboard/equistat.png" alt=""/>
	           		 </div> -->	 
	           		<div style="float: left;margin-top: 3px;margin-left: 0px;background: url(resource/images/syntheboard/topoBG.png) no-repeat; width: 622px;
							height: 338px;">
	                	 <div style="float: left;margin-top: 20px;margin-left: 10px; width: 60px;height: 180px;">
	                	 	<div style="float: left;margin-top: 0px;margin-left: 17px; width: 40px;height: 40px;font-size: 12px;color:#ffffff;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.90);">
	                	 		SC
	                	 	</div>
	                	 	<div style="float: left;margin-top: -32px;margin-left: 0px; width: 60px;height: 50px;font-size: 12px;color:#ffffff;">
	                	 		<img  class="" src="resource/images/syntheboard/1-27.png" style="" alt=""/>
	                	 	</div>
	                	 	<div style="float: left;margin-top: 0px;margin-left: 6px; width: 20px;height: 100px;font-size: 12px;color:#ffffff;">
	                	 		<div style="float: left;margin-top: -5px;margin-left: 6px; width: 13px;height: 70px;font-size: 12px;color:#ffffff;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.70);">
	                	 			同步上传异步收容
	                	 		</div>
	                	 		<div style="float: left;margin-top: -7px;margin-left: 0px; width: 1px;height: 60px;background-color: #ffffff;">
	                	 		</div>
	                	 		<div style="float: left;margin-top: 1px;margin-left: 0px; width: 1px;height: 60px;background-color: #ffffff;">
	                	 		</div>
	                	 	</div>
	                	 	<div style="float: left;margin-top: 7px;margin-left: 0px; width: 60px;height: 50px;font-size: 12px;color:#ffffff;">
	                	 		<img src="resource/images/syntheboard/1-27.png" style="" alt=""/>
	                	 	</div>
	                	 	<div style="float: left;margin-top: -9px;margin-left: 19px; width: 40px;height: 40px;font-size: 12px;color:#ffffff;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.90);">
	                	 		LC
	                	 	</div>
	                	 </div>
	                	 <div style="float: left;margin-top: 131px;margin-left: -35px; width: 50px;height:1px;background-color: #ffffff;">
	                	 </div>
	                	 <div style="float: left;margin-top: 68px;margin-left: -35px; width:110px;height:80px;">
	                	 	<div  style="float: left;margin-top: 37px;margin-left: 29px; width: 60px;height: 50px;font-size: 12px;color:#ffffff;">
	                	 		<img id="mcc"src="resource/images/syntheboard/1-28.png" style="" alt=""/>
	                	 	</div>
	                	 	<div  style="float: left;margin-top: -9px;margin-left: 15px; width: 110px;height: 30px;font-size: 12px;color:#ffffff;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.70);">
	                	 		ACC/MCC综合前置
	                	 	</div>
	                	 </div>
	                	 <div style="float: left;margin-top: 131px;margin-left: -41px; width: 40px;height:40px;">
	                	 	 <div style="float: left;margin-top: 0px;margin-left: 1px; width: 40px;height:1px;background-color: #ffffff;">
	                	 	 </div>
	                	 	 <div style="float: left;margin-top: -3px;margin-left: 7px; width: 50px;height:30px;font-size: 12px;color:#ffffff;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.60);">
	                	 		交易入库
	                	 	</div>
	                	 </div>
	                	 <div style="float: left;margin-top: 20px;margin-left: -4px; width: 60px;height: 180px;">
	                	 	<div style="float: left;margin-top: 0px;margin-left: 10px; width: 40px;height: 40px;font-size: 12px;color:#ffffff;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.90);">
	                	 		云更新
	                	 	</div>
	                	 	<div  style="float: left;margin-top: -35px;margin-left: 3px; width: 60px;height: 50px;font-size: 12px;color:#ffffff;">
	                	 		<img id="cloudupd" src="resource/images/syntheboard/1-37.png" style="" alt=""/>
	                	 	</div>
	                	 	<div style="float: left;margin-top: 20px;margin-left: 10px; width: 50px;height: 30px;">
	                	 		<div style="float: left;margin-top: -22px;margin-left: 17px; width: 1px;height:30px;background-color: #ffffff;">
	                	 	 	</div>
		                	 	<div  style="float: left;margin-top: -25px;margin-left: 19px; width: 50px;height: 30px;font-size: 12px;color:#ffffff;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.70);">
		                	 		云更新
		                	 	</div>
	                	 	</div>
	                	 	<div style="float: left;margin-top: -25px;margin-left: 2px; width: 60px;height: 50px;font-size: 12px;color:#ffffff;">
	                	 		<img id="frontdb"src="resource/images/syntheboard/1-29.png" style="" alt=""/>
	                	 	</div>
	                	 	<div id="" style="float: left;margin-top: -7px;margin-left: 8px; width: 60px;height: 40px;font-size: 12px;color:#ffffff;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.70);">
	                	 		前置数据库
	                	 	</div>
	                	 </div>
	                	 <div style="float: left;margin-top: 131px;margin-left: -11px; width: 40px;height:40px;">
	                	 	 <div style="float: left;margin-top: 0px;margin-left: 1px; width: 40px;height:1px;background-color: #ffffff;">
	                	 	 </div>
	                	 	 <div style="float: left;margin-top: -3px;margin-left: 7px; width: 50px;height:30px;font-size: 12px;color:#ffffff;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.60);">
	                	 		读取数据
	                	 	</div>
	                	 </div>
	                	 <div style="float: left;margin-top: 79px;margin-left: -3px; width: 60px;height:80px;">
	                	 	<div style="float: left;margin-top: 0px;margin-left: 10px; width: 50px;height: 30px;">
	                	 		<div style="float: left;margin-top: -22px;margin-left: 17px; width: 1px;height:50px;background-color: #ffffff;">
	                	 	 	</div>
		                	 	<div style="float: left;margin-top: -35px;margin-left: 19px; width: 50px;height: 30px;font-size: 12px;color:#ffffff;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.70);">
		                	 		段分发
		                	 	</div>
	                	 	</div>
	                	 	<div style="float: left;margin-top: -5px;margin-left: 2px; width: 60px;height: 50px;font-size: 12px;color:#ffffff;">
	                	 		<img id="finaop"src="resource/images/syntheboard/1-38.png" style="" alt=""/>
	                	 	</div>
	                	 	<div style="float: left;margin-top: -12px;margin-left: 8px; width: 60px;height: 40px;font-size: 12px;color:#ffffff;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.70);">
	                	 		财务处理
	                	 	</div>
	                	 </div>
	                	 <div style="float: left;margin-top: 131px;margin-left: -11px; width: 40px;height:40px;">
	                	 	 <div style="float: left;margin-top: 0px;margin-left: 1px; width: 40px;height:1px;background-color: #ffffff;">
	                	 	 </div>
	                	 	 <div style="float: left;margin-top: -3px;margin-left: 7px; width: 50px;height:30px;font-size: 12px;color:#ffffff;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.60);">
	                	 		清分处理
	                	 	</div>
	                	 </div>
	                	 <div style="float: left;margin-top: 20px;margin-left: -4px; width: 60px;height: 180px;">
	                	 	<div style="float: left;margin-top: 3px;margin-left: -4px; width: 60px;height: 40px;">
	                	 		<div style="float: left;position: absolute;margin-top: 33px;margin-left: -54px; width: 50px;height:1px;background-color: #ffffff;">
	                	 	 	</div>
		                	 	<div style="float: left;margin-top: -3px;margin-left: 10px; width: 50px;height: 40px;font-size: 12px;color:#ffffff;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.90);">
		                	 		应用管理
		                	 	</div>
	                	 	</div>
	                	 	<div style="float: left;margin-top: -35px;margin-left: 3px; width: 60px;height: 50px;font-size: 12px;color:#ffffff;">
	                	 		<img id="appmana"src="resource/images/syntheboard/1-30.png" style="" alt=""/>
	                	 	</div>
	                	 	<div style="float: left;margin-top: 20px;margin-left: 10px; width: 50px;height: 30px;">
	                	 		<div style="float: left;margin-top: -22px;margin-left: 17px; width: 1px;height:30px;background-color: #ffffff;">
	                	 	 	</div>
		                	 	
	                	 	</div>
	                	 	<div style="float: left;margin-top: -25px;margin-left: 2px; width: 60px;height: 50px;font-size: 12px;color:#ffffff;">
	                	 		<img id="finadb"src="resource/images/syntheboard/1-29.png" style="" alt=""/>
	                	 	</div>
	                	 	<div style="float: left;margin-top: -7px;margin-left: 8px; width: 60px;height: 40px;font-size: 12px;color:#ffffff;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.70);">
	                	 		财务数据库
	                	 	</div>
	                	 	<div style="float: left;margin-top: 0px;margin-left: 10px; width: 50px;height: 30px;">
	                	 		<div style="float: left;margin-top: -20px;margin-left: -18px; width: 50px;height: 30px;font-size: 12px;color:#ffffff;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.70);">
		                	 		打包转发
		                	 	</div>
	                	 		<div style="float: left;margin-top: -22px;margin-left: -15px; width: 1px;height:30px;background-color: #ffffff;">
	                	 	 	</div>
		                	 	
	                	 	</div>
	                	 	<div style="float: left;margin-top: -25px;margin-left: 2px; width: 60px;height: 50px;font-size: 12px;color:#ffffff;">
	                	 		<img id="qffront" src="resource/images/syntheboard/1-29.png" style="" alt=""/>
	                	 	</div>
	                	 	<div style="float: left;margin-top: -9px;margin-left: 3px; width: 80px;height: 40px;font-size: 12px;color:#ffffff;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.70);">
	                	 		清分对外前置
	                	 	</div>
	                	 	<div style="float: left;margin-top: -22px;margin-left: 27px; width: 1px;height:15px;background-color: #ffffff;">
	                	 	</div>
	                	 	<div style="float: left;margin-top: -9px;margin-left: -48px; width: 150px;height:2px;">
	                	 		<div style="float: left;margin-top: 0px;margin-left: 0px; width: 74px;height:1px;background-color: #ffffff;">
	                	 		</div>
	                	 		<div style="float: left;margin-top: 0px;margin-left: 2px; width: 74px;height:1px;background-color: #ffffff;">
	                	 		</div>
	                	 	</div>
	                	 	<div style="float: left;margin-top: -9px;margin-left: -58px; width: 150px;height:2px;">
	                	 		<div style="float: left;margin-top: 0px;margin-left: 0px; width: 50px;height:2px;">
	                	 			<div style="float: left;margin-top: 0px;margin-left: 5px; width: 50px;height: 30px;">
			                	 		<div style="float: left;margin-top: 0px;margin-left: 5px; width: 1px;height:10px;background-color: #ffffff;">
			                	 	 	</div>
			                	 	</div>
			                	 	<div style="float: left;margin-top: -25px;margin-left: -13px; width: 60px;height: 50px;font-size: 12px;color:#ffffff;">
			                	 		<img id="tc"src="resource/images/syntheboard/1-32.png" style="" alt=""/>
			                	 	</div>
			                	 	<div style="float: left;margin-top: -10px;margin-left: -2px; width: 80px;height: 40px;font-size: 12px;color:#ffffff;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.70);">
			                	 		通畅
			                	 	</div>
	                	 		</div>
	                	 		<div style="float: left;margin-top: 0px;margin-left: 25px; width: 50px;height:2px;">
	                	 			<div style="float: left;margin-top: 0px;margin-left: 5px; width: 50px;height: 30px;">
			                	 		<div style="float: left;margin-top: 0px;margin-left: 5px; width: 1px;height:10px;background-color: #ffffff;">
			                	 	 	</div>
			                	 	</div>
			                	 	<div style="float: left;margin-top: -25px;margin-left: -13px; width: 60px;height: 50px;font-size: 12px;color:#ffffff;">
			                	 		<img id="ty"src="resource/images/syntheboard/1-32.png" style="" alt=""/>
			                	 	</div>
			                	 	<div style="float: left;margin-top: -10px;margin-left: 2px; width: 80px;height: 40px;font-size: 12px;color:#ffffff;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.70);">
			                	 		通银
			                	 	</div>
	                	 		</div>
	                	 		<div style="float: left;margin-top: 0px;margin-left: 149px; width: 50px;height:2px;">
	                	 			<div style="float: left;margin-top: 0px;margin-left: 5px; width: 50px;height: 30px;">
			                	 		<div style="float: left;margin-top: -1px;margin-left: 5px; width: 1px;height:10px;background-color: #ffffff;">
			                	 	 	</div>
			                	 	</div>
			                	 	<div style="float: left;margin-top: -25px;margin-left: -13px; width: 60px;height: 50px;font-size: 12px;color:#ffffff;">
			                	 		<img id="transcard" src="resource/images/syntheboard/1-41.png" style="" alt=""/>
			                	 	</div>
			                	 	<div style="float: left;margin-top:-10px;margin-left: 2px; width: 80px;height: 40px;font-size: 12px;color:#ffffff;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.70);">
			                	 		交通卡
			                	 	</div>
	                	 		</div>
	                	 	</div>
	                	 </div>
	                	 <div style="float: left;margin-top: 30px;margin-left: 84px; width: 60px;height: 180px;">
	                	 	<div style="float: left;margin-top: -25px;margin-left: 2px; width: 60px;height: 50px;font-size: 12px;color:#ffffff;">
	                	 		<img src="resource/images/syntheboard/1-29.png" style="" alt=""/>
	                	 	</div>
	                	 	<div style="float: left;margin-top: -9px;margin-left: 3px; width: 80px;height: 40px;font-size: 12px;color:#ffffff;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.70);">
	                	 		清分对外前置
	                	 	</div>
	                	 	<div style="float: left;margin-top: -22px;margin-left: 27px; width: 1px;height:15px;background-color: #ffffff;">
	                	 	</div>
	                	 	<div style="float: left;margin-top: -9px;margin-left: -48px; width: 150px;height:2px;">
	                	 		<div style="float: left;margin-top: 0px;margin-left: 0px; width: 74px;height:1px;background-color: #ffffff;">
	                	 		</div>
	                	 		<div style="float: left;margin-top: 0px;margin-left: 2px; width: 74px;height:1px;background-color: #ffffff;">
	                	 		</div>
	                	 	</div>
	                	 	<div style="float: left;margin-top: -9px;margin-left: -58px; width: 150px;height:2px;">
	                	 		<div style="float: left;margin-top: 0px;margin-left: 0px; width: 50px;height:2px;">
	                	 			<div style="float: left;margin-top: 0px;margin-left: 5px; width: 50px;height: 30px;">
			                	 		<div style="float: left;margin-top: 0px;margin-left: 5px; width: 1px;height:10px;background-color: #ffffff;">
			                	 	 	</div>
			                	 	</div>
			                	 	<div style="float: left;margin-top:-25px;margin-left: -13px; width: 60px;height: 50px;font-size: 12px;color:#ffffff;">
			                	 		<img src="resource/images/syntheboard/1-42.png" style="" alt=""/>
			                	 	</div>
			                	 	<div style="float: left;margin-top: -10px;margin-left: -5px; width: 80px;height: 40px;font-size: 12px;color:#ffffff;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.70);">
			                	 		润乾报表
			                	 	</div>
	                	 		</div>
	                	 		<div style="float: left;margin-top: 0px;margin-left: 25px; width: 50px;height:2px;">
	                	 			<div style="float: left;margin-top: 0px;margin-left: 5px; width: 50px;height: 30px;">
			                	 		<div style="float: left;margin-top: 0px;margin-left: 5px; width: 1px;height:10px;background-color: #ffffff;">
			                	 	 	</div>
			                	 	</div>
			                	 	<div style="float: left;margin-top: -25px;margin-left: -13px; width: 60px;height: 50px;font-size: 12px;color:#ffffff;">
			                	 		<img src="resource/images/syntheboard/1-34.png" style="" alt=""/>
			                	 	</div>
			                	 	<div style="float: left;margin-top: -10px;margin-left: -12px; width: 80px;height: 40px;font-size: 12px;color:#ffffff;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.70);">
			                	 		票务管理平台
			                	 	</div>
			                	 	<div style="float: left;margin-top: 0px;margin-left: -5px; width: 50px;height: 30px;">
			                	 		<div style="float: left;margin-top: -22px;margin-left: 17px; width: 1px;height:50px;background-color: #ffffff;">
			                	 	 	</div>
				                	 	<div style="float: left;margin-top: -35px;margin-left: 19px; width: 50px;height: 30px;font-size: 12px;color:#ffffff;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.70);">
				                	 		HTTP
				                	 	</div>
			                	 	</div>
			                	 	<div style="float: left;margin-top: -5px;margin-left: -12px; width: 60px;height: 50px;font-size: 12px;color:#ffffff;">
			                	 		<img src="resource/images/syntheboard/1-38.png" style="" alt=""/>
			                	 	</div>
			                	 	<div style="float: left;margin-top: -12px;margin-left: 1px; width: 60px;height: 40px;font-size: 12px;color:#ffffff;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.70);">
			                	 		客户端
			                	 	</div>
	                	 		</div>
	                	 		<div style="float: left;margin-top: 0px;margin-left: 149px; width: 50px;height:2px;">
	                	 			<div style="float: left;margin-top: 0px;margin-left: 5px; width: 50px;height: 30px;">
			                	 		<div style="float: left;margin-top: -1px;margin-left: 5px; width: 1px;height:10px;background-color: #ffffff;">
			                	 	 	</div>
			                	 	</div>
			                	 	<div style="float: left;margin-top: -25px;margin-left: -13px; width: 60px;height: 50px;font-size: 12px;color:#ffffff;">
			                	 		<img src="resource/images/syntheboard/1-43.png" style="" alt=""/>
			                	 	</div>
			                	 	<div style="float: left;margin-top: -10px;margin-left: -5px; width: 80px;height: 40px;font-size: 12px;color:#ffffff;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.70);">
			                	 		数据采集
			                	 	</div>
			                	 	<div style="float: left;margin-top: 0px;margin-left: -5px; width: 50px;height: 30px;">
			                	 		<div style="float: left;margin-top: -22px;margin-left: 17px; width: 1px;height:50px;background-color: #ffffff;">
			                	 	 	</div>
				                	 	<div style="float: left;margin-top: -35px;margin-left: 0px; width: 50px;height: 30px;font-size: 12px;color:#ffffff;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.70);">
				                	 		FTP
				                	 	</div>
			                	 	</div>
			                	 	<div style="float: left;margin-top: -5px;margin-left: -12px; width: 60px;height: 50px;font-size: 12px;color:#ffffff;">
			                	 		<img src="resource/images/syntheboard/1-38.png" style="" alt=""/>
			                	 	</div>
			                	 	<div style="float: left;margin-top: -12px;margin-left: 8px; width: 60px;height: 40px;font-size: 12px;color:#ffffff;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.70);">
			                	 		SC
			                	 	</div>
	                	 		</div>
	                	 	</div>
	                	 </div>
	           		 </div>	
	  	  		</el-row>
	  	  	</el-col>
	  	  	<el-col :span="8">
		  	  	<el-row>
	  	  			<div style="float: left;margin-top: 17px;margin-left: 17px;">
	                	<img src="resource/images/syntheboard/TVM_title.png" alt=""/>
	           		 </div>		
	  	  		</el-row>
	  	  		<el-row>
	  	  			<div style="float: left;margin-top: -7px;margin-left: 17px;background: url(resource/images/syntheboard/TVM_frame.png) no-repeat; width: 600px;
							height: 168px;">
						<div style="float: left;margin-top: -7px;margin-left: 10px; width: 180px;height: 168px;">
							<div style="float: left;margin-top: 25px;margin-left: 0px; width: 180px;height: 40px;">
								<div id="preTimes" class="lcd" style="float: left;margin-top: 0px;margin-left: 25px;font-size: 36px;color:#00FF73">
									  	  				{{preTimes}}
									  	  	</div>
									  	  		<div class="lcd" style="float: left;margin-top: 12px;margin-left: 10px;font-size: 14px;color:#ffffff">
									  	  				当天
									  	  		</div>
							</div>
							<div style="float: left;margin-top: 0px;margin-left: 0px; width: 180px;height: 40px;">
								<div id="befTimes" class="lcd" style="float: left;margin-top: 0px;margin-left: 25px;font-size: 36px;color:#00FF73">
									  	  				{{befTimes}}
									  	  	</div>
									  	  		<div class="lcd" style="float: left;margin-top: 12px;margin-left: 10px;font-size: 14px;color:#ffffff">
									  	  				前天
									  	  		</div>
							</div>
							<div style="float: left;margin-top: 28px;margin-left:0px; width: 180px;
										height: 40px;">
									<div style="float: left;margin-top:0px;margin-left: 0px;font-weight: bold;width: 180px;text-align:center; font-size: 16px;color:#6CA797">
											总笔数
											  	  			</div>
											  	  			
											  	  				  	  				
								</div>
					 	</div>
					 	<div style="float: left;margin-top: -7px;margin-left: 10px; width: 180px;height: 168px;">
							<div style="float: left;margin-top: 25px;margin-left: 0px; width: 180px;height: 40px;">
								<div id="preAmount" class="lcd" style="float: left;margin-top: 0px;margin-left: 25px;font-size: 36px;color:#00FF73">
									  	  				{{preAmount}}
									  	  	</div>
									  	  		<div class="lcd" style="float: left;margin-top: 12px;margin-left: 10px;font-size: 14px;color:#ffffff">
									  	  				当天
									  	  		</div>
							</div>
							<div style="float: left;margin-top: 0px;margin-left: 0px; width: 180px;height: 40px;">
								<div id="befAmount" class="lcd" style="float: left;margin-top: 0px;margin-left: 25px;font-size: 36px;color:#00FF73">
									  	  				{{befAmount}}
									  	  	</div>
									  	  		<div class="lcd" style="float: left;margin-top: 12px;margin-left: 10px;font-size: 14px;color:#ffffff">
									  	  				前天
									  	  		</div>
							</div>
							<div style="float: left;margin-top: 28px;margin-left:0px; width: 180px;
										height: 40px;">
									<div style="float: left;margin-top:0px;margin-left: 0px;font-weight: bold;width: 180px;text-align:center; font-size: 16px;color:#6CA797">
											总金额(元)
											  	  			</div>
											  	  			
											  	  				  	  				
								</div>
					 	</div>
					 	<div style="float: left;margin-top: -7px;margin-left: 10px; width: 180px;height: 168px;">
							<div style="float: left;margin-top: 25px;margin-left: 0px; width: 180px;height: 40px;">
								<div id="preNums" class="lcd" style="float: left;margin-top: 0px;margin-left: 25px;font-size: 36px;color:#00FF73">
									  	  				{{preNums}}
									  	  	</div>
									  	  		<div class="lcd" style="float: left;margin-top: 12px;margin-left: 10px;font-size: 14px;color:#ffffff">
									  	  				当天
									  	  		</div>
							</div>
							<div style="float: left;margin-top: 0px;margin-left: 0px; width: 180px;height: 40px;">
								<div id="befNums" class="lcd" style="float: left;margin-top: 0px;margin-left: 25px;font-size: 36px;color:#00FF73">
									  	  				{{befNums}}
									  	  	</div>
									  	  		<div class="lcd" style="float: left;margin-top: 12px;margin-left: 10px;font-size: 14px;color:#ffffff">
									  	  				前天
									  	  		</div>
							</div>
							<div style="float: left;margin-top: 28px;margin-left:0px; width: 180px;
										height: 40px;">
									<div style="float: left;margin-top:0px;margin-left: 0px;font-weight: bold;width: 180px;text-align:center; font-size: 16px;color:#6CA797">
											售出数(张)
											  	  			</div>
											  	  			
											  	  				  	  				
								</div>
					 	</div>	
					 </div>		
	  	  		</el-row>
	  	  		<el-row>
	  	  			<div style="float: left;margin-top: 0px;margin-left: 17px;width: 600px;height: 90px;">
	  	  				<div style="float: left;margin-top: 0px;margin-left: 0px;width: 40px;height: 80px;">
	                		<div style="float: left;margin-top: 10px;margin-left: 7px;">
			                	<img src="resource/images/syntheboard/TVM_zhifubao_icon.png" alt=""/>
			           		 </div>
			           		 <div style="float: left;margin-top: 10px;margin-left: 7px;">
			                	<img src="resource/images/syntheboard/TVM_yinlian_icon.png" alt=""/>
			           		 </div>
	           		 	</div>
	           		 	<div style="float: left;margin-top: 0px;margin-left: 0px;width: 160px;height: 80px;">
	           		 		<div class="lcd" style="float: left;margin-top: 5px;margin-left: 10px;height: 20px;width: 160px;font-size: 12px;color:#6CA797">
									  	  				总笔数
							</div>
							<div class="lcd" style="float: left;margin-top: -8px;margin-left: 10px;height: 30px;width: 160px;font-size: 14px;color:#6CA797">
								<div class="lcd" style="float: left;margin-top: 5px;margin-left: 0px;height: 20px;width: 40px;font-size: 12px;color:#6CA797">
									  支付宝	  				
								</div>
								<div id="payTimes" class="lcd" style="float: left;margin-top: 0px;margin-left: 5px;height: 30px;width: 100px;font-size: 28px;color:#00FF73">
									 {{payTimes}}	  				
								</div>		  	  				
							</div>
							<div style="float: left;margin-top: 33px;margin-left: 0px;    position: absolute;">
			                	<img src="resource/images/syntheboard/TVM_line2.png" alt=""/>
			           		 </div>
							<div class="lcd" style="float: left;margin-top: 5px;margin-left: 10px;height: 30px;width: 160px;font-size: 14px;color:#6CA797">
								<div class="lcd" style="float: left;margin-top: 5px;margin-left: 0px;height: 20px;width: 40px;font-size: 12px;color:#6CA797">
									  银联  				
								</div>
								<div id="unionTime" class="lcd" style="float: left;margin-top: 0px;margin-left: 5px;height: 30px;width: 100px;font-size: 28px;color:#00FF73">
									  {{unionTime}}	  				
								</div>		  	  				
							</div>
	                	</div>
	                	<div style="float: left;margin-top: 0px;margin-left: 25px;width: 160px;height: 80px;">
	           		 		<div class="lcd" style="float: left;margin-top: 5px;margin-left: 10px;height: 20px;width: 160px;font-size: 12px;color:#6CA797">
									  	  				总金额
							</div>
							<div class="lcd" style="float: left;margin-top: -8px;margin-left: 10px;height: 30px;width: 160px;font-size: 14px;color:#6CA797">
								<div class="lcd" style="float: left;margin-top: 5px;margin-left: 0px;height: 20px;width: 40px;font-size: 12px;color:#6CA797">
									  支付宝	  				
								</div>
								<div id="payAmount" class="lcd" style="float: left;margin-top: 0px;margin-left: 5px;height: 30px;width: 100px;font-size: 28px;color:#00FF73">
									  {{payAmount}}	  				
								</div>		  	  				
							</div>
							<div style="float: left;margin-top: 33px;margin-left: 0px;    position: absolute;">
			                	<img src="resource/images/syntheboard/TVM_line2.png" alt=""/>
			           		 </div>
							<div class="lcd" style="float: left;margin-top: 5px;margin-left: 10px;height: 30px;width: 160px;font-size: 14px;color:#6CA797">
								<div class="lcd" style="float: left;margin-top: 5px;margin-left: 0px;height: 20px;width: 40px;font-size: 12px;color:#6CA797">
									  银联  				
								</div>
								<div id="unionAmount" class="lcd" style="float: left;margin-top: 0px;margin-left: 5px;height: 30px;width: 100px;font-size: 28px;color:#00FF73">
									 {{unionAmount}}  				
								</div>		  	  				
							</div>
	                	</div>
	                	<div style="float: left;margin-top: 0px;margin-left: 25px;width: 160px;height: 80px;">
	           		 		<div class="lcd" style="float: left;margin-top: 5px;margin-left: 10px;height: 20px;width: 160px;font-size: 12px;color:#6CA797">
									  	  				售出数(张)
							</div>
							<div class="lcd" style="float: left;margin-top: -8px;margin-left: 10px;height: 30px;width: 160px;font-size: 14px;color:#6CA797">
								<div class="lcd" style="float: left;margin-top: 5px;margin-left: 0px;height: 20px;width: 40px;font-size: 12px;color:#6CA797">
									  支付宝	  				
								</div>
								<div id="payNums" class="lcd" style="float: left;margin-top: 0px;margin-left: 5px;height: 30px;width: 100px;font-size: 28px;color:#00FF73">
									  {{payNums}}  				
								</div>		  	  				
							</div>
							<div style="float: left;margin-top: 33px;margin-left: 0px;    position: absolute;">
			                	<img src="resource/images/syntheboard/TVM_line2.png" alt=""/>
			           		 </div>
							<div class="lcd" style="float: left;margin-top: 5px;margin-left: 10px;height: 30px;width: 160px;font-size: 14px;color:#6CA797">
								<div class="lcd" style="float: left;margin-top: 5px;margin-left: 0px;height: 20px;width: 40px;font-size: 12px;color:#6CA797">
									  银联  				
								</div>
								<div id="unionNums" class="lcd" style="float: left;margin-top: 0px;margin-left: 5px;height: 30px;width: 100px;font-size: 28px;color:#00FF73">
									  {{unionNums}}	  				
								</div>		  	  				
							</div>
	                	</div>
	           		 </div>		
	  	  		</el-row>
	  	  		<el-row>
	  	  			<div style="float: left;margin-top: 17px;margin-left: 17px;">
	                	<img src="resource/images/syntheboard/erweimajianyi_title.png" alt=""/>
	           		 </div>		
	  	  		</el-row>
	  	  		<el-row>
	  	  			<div style="float: left;margin-top: -7px;margin-left: 10px; width: 600px;height: 268px;">
	  	  				<div style="float: left;margin-top: 0px;margin-left: 10px; width: 380px;height: 268px;">
	  	  					<div style="float: left;margin-top: 7px;margin-left: 5px;background: url(resource/images/syntheboard/Below_label.png) no-repeat; width: 368px;
							height: 132px;">
								<div style="float: left;margin-top: -7px;margin-left: 10px; width: 180px;height: 132px;">
									<div style="float: left;margin-top: 0px;margin-left: 0px; width: 180px;height: 25px;">
										
											  	  		<div class="lcd" style="float: left;margin-top: 15px;margin-left: 130px;font-size: 13px;color:#ffffff">
											  	  				{{whens}}
											  	  		</div>
									</div>
									<div style="float: left;margin-top: 13px;margin-left: 0px; width: 180px;height: 40px;">
										<div id="qrcdAll" class="lcd" style="float: left;margin-top: 0px;margin-left: 25px;font-size: 36px;color:#00FF73">
											  	  				{{qrcdAll}}
											  	  	</div>
											  	  		<div class="lcd" style="float: left;margin-top: 12px;margin-left: 10px;font-size: 14px;color:#ffffff">
											  	  				万
											  	  		</div>
									</div>
									<div style="float: left;margin-top: 20px;margin-left:0px; width: 180px;
												height: 40px;">
											<div style="float: left;margin-top:8px;margin-left: -10px;font-weight: bold;width: 180px;text-align:center; font-size: 16px;color:#6CA797">
													实时客流
													  	  			</div>
													  	  			
													  	  				  	  				
										</div>
							 	</div>
							 	<div style="float: left;margin-top: -7px;margin-left: 20px; width: 150px;height: 132px;">
							 		<div style="width:130px;height:40px;float: left;margin-top: 20px;margin-left: 0px;">
										  	  			<div style="float: left;margin-top: 11px;margin-left: 0px;font-size: 13px;color:#6CA797">
										  	  				进站
										  	  			</div>
										  	  			<div id="qrcdent" class="lcd" style="float: left;margin-top: 5px;margin-left: 13px;font-size: 28px;color:#02FAB8">
										  	  				{{qrcdent}}
										  	  			</div>
										  	  			<div class="lcd" style="float: left;margin-top: 13px;margin-left: 23px;font-size: 12px;color:#ffffff">
										  	  				万
										  	  			</div>
										  	  		</div>
									<div style="width:130px;height:40px;float: left;margin-top: 0px;margin-left: 0px;">
										  	  			<div style="float: left;margin-top: 11px;margin-left: 0px;font-size: 13px;color:#6CA797">
										  	  				出站
										  	  			</div>
										  	  			<div id="qrcdexit" class="lcd" style="float: left;margin-top: 5px;margin-left: 13px;font-size: 28px;color:#02FAB8">
										  	  				{{qrcdexit}}
										  	  			</div>
										  	  			<div class="lcd" style="float: left;margin-top: 13px;margin-left: 23px;font-size: 12px;color:#ffffff">
										  	  				万
										  	  			</div>
										  	  		</div>
							 	</div>
	           				</div>
	           				<div style="float: left;margin-top: 3px;margin-left: 5px;background: url(resource/images/syntheboard/Upper_label.png) no-repeat; width: 370px;
							height: 148px;">
								<div style="width:120px;height:148px;float: left;margin-top: 0px;margin-left: 0px;">
									<div style="float: left;margin-top: 15px;margin-left:7px; width: 110px;
									height: 30px;">
										<div style="float: left;margin-top:0px;margin-left: 0px;font-weight: bolder;font-size: 15px;color:#6CA797">
												进站：
												  	  			</div>
												  	  			<div id="zfbe" class="lcd" style="float: left;margin-top: 0px;margin-left: 0px;font-size: 20px;color:#02FAB8">
												  	  				{{zfb.ENTER_TIMES}} 
												  	  			</div>
												  	  					  	  				
									</div>
									<div style="float: left;margin-top: 3px;margin-left:7px; width: 110px;
									height: 30px;">
										<div style="float: left;margin-top:0px;margin-left: 0px;font-weight: bolder;font-size: 15px;color:#6CA797">
												出站：
												  	  			</div>
												  	  			<div id="zfbx" class="lcd" style="float: left;margin-top: 0px;margin-left: 0px;font-size: 20px;color:#02FAB8">
												  	  				{{zfb.EXIT_TIMES}} 
												  	  			</div>
												  	  					  	  				
									</div>
									<div style="float: left;margin-top: 5px;margin-left:7px; width: 120px;
									height: 30px;">
										<div style="float: left;margin-top:0px;margin-left: 0px;font-weight: bolder;font-size: 15px;color:#6CA797">
												合计：
												  	  			</div>
												  	  			<div id="zfbm" class="lcd" style="float: left;margin-top: 0px;margin-left: 0px;font-size: 20px;color:#02FAB8">
												  	  				{{zfb.ENTER_TIMES+zfb.EXIT_TIMES}}
												  	  			</div>
												  	  					  	  				
									</div>
									<div style="float: left;margin-top:3px;margin-left: 10px;font-weight: bold;width: 110px;text-align:center; font-size: 16px;color:#6CA797">
													<div style="float: left;margin-top:2px;margin-left: 8px;font-weight: bold;width: 30px;text-align:center; font-size: 16px;color:#6CA797">
														<img src="resource/images/syntheboard/icon_01.png" alt=""/>
													  	  			</div>
													<div style="float: left;margin-top:1px;margin-left: 0px;font-weight: bold;width: 60px;text-align:center; font-size: 16px;color:#6CA797">
													支付宝
													  	  			</div>
													  	  			</div>
								</div>
								<div style="width:110px;height:148px;float: left;margin-top: 0px;margin-left: 6px;">
									<div style="float: left;margin-top: 15px;margin-left:7px; width: 110px;
									height: 30px;">
										<div style="float: left;margin-top:0px;margin-left: 0px;font-weight: bolder;font-size: 15px;color:#6CA797">
												进站：
												  	  			</div>
												  	  			<div id="upaye" class="lcd" style="float: left;margin-top: 0px;margin-left: 0px;font-size: 20px;color:#02FAB8">
												  	  				{{upay.ENTER_TIMES}} 
												  	  			</div>
												  	  					  	  				
									</div>
									<div style="float: left;margin-top: 3px;margin-left:7px; width: 110px;
									height: 30px;">
										<div style="float: left;margin-top:0px;margin-left: 0px;font-weight: bolder;font-size: 15px;color:#6CA797">
												出站：
												  	  			</div>
												  	  			<div id="upayx" class="lcd" style="float: left;margin-top: 0px;margin-left: 0px;font-size: 20px;color:#02FAB8">
												  	  				{{upay.EXIT_TIMES}} 
												  	  			</div>
												  	  					  	  				
									</div>
									<div style="float: left;margin-top: 5px;margin-left:7px; width: 110px;
									height: 30px;">
										<div style="float: left;margin-top:0px;margin-left: 0px;font-weight: bolder;font-size: 15px;color:#6CA797">
												合计：
												  	  			</div>
												  	  			<div id="upaym" class="lcd" style="float: left;margin-top: 0px;margin-left: 0px;font-size: 20px;color:#02FAB8">
												  	  				{{upay.ENTER_TIMES+upay.EXIT_TIMES}} 
												  	  			</div>
												  	  					  	  				
									</div>
									<div style="float: left;margin-top:3px;margin-left: 10px;font-weight: bold;width: 110px;text-align:center; font-size: 16px;color:#6CA797">
													<div style="float: left;margin-top:2px;margin-left: 10px;font-weight: bold;width: 30px;text-align:center; font-size: 16px;color:#6CA797">
														<img src="resource/images/syntheboard/icon_02.png" alt=""/>
													  	  			</div>
													<div style="float: left;margin-top:1px;margin-left: 0px;font-weight: bold;width: 50px;text-align:center; font-size: 16px;color:#6CA797">
													银联
													  	  			</div>
													  	  			</div>
								</div>
								<div style="width:110px;height:148px;float: left;margin-top: 0px;margin-left: 13px;">
									<div style="float: left;margin-top: 15px;margin-left:7px; width: 110px;
									height: 30px;">
										<div style="float: left;margin-top:0px;margin-left: 0px;font-weight: bolder;font-size: 15px;color:#6CA797">
												进站：
												  	  			</div>
												  	  			<div id="wete" class="lcd" style="float: left;margin-top: 0px;margin-left: 0px;font-size: 20px;color:#02FAB8">
												  	  				{{wechat.ENTER_TIMES}} 
												  	  			</div>
												  	  					  	  				
									</div>
									<div style="float: left;margin-top: 3px;margin-left:7px; width: 110px;
									height: 30px;">
										<div style="float: left;margin-top:0px;margin-left: 0px;font-weight: bolder;font-size: 15px;color:#6CA797">
												出站：
												  	  			</div>
												  	  			<div id="wetx" class="lcd" style="float: left;margin-top: 0px;margin-left: 0px;font-size: 20px;color:#02FAB8">
												  	  				{{wechat.EXIT_TIMES}}  
												  	  			</div>
												  	  					  	  				
									</div>
									<div style="float: left;margin-top: 5px;margin-left:7px; width: 110px;
									height: 30px;">
										<div style="float: left;margin-top:0px;margin-left: 0px;font-weight: bolder;font-size: 15px;color:#6CA797">
												合计：
												  	  			</div>
												  	  			<div id="wetm" class="lcd" style="float: left;margin-top: 0px;margin-left: 0px;font-size: 20px;color:#02FAB8">
												  	  				{{wechat.ENTER_TIMES+wechat.EXIT_TIMES}} 
												  	  			</div>
												  	  					  	  				
									</div>
									<div style="float: left;margin-top:3px;margin-left: 10px;font-weight: bold;width: 110px;text-align:center; font-size: 16px;color:#6CA797">
													<div style="float: left;margin-top:2px;margin-left: 10px;font-weight: bold;width: 30px;text-align:center; font-size: 16px;color:#6CA797">
														<img src="resource/images/syntheboard/icon_03.png" alt=""/>
													  	  			</div>
													<div style="float: left;margin-top:1px;margin-left: 0px;font-weight: bold;width: 50px;text-align:center; font-size: 16px;color:#6CA797">
													微信
													  	  			</div>
													  	  			</div>
								</div>
							</div>
	           			</div>
	           			<div style="width:200px;height:278px;float: left;margin-top: 10px;margin-left: 0px;">
	           				<div style="width:200px;height:154px;float: left;margin-top: 0px;margin-left: 0px;">
	           					<div style="width:160px;height:154px;float: left;margin-top: 0px;margin-left: 30px;">
	           						<img src="resource/images/syntheboard/erweimajiaoyi_icon.png" alt=""/>
	           					</div>
	           					<div style="float: left;margin-top: 60px;margin-left:86px; width: 50px;position:absolute;
									height: 40px;">
										<div class="lcd" style="float: left;margin-top:0px;margin-left: 0px;font-weight: bold;font-size: 36px;color:#02FAB8">
												{{qrcdRate}}
												  	  			</div>
												  	  			<div class="lcd" style="float: left;margin-top: 7px;margin-left: 0px;font-size: 24px;color:#02FAB8">
												  	  				% 
												  	  			</div>
												  	  			
												  	  			
												  	  					  	  				
							</div>
	           				
	           				</div>
	           				<div style="float: left;margin-top:3px;margin-left: 10px;width:200px;height:30px;">
								<div style="float: left;margin-top:3px;margin-left: 40px;width:130px;font-weight: bold;width: 110px;text-align:center; font-size: 16px;color:#6CA797">
									全路网总占比			
								</div>					
							</div>
							<div style="float: left;margin-top: 5px;margin-left:12px; width: 200px;
									height: 30px;">
										<div style="float: left;margin-top:0px;margin-left: 0px;font-weight: bolder;font-size: 15px;color:#6CA797">
												客流历史峰值：
												  	  			</div>
												  	  			<div class="lcd" style="float: left;margin-top: 2px;margin-left: 0px;font-size: 20px;color:#02FAB8">
												  	  				{{qrcdt}}
												  	  			</div>
												  	  			
												  	  			<div class="lcd" style="float: left;margin-top: 3px;margin-left: 6px;font-size: 12px;color:#ffffff">
										  	  				万
										  	  			</div>
												  	  					  	  				
							</div>
							<div style="float: left;margin-top: 0px;margin-left:12px; width: 200px;
									height: 30px;">
										<div style="float: left;margin-top:0px;margin-left: 0px;font-weight: bolder;font-size: 15px;color:#6CA797">
												客流历史日期：
												  	  			</div>
												  	  			<div class="lcd" style="float: left;margin-top: 2px;margin-left: 0px;font-size: 20px;color:#02FAB8">
												  	  				{{qrcdate}}
												  	  			</div>
												  	  			
												  	  		
												  	  					  	  				
							</div>
							<div style="float: left;margin-top: 0px;margin-left:12px; width: 200px;
									height: 30px;">
										<div style="float: left;margin-top:0px;margin-left: 0px;font-weight: bolder;font-size: 15px;color:#6CA797">
												客流历史占比：
												  	  			</div>
												  	  			<div class="lcd" style="float: left;margin-top: 2px;margin-left: 0px;font-size: 20px;color:#02FAB8">
												  	  				{{qrcdRa}}% 
												  	  			</div>
												  	  			
												  	  			
												  	  					  	  				
							</div>
	           			</div>
	           		</div>		
	  	  		</el-row>
	  	  			  
	  	  	</el-col>
  	  	</el-row>
  	  	
		<el-row>
	  	  	<el-col :span="8">
	  	  		<el-row>
	  	  			<div style="float: left;margin-top: 6px;margin-left: 33px;">
	                	<img src="resource/images/syntheboard/gaojingxunxi_title.png" alt=""/>
	           		 </div>		
	  	  		</el-row>
	  	  		<el-row>
	  	  			<div id="" style="float: left;margin-top: 0px;margin-left: 33px; width: 600px;
									height: 270px;">
						<div style="float: left;margin-top: 6px;margin-left: 0px;width: 600px;height: 120px;">
			                	<div style="float: left;margin-top: 0px;margin-left: 10px;width: 81px;height: 99px;">
				                	<img v-if="alara" src="resource/images/syntheboard/renweizaihai_icon_Giveanalarm.png" @click="switchalarm('an')" alt=""/>
				                	<img  v-else src="resource/images/syntheboard/ewnweizaihaii_icon_normal.png" @click="switchalarm('ay')" alt=""/>
				                	<div  style="float: left;position:absolute; text-align:center; margin-top: -30px;margin-left: 12px; width: 60px;height: 40px;font-weight: bold;font-size: 13px;color:#6CA797;">
											紧急
									</div>
				           		 </div>
				           		 <div style="float: left;margin-top: 0px;margin-left: 8px;width: 81px;height: 99px;">
				                	<img v-if="alarb" src="resource/images/syntheboard/ziranzaihai_icon_Giveanalarm.png" @click="switchalarm('bn')" alt=""/>
				                	<img v-else src="resource/images/syntheboard/ziranzaihai_icon_normal.png"  @click="switchalarm('by')" alt=""/>
				                	<div  style="float: left;position:absolute; text-align:center; margin-top: -30px;margin-left: 12px; width: 60px;height: 40px;font-weight: bold;font-size: 13px;color:#6CA797;">
											严重
									</div>
				           		 </div>
				           		  <div style="float: left;margin-top: 0px;margin-left: 8px;width: 400px;height: 120px;">
				                  	<div  style="float: left;margin-top: -7px;margin-left: 0px; width: 400px;height: 30px;font-weight: bold;font-size: 14px;color:#6CA797;">
											具体详情
									</div>
									<div  style="float: left;margin-top: -7px;margin-left: 0px; width: 400px;height: 20px;font-weight: bold;border: 1px solid #008C6F;
										font-size: 14px;color:#6CA797;">
										<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 90px;height: 20px;font-size: 11px;border-right: 1px solid #008C6F;text-align: left;color:#6CA797">
					  	  					<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 89px;height: 18px;margin: 0px 0px 1px 6px;
					  	  						font-size: 12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.80);text-align: left;color:#6CA797">
					  	  						设备名称
					  	  					</div>
			  	  						</div>
			  	  						<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 80px;height: 20px;font-size: 11px;border-right: 1px solid #008C6F;text-align: left;color:#6CA797">
					  	  					<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 79px;height: 18px;margin: 0px 0px 1px 6px;
					  	  						font-size: 12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.80);text-align: left;color:#6CA797">
					  	  						时间
					  	  					</div>
			  	  						</div>
			  	  						<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 60px;height: 20px;font-size: 11px;border-right: 1px solid #008C6F;text-align: left;color:#6CA797">
					  	  					<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 59px;height: 18px;margin: 0px 0px 1px 6px;
					  	  						font-size: 12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.80);text-align: left;color:#6CA797">
					  	  					   告警级别
					  	  					</div>
			  	  						</div>
			  	  						<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 160px;height: 20px;font-size: 11px;text-align: left;color:#6CA797">
					  	  					<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 160px;height: 18px;margin: 0px 0px 1px 6px;
					  	  						font-size: 12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.80);text-align: left;color:#6CA797">
					  	  						事故原因
					  	  					</div>
			  	  						</div>			
									</div>
									<ul v-show="alar" style="float: left;margin-top: 0px;margin-left: -40px; width: 400px;height: 85px;overflow-y:auto;overflow-x:hidden;">
									<li v-for="(item,index) in alarmData" :key="index" style="float: left;margin-top: 0px;margin-left: 0px; width: 400px;height: 21px;list-style-type:none;  ">
									  <div  style="float: left;margin-top: 0px;margin-left: 0px; width: 400px;height: 20px;font-weight: bold;border-right: 1px solid #008C6F;
										font-size: 14px;color:#6CA797;border-left: 1px solid #008C6F;border-bottom: 1px solid #008C6F;">
										<div  style="float: left;margin-top: 0px;margin-left: 0px; overflow: hidden;width: 90px;height: 20px;font-size: 11px;border-right: 1px solid #008C6F;text-align: left;color:#6CA797">
					  	  					<div  class="animate" style="float: left;margin-top: 0px;margin-left: 0px;width: 99px;height: 18px;margin: 0px 0px 1px 6px;
					  	  						font-size: 12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.80);text-align: left;color:#6CA797">
					  	  						{{item.resourceLabel}}
					  	  					</div>
			  	  						</div>
			  	  						<div  style="float: left;margin-top: 0px;overflow: hidden;margin-left: 0px;width: 80px;height: 20px;font-size: 11px;border-right: 1px solid #008C6F;text-align: left;color:#6CA797">
					  	  					<div  style="float: left;overflow: hidden;margin-top: 0px;margin-left: 0px;width: 79px;height: 18px;margin: 0px 0px 1px 6px;
					  	  						font-size: 12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.80);text-align: left;color:#6CA797">
					  	  						{{item.alarmTime | amendT}}
					  	  					</div>
			  	  						</div>
			  	  						<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 60px;height: 20px;font-size: 11px;border-right: 1px solid #008C6F;text-align: left;color:#6CA797">
					  	  					<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 59px;height: 18px;margin: 0px 0px 1px 6px;
					  	  						font-size: 12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.80);text-align: left;color:#6CA797">
					  	  						{{item.level | amendS}}
					  	  					</div>
			  	  						</div>
			  	  						<div  style="float: left;margin-top: 0px;overflow: hidden;margin-left: 0px;width: 160px;height: 20px;font-size: 11px;text-align: left;color:#6CA797">
					  	  					<div  class="animate"style="float: left;margin-top: 0px;margin-left:0px;height: 18px;margin: 0px 0px 1px 6px;
					  	  						font-size: 12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.80);text-align: left;color:#6CA797">
													        {{item.name}}
					  	  						
					  	  					</div>
			  	  						</div>			
									 </div>
									</li>
									</ul>
									<ul  v-show="alara" style="float: left;margin-top: 0px;margin-left: -40px; width: 400px;height: 85px;overflow-y:auto;overflow-x:hidden;">
									<li v-for="(item,index) in alarma" :key="index" style="float: left;margin-top: 0px;margin-left: 0px; width: 400px;height: 21px;list-style-type:none;  ">
									  <div  style="float: left;margin-top: 0px;margin-left: 0px; width: 400px;height: 20px;font-weight: bold;border-right: 1px solid #008C6F;
										font-size: 14px;color:#6CA797;border-left: 1px solid #008C6F;border-bottom: 1px solid #008C6F;">
										<div  style="float: left;margin-top: 0px;margin-left: 0px; overflow: hidden;width: 90px;height: 20px;font-size: 11px;border-right: 1px solid #008C6F;text-align: left;color:#6CA797">
					  	  					<div  class="animate" style="float: left;margin-top: 0px;margin-left: 0px;width: 99px;height: 18px;margin: 0px 0px 1px 6px;
					  	  						font-size: 12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.80);text-align: left;color:#6CA797">
					  	  						{{item.resourceLabel}}
					  	  					</div>
			  	  						</div>
			  	  						<div  style="float: left;margin-top: 0px;overflow: hidden;margin-left: 0px;width: 80px;height: 20px;font-size: 11px;border-right: 1px solid #008C6F;text-align: left;color:#6CA797">
					  	  					<div  style="float: left;overflow: hidden;margin-top: 0px;margin-left: 0px;width: 79px;height: 18px;margin: 0px 0px 1px 6px;
					  	  						font-size: 12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.80);text-align: left;color:#6CA797">
					  	  						{{item.alarmTime | amendT}}
					  	  					</div>
			  	  						</div>
			  	  						<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 60px;height: 20px;font-size: 11px;border-right: 1px solid #008C6F;text-align: left;color:#6CA797">
					  	  					<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 59px;height: 18px;margin: 0px 0px 1px 6px;
					  	  						font-size: 12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.80);text-align: left;color:#6CA797">
					  	  						{{item.level | amendS}}
					  	  					</div>
			  	  						</div>
			  	  						<div  style="float: left;margin-top: 0px;overflow: hidden;margin-left: 0px;width: 160px;height: 20px;font-size: 11px;text-align: left;color:#6CA797">
					  	  					<div  class="animate"style="float: left;margin-top: 0px;margin-left:0px;height: 18px;margin: 0px 0px 1px 6px;
					  	  						font-size: 12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.80);text-align: left;color:#6CA797">
													        {{item.name}}
					  	  						
					  	  					</div>
			  	  						</div>			
									 </div>
									</li>
									</ul>
									<ul v-show="alarb" style="float: left;margin-top: 0px;margin-left: -40px; width: 400px;height: 85px;overflow-y:auto;overflow-x:hidden;">
									<li v-for="(item,index) in alarmb" :key="index" style="float: left;margin-top: 0px;margin-left: 0px; width: 400px;height: 21px;list-style-type:none;  ">
									  <div  style="float: left;margin-top: 0px;margin-left: 0px; width: 400px;height: 20px;font-weight: bold;border-right: 1px solid #008C6F;
										font-size: 14px;color:#6CA797;border-left: 1px solid #008C6F;border-bottom: 1px solid #008C6F;">
										<div  style="float: left;margin-top: 0px;margin-left: 0px; overflow: hidden;width: 90px;height: 20px;font-size: 11px;border-right: 1px solid #008C6F;text-align: left;color:#6CA797">
					  	  					<div  class="animate" style="float: left;margin-top: 0px;margin-left: 0px;width: 99px;height: 18px;margin: 0px 0px 1px 6px;
					  	  						font-size: 12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.80);text-align: left;color:#6CA797">
					  	  						{{item.resourceLabel}}
					  	  					</div>
			  	  						</div>
			  	  						<div  style="float: left;margin-top: 0px;overflow: hidden;margin-left: 0px;width: 80px;height: 20px;font-size: 11px;border-right: 1px solid #008C6F;text-align: left;color:#6CA797">
					  	  					<div  style="float: left;overflow: hidden;margin-top: 0px;margin-left: 0px;width: 79px;height: 18px;margin: 0px 0px 1px 6px;
					  	  						font-size: 12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.80);text-align: left;color:#6CA797">
					  	  						{{item.alarmTime | amendT}}
					  	  					</div>
			  	  						</div>
			  	  						<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 60px;height: 20px;font-size: 11px;border-right: 1px solid #008C6F;text-align: left;color:#6CA797">
					  	  					<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 59px;height: 18px;margin: 0px 0px 1px 6px;
					  	  						font-size: 12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.80);text-align: left;color:#6CA797">
					  	  						{{item.level | amendS}}
					  	  					</div>
			  	  						</div>
			  	  						<div  style="float: left;margin-top: 0px;overflow: hidden;margin-left: 0px;width: 160px;height: 20px;font-size: 11px;text-align: left;color:#6CA797">
					  	  					<div  class="animate"style="float: left;margin-top: 0px;margin-left:0px;height: 18px;margin: 0px 0px 1px 6px;
					  	  						font-size: 12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.80);text-align: left;color:#6CA797">
													        {{item.name}}
					  	  						
					  	  					</div>
			  	  						</div>			
									 </div>
									</li>
									</ul>
				           		 </div>			
		           		 </div>
		           		 <div style="float: left;margin-top: -8px;margin-left: 0px;width: 600px;height: 160px;">
		           		 	<div  style="float: left;margin-top: 0px;margin-left: 0px; width: 500px;height: 30px;font-weight: bold;font-size: 14px;color:#6CA797;">
								上海地铁线路
							</div>
							<div  style="float: left;margin-top: -7px;margin-left: 10px; width: 580px;height: 25px;font-weight: bold;border: 1px solid #008C6F;
										font-size: 14px;color:#6CA797;">
										<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 90px;height: 25px;font-size: 11px;border-right: 1px solid #008C6F;text-align: left;color:#6CA797">
					  	  					<div style="float: left;margin-top: 4px;margin-left: 5px;width: 10px;height: 10px;">
							                	<img src="resource/images/syntheboard/xianlumingcheng_icon-03.png" alt=""/>
							           		 </div>
					  	  					<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 69px;height: 20px;margin: 4px 0px 1px 3px;
					  	  						font-size: 12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.80);text-align: left;color:#6CA797">
					  	  						1号路
					  	  					</div>
			  	  						</div>
			  	  						<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 90px;height: 25px;font-size: 11px;border-right: 1px solid #008C6F;text-align: left;color:#6CA797">
					  	  					<div style="float: left;margin-top: 4px;margin-left: 5px;width: 10px;height: 10px;">
							                	<img src="resource/images/syntheboard/xianlumingcheng_icon-04.png" alt=""/>
							           		 </div>
					  	  					<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 69px;height: 20px;margin: 4px 0px 1px 3px;
					  	  						font-size: 12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.80);text-align: left;color:#6CA797">
					  	  						5号线
					  	  					</div>
			  	  						</div>
			  	  						<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 230px;height: 25px;font-size: 11px;border-right: 1px solid #008C6F;text-align: left;color:#6CA797">
					  	  					<div style="float: left;margin-top: 4px;margin-left: 5px;width: 10px;height: 10px;">
							                	<img src="resource/images/syntheboard/xianlumingcheng_icon-05.png" alt=""/>
							           		 </div>
					  	  					<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 209px;height: 20px;margin: 4px 0px 1px 3px;
					  	  						font-size: 12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.80);text-align: left;color:#6CA797">
					  	  						9号线
					  	  					</div>
			  	  						</div>
			  	  						<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 120px;height: 25px;font-size: 11px;text-align: left;color:#6CA797">
					  	  					<div style="float: left;margin-top: 4px;margin-left: 5px;width: 10px;height: 10px;">
							                	<img src="resource/images/syntheboard/xianlumingcheng_icon-06.png" alt=""/>
							           		 </div>
					  	  					<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 100px;height: 20px;margin: 4px 0px 1px 3px;
					  	  						font-size: 12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.80);text-align: left;color:#6CA797">
					  	  						11号线(花桥 三林)
					  	  					</div>
			  	  						</div>			
									</div>
									<div  style="float: left;margin-top: 0px;margin-left: 10px; width: 580px;height: 25px;font-weight: bold;border-right: 1px solid #008C6F;
										font-size: 14px;color:#6CA797;border-left: 1px solid #008C6F;border-bottom: 1px solid #008C6F;">
										<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 90px;height: 25px;font-size: 11px;border-right: 1px solid #008C6F;text-align: left;color:#6CA797">
					  	  					<div style="float: left;margin-top: 4px;margin-left: 5px;width: 10px;height: 10px;">
							                	<img src="resource/images/syntheboard/xianlumingcheng_icon-07.png" alt=""/>
							           		 </div>
					  	  					<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 69px;height: 20px;margin: 4px 0px 1px 3px;
					  	  						font-size: 12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.80);text-align: left;color:#6CA797">
					  	  						2号路
					  	  					</div>
			  	  						</div>
			  	  						<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 90px;height: 25px;font-size: 11px;border-right: 1px solid #008C6F;text-align: left;color:#6CA797">
					  	  					<div style="float: left;margin-top: 4px;margin-left: 5px;width: 10px;height: 10px;">
							                	<img src="resource/images/syntheboard/xianlumingcheng_icon-08.png" alt=""/>
							           		 </div>
					  	  					<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 69px;height: 20px;margin: 4px 0px 1px 3px;
					  	  						font-size: 12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.80);text-align: left;color:#6CA797">
					  	  						6号线
					  	  					</div>
			  	  						</div>
			  	  						<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 230px;height: 25px;font-size: 11px;border-right: 1px solid #008C6F;text-align: left;color:#6CA797">
					  	  					<div style="float: left;margin-top: 4px;margin-left: 5px;width: 10px;height: 10px;">
							                	<img src="resource/images/syntheboard/xianlumingcheng_icon-09.png" alt=""/>
							           		 </div>
					  	  					<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 209px;height: 20px;margin: 4px 0px 1px 3px;
					  	  						font-size: 12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.80);text-align: left;color:#6CA797">
					  	  						磁悬浮
					  	  					</div>
			  	  						</div>
			  	  						<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 120px;height: 25px;font-size: 11px;text-align: left;color:#6CA797">
					  	  					<div style="float: left;margin-top: 4px;margin-left: 5px;width: 10px;height: 10px;">
							                	<img src="resource/images/syntheboard/xianlumingcheng_icon-10.png" alt=""/>
							           		 </div>
					  	  					<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 100px;height: 20px;margin: 4px 0px 1px 3px;
					  	  						font-size: 12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.80);text-align: left;color:#6CA797">
					  	  						12号线
					  	  					</div>
			  	  						</div>			
									</div>
									<div  style="float: left;margin-top: 0px;margin-left: 10px; width: 580px;height: 25px;font-weight: bold;border-right: 1px solid #008C6F;
										font-size: 14px;color:#6CA797;border-left: 1px solid #008C6F;border-bottom: 1px solid #008C6F;">
										<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 90px;height: 25px;font-size: 11px;border-right: 1px solid #008C6F;text-align: left;color:#6CA797">
					  	  					<div style="float: left;margin-top: 4px;margin-left: 5px;width: 10px;height: 10px;">
							                	<img src="resource/images/syntheboard/xianlumingcheng_icon-11.png" alt=""/>
							           		 </div>
					  	  					<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 69px;height: 20px;margin: 4px 0px 1px 3px;
					  	  						font-size: 12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.80);text-align: left;color:#6CA797">
					  	  						3号路
					  	  					</div>
			  	  						</div>
			  	  						<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 90px;height: 25px;font-size: 11px;border-right: 1px solid #008C6F;text-align: left;color:#6CA797">
					  	  					<div style="float: left;margin-top: 4px;margin-left: 5px;width: 10px;height: 10px;">
							                	<img src="resource/images/syntheboard/xianlumingcheng_icon-12.png" alt=""/>
							           		 </div>
					  	  					<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 69px;height: 20px;margin: 4px 0px 1px 3px;
					  	  						font-size: 12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.80);text-align: left;color:#6CA797">
					  	  						7号线
					  	  					</div>
			  	  						</div>
			  	  						<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 230px;height: 25px;font-size: 11px;border-right: 1px solid #008C6F;text-align: left;color:#6CA797">
					  	  					<div style="float: left;margin-top: 4px;margin-left: 5px;width: 13px;height: 10px;">
							                	<img src="resource/images/syntheboard/xianlumingcheng_icon-13.png" alt=""/>
							           		 </div>
					  	  					<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 209px;height: 20px;margin: 4px 0px 1px 3px;
					  	  						font-size: 12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.80);text-align: left;color:#6CA797">
					  	  						10号线(新江湾城-航中路)
					  	  					</div>
			  	  						</div>
			  	  						<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 120px;height: 25px;font-size: 11px;text-align: left;color:#6CA797">
					  	  					<div style="float: left;margin-top: 4px;margin-left: 5px;width: 10px;height: 10px;">
							                	<img src="resource/images/syntheboard/xianlumingcheng_icon-14.png" alt=""/>
							           		 </div>
					  	  					<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 100px;height: 20px;margin: 4px 0px 1px 3px;
					  	  						font-size: 12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.80);text-align: left;color:#6CA797">
					  	  						13号线
					  	  					</div>
			  	  						</div>			
									</div>
									<div  style="float: left;margin-top: 0px;margin-left: 10px; width: 580px;height: 25px;font-weight: bold;border-right: 1px solid #008C6F;
										font-size: 14px;color:#6CA797;border-left: 1px solid #008C6F;border-bottom: 1px solid #008C6F;">
										<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 90px;height: 25px;font-size: 11px;border-right: 1px solid #008C6F;text-align: left;color:#6CA797">
					  	  					<div style="float: left;margin-top: 4px;margin-left: 5px;width: 10px;height: 10px;">
							                	<img src="resource/images/syntheboard/xianlumingcheng_icon-15.png" alt=""/>
							           		 </div>
					  	  					<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 69px;height: 20px;margin: 4px 0px 1px 3px;
					  	  						font-size: 12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.80);text-align: left;color:#6CA797">
					  	  						4号路
					  	  					</div>
			  	  						</div>
			  	  						<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 90px;height: 25px;font-size: 11px;border-right: 1px solid #008C6F;text-align: left;color:#6CA797">
					  	  					<div style="float: left;margin-top: 4px;margin-left: 5px;width: 10px;height: 10px;">
							                	<img src="resource/images/syntheboard/xianlumingcheng_icon-16.png" alt=""/>
							           		 </div>
					  	  					<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 69px;height: 20px;margin: 4px 0px 1px 3px;
					  	  						font-size: 12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.80);text-align: left;color:#6CA797">
					  	  						8号线
					  	  					</div>
			  	  						</div>
			  	  						<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 230px;height: 25px;font-size: 11px;border-right: 1px solid #008C6F;text-align: left;color:#6CA797">
					  	  					<div style="float: left;margin-top: 4px;margin-left: 5px;width: 13px;height: 10px;">
							                	<img src="resource/images/syntheboard/xianlumingcheng_icon-17.png" alt=""/>
							           		 </div>
					  	  					<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 209px;height: 20px;margin: 4px 0px 1px 3px;
					  	  						font-size: 12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.80);text-align: left;color:#6CA797">
					  	  						10号线(新江湾城-虹桥火车站)
					  	  					</div>
			  	  						</div>
			  	  						<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 120px;height: 25px;font-size: 11px;text-align: left;color:#6CA797">
					  	  					<div style="float: left;margin-top: 4px;margin-left: 5px;width: 10px;height: 10px;">
							                	<img src="resource/images/syntheboard/xianlumingcheng_icon-18.png" alt=""/>
							           		 </div>
					  	  					<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 100px;height: 20px;margin: 4px 0px 1px 3px;
					  	  						font-size: 12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.80);text-align: left;color:#6CA797">
					  	  						16号线
					  	  					</div>
			  	  						</div>			
									</div>
									<div  style="float: left;margin-top: 0px;margin-left: 10px; width: 580px;height: 25px;font-weight: bold;border-right: 1px solid #008C6F;
										font-size: 14px;color:#6CA797;border-left: 1px solid #008C6F;border-bottom: 1px solid #008C6F;">
										<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 90px;height: 25px;font-size: 11px;border-right: 1px solid #008C6F;text-align: left;color:#6CA797">
					  	  					<div style="float: left;margin-top: 4px;margin-left: 5px;width: 10px;height: 10px;">
							                	<img src="resource/images/syntheboard/xianlumingcheng_icon-19.png" alt=""/>
							           		 </div>
					  	  					<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 69px;height: 20px;margin: 4px 0px 1px 3px;
					  	  						font-size: 12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.80);text-align: left;color:#6CA797">
					  	  						5号路
					  	  					</div>
			  	  						</div>
			  	  						<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 90px;height: 25px;font-size: 11px;border-right: 1px solid #008C6F;text-align: left;color:#6CA797">
					  	  					<div style="float: left;margin-top: 4px;margin-left: 5px;width: 10px;height: 10px;">
							                	<img src="resource/images/syntheboard/xianlumingcheng_icon-20.png" alt=""/>
							           		 </div>
					  	  					<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 69px;height: 20px;margin: 4px 0px 1px 3px;
					  	  						font-size: 12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.80);text-align: left;color:#6CA797">
					  	  						浦江线
					  	  					</div>
			  	  						</div>
			  	  						<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 230px;height: 25px;font-size: 11px;border-right: 1px solid #008C6F;text-align: left;color:#6CA797">
					  	  					<div style="float: left;margin-top: 4px;margin-left: 5px;width: 13px;height: 10px;">
							                	<img src="resource/images/syntheboard/xianlumingcheng_icon-21.png" alt=""/>
							           		 </div>
					  	  					<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 209px;height: 20px;margin: 4px 0px 1px 3px;
					  	  						font-size: 12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.80);text-align: left;color:#6CA797">
					  	  						11号线(嘉定北-迪士尼)
					  	  					</div>
			  	  						</div>
			  	  						<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 120px;height: 25px;font-size: 11px;text-align: left;color:#6CA797">
					  	  					<div style="float: left;margin-top: 4px;margin-left: 5px;width: 10px;height: 10px;">
							                	<img src="resource/images/syntheboard/xianlumingcheng_icon-22.png" alt=""/>
							           		 </div>
					  	  					<div  style="float: left;margin-top: 0px;margin-left: 0px;width: 100px;height: 20px;margin: 4px 0px 1px 3px;
					  	  						font-size: 12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.80);text-align: left;color:#6CA797">
					  	  						17号线
					  	  					</div>
			  	  						</div>			
									</div>
		           		 </div>		
					</div>
	  	  				
	  	  		</el-row>
	  	  	
	  	  	</el-col>
	  	  	<el-col :span="8">
	  	  		<el-row>
	  	  			<div style="float: left;margin-top: 6px;margin-left: 33px;">
	                	<img src="resource/images/syntheboard/piaowufangwen_title.png" alt=""/>
	           		 </div>		
	  	  		</el-row>
	  	  		<div style="float: left;margin-top: 40px;margin-left: 42px;background: url(resource/images/syntheboard/piaowufangwen_label.png) no-repeat; width: 580px;
							height: 200px;">
					<el-row>
						<div style="float: left;margin-top: 0px;margin-left:0px; width: 170px;
									height: 200px;">
							<div style="float: left;margin-top: 10px;margin-left:16px; width: 170px;
									height: 40px;">
								<div style="float: left;margin-top:8px;margin-left: 0px;font-weight: bolder;font-size: 15px;color:#6CA797">
										SC上传：
										  	  			</div>
										  	  			<div class="lcd" style="float: left;margin-top: 8px;margin-left: 13px;font-size: 20px;color:#02FAB8">
										  	  				{{scct}}
										  	  			</div>	  	  				
							</div>
							<div style="float: left;margin-top: 10px;margin-left:16px; width: 170px;
									height: 40px;">
								<div style="float: left;margin-top:0px;margin-left: 0px;font-weight: bolder;font-size: 15px;color:#6CA797">
										票卡流失：
										  	  			</div>
										  	  			<div class="lcd" style="float: left;margin-top: 0px;margin-left: 7px;font-size: 20px;color:#02FAB8">
										  	  				{{ticlost}}
										  	  			</div>
										  	  			<div class="lcd" style="float: left;margin-top: 0px;margin-left: 5px;font-size: 13px;color:#02FAB8">
										  	  				 张
										  	  			</div>	  	  				
							</div>
							<div style="float: left;margin-top: 10px;margin-left:16px; width: 170px;
									height: 40px;">
								<div style="float: left;margin-top:0px;margin-left: 0px;font-weight: bolder;font-size: 15px;color:#6CA797">
										票卡库存：
										  	  			</div>
										  	  			<div class="lcd" style="float: left;margin-top: 0px;margin-left: 3px;font-size: 20px;color:#02FAB8">
										  	  				{{tsgtotal}}
										  	  			</div>
										  	  			<div class="lcd" style="float: left;margin-top: 0px;margin-left: 5px;font-size: 13px;color:#02FAB8">
										  	  				 张
										  	  			</div>		  	  				
							</div>
							<div style="float: left;margin-top: 11px;margin-left:16px; width: 170px;
									height: 40px;">
								<div style="float: left;margin-top:0px;margin-left: 0px;font-weight: bolder;font-size: 15px;color:#6CA797">
										未日结车站数：
										  	  			</div>
										  	  			<div class="lcd" style="float: left;margin-top: 0px;margin-left: 5px;font-size: 20px;color:#02FAB8">
										  	  				{{staEnd}}
										  	  			</div>
										  	  				  	  				
							</div>		
						</div>
						<div style="float: left;margin-top: 0px;margin-left:0px; width: 170px;
									height: 200px;">
							<div style="float: left;margin-top: 10px;margin-left:25px; width: 170px;
									height: 130px;">		
							<ul  style="float: left;margin-top: 0px;margin-left: -47px; width: 170px;height: 130px;overflow-y:auto;overflow-x:hidden;">
									<li v-for="(item,index) in eqml" :key="index" style="float: left;margin-top: 0px;margin-left: 0px; width: 170px;height: 20px;list-style-type:none;  ">
								<div style="float: left;margin-top: 0px;margin-left:16px; width: 170px;
										height: 20px;">
									<div style="float: left;margin-top:8px;margin-left: 0px;font-weight: bolder;font-size: 12px;color:#6CA797">
											{{item.STATION_NM_CN}}:
											  	  			</div>
											  	  			<div class="" style="float: left;margin-top: 8px;margin-left: 7px;font-size: 12px;color:#02FAB8">
											  	  				{{item.EQUIP_ID}}
											  	  			</div>	  	  				
								</div>
									</li>
									</ul>	  	  			  	  				
							</div>
							<div style="float: left;margin-top: 12px;margin-left:0px; width: 170px;
									height: 40px;">
								<div style="float: left;margin-top: 9px;margin-left:16px; width: 170px;
										height: 40px;">
									<div style="float: left;margin-top:0px;margin-left: 19px;font-weight: bolder;font-size: 15px;color:#6CA797">
											寄存器上传异常设备
											  	  			</div>
											  	  			
											  	  				  	  				
								</div>
							</div>			
						</div>
						<div style="float: left;margin-top: 0px;margin-left:0px; width: 200px;
									height: 200px;">
							<div style="float: left;margin-top: 10px;margin-left:25px; width: 200px;
									height: 130px;">		
								<div style="float: left;margin-top: 0px;margin-left:115px; position: absolute;width: 10px;
									height: 130px;border-right: 1px solid #008C6F;">
								</div>	
								<div style="float: left;margin-top: 0px;margin-left:16px; width: 190px;
										height: 30px;">
									<div style="float: left;margin-top:2px;margin-left: 36px;width: 70px;text-align: center;font-weight: bolder;font-size: 14px;color:#6CA797">
											客流
											  	  			</div>
									<div style="float: left;margin-top:2px;margin-left: 0px;width: 73px;text-align: center;font-weight: bolder;font-size: 14px;color:#6CA797">
											收益
											  	  			</div>
									
											  	  				  	  				
								</div>
								<div   style="float: left;margin-top: 0px;margin-left:2px; width: 190px; 
										height: 120px;">
									<div v-for="(item,index) in opdata" style="float: left;margin-top: 0px;margin-left:16px; width: 190px;
											height: 16px;">
										<div style="float: left;margin-top:2px;margin-left: 0px;width: 35px;text-align: center;font-weight: bolder;font-size: 13px;color:#6CA797">
												{{item.OWNER_NM_CN |amName}}
												  	  			</div>
										<div style="float: left;margin-top:2px;margin-left: 0px;width: 70px;text-align: center;font-size: 12px;color:#02FAB8">
												{{item.TIMES}}万
												  	  			</div>
										<div style="float: left;margin-top:2px;margin-left: 0px;width: 73px;text-align: center;font-size: 12px;color:#02FAB8">
												{{item.AMT}}万
												  	  			</div>
									  	  				  	  				
									</div>
							  </div>
									  	  			  	  				
							</div>
							<div style="float: left;margin-top: 12px;margin-left:0px; width: 170px;
									height: 40px;">
								<div style="float: left;margin-top: 9px;margin-left:16px; width: 170px;
										height: 40px;">
									<div style="float: left;margin-top:0px;margin-left: 22px;width: 170px;font-weight: bolder;text-align: center;font-size: 15px;color:#6CA797">
											指标
											  	  			</div>
											  	  			
											  	  				  	  				
								</div>
							</div>			
						</div>	
					</el-row>
				</div>
	  	  	</el-col>
	  	  	<el-col :span="8">
	  	  		<el-row>
		  	  			<div style="float: left;margin-top: 5px;margin-left: 17px;" @click="klzfDetl()">
		                	<img src="resource/images/syntheboard/shishikeliu_title.png" alt=""/>
		           		 </div>		
	  	  		</el-row>
	  	  		<el-row>
	  	  			<div id="klzfzl" style="float: left;margin-top: 0px;margin-left: 0px;width: 600px;height: 280px;margin: 0px 0px 10px 0px;">
	  	  				<div style="float: left;margin-top: 0px;margin-left:5px; width: 50px;
									height: 280px;">
							<div style="float: left;margin-top: 0px;margin-left:44px; position: absolute;width: 10px;
									height: 270px;border-right: 2px solid #02FAB8;">
								</div>			
							<div  id ="czzf" style="float: left;margin-top: 10px;margin-left:5px; width: 50px;background: url(resource/images/syntheboard/shishikeliu_icon_selected.png) no-repeat;
									height: 42px;" @click="zlzfswitch('czzf')">
								<div style="float: left;margin-top:2px;margin-left: 10px;font-weight: bold;width: 30px;text-align:center; font-size: 13px;color:black">
													增幅排名
													  	  			</div>
							</div>
							<div  id="czzl" style="float: left;margin-top: 10px;margin-left:5px; width: 50px;background: url(resource/images/syntheboard/shishikeliu_icon_normal.png) no-repeat;
									height: 42px;" @click="zlzfswitch('czzl')">
								<div style="float: left;margin-top:2px;margin-left: 10px;font-weight: bold;width: 30px;text-align:center; font-size: 13px;color:black">
													增量排名
													  	  			</div>
							</div>
						</div>
						<div style="float: left;margin-top: 6px;margin-left:5px; width: 540px;
									height: 280px;">
							
	  	  		
	  	  				<el-row>
	  	  					<div id="chzzf" style="float: left;margin-top: 0px;margin-left: 15px;display:block;">
			                	<el-row>
	  	  							<el-col :span="8">
	  	  								<div style="float: left;margin-top: 0px;margin-left: 15px;width: 155px">
	  	  									<el-row>
	  	  										<div style="float: left;margin-top: 0px;margin-left: -17px;">
								                	<img src="resource/images/pasflw/list-1.png" alt=""/>
								           		 </div>
	  	  									</el-row>
	  	  									<el-row>
	  	  										<div style="float: left;margin-top: 0px;margin-left: -17px;">
								                	<div style="float: left;margin-top: 0px;margin-left: 10px;font-size: 16px;font-weight: bolder;color:#00CCC6">
								                		站点
								           		 	</div>
								           		 	<div style="float: left;margin-top: 0px;margin-left: 25px;font-size: 16px;font-weight: bolder;color:#00CCC6">
								                		进站
								           		 	</div>
								           		 	<div style="float: left;margin-top: 0px;margin-left: 25px;font-size: 16px;font-weight: bolder;color:#00CCC6">
								                		增幅
								           		 	</div>
								           		 	<div style="float: left;margin-top: 10px;margin-left: 3px;position: absolute;">
									                	<img src="resource/images/pasflw/line-2.png" alt=""/>
									           		 </div>
								           		 </div>
	  	  									</el-row>
	  	  									
	  	  											
			  	  										<div v-for="(item,index) in zfjdata" :key="index" class="" style="float: left;margin-top: 10px;margin-left: -15px;width：156px">
										                	<div style="float: left;margin-top: 0px;margin-left: 0px;width:80px;text-align:center; font-weight: bolder;color:#ffffff;font-size:12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.70);">
										                		{{item.STATION_NM_CN}}
										           		 	</div>
										           		 	<div style="float: left;margin-top: 0px;margin-left: 0px;text-align:center; width:38px;font-weight: bolder;color:#ffffff;font-size:12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.70);">
										                		{{item.TOTAL_TIMES}}
										           		 	</div>
										           		 	<div v-if="item.isa" style="float: left;margin-top: 0px;margin-left: 10px;text-align:right; width:38px;font-weight: bolder;color:red;font-size:12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.70);">
										                		{{item.INCREASE}}%
										           		 	</div>
										           		 	<div v-else style="float: left;margin-top: 0px;margin-left: 10px;text-align:right; width:38px;font-weight: bolder;color:green;font-size:12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.70);">
										                		{{item.INCREASE_ABS}}%
										           		 	</div>
										           		 	
										           		 	<div style="float: left;margin-top: 5px;margin-left: 3px;position: absolute;">
											                	<img src="resource/images/pasflw/line-2.png" alt=""/>
											           		 </div>
										           		 </div>
			  	  									
	  	  									
	  	  								</div>
	  	  							</el-col>
	  	  							<el-col :span="8">
	  	  								<div style="float: left;margin-top: 0px;margin-left: 20px;width: 155px">
	  	  									<el-row>
	  	  										<div style="float: left;margin-top: 0px;margin-left: -17px;">
								                	<img src="resource/images/pasflw/list-3.png" alt=""/>
								           		 </div>
	  	  									</el-row>
	  	  									<el-row>
	  	  										<div style="float: left;margin-top: 0px;margin-left: -17px;">
								                	<div style="float: left;margin-top: 0px;margin-left: 10px;font-size: 16px;font-weight: bolder;color:#CC7E00">
								                		站点
								           		 	</div>
								           		 	<div style="float: left;margin-top: 0px;margin-left: 25px;font-size: 16px;font-weight: bolder;color:#CC7E00">
								                		出站
								           		 	</div>
								           		 	<div style="float: left;margin-top: 0px;margin-left: 25px;font-size: 16px;font-weight: bolder;color:#CC7E00">
								                		增幅
								           		 	</div>
								           		 	<div style="float: left;margin-top: 10px;margin-left: 3px;position: absolute;">
									                	<img src="resource/images/pasflw/line-2.png" alt=""/>
									           		 </div>
								           		 </div>
	  	  									</el-row>
	  	  											<div v-for="(item,index) in zfcdata" :key="index" class="" style="float: left;margin-top: 10px;margin-left: -15px;width：156px">
										                	<div style="float: left;margin-top: 0px;margin-left: 0px;width:80px;text-align:center; font-weight: bolder;color:#ffffff;font-size:12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.70);">
										                		{{item.STATION_NM_CN}}
										           		 	</div>
										           		 	<div style="float: left;margin-top: 0px;margin-left: 0px;text-align:center; width:38px;font-weight: bolder;color:#ffffff;font-size:12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.70);">
										                		{{item.TOTAL_TIMES}}
										           		 	</div>
										           		 	<div v-if="item.isa" style="float: left;margin-top: 0px;margin-left: 10px;text-align:right; width:38px;font-weight: bolder;color:red;font-size:12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.70);">
										                		{{item.INCREASE}}%
										           		 	</div>
										           		 	<div v-else style="float: left;margin-top: 0px;margin-left: 10px;text-align:right; width:38px;font-weight: bolder;color:green;font-size:12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.70);">
										                		{{item.INCREASE_ABS}}%
										           		 	</div>
										           		 	
										           		 	<div style="float: left;margin-top: 5px;margin-left: 3px;position: absolute;">
											                	<img src="resource/images/pasflw/line-2.png" alt=""/>
											           		 </div>
										           		 </div>
	  	  								</div>
	  	  							</el-col>
	  	  							<el-col :span="8">
	  	  								<div style="float: left;margin-top: 0px;margin-left: 25px;width: 155px">
	  	  									<el-row>
	  	  										<div style="float: left;margin-top: 0px;margin-left: -17px;">
								                	<img src="resource/images/pasflw/list-2.png" alt=""/>
								           		 </div>
	  	  									</el-row>
	  	  									<el-row>
	  	  										<div style="float: left;margin-top: 0px;margin-left: -17px;">
								                	<div style="float: left;margin-top: 0px;margin-left: 10px;font-size: 16px;font-weight: bolder;color:#78A3C6">
								                		站点
								           		 	</div>
								           		 	<div style="float: left;margin-top: 0px;margin-left: 25px;font-size: 16px;font-weight: bolder;color:#78A3C6">
								                		换乘
								           		 	</div>
								           		 	<div style="float: left;margin-top: 0px;margin-left: 25px;font-size: 16px;font-weight: bolder;color:#78A3C6">
								                		增幅
								           		 	</div>
								           		 	<div style="float: left;margin-top: 10px;margin-left: 3px;position: absolute;">
									                	<img src="resource/images/pasflw/line-2.png" alt=""/>
									           		 </div>
								           		 </div>
	  	  									</el-row>
	  	  											<div v-for="(item,index) in zfhdata" :key="index" class="" style="float: left;margin-top: 10px;margin-left: -15px;width：156px">
										                	<div style="float: left;margin-top: 0px;margin-left: 0px;width:80px;text-align:center; font-weight: bolder;color:#ffffff;font-size:12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.70);">
										                		{{item.STATION_NM_CN}}
										           		 	</div>
										           		 	<div style="float: left;margin-top: 0px;margin-left: 0px;text-align:center; width:38px;font-weight: bolder;color:#ffffff;font-size:12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.70);">
										                		{{item.TOTAL_TIMES}}
										           		 	</div>
										           		 	<div v-if="item.isa" style="float: left;margin-top: 0px;margin-left: 10px;text-align:right; width:38px;font-weight: bolder;color:red;font-size:12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.70);">
										                		{{item.INCREASE}}%
										           		 	</div>
										           		 	<div v-else style="float: left;margin-top: 0px;margin-left: 10px;text-align:right; width:38px;font-weight: bolder;color:green;font-size:12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.70);">
										                		{{item.INCREASE_ABS}}%
										           		 	</div>
										           		 	
										           		 	<div style="float: left;margin-top: 5px;margin-left: 3px;position: absolute;">
											                	<img src="resource/images/pasflw/line-2.png" alt=""/>
											           		 </div>
										           		 </div>
	  	  								</div>
	  	  							</el-col>
	  	  						</el-row>
			           		 </div>	
			           		<div id="chzzl" style="float: left;margin-top: 0px;margin-left: 15px;display:none;">
			                	<el-row>
	  	  							<el-col :span="8">
	  	  								<div style="float: left;margin-top: 0px;margin-left: 15px;width: 155px">
	  	  									<el-row>
	  	  										<div style="float: left;margin-top: 0px;margin-left: -17px;">
								                	<img src="resource/images/pasflw/list-1.png" alt=""/>
								           		 </div>
	  	  									</el-row>
	  	  									<el-row>
	  	  										<div style="float: left;margin-top: 0px;margin-left: -17px;">
								                	<div style="float: left;margin-top: 0px;margin-left: 10px;font-size: 16px;font-weight: bolder;color:#00CCC6">
								                		站点
								           		 	</div>
								           		 	<div style="float: left;margin-top: 0px;margin-left: 25px;font-size: 16px;font-weight: bolder;color:#00CCC6">
								                		进站
								           		 	</div>
								           		 	<div style="float: left;margin-top: 0px;margin-left: 25px;font-size: 16px;font-weight: bolder;color:#00CCC6">
								                		增量
								           		 	</div>
								           		 	<div style="float: left;margin-top: 10px;margin-left: 3px;position: absolute;">
									                	<img src="resource/images/pasflw/line-2.png" alt=""/>
									           		 </div>
								           		 </div>
	  	  									</el-row>
	  	  									
	  	  											
			  	  										<div v-for="(item,index) in zljdata" :key="index" class="" style="float: left;margin-top: 10px;margin-left: -15px;width：156px">
										                	<div style="float: left;margin-top: 0px;margin-left: 0px;    height: 12px;width:80px;text-align:center; font-weight: bolder;color:#ffffff;font-size:12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.70);">
										                		{{item.STATION_NM_CN}}
										           		 	</div>
										           		 	<div style="float: left;margin-top: 0px;margin-left: 0px;text-align:center; width:38px;font-weight: bolder;color:#ffffff;font-size:12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.70);">
										                		{{item.TOTAL_TIMES}}
										           		 	</div>
										           		 	<div v-if="item.isa" style="float: left;margin-top: 0px;margin-left: 10px;text-align:right; width:38px;font-weight: bolder;color:red;font-size:12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.70);">
										                		{{item.INCREASE}}
										           		 	</div>
										           		 	<div v-else style="float: left;margin-top: 0px;margin-left: 10px;text-align:right; width:38px;font-weight: bolder;color:green;font-size:12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.70);">
										                		{{item.INCREASE_ABS}}
										           		 	</div>
										           		 	
										           		 	<div style="float: left;margin-top: 5px;margin-left: 3px;position: absolute;">
											                	<img src="resource/images/pasflw/line-2.png" alt=""/>
											           		 </div>
										           		 </div>
			  	  									
	  	  									
	  	  								</div>
	  	  							</el-col>
	  	  							<el-col :span="8">
	  	  								<div style="float: left;margin-top: 0px;margin-left: 20px;width: 155px">
	  	  									<el-row>
	  	  										<div style="float: left;margin-top: 0px;margin-left: -17px;">
								                	<img src="resource/images/pasflw/list-3.png" alt=""/>
								           		 </div>
	  	  									</el-row>
	  	  									<el-row>
	  	  										<div style="float: left;margin-top: 0px;margin-left: -17px;">
								                	<div style="float: left;margin-top: 0px;margin-left: 10px;font-size: 16px;font-weight: bolder;color:#CC7E00">
								                		站点
								           		 	</div>
								           		 	<div style="float: left;margin-top: 0px;margin-left: 25px;font-size: 16px;font-weight: bolder;color:#CC7E00">
								                		出站
								           		 	</div>
								           		 	<div style="float: left;margin-top: 0px;margin-left: 25px;font-size: 16px;font-weight: bolder;color:#CC7E00">
								                		增量
								           		 	</div>
								           		 	<div style="float: left;margin-top: 10px;margin-left: 3px;position: absolute;">
									                	<img src="resource/images/pasflw/line-2.png" alt=""/>
									           		 </div>
								           		 </div>
	  	  									</el-row>
	  	  											<div v-for="(item,index) in zlcdata" :key="index" class="" style="float: left;margin-top: 10px;margin-left: -15px;width：156px">
										                	<div style="float: left;margin-top: 0px;margin-left: 0px;    height: 12px;width:80px;text-align:center; font-weight: bolder;color:#ffffff;font-size:12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.70);">
										                		{{item.STATION_NM_CN}}
										           		 	</div>
										           		 	<div style="float: left;margin-top: 0px;margin-left: 0px;text-align:center; width:38px;font-weight: bolder;color:#ffffff;font-size:12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.70);">
										                		{{item.TOTAL_TIMES}}
										           		 	</div>
										           		 	<div v-if="item.isa" style="float: left;margin-top: 0px;margin-left: 10px;text-align:right; width:38px;font-weight: bolder;color:red;font-size:12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.70);">
										                		{{item.INCREASE}}
										           		 	</div>
										           		 	<div v-else style="float: left;margin-top: 0px;margin-left: 10px;text-align:right; width:38px;font-weight: bolder;color:green;font-size:12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.70);">
										                		{{item.INCREASE_ABS}}
										           		 	</div>
										           		 	
										           		 	<div style="float: left;margin-top: 5px;margin-left: 3px;position: absolute;">
											                	<img src="resource/images/pasflw/line-2.png" alt=""/>
											           		 </div>
										           		 </div>
	  	  								</div>
	  	  							</el-col>
	  	  							<el-col :span="8">
	  	  								<div style="float: left;margin-top: 0px;margin-left: 25px;width: 155px">
	  	  									<el-row>
	  	  										<div style="float: left;margin-top: 0px;margin-left: -17px;">
								                	<img src="resource/images/pasflw/list-2.png" alt=""/>
								           		 </div>
	  	  									</el-row>
	  	  									<el-row>
	  	  										<div style="float: left;margin-top: 0px;margin-left: -17px;">
								                	<div style="float: left;margin-top: 0px;margin-left: 10px;font-size: 16px;font-weight: bolder;color:#78A3C6">
								                		站点
								           		 	</div>
								           		 	<div style="float: left;margin-top: 0px;margin-left: 25px;font-size: 16px;font-weight: bolder;color:#78A3C6">
								                		换乘
								           		 	</div>
								           		 	<div style="float: left;margin-top: 0px;margin-left: 25px;font-size: 16px;font-weight: bolder;color:#78A3C6">
								                		增量
								           		 	</div>
								           		 	<div style="float: left;margin-top: 10px;margin-left: 3px;position: absolute;">
									                	<img src="resource/images/pasflw/line-2.png" alt=""/>
									           		 </div>
								           		 </div>
	  	  									</el-row>
	  	  											<div v-for="(item,index) in zlhdata" :key="index" class="" style="float: left;margin-top: 10px;margin-left: -15px;width：156px">
										                	<div style="float: left;margin-top: 0px;margin-left: 0px;    height: 12px;width:80px;text-align:center; font-weight: bolder;color:#ffffff;font-size:12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.70);">
										                		{{item.STATION_NM_CN}}
										           		 	</div>
										           		 	<div style="float: left;margin-top: 0px;margin-left: 0px;text-align:center; width:38px;font-weight: bolder;color:#ffffff;font-size:12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.70);">
										                		{{item.TOTAL_TIMES}}
										           		 	</div>
										           		 	<div v-if="item.isa" style="float: left;margin-top: 0px;margin-left: 10px;text-align:right; width:38px;font-weight: bolder;color:red;font-size:12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.70);">
										                		{{item.INCREASE}}
										           		 	</div>
										           		 	<div v-else style="float: left;margin-top: 0px;margin-left: 10px;text-align:right; width:38px;font-weight: bolder;color:green;font-size:12px;-webkit-transform-origin-x: 0;-webkit-transform: scale(0.70);">
										                		{{item.INCREASE_ABS}}
										           		 	</div>
										           		 	
										           		 	<div style="float: left;margin-top: 5px;margin-left: 3px;position: absolute;">
											                	<img src="resource/images/pasflw/line-2.png" alt=""/>
											           		 </div>
										           		 </div>
	  	  								</div>
	  	  							</el-col>
	  	  						</el-row>
			           		 </div>
	  	  				</el-row>
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
				       
				        <div id="fsklsc">
					        <div id="afsklchar" v-show="fsklsw" style="height:400px;width:1280px;padding: 2% 3% 0 3%;"></div>
					        <div id="bfsklchar" v-show="fsklsw" style="height:280px;width:1280px;padding: 0 3% 2% 3%;"></div>
				        </div>
				      
						<div id="" v-show="klzfsw" style="height:680px;width:1280px;position: relative;">
					        <div id="klzfchar" v-show="klzfsw" style="position: absolute;width:1220px;height:640px;left:50%;top:50%; 
								margin-left:-610px;margin-top:-320px;"></div>
						</div>
				      </div>
				    </slot>
				  </div>
				
  	  	</div>
  	  </div>
  
  	  
      <script type="text/javascript">
  
			       
		new Vue({
		  el: '#pfwd',
		  data:function(){
			return {
				modalTitle:'',
				isShow:false,
				fsklsw:false,
				klzfsw:false,
				alara:false,
				alar:true,
				alarb:false,
				gm:'',
				bm:'',
				vm:'',
				cm:'',
				tot:'',
				piedata:[],
				//tvm扫码总笔数
				befTimes:'',
				preTimes:'',
				//tvm扫码总张数
				befNums:'',
				preNums:'',
				//tvm扫码总金额
				befAmount:'',
				preAmount:'',
				//tvm支付宝 笔数 金额  售出数
				payTimes:'',
				payAmount:'0',
				payNums:'',
				//tvm银联 笔数 金额  售出数
				unionTime:'',
				unionAmount:'',
				unionNums:'',
				zfjdata:[],
				zfcdata:[],
				zfhdata:[],
				zljdata:[],
				zlcdata:[],
				zlhdata:[],
				alarmData:[],
					alarmget:[],
					alarma:[],
					alarmb:[],
					alarmb:[],
					alarmtp:[],
				date:"",
				when:'',
				dates:"",
				whens:'',
				summary:{
					asshow:false,
					dsshow:false,
					ascRate:"",
					changeTimes:'',
					dscRate:"",
					enterTimes:'',
					pfwAmount:"",
					mpfwAmount:"",
					hpfwAmount:"",
					hdate:""
				},
				flklData:'',
				qrcdAll:'',
				qrcdent:'',
				qrcdexit:'',
				pafAll:'',
				zfb:'',
				wechat:'',
				qrcdRate:'',
				upay:'',
				xlpfwpmchar:'',
				xlpfwOption:'',
				xlpfwData:'',
				sbchar:'',
				sbOption:'',
				sbData:'',
				chzLine:[],
				qrcdt:'',
				qrcdtotal:'',
				qrcdate:'',
				qrcdRa:'',
				ticlost:'',
				scct:'',
				tsgtotal:'',
				staEnd:'',
				opdata:[],
				eqml:[]
			}
		  },
		    mounted: function () {
		    	this.sbschar();
		    	this.initData();
		    	
		 		this.GetEqm();
			   this.GetTck();
			   this.timeReload();
		
		




        },
		  methods: {
		  
		  //初始化页面
		  initData:function(){
		  	 this.getTVMdata();
		    	
		    	this.getSbstat();
		   		this.getNowFormatnow();
		      	this.getFspafl(); 
		 		
		  		this.getPFWsmy();
		 	 	this.loadQrcdFluxIncome();
			   this.getZfuj();
			   this.getZfuc();
			   this.getZfuh();
			   this.getZlaj();
			   this.getZlac();
			   this.getZlah(); 
			   this.getEqmsata();
			   
			 
			   
			  
		  },
		  //定时刷新
		  timeReload:function(){
		  	var vueThis=this;
		  	setInterval(function() {
                  vueThis.initData();
                }, 300000);
		  },
		  //获取票务访问信息
		  GetTck:function(){
		  	var vueThis=this;
		  	$.post("synt/GetMopNums.action",{"date":vueThis.date}, function(data){
		  			vueThis.qrcdt=data.qrcdt;
		  			vueThis.qrcdtotal=data.qrcdtotal;
		  			vueThis.qrcdate=data.qrcdate.substring(0,4)+"."+data.qrcdate.substring(4,6)+"."+data.qrcdate.substring(6,8);
		  			vueThis.qrcdRa=(data.qrcdt/data.qrcdtotal*100).toFixed(0);
		  		
		  			vueThis.ticlost=data.ticlost;
		  			vueThis.tsgtotal=data.tsgtotal;
		  			vueThis.scct=data.scct;
		  			vueThis.staEnd=data.staEnd;
		  			vueThis.eqml=data.eqml;
		  			vueThis.opdata=data.opAmt;
		  		
		  	
		  	});
		  
		  },
		  //获取设备数量
		  GetEqm:function(){
		  	var vueThis=this;
		  	$.post("synt/GetEpNums.action",{"date":vueThis.date}, function(data){
		  		
		  		vueThis.gm=data.GM;
		  		vueThis.bm=data.BOM;
		  		vueThis.vm=data.TVM;
		  		vueThis.cm=data.CVM;
		  		vueThis.tot=data.total;
		  		var itg={};
		  		
		  		itg.name='闸机';
		  		itg.value=data.GM;
		  		vueThis.piedata.push(itg);
		  		
		  		var itb={};
		  		itb.name='BOM';
		  		itb.value=data.BOM;
		  		vueThis.piedata.push(itb);
		  		var itv={};
		  		itv.name='TVM';
		  		itv.value=data.TVM;
		  		vueThis.piedata.push(itv);
		  		var itc={};
		  		itc.name='CVM';
		  		itc.value=data.CVM;
		  		vueThis.piedata.push(itc);
		  		
		  		console.log(vueThis.piedata);
		  		vueThis.sbOption.series[0].data=vueThis.piedata;
		  		vueThis.sbchar.setOption(vueThis.sbOption);
		  		
		  	});
		  },
		  //数字滚动动画
		  Numcount:function(value){
		  	var vueThis=this;
		  	  
		  	 var options = {
			  useEasing : true, 
			  useGrouping : true, 
			  separator : '', 
			  decimal : '.', 
			  prefix : '', 
			  suffix : '' 
			};
			if(value=='a'){
			
			var pfwAmount = new CountUp("pfwAmount", 0,vueThis.summary.pfwAmount, 1, 5,options);
			 pfwAmount.start(); 
			 var mpfwAmount = new CountUp("mpfwAmount", 0,vueThis.summary.mpfwAmount, 1, 5,options);
			 mpfwAmount.start(); 
			 var changeTimes = new CountUp("changeTimes", 0,vueThis.summary.changeTimes, 1, 5,options);
			 changeTimes.start(); 
			 var enterTimes = new CountUp("enterTimes", 0,vueThis.summary.enterTimes, 1, 5,options);
			 enterTimes.start(); 
			// var hpfwAmount = new CountUp("hpfwAmount", 0,vueThis.summary.hpfwAmount, 1, 5,options);
			// hpfwAmount.start(); 
			}
			var optionsa = {
			  useEasing : true, 
			  useGrouping : true, 
			  separator : '', 
			  decimal : '', 
			  prefix : '', 
			  suffix : '' 
			};
			if(value=='b'){
			
			var befTimes = new CountUp("befTimes", 0,vueThis.befTimes, 0, 5,optionsa);
			 befTimes.start(); 
			 var preTimes = new CountUp("preTimes", 0,vueThis.preTimes, 0, 5,optionsa);
			 preTimes.start(); 
			 var befNums = new CountUp("befNums", 0,vueThis.befNums, 0, 5,optionsa);
			 befNums.start(); 
			 var preNums = new CountUp("preNums", 0,vueThis.preNums, 0, 5,optionsa);
			 preNums.start(); 
			 var befAmount = new CountUp("befAmount", 0,vueThis.befAmount, 0, 5,optionsa);
			 befAmount.start(); 
			 var preAmount = new CountUp("preAmount", 0,vueThis.preAmount, 0, 5,optionsa);
			 preAmount.start(); 
			 
	
			 var payTimes = new CountUp("payTimes", 0,vueThis.payTimes, 0, 5,optionsa);
			 payTimes.start(); 
			  var payAmount = new CountUp("payAmount", 0,vueThis.payAmount, 0, 5,optionsa);
			 payAmount.start(); 
			  var payNums = new CountUp("payNums", 0,vueThis.payNums, 0, 5,optionsa);
			 payNums.start(); 
			   var unionTime = new CountUp("unionTime", 0,vueThis.unionTime, 0, 5,optionsa);
			 unionTime.start(); 
			   var unionAmount = new CountUp("unionAmount", 0,vueThis.unionAmount, 0, 5,optionsa);
			 unionAmount.start(); 
			   var unionNums = new CountUp("unionNums", 0,vueThis.unionNums, 0, 5,optionsa);
			 unionNums.start(); 
			 }
			 
			 if(value=='c'){
			 var qrcdAll = new CountUp("qrcdAll", 0,vueThis.qrcdAll, 1, 5,options);
			 qrcdAll.start(); 
			  var qrcdent = new CountUp("qrcdent", 0,vueThis.qrcdent, 1, 5,options);
			 qrcdent.start(); 
			  var qrcdexit = new CountUp("qrcdexit", 0,vueThis.qrcdexit, 1, 5,options);
			 qrcdexit.start(); 
			
			 var zfbe = new CountUp("zfbe", 0,vueThis.zfb.ENTER_TIMES, 0, 5,optionsa);
			 zfbe.start(); 
			 var zfbx = new CountUp("zfbx", 0,vueThis.zfb.EXIT_TIMES, 0, 5,optionsa);
			 zfbx.start(); 
			 var zfbm = new CountUp("zfbm", 0,vueThis.zfb.EXIT_TIMES+vueThis.zfb.ENTER_TIMES, 0, 5,optionsa);
			 zfbm.start(); 
			 
			  var upaye = new CountUp("upaye", 0,vueThis.upay.ENTER_TIMES, 0, 5,optionsa);
			 upaye.start(); 
			 var upayx = new CountUp("upayx", 0,vueThis.upay.EXIT_TIMES, 0, 5,optionsa);
			 upayx.start(); 
			 var upaym = new CountUp("upaym", 0,vueThis.upay.EXIT_TIMES+vueThis.upay.ENTER_TIMES, 0, 5,optionsa);
			 upaym.start(); 
			 
			 var wete = new CountUp("wete", 0,vueThis.wechat.ENTER_TIMES, 0, 5,optionsa);
			 wete.start(); 
			 var wetx = new CountUp("wetx", 0,vueThis.wechat.EXIT_TIMES, 0, 5,optionsa);
			 wetx.start(); 
			 var wetm = new CountUp("wetm", 0,vueThis.wechat.EXIT_TIMES+vueThis.wechat.ENTER_TIMES, 0, 5,optionsa);
			 wetm.start(); 
			 }
		  },
		  //客流增幅缩放
		  klzfDetl:function(){
		  	var vueThis=this;
		  		 vueThis.isShow=true;
		  		 vueThis.fsklsw=false;
		  		  vueThis.klzfsw=true;
		  		
		  		vueThis.modalTitle='客流增幅增量';
		  	
		  	var czyds=$('#klzfzl').clone(true);
					$('#klzfchar').html(czyds);
					$($("#klzfchar").children("div").get(0)).css('transform','scale(1.5)');
					$($("#klzfchar").children("div").get(0)).css('margin-left','320px');
					$($("#klzfchar").children("div").get(0)).css('margin-top','215px');
			
		  },
		  	 //分时客流
		  fsklDetl:function(){
		  	var vueThis=this;
		  		 vueThis.isShow=true;
		  		 vueThis.fsklsw=true;
		  		 vueThis.klzfsw=false;
		  		
		      vueThis.modalTitle='全日分时客流累计';
		      vueThis.fsklchars('afsklchar','bfsklchar');
		  },
		  
		   onFull:function(){
			
			$('#fullsc').css('transform','scale(1.5)');
			},
			
			  onClose:function() {
		  	$('#fullsc').css('transform','scale(1)');
			this.isShow = false;
			
			},
			
		  	  //获取数据总览数据
		  getPFWsmy:function(){
		  
		  	var vueThis=this;
		
		  		var week_date="<%=week_date%>";
		  		
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
						$("#asd").css("color",'#03A781');
						
					}
					
					
					vueThis.summary.changeTimes=data.changeTimes;
					vueThis.summary.enterTimes=data.enterTimes;
					vueThis.summary.pfwAmount=data.pfwAmount;
					vueThis.summary.mpfwAmount=data.mpfwAmount;
					vueThis.summary.hpfwAmount=data.hpfwAmount;
					var start_day=data.Mdate;
					var start_day_tp=start_day.substr(0,4)+"."+start_day.substr(4,2)+"."+start_day.substr(6,2);		
					vueThis.summary.hdate=start_day_tp;
					vueThis.Numcount('a');
					 console.log("历史日期:"+vueThis.summary.hdate);
			     
				}); 
		  },
		  
		  //加载“二维码总览”数据
    	loadQrcdFluxIncome:function(){
    		 	var vueThis=this;
    		$.post("qrcd/get_qrcdfluxincome.action", {"sel_flag":"flux_new","start_day":vueThis.date}, function(data){
    			if(data){
   					console.log("二维码总览:"+data);
   					//for (var i=0;i<=data.length-1;i++){
   					vueThis.qrcdAll=((data[0].ENTER_TIMES+data[0].EXIT_TIMES)/10000).toFixed(1);
   					vueThis.qrcdent=(data[0].ENTER_TIMES/10000).toFixed(1);
   					vueThis.qrcdexit=(data[0].EXIT_TIMES/10000).toFixed(1);
   					vueThis.zfb=data[1];
   					vueThis.upay=data[2];
   					vueThis.wechat=data[3];
   					vueThis.qrcdRate=((data[0].ENTER_TIMES+data[0].EXIT_TIMES)/(data[4].ENTER_TIMES+data[4].EXIT_TIMES)*100).toFixed(0);
   				
   					vueThis.Numcount('c');
   					//}
   					
   					
    			}
    		});
    	},
    	//切换告警信息
    	switchalarm:function(st){
    		var vueThis=this;
    			if(st=='ay'){
    				vueThis.alara=true;
    				vueThis.alar=false;
    				//vueThis.alarmData =vueThis.alarma; 
    			}
    			if(st=='an'){
    				vueThis.alara=false;
    				vueThis.alar=true;
    				//vueThis.alarmData =vueThis.alarmget; 
    			}
    			if(st=='by'){
    				vueThis.alarb=true;
    				vueThis.alar=false;
    				//vueThis.alarmData =vueThis.alarmb; 
    			}
    			if(st=='bn'){
    				vueThis.alarb=false;
    				vueThis.alar=true;
    				//vueThis.alarmData =vueThis.alarmget; 
    			}
    	},
    	//获取告警信息
    	getEqmsata:function(){
    		 	var vueThis=this;
    		 	
    		$.post("synt/GetEupState.action",function(data){
    		//$.post("http://172.16.98.53/operation/api/v1/external/alarm/query",function(data){
   				vueThis.alarmData = data;
   				vueThis.alarmget = data;
   				vueThis.alarma=[];
   				vueThis.alarmb=[];
   				vueThis.alarmtp=[];
				 for (var i=0;i<data.length;i++){
				     var it=data[i];
				     
				     var date = new Date(it.alarmTime);//时间戳为10位需*1000，时间戳为13位的话不需乘1000

					       var Y = date.getFullYear();
				
				        var M = date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1;
				
				        var D = date.getDate() < 10 ? '0'+(date.getDate()) : date.getDate();
				        
				        var da=Y+M+D;
				        
				        console.log(da);
				     if(it.level==4){
				     	vueThis.alarmb.push(it);
				     	if(da==vueThis.date){
				     		vueThis.alarmtp.push(it);
				     	}
				     	
				     }
				 	if(it.level==5){
				     	vueThis.alarma.push(it);
				     	if(da==vueThis.date){
				     		vueThis.alarmtp.push(it);
				     	}
				     	
				     }
				 }
				 if(vueThis.alarmtp){
				 
					 for (var j=0;vueThis.alarmtp.length;j++){
					 		var rid=vueThis.alarmtp[j].resourceId;
					 	//账务处理 13937    交通卡13026   通银 13028  通畅  13027   云更新 13050  清分对外前置  13025  前置数据库  13938   应用管理服务器  13421
						//后台数据库  13939  账务数据库  13940 MCC综合前置  13941	
						if(rid=="13937"){
							  $("#finaop").attr("src",'resource/images/syntheboard/1-56.png');
			   					$("#finaop").css('animation', 'twinkling 1.5s ease-out  20');
						}
						if(rid=="13026"){
							  $("#transcard").attr("src",'resource/images/syntheboard/1-59.png');
			   					$("#transcard").css('animation', 'twinkling 1.5s ease-out  20');
						}
					 	if(rid=="13028"){
							  $("#ty").attr("src",'resource/images/syntheboard/1-58.png');
			   					$("#ty").css('animation', 'twinkling 1.5s ease-out  20');
						}	
					 	if(rid=="13027"){
							  $("#tc").attr("src",'resource/images/syntheboard/1-58.png');
			   					$("#tc").css('animation', 'twinkling 1.5s ease-out  20');
						}
						if(rid=="13050"){
							  $("#cloudupd").attr("src",'resource/images/syntheboard/1-55.png');
			   					$("#cloudupd").css('animation', 'twinkling 1.5s ease-out  20');
						}
						if(rid=="13025"){
							  $("#qffront").attr("src",'resource/images/syntheboard/1-49.png');
			   					$("#qffront").css('animation', 'twinkling 1.5s ease-out  20');
						}
						if(rid=="13938"){
							  $("#frontdb").attr("src",'resource/images/syntheboard/1-51.png');
			   					$("#frontdb").css('animation', 'twinkling 1.5s ease-out  20');
						}
						if(rid=="13421"){
							  $("#appmana").attr("src",'resource/images/syntheboard/1-48.png');
			   					$("#appmana").css('animation', 'twinkling 1.5s ease-out  20');
						}
						if(rid=="13940"){
							  $("#finadb").attr("src",'resource/images/syntheboard/1-57.png');
			   					$("#finadb").css('animation', 'twinkling 1.5s ease-out  20');
						}
						if(rid=="13941"){
							  $("#mcc").attr("src",'resource/images/syntheboard/1-46.png');
			   					$("#mcc").css('animation', 'twinkling 1.5s ease-out  20');
						}
					 }
				 }	
   					console.log(vueThis.alarma);
    			
    		}).error(function(data){
    			console.log("aaaacccc=================");
    			console.log(data);
    		});
    	},
		  //获取TVM数据
    	getTVMdata:function(){
    		 	var vueThis=this;
    		 	
    		$.post("synt/GetTVMdata.action",function(data){
    			var it=data;
   					
   					
   				vueThis.befTimes = it.befTimes;
					vueThis.preTimes = it.preTimes;
					vueThis.befNums = it.befNums;
					vueThis.preNums = it.preNums;
					vueThis.befAmount = it.befAmount;
					vueThis.preAmount = it.preAmount;
					console.log("当天总金额:"+vueThis.preAmount);
					
					//tvm 支付宝，银联 笔数 金额  售出数
					vueThis.payTimes = it.times;
					vueThis.payAmount = it.amount;
					vueThis.payNums = it.nums;
					vueThis.unionTime = it.unionTimes;
					vueThis.unionAmount = it.unionAmount;
					vueThis.unionNums = it.unionNums;
   					
   					
   					vueThis.Numcount('b');
   					
    			
    		}).error(function(data){
    			console.log("aaaacccc=================");
    			console.log(data);
    		});
    	},
		 // 插入 
			//参数说明：str表示原字符串变量，flg表示要插入的字符串，sn表示要插入的位置
			insert_flg:function(str,flg,sn){
			    var newstr="";
			    for(var i=0;i<str.length;i+=sn){
			        var tmp=str.substring(i, i+sn);
			        newstr+=tmp+flg;
			    }
			    return newstr;
			},

		  //获取设备状态数据
            getSbstat:function(){
            var vueThis=this;
            vueThis.sbchar.setOption(vueThis.sbOption); 
             var selTypes=[1,3];
            	/* 	$.post("distrc/GetDstpflw.action",{"date":vueThis.date,"size":20,"selType":selTypes}, function(data){
					var data_name = [];
					var item = {};
					
					console.log("区域客流:"+data);
					
					
					 for (var i=0;i<=2;i++){
					       item=new Object();
					       item.name=data[i]['DISTRICT_CODE'];
					       item.value=data[i]['IN_PASS_NUM'];
						
						data_name.push(item);
					}
					vueThis.sbOption.series[0].data = data_name;
				
					vueThis.sbchar.setOption(vueThis.sbOption); 
	
			     
				});  */
            },
		  
		  // 设备状态图表
		  		sbschar:function(){
		  		 var vueThis=this;
		  			//初始化echarts图表
                var myChart;
                myChart = echarts.init(document.querySelector('#sbstat'));
				vueThis.sbchar=myChart;
               
                	option = {
					   
					    tooltip : {
					        trigger: 'item',
					        formatter: "{a} <br/>{b} : {c}"+" ({d}%)"
					    },
					     legend: {
					        orient: 'vertical',
					        x: 'left',
					        y:'bottom',
					        textStyle: {color: '#ffffff'},
					        data:['闸机','BOM','CVM','TVM']
					    },
						grid:{y2:17,x:45,y:0,x2:10},
					    series : [
					        {
					            name:'',
					            type:'pie',
					            radius : '40%',
					            center: ['48%', '30%'],
					            //roseType: 'radius',
					            label: {
					               normal: {
										show: true,
										textStyle: {
											color:'#ffffff',
											fontWeight: 300,
											fontSize: 6 //文字的字体大小
										},
										formatter: '{b}{c}'+'({d}%)',
										position:'outside'
					                }
					            },
					            labelLine: {
					            	show:false,
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
								data:[
						                {value:335, name:'直接访问'},
						                {value:310, name:'邮件营销'},
						                {value:234, name:'联盟广告'},
						                {value:135, name:'视频广告'},
						                {value:1548, name:'搜索引擎'}
						            ],	
					            animationType: 'scale',
					            animationEasing: 'elasticOut',
					            animationDelay: function (idx) {
					                return Math.random() * 200;
					            }
					        }
					    ]
					};
                	
                	vueThis.sbOption=option;
                	
             
		  		},
		//增幅增量切换
		zlzfswitch:function(sta){
			if(sta=='czzf'){
			$("#chzzf").css("display","block");
			$("#czzf").css("background","url(resource/images/syntheboard/shishikeliu_icon_selected.png) no-repeat");
			$("#chzzl").css("display","none");
			$("#czzl").css("background","url(resource/images/syntheboard/shishikeliu_icon_normal.png) no-repeat");
			}
			if(sta=="czzl"){
			$("#chzzl").css("display","block");
			$("#czzl").css("background","url(resource/images/syntheboard/shishikeliu_icon_selected.png) no-repeat");
			$("#chzzf").css("display","none");
			$("#czzf").css("background","url(resource/images/syntheboard/shishikeliu_icon_normal.png) no-repeat");
			}
		
		},
		  
		 
		  //获取各车站换乘客流增幅数据
		  getZfuh:function(){
		  
		  	var vueThis=this;
		
		  		var week_date="<%=week_date%>";
		  		
		  		vueThis.zfhdata=[];
		  	
				$.post("zfuchzpfw/GetZfuChzpfw.action",{"date":vueThis.date,"controlDate":week_date,"fluxType":3,"sortType":1,"size":7}, function(data){
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
		  	
				$.post("zlchzpfw/GetZlaChzpfw.action",{"date":vueThis.date,"controlDate":week_date,"fluxType":3,"sortType":1,"size":7}, function(data){
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
		  	
				$.post("zfuchzpfw/GetZfuChzpfw.action",{"date":vueThis.date,"controlDate":week_date,"fluxType":2,"sortType":1,"size":7}, function(data){
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
		  	
				$.post("zlchzpfw/GetZlaChzpfw.action",{"date":vueThis.date,"controlDate":week_date,"fluxType":2,"sortType":1,"size":7}, function(data){
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
		  	
				$.post("zfuchzpfw/GetZfuChzpfw.action",{"date":vueThis.date,"controlDate":week_date,"fluxType":1,"sortType":1,"size":7}, function(data){
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
		  	
				$.post("zlchzpfw/GetZlaChzpfw.action",{"date":vueThis.date,"controlDate":week_date,"fluxType":1,"sortType":1,"size":7}, function(data){
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
		
		
		  //获取当前时间
            getNowFormatnow:function() {
                var vuThis=this;
                var date = new Date();
                //var seperator1 = "-";
                var year = date.getFullYear();
                var month = (date.getMonth() + 1).toString();
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
                if (nowMins >= 0 && nowMins <= 9) {
                    nowMins = "0" + nowMins;
                	}
                var currentdate = year + month + strDate+nowHours+nowMin;
                //获取当前时刻
                var now=currentdate+'00';
                console.log("当前时刻"+now);
                vuThis.when=now;
               
                var date= year + month + strDate;
                 vuThis.date=date;
                   console.log("当前日期"+date);
                    var nowMina= new Date().getMinutes(); 
                  if (nowMina >= 0 && nowMina <= 9) {
                    nowMina = "0" + nowMina;
                }
                    var whens=nowHours+":"+nowMina;
                	vuThis.whens=whens;
                	
                	var dates= year +"."+ month +"."+ strDate;
                	vuThis.dates=dates;

              /*   //获取星期
                var a = new Array("日", "一", "二", "三", "四", "五", "六");
                var week = new Date().getDay();
                var str = "星期"+ a[week];
                //alert(str);
                vuThis.day=str;
                console.log(vuThis.now+vuThis.now); */


                return currentdate;
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
					vueThis.fsklchar(data);
				  });
		  },
		  
		  		//分时客流图表
		  		
		  		fsklchar: function (cda) {
		  		/*   // 路径配置
		        require.config({
		            paths: {
		                echarts: 'resource/echarts/build/dist'
		            }
		        });
        
        // 使用
		        require(
		            [
		                'echarts',
		                //'echarts/theme/dark1',
		                'echarts/chart/bar',
		                'echarts/chart/line'
		            ], */
		  		
                var myChart = echarts.init(document.getElementById('fskla')); 
                
                
                /*List<String> time_period=new ArrayList();//时刻
		    List fir_times=new ArrayList();//第一天客流量
		    List sec_times=new ArrayList();//第二天客流量
		    List today_times=new ArrayList();//当天客流量
		    List pre_times=new ArrayList();//预测客流量
		    List fir_fen_times=new ArrayList();//第一天分时客流量
		    List sec_fen_times=new ArrayList();//第二天分时客流量
		    List fen_times=new ArrayList();//当天客分时流量
		    JSONObject total_times=new JSONObject();//总客流量
		    String predict_time="";*/
		    //var pre_times=new Array();
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
				        
				        		console.log(params);
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
				            name:"预测",
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
				var myChart1 = echarts.init(document.getElementById('fsklb')); 
				myChart1.setOption(option1);
            }
            
           
		  
		      
		      
		    
		    },
		  filters: {
		  	amendNum:function(value){
		  		var val=parseInt(value);
		  		return val;
		  },
		  amendT:function(value){
		  	var date = new Date(value);//时间戳为10位需*1000，时间戳为13位的话不需乘1000

	       var Y = date.getFullYear();

        var M = date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1;

        var D = date.getDate() < 10 ? '0'+(date.getDate()) : date.getDate();

        var h = date.getHours()< 10 ? '0'+(date.getHours()) : date.getHours();

        var m = date.getMinutes() < 10 ? '0'+(date.getMinutes()) : date.getMinutes();
	
	        var time= M+'.'+D+'/'+h+':'+m;
	        return time;
		  },
		  amendS:function(value){
		  	var sta='';
		  	if(value==1){
		  	sta="提示";
		  	}
		  	if(value==2){
		  	sta="警告";
		  	}
		  	if(value==3){
		  	sta="普通";
		  	}
		  	if(value==4){
		  	sta="严重";
		  	}
		  	if(value==5){
		  	sta="紧急";
		  	}
		  	return sta;
		  },
		  amName:function(value){
		  var name='';
		  	if(value=="第一运营公司"){
		  		name='运一'
		  	}
		  	if(value=="第二运营公司"){
		  		name='运二'
		  	}
		  	if(value=="第三运营公司"){
		  		name='运三'
		  	}
		  	if(value=="第四运营公司"){
		  		name='运四'
		  	}
		  	if(value=="磁浮运营公司"){
		  		name='磁浮'
		  	}
		  	if(value=="申凯运营公司"){
		  		name='申凯'
		  	
		  }
		  	return name;
		  }
			
		}
		});
		

      </script>
  </body>
</html>