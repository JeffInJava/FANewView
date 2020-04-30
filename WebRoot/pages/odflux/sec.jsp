<%@ page language="java" import="java.util.*,java.lang.*,net.sf.json.*,java.sql.*,com.util.*,java.text.*,java.io.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

DateFormat df = new SimpleDateFormat("yyyyMM");
Calendar c = Calendar.getInstance();
c.add(Calendar.MONTH,-2);
String selMonth=df.format(c.getTime());
%>

<!DOCTYPE html>
<html>
  <head>
    <base href="<%=basePath%>">
    <title>实际运能填写</title>		
	<link rel="stylesheet" type="text/css" href="style/common/style/report.css" />
	<link rel="stylesheet" type="text/css" href="resource/eleme/index.css" />
	<script type="text/javascript" src="style/common/js/report.js"></script>
	<script src="resource/jquery/js/jquery-1.7.2.js" type="text/javascript"></script>
	<script src="resource/eleme/vue.js" type="text/javascript"></script>
	<script src="resource/eleme/index.js" type="text/javascript"></script>
    <script src="resource/inesa/js/common.js"></script>
    
	<style type="text/css">
		.cons{margin-top:10px;}
		.cons table{border:solid #ddd; border-width:1px 0px 0px 1px;color:#333;text-align: center;font-size:12px;}
		.cons table tr th,.cons table tr td {border:solid #ddd; border-width:0px 1px 1px 0px; }
		.cons table tr th{background-color:#337ab7;color: #fff;}
		.cons table tr td{font-weight:normal}
		.cons table tr input{width:60px;}
		.bg{background-color: #d9edf7;}
		.descriptions{position:absolute;bottom:-40px}
		.descriptions table{margin-top:10px;color:#333;font-size:12px;}
		.tdbg{background-color:#d9edf7;}
	</style>
</head>
<body>
  <div id="app">
	<TABLE style="TABLE-LAYOUT: fixed" height=28 cellSpacing=0 cellPadding=0 width="100%"> 
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
								<TD width="25%">
									查询月份：<el-date-picker id="start_mon" v-model="start_mon" type="month" format="yyyyMM"/>	
								</TD> 
								<td>
									<input type="button" class="combut" onclick="selCapData()" value="查询" onMouseOver="onmouseClass(this)" onMouseOut="outmouseClass(this)" onMouseDown="downmouseClass(this)">
									<input type="button" class="combut" onclick="saveDate()" value="保存" onMouseOver="onmouseClass(this)" onMouseOut="outmouseClass(this)" onMouseDown="downmouseClass(this)">
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
					<th width="80px">编组数</th>
					<th width="80px">人数</th>
					<th width="100px">满载率</th>
				</tr>
			</thead>
			<tbody></tbody>
		</table>
	</div>
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

    



	//<el-time-picker v-model="value2"></el-time-picker>
	new Vue({
	    el: '#app',
	    data: function() {
	      return { value2:'',start_mon:new Date("<%=selMonth %>".substr(0,4),"<%=selMonth %>".substr(4,2))}
	    }
	});

	//查询数据
	function selCapData(){
		var tp_str="";
		var start_mon=$("#start_mon input").val();
		doPost("sec/get_traincap.action", {"start_mon":start_mon,"sel_flag":"1"}, function(data){
			$.each(data,function(i,v){
				if(v.REAL_FULL_PRE){
					tp_str+="<tr><td>"+v.LINE_NM+"<input type='hidden' name='line_id' value='"+v.LINE_ID+"'>" +
					"<input type='hidden' name='stmt_day' value='"+v.STMT_DAY+"'></td><td>"+v.STMT_MON+"</td><td>"+v.TIME_PERIOD+"</td><td>"+v.SECTIONNAME+"</td><td>"+
					v.SEC_FLUX+"</td><td class='tdbg'><input name='real_start_time_pre' onClick=\"WdatePicker({dateFmt:'HH:mm:ss'})\" value='"+v.REAL_START_TIME_PRE+"'></td>" +
					"<td class='tdbg'><input name='real_start_time_next' onClick=\"WdatePicker({dateFmt:'HH:mm:ss'})\" value='"+v.REAL_START_TIME_NEXT+"'></td><td>"+v.REAL_START_TIME_DIF+"</td><td>"+v.REAL_FIR_OCCUPY_TIME+"</td>" +
					"<td class='tdbg'><input name='real_lines' value='"+v.REAL_LINES+"' style='width:40px'></td><td>"+v.REAL_END_TIME_DIF+"</td><td>"+v.REAL_LAST_OCCUPY_TIME+"</td>" +
					"<td class='tdbg'><input name='real_end_time_last' onClick=\"WdatePicker({dateFmt:'HH:mm:ss'})\" value='"+v.REAL_END_TIME_LAST+"'></td>" +
					"<td class='tdbg'><input name='real_end_time_fir' onClick=\"WdatePicker({dateFmt:'HH:mm:ss'})\" value='"+v.REAL_END_TIME_FIR+"'></td><td>"+v.REAL_TRAINNUM+"</td>" +
					"<td>"+v.TRAINCOMPOSE+"</td><td>"+v.TRAINFIXEDNUM+"</td><td>"+v.REAL_FULL_PRE+"%</td></tr>";
				}else{
					tp_str+="<tr><td>"+v.LINE_NM+"<input type='hidden' name='line_id' value='"+v.LINE_ID+"'>" +
					"<input type='hidden' name='stmt_day' value='"+v.STMT_DAY+"'></td><td>"+v.STMT_MON+"</td><td>"+v.TIME_PERIOD+"</td><td>"+v.SECTIONNAME+"</td><td>"+
					v.SEC_FLUX+"</td><td class='tdbg'><input name='real_start_time_pre' onClick=\"WdatePicker({dateFmt:'HH:mm:ss'})\"></td>" +
					"<td class='tdbg'><input name='real_start_time_next' onClick=\"WdatePicker({dateFmt:'HH:mm:ss'})\"></td><td></td><td></td>" +
					"<td class='tdbg'><input name='real_lines' style='width:40px'></td><td></td><td></td><td class='tdbg'><input name='real_end_time_last' onClick=\"WdatePicker({dateFmt:'HH:mm:ss'})\"></td>" +
					"<td class='tdbg'><input name='real_end_time_fir' onClick=\"WdatePicker({dateFmt:'HH:mm:ss'})\"></td><td></td>" +
					"<td>"+v.TRAINCOMPOSE+"</td><td>"+v.TRAINFIXEDNUM+"</td><td></td></tr>";
				}
				
			});
			$("#capId tbody").html(tp_str);
			
			//绑定onblur事件
			$("input").blur(function(){
  				calculate(this);
			});
		});
	}
	
	//根据填写内容，计算相应的数据
	function calculate(obj){
		var tds=$(obj).parent("td").parent("tr").find("td");//获取同级的td
		var tm=$(tds[2]).text().toString().split("~");//时间
		var sttm,sttn,lns,stls,sttf,dt;
		if(tm){
			sttm=$(tds).find("input[name='real_start_time_pre']").eq(0).val();//起始时段前最后列车发点
			sttn=$(tds).find("input[name='real_start_time_next']").eq(0).val();//起始时段内第一列车发点
			lns=$(tds).find("input[name='real_lines']").eq(0).val();//中值开行列车数
			stls=$(tds).find("input[name='real_end_time_last']").eq(0).val();//结束时段内最后一列车发点
			sttf=$(tds).find("input[name='real_end_time_fir']").eq(0).val();//结束时段后第一列车发点
			
			if(sttm){
				sttm=sttm.toString().split(":");
				//计算第一列车占用区段时长（秒）
				dt=tm[0].substr(0,2)*3600+tm[0].substr(3,2)*60-sttm[0]*3600-sttm[1]*60-sttm[2]*1;
				if(dt){
					$(tds[8]).text(dt);
				}
			}
			
			if(sttn){
				sttn=sttn.toString().split(":");
				//计算起始点运营间隔（秒）
				if(sttm){
					dt=sttn[0]*3600+sttn[1]*60+sttn[2]*1-sttm[0]*3600-sttm[1]*60-sttm[2]*1;
					if(dt){
						$(tds[7]).text(dt);
					}
				}
			}
			
			if(stls){
				stls=stls.toString().split(":");
				//计算结束时段内最后一列车发点
				dt=tm[1].substr(0,2)*3600+tm[1].substr(3,2)*60-stls[0]*3600-stls[1]*60-stls[2]*1;
				if(dt){
					$(tds[11]).text(dt);
				}
			}
			if(sttf){
				sttf=sttf.toString().split(":");
				//计算结束时段后第一列车发点
				if(stls){
					dt=sttf[0]*3600+sttf[1]*60+sttf[2]*1-stls[0]*3600-stls[1]*60-stls[2]*1;
					if(dt){
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
				params.lineId.push($(tds).find("input[name='line_id']").eq(0).val());
				params.stmtDay.push($(tds).find("input[name='stmt_day']").eq(0).val());
				params.realStartTimePre.push($(tds).find("input[name='real_start_time_pre']").eq(0).val());
				params.realStartTimeNext.push($(tds).find("input[name='real_start_time_next']").eq(0).val());
				
				params.realStartTimeDif.push($(tds[7]).text());
				params.realFirOccupyTime.push($(tds[8]).text());
				params.realLines.push($(tds).find("input[name='real_lines']").eq(0).val());
				params.realEndTimeDif.push($(tds[10]).text());
				
				params.realLastOccupyTime.push($(tds[11]).text());
				params.realEndTimeLast.push($(tds).find("input[name='real_end_time_last']").eq(0).val());
				params.realEndTimeFir.push($(tds).find("input[name='real_end_time_fir']").eq(0).val());
				params.realTrainnum.push($(tds[14]).text());
				params.realFullPre.push($(tds[17]).text());
			}
		});
		params.sel_flag="2";
		doPost("sec/get_traincap.action",params, function(data){
			alert("保存成功!");
		});
	}
</script>
</body>
</html>