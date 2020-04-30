<%@ page language="java" import="java.util.*,java.lang.*,net.sf.json.*,java.sql.*,com.util.*,java.text.*,java.io.*" pageEncoding="UTF-8"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

DateFormat df = new SimpleDateFormat("yyyyMM");
Calendar c = Calendar.getInstance();
c.add(Calendar.MONTH,-2);
String selMonth=df.format(c.getTime());

String referer = request.getHeader("referer");
String p_username="";
if(StringUtils.isNotBlank(referer)){
	try{
		p_username=referer.substring(referer.indexOf("p_username=")+11,referer.indexOf("&p_password"));
	}catch(Exception e){
		
	}
}
%>

<!DOCTYPE html>
<html>
  <head>
    <base href="<%=basePath%>">
    <title>实际运能填写</title>		
	<link rel="stylesheet" type="text/css" href="style/common/style/report.css" />
	<link rel="stylesheet" href="resource/element-ui/index.css" />
	
	<script type="text/javascript" src="style/common/js/report.js"></script>
	<script src="resource/jquery/js/jquery-1.7.2.js" type="text/javascript"></script>
    <script src="resource/inesa/js/common.js"></script>
    <script src="resource/vue/vue.min.js"></script>
    <script src="resource/element-ui/index.js"></script>
	<style type="text/css">
		.cons{margin-top:10px;}
		.cons table{border:solid #ddd; border-width:1px 0px 0px 1px;color:#333;text-align: center;font-size:12px;}
		.cons table tr th,.cons table tr td {border:solid #ddd; border-width:0px 1px 1px 0px; }
		.cons table tr th{background-color:#337ab7;color: #fff;}
		.cons table tr td{font-weight:normal}
		.cons table tr td input{padding:0px;padding-left:2px;}
		.el-time-panel__footer [type="button"]{margin:0px;}
		.bg{background-color: #d9edf7;}
		.descriptions{position:absolute;bottom:5px}
		.descriptions table{margin-top:10px;color:#333;font-size:12px;}
		.tdbg{background-color:#d9edf7;}
	</style>
</head>
<body>

	<TABLE id="app" style="TABLE-LAYOUT: fixed" height=28 cellSpacing=0 cellPadding=0 width="100%"> 
		<TBODY> 
			<TR height=1> 
				<TD width=1></TD><TD width=1></TD><TD width=1></TD> 
				<TD bgcolor="#fafafa"></TD> 
				<TD width=1></TD><TD width=1></TD><TD width=1></TD>
			</TR> 
			<TR height=1> 
				<TD></TD><TD bgcolor="#fafafa" colSpan=2></TD> 
				<TD bgcolor="#fafafa"></TD> 
				<TD bgcolor="#fafafa" colSpan=2></TD><TD></TD>
			</TR> 
			<TR height=1> 
				<TD></TD><TD bgcolor="#fafafa"></TD> 
				<TD bgcolor="#fafafa" colSpan=3></TD> 
				<TD bgcolor="#fafafa"></TD><TD></TD>
			</TR> 
			<TR> 
				<TD width=1 bgcolor="#fafafa"></TD> 
				<TD bgcolor="#fafafa" colSpan=5> 
					<TABLE style="TABLE-LAYOUT: fixed" height="100%" cellSpacing=0 cellPadding=3 width="100%"> 
						<TBODY> 
							<TR> 
								<td width="20%">
									查询月份：<el-date-picker id="start_mon" v-model="start_mon" type="month" format="yyyyMM" size='mini' style="width:120px;"/></el-col>
								</td> 
								<td>
									<input type="button" class="combut" id="selbtn" onclick="selCapData()" value="查询" onMouseOver="onmouseClass(this)" onMouseOut="outmouseClass(this)" onMouseDown="downmouseClass(this)" disabled="disabled">
									<input type="button" class="combut" id="savebtn" onclick="saveDate()" value="保存" onMouseOver="onmouseClass(this)" onMouseOut="outmouseClass(this)" onMouseDown="downmouseClass(this)" disabled="disabled">
								</td>
							</TR>
						</TBODY>
					</TABLE> 
				</TD> 
				<TD width=1 bgcolor="#fafafa"></TD>
			</TR> 
			<TR height=1> 
				<TD></TD><TD bgcolor="#fafafa"></TD> 
				<TD bgcolor="#fafafa" colSpan=3></TD> 
				<TD bgcolor="#fafafa"></TD><TD></TD>
			</TR> 
			<TR height=1> 
				<TD></TD><TD bgcolor="#fafafa" colSpan=2></TD> 
				<TD bgcolor="#fafafa"></TD> 
				<TD bgcolor="#fafafa" colSpan=2></TD><TD></TD>
			</TR> 
			<TR height=1> 
				<TD colSpan=3></TD> 
				<TD bgcolor="#fafafa"></TD> 
				<TD colSpan=3></TD>
			</TR> 
		</TBODY>
	</TABLE>
	<div class="cons">
		<table id="capId" cellpadding="0" cellspacing="0">
			<thead>
				<tr>
					<th width="130px">线路</th>
					<th width="100px">日期</th>
					<th width="100px">时间</th>
					<th width="110px">区间</th>
					<th width="80px">断面客流</th>
					<th width="100px">起始时段前最后列车发点</th>
					<th width="100px">起始时段内第一列车发点</th>
					<th width="80px">起始点运营间隔(秒)</th>
					<th width="90px">第一列车占用区段时长(秒)</th>
					<th width="70px">中值开行列车数</th>
					<th width="80px">终止点运营间隔(秒)</th>
					<th width="100px">最后一列车占用区段时长(秒)</th>
					<th width="100px">结束时段内最后一列车发点</th>
					<th width="100px">结束时段后第一列车发点</th>
					<th width="80px">运能</th>
					<th width="60px">编组数</th>
					<th width="60px">人数</th>
					<th width="100px">满载率</th>
					<th width="80px">修改人</th>
					<th width="90px">修改时间</th>
				</tr>
			</thead>
			<tbody></tbody>
		</table>
	</div>
	<div class="descriptions">
		<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td width="80px">填记说明：</td>
				<td style="background-color: #d9edf7">1、请大家填记黄色底色部分，公式自动计算。</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td style="background-color: #d9edf7">2、中值开行列车指在该时段区段内起始站始发的所有列车（含第一列和最后一列车）。</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td style="background-color: #d9edf7">3、秒的数量请估算到半分钟，如例所示。</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td style="background-color: #d9edf7">4、所有发点都是起始站实际载客列车发点。</td>
			</tr>
		</table>
		<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td width="80px">注：</td>
				<td width="160px">起始点运营间隔</td>
				<td>起始时段前最后列车发点至起始时段内第一列车发点的时间间隔</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>第一列车占用区段时长</td>
				<td>起始时段前最后列车发点至起始时间（即8:00）的时间间隔</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>终止点运营间隔</td>
				<td>结束时段内最后一列车发点至结束时段后第一列车发点的时间间隔</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>最后一列车占用区段时长</td>
				<td>结束时段内最后一列车发点至结束时段（即9:00）的时间间隔</td>
			</tr>
		</table>
	</div>

<script type="text/javascript">

	new Vue({
	    el: '#app',
	    data: function() {
	       return {start_mon:new Date("<%=selMonth %>".substr(0,4),"<%=selMonth %>".substr(4,2))}
	    }
	});
  
	var p_data,p_username="<%=p_username%>";
	$(function(){
		doPost("sec/get_traincap.action", {"username":p_username,"sel_flag":"2"}, function(data){
			if(data&&data.length>0&&data[0].NM>0){
				$("#selbtn").attr("disabled",false); 
				$("#savebtn").attr("disabled",false); 
			}else{
				alert("没有权限！");
			}
		});
	});
	//查询数据
	function selCapData(){
		if(p_username){//判断用户是否存在
			if(!ischange()){
				if(confirm("有数据项改动，是否需要保存？")){
					return;
				}
			}
			var tp_str="";
			doPost("sec/get_traincap.action", {"username":p_username,"start_mon":$("#start_mon input").val(),"sel_flag":"1"}, function(data){
				var tp_ds={};
				p_data=data;
				if(data&&data.length>=14){
					$(".descriptions").css("bottom","-100px");
				}else{
					$(".descriptions").css("bottom","5px");
				}
				$.each(data,function(i,v){
					if(v.REAL_FULL_PRE){
						tp_str+="<tr><td>"+v.LINE_NM+"<input type='hidden' name='line_id' value='"+v.LINE_ID+"'>" +
						"<input type='hidden' name='stmt_day' value='"+v.STMT_DAY+"'></td><td>"+v.STMT_MON+"</td><td>"+v.TIME_PERIOD+"</td><td>"+v.SECTIONNAME+"</td><td>"+
						v.SEC_FLUX+"</td><td class='tdbg'><el-time-picker v-model='real_start_time_pre"+i+"' size='mini' style='width:85px;'/></td>" +
						"<td class='tdbg'><el-time-picker v-model='real_start_time_next"+i+"' size='mini' style='width:85px;'/></td><td>"+v.REAL_START_TIME_DIF+"</td><td>"+v.REAL_FIR_OCCUPY_TIME+"</td>" +
						"<td class='tdbg'><input name='real_lines' value='"+v.REAL_LINES+"' style='width:40px'></td><td>"+v.REAL_END_TIME_DIF+"</td><td>"+v.REAL_LAST_OCCUPY_TIME+"</td>" +
						"<td class='tdbg'><el-time-picker v-model='real_end_time_last"+i+"' size='mini' style='width:85px;'/></td>" +
						"<td class='tdbg'><el-time-picker v-model='real_end_time_fir"+i+"' size='mini' style='width:85px;'/></td><td>"+v.REAL_TRAINNUM+"</td>" +
						"<td>"+v.TRAINCOMPOSE+"</td><td>"+v.TRAINFIXEDNUM+"</td><td>"+v.REAL_FULL_PRE+"%</td><td>"+(v.USER_NAME?v.USER_NAME:"")+"</td><td>"+(v.UPDATE_TIME?v.UPDATE_TIME:"")+"</td></tr>";
						tp_ds["real_start_time_pre"+i]=new Date(2016, 9, 10,v.REAL_START_TIME_PRE.toString().substr(0,2),v.REAL_START_TIME_PRE.toString().substr(3,2),v.REAL_START_TIME_PRE.toString().substr(6,2));
						tp_ds["real_start_time_next"+i]=new Date(2016, 9, 10,v.REAL_START_TIME_NEXT.toString().substr(0,2),v.REAL_START_TIME_NEXT.toString().substr(3,2),v.REAL_START_TIME_NEXT.toString().substr(6,2));
						tp_ds["real_end_time_last"+i]=new Date(2016, 9, 10,v.REAL_END_TIME_LAST.toString().substr(0,2),v.REAL_END_TIME_LAST.toString().substr(3,2),v.REAL_END_TIME_LAST.toString().substr(6,2));
						tp_ds["real_end_time_fir"+i]=new Date(2016, 9, 10,v.REAL_END_TIME_FIR.toString().substr(0,2),v.REAL_END_TIME_FIR.toString().substr(3,2),v.REAL_END_TIME_FIR.toString().substr(6,2));
					}else{
						tp_str+="<tr><td>"+v.LINE_NM+"<input type='hidden' name='line_id' value='"+v.LINE_ID+"'>" +
						"<input type='hidden' name='stmt_day' value='"+v.STMT_DAY+"'></td><td>"+v.STMT_MON+"</td><td>"+v.TIME_PERIOD+"</td><td>"+v.SECTIONNAME+"</td><td>"+
						v.SEC_FLUX+"</td><td class='tdbg'><el-time-picker v-model='real_start_time_pre"+i+"' size='mini' style='width:85px;'/></td>" +
						"<td class='tdbg'><el-time-picker v-model='real_start_time_next"+i+"' size='mini' style='width:85px;'/></td><td></td><td></td>" +
						"<td class='tdbg'><input name='real_lines' style='width:40px'></td><td></td><td></td><td class='tdbg'><el-time-picker v-model='real_end_time_last"+i+"' size='mini' style='width:85px;'/></td>" +
						"<td class='tdbg'><el-time-picker v-model='real_end_time_fir"+i+"' size='mini' style='width:85px;'/></td><td></td>" +
						"<td>"+v.TRAINCOMPOSE+"</td><td>"+v.TRAINFIXEDNUM+"</td><td></td><td></td><td></td></tr>";
						tp_ds["real_start_time_pre"+i]="";
						tp_ds["real_start_time_next"+i]="";
						tp_ds["real_end_time_last"+i]="";
						tp_ds["real_end_time_fir"+i]="";
					}
					
				});
				if(tp_str){
					$("#capId tbody").html(tp_str);
					new Vue({
					    el: '#capId',
					    data: function() {
					      return tp_ds;
					    }
					});
					
					//绑定onblur事件
					$("input").blur(function(){
		  				calculate(this);
					});
				}else{
					$("#capId tbody").html("");
					alert("未查询到数据！");
				}
				
			});
		}else{
			alert("未登录或没有权限！");
		}
	}
	
	//判断是否有数据更改
	function ischange(){
		var sttm,sttn,lns,stls,sttf,dt,is_flag=true,tp;
		sttm=$("#capId tr td:nth-child(6)").find("input");//起始时段前最后列车发点
		sttn=$("#capId tr td:nth-child(7)").find("input");//起始时段内第一列车发点
		lns=$("#capId").find("input[name='real_lines']");//中值开行列车数
		stls=$("#capId tr td:nth-child(13)").find("input");//结束时段内最后一列车发点
		sttf=$("#capId tr td:nth-child(14)").find("input");//结束时段后第一列车发点
		if(p_data&&p_data.length>0){
			$.each(p_data,function(i,v){
				tp=v.REAL_START_TIME_PRE?v.REAL_START_TIME_PRE:"";
				if(tp!=$(sttm[i]).val()){
					is_flag=false;
					return false;
				}
				
				tp=v.REAL_START_TIME_NEXT?v.REAL_START_TIME_NEXT:"";
				if(tp!=$(sttn[i]).val()){
					is_flag=false;
					return false;
				}
				
				tp=v.REAL_LINES?v.REAL_LINES:"";
				if(tp!=$(lns[i]).val()){
					is_flag=false;
					return false;
				}
				
				tp=v.REAL_END_TIME_LAST?v.REAL_END_TIME_LAST:"";
				if(tp!=$(stls[i]).val()){
					is_flag=false;
					return false;
				}
				
				tp=v.REAL_END_TIME_FIR?v.REAL_END_TIME_FIR:"";
				if(tp!=$(sttf[i]).val()){
					is_flag=false;
					return false;
				}
			});
		}
		return is_flag;
	}
	
	//根据填写内容，计算相应的数据
	function calculate(obj){
		
		var tds=$(obj).parent("div").parent("td").parent("tr").find("td");//获取同级的td
		var tm=$(tds[2]).text().toString().split("~");//时间
		var sttm,sttn,lns,stls,sttf,dt;
		if(tm){
			sttm=$(tds).find("input").eq(2).val();//起始时段前最后列车发点
			sttn=$(tds).find("input").eq(3).val();//起始时段内第一列车发点
			lns=$(tds).find("input").eq(4).val();//中值开行列车数
			stls=$(tds).find("input").eq(5).val();//结束时段内最后一列车发点
			sttf=$(tds).find("input").eq(6).val();//结束时段后第一列车发点
			
			if(sttm){
				sttm=sttm.toString().split(":");
				//计算第一列车占用区段时长（秒）
				dt=tm[0].substr(0,2)*3600+tm[0].substr(3,2)*60-sttm[0]*3600-sttm[1]*60-sttm[2]*1;
				if(dt==0||dt){
					$(tds[8]).text(dt);
				}
			}
			
			if(sttn){
				sttn=sttn.toString().split(":");
				//计算起始点运营间隔（秒）
				if(sttm){
					dt=sttn[0]*3600+sttn[1]*60+sttn[2]*1-sttm[0]*3600-sttm[1]*60-sttm[2]*1;
					if(dt==0||dt){
						$(tds[7]).text(dt);
					}
				}
			}
			
			if(stls){
				stls=stls.toString().split(":");
				//计算最后一列车占用区段时长
				dt=tm[1].substr(0,2)*3600+tm[1].substr(3,2)*60-stls[0]*3600-stls[1]*60-stls[2]*1;
				if(dt==0||dt){
					$(tds[11]).text(dt);
				}
			}
			if(sttf){
				sttf=sttf.toString().split(":");
				//计算终止点运营间隔
				if(stls){
					dt=sttf[0]*3600+sttf[1]*60+sttf[2]*1-stls[0]*3600-stls[1]*60-stls[2]*1;
					if(dt==0||dt){
						$(tds[10]).text(dt);
					}
				}
			}
			
			//计算运能
			var cap=(-$(tds[8]).text()/$(tds[7]).text()+lns*1+$(tds[11]).text()/$(tds[10]).text())*$(tds[15]).text()*$(tds[16]).text();
			if($(tds[7]).text()&&$(tds[10]).text()&&cap){
				$(tds[14]).text(Math.round(cap));
			}
			
			//计算满载率
			var full_per=($(tds[4]).text()/cap*100).toFixed(2);
			if(full_per&&cap){
				$(tds[17]).text(full_per+"%");
			}
		}
	}
	
	//保存填写数据
	function saveDate(){
		var params={lineId:[],stmtDay:[],realStartTimePre:[],realStartTimeNext:[],realStartTimeDif:[],realFirOccupyTime:[],
			realLines:[],realEndTimeDif:[],realLastOccupyTime:[],realEndTimeLast:[],realEndTimeFir:[],realTrainnum:[],realFullPre:[]},tds,trs=$("#capId tbody tr");
		$.each(trs,function(i,v){
			tds=$(v).find("td");
			if($(tds[17]).text()){
				params.lineId.push($(tds).find("input").eq(0).val());
				params.stmtDay.push($(tds).find("input").eq(1).val());
				params.realStartTimePre.push($(tds).find("input").eq(2).val());
				params.realStartTimeNext.push($(tds).find("input").eq(3).val());
				
				params.realStartTimeDif.push($(tds[7]).text());
				params.realFirOccupyTime.push($(tds[8]).text());
				params.realLines.push($(tds).find("input").eq(4).val());
				params.realEndTimeDif.push($(tds[10]).text());
				
				params.realLastOccupyTime.push($(tds[11]).text());
				params.realEndTimeLast.push($(tds).find("input").eq(5).val());
				params.realEndTimeFir.push($(tds).find("input").eq(6).val());
				params.realTrainnum.push($(tds[14]).text());
				params.realFullPre.push($(tds[17]).text());
			}
		});
		params.sel_flag="3";
		params.username=p_username;
		if(params.lineId.length>0){
			doPost("sec/get_traincap.action",params, function(data){
				alert("保存成功!");
				selCapData();
			});
		}else{
			alert("请填写修改项！");
		}
		
	}
</script>
</body>
</html>