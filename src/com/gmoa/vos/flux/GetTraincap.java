package com.gmoa.vos.flux;


import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import jsontag.JsonTagContext;
import jsontag.annotation.JsonTagAnnotation;
import jsontag.dao.JsonTagTemplateDaoImpl;
import jsontag.interf.IDoService;


/**
 * 根据月份查询本月最大断面客流、填写运能
 * 日期格式：yyyymm
 *
 */    
@JsonTagAnnotation(actionValue="/get_traincap.action",namespace="/sec",isJsonReturn=true)
public class GetTraincap extends JsonTagTemplateDaoImpl implements IDoService {
	private String start_mon;
	private String sel_flag;
	private String username;
	
	@Override
	public Object doService() throws Exception {
		List<Map<String,Object>> list=null;
		String sql="";
		if("1".equals(sel_flag)){
			sql="select to_number(aa.line_id)||'号线'||aa.sectiondirection line_nm,to_number(substr(aa.stmt_day,5,2))||'月'||to_number(substr(aa.stmt_day,7,2))||'日' stmt_mon,"+
			"aa.*,cc.user_name,cc.update_time from tbl_pw_traincap aa," +
			"( " +
			" select t1.line_id from RARD.TRDAS01 t1,RARD.TRDUS01 t2 where t1.depa_id=t2.dep_id and t2.user_id=? " +
			") bb," +
			"(" +
			"select line_id,stmt_day,user_name,to_char(to_date(update_time,'yyyymmddhh24miss'),'yyyy/mm/dd hh24:mi:ss') update_time from "+
			"(select ROW_NUMBER() OVER(PARTITION BY line_id,stmt_day ORDER BY update_time DESC) rn,tt.* from tbl_pw_traincap_log tt) where rn = 1 " +
			") cc where aa.line_id=bb.line_id and aa.line_id=cc.line_id(+) and aa.stmt_day=cc.stmt_day(+) and substr(aa.stmt_day,1,6)=? order by aa.line_id";
			list=jsonTagJdbcDao.getJdbcTemplate().queryForList(sql,username,start_mon);
			return list;
		}else if("2".equals(sel_flag)){
			sql="select count(t1.line_id) nm from RARD.TRDAS01 t1,RARD.TRDUS01 t2 where t1.depa_id=t2.dep_id and t2.user_id=?";
			list=jsonTagJdbcDao.getJdbcTemplate().queryForList(sql,username);
			return list;
		}else{
			String[] lineId=JsonTagContext.getRequest().getParameterValues("lineId[]");
			String[] stmtDay=JsonTagContext.getRequest().getParameterValues("stmtDay[]");
			String[] realStartTimePre=JsonTagContext.getRequest().getParameterValues("realStartTimePre[]");
			String[] realStartTimeNext=JsonTagContext.getRequest().getParameterValues("realStartTimeNext[]");
			String[] realStartTimeDif=JsonTagContext.getRequest().getParameterValues("realStartTimeDif[]");
			String[] realFirOccupyTime=JsonTagContext.getRequest().getParameterValues("realFirOccupyTime[]");
			String[] realLines=JsonTagContext.getRequest().getParameterValues("realLines[]");
			String[] realEndTimeDif=JsonTagContext.getRequest().getParameterValues("realEndTimeDif[]");
			String[] realLastOccupyTime=JsonTagContext.getRequest().getParameterValues("realLastOccupyTime[]");
			String[] realEndTimeLast=JsonTagContext.getRequest().getParameterValues("realEndTimeLast[]");
			String[] realEndTimeFir=JsonTagContext.getRequest().getParameterValues("realEndTimeFir[]");
			String[] realTrainnum=JsonTagContext.getRequest().getParameterValues("realTrainnum[]");
			String[] realFullPre=JsonTagContext.getRequest().getParameterValues("realFullPre[]");
			DateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
			for(int i=0;i<lineId.length;i++){
				sql="update TBL_PW_TRAINCAP set REAL_START_TIME_PRE='"+realStartTimePre[i]+"',REAL_START_TIME_NEXT='"+realStartTimeNext[i]+"',REAL_START_TIME_DIF="+
				realStartTimeDif[i]+",REAL_FIR_OCCUPY_TIME="+realFirOccupyTime[i]+",REAL_LINES="+realLines[i]+",REAL_END_TIME_DIF="+realEndTimeDif[i]+",REAL_LAST_OCCUPY_TIME="+
				realLastOccupyTime[i]+",REAL_END_TIME_LAST='"+realEndTimeLast[i]+"',REAL_END_TIME_FIR='"+realEndTimeFir[i]+"',REAL_TRAINNUM="+realTrainnum[i]+
				",REAL_FULL_PRE="+realFullPre[i].replace("%","")+" where line_id='"+lineId[i]+"' and stmt_day='"+stmtDay[i]+"'";
				jsonTagJdbcDao.getJdbcTemplate().execute(sql);
				
				sql="insert into TBL_PW_TRAINCAP_log select '"+lineId[i]+"','"+stmtDay[i]+"',user_id,user_name,'"+df.format(new Date())+"' from RARD.TRDUS01 where user_id='"+username+"'";
				jsonTagJdbcDao.getJdbcTemplate().execute(sql);
			}
			return "seccuss";
		}
	}

	public String getStart_mon() {
		return start_mon;
	}
	public void setStart_mon(String startMon) {
		start_mon = startMon;
	}
	public String getSel_flag() {
		return sel_flag;
	}
	public void setSel_flag(String selFlag) {
		sel_flag = selFlag;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
	
}
