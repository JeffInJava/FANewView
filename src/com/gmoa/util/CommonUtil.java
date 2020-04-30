package com.gmoa.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.Map;

public class CommonUtil {

	
	public static Date getNowDate(){
		return new Date();
	}
	
	public static boolean isEmpty(Object obj) {

		if (null == obj)
			return true;

		if (obj instanceof String)
			return "".equals((String) obj);

		if (obj instanceof Object[])
			return ((Object[]) obj).length == 0;

		if (obj instanceof Collection) {
			Collection<?> c = (Collection<?>) obj;
			boolean re = c.isEmpty();
			if (!re && c.size() == 1 && null == c.toArray()[0])
				re = true;
			return re;
		}

		if (obj instanceof Map)
			return ((Map<?, ?>) obj).size() == 0;

		return false;
	}
	
	public static String getWeekDate(String date ,int i){
		SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMdd"); //设置时间格式  
        Calendar cal = Calendar.getInstance();
        try{
        	cal.setTime(sdf.parse(date));  
        }catch(Exception e){}
        
        //System.out.println("要计算日期为:"+sdf.format(cal.getTime())); //输出要计算日期  
         
        //判断要计算的日期是否是周日，如果是则减一天计算周六的，否则会出问题，计算到下一周去了  
        int dayWeek = cal.get(Calendar.DAY_OF_WEEK);//获得当前日期是一个星期的第几天  
        if(1 == dayWeek) {  
           cal.add(Calendar.DAY_OF_MONTH, -1);  
        }  
         
       cal.setFirstDayOfWeek(Calendar.MONDAY);//设置一个星期的第一天，按中国的习惯一个星期的第一天是星期一  
        
       int day = cal.get(Calendar.DAY_OF_WEEK);//获得当前日期是一个星期的第几天  
       cal.add(Calendar.DATE, cal.getFirstDayOfWeek()-day + i - 1);//获得日期
       return sdf.format(cal.getTime());
       
//       System.out.println("所在周星期一的日期："+sdf.format(cal.getTime()));
//       System.out.println(cal.getFirstDayOfWeek()+"-"+day+"+6="+(cal.getFirstDayOfWeek()-day+6));
//        
//       cal.add(Calendar.DATE, 6);
//       System.out.println("所在周星期日的日期："+sdf.format(cal.getTime()));  
	}
	
	public static String getStringDate(Date date) {
		SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMdd"); //设置时间格式  
		return sdf.format(date);
	}
	/**
	 * 日期的修正，如果小于两点，则往前推一天
	 * @param startTime
	 * @return
	 */
	public static String getRightDay(String startTime){
		Calendar cal = Calendar.getInstance();
		cal = Calendar.getInstance();
		int hour= cal.get(Calendar.HOUR_OF_DAY);
		if(hour<3){
			SimpleDateFormat sdf= new SimpleDateFormat("yyyyMMdd");
			Date date = null;
			try {
				date = sdf.parse(startTime);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			if(date==null){
				date = new Date();
			}
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(date);
			calendar.add(Calendar.DATE, -1);
			return sdf.format(calendar.getTime());
		}
		return startTime;
	}
	
	public static String getNextDay(String startTime){
		SimpleDateFormat sdf= new SimpleDateFormat("yyyyMMdd");
		Date date = null;
		try {
			date = sdf.parse(startTime);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		if(date==null){
			date = new Date();
		}
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.DATE, 1);
		return sdf.format(calendar.getTime());
	}
	public static int stmtDayDiff(String searchDate){
		Calendar cal = Calendar.getInstance();
		cal = Calendar.getInstance();
		SimpleDateFormat sdf= new SimpleDateFormat("yyyyMMdd");
		Date date = null;
		try {
			date = sdf.parse(searchDate);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		if(date==null){
			date = new Date();
		}
		Calendar scalendar = Calendar.getInstance();
		scalendar.setTime(date);
		long diffDays = (cal.getTimeInMillis() - scalendar.getTimeInMillis())
                / (1000 * 60 * 60 * 24);
		return (int) diffDays;
	}
	
	
	public static void main(String args[]){
		//System.out.println(CommonUtil.getWeekDate("20151201", 1));
		//System.out.println(CommonUtil.getWeekDate("20151204", 7));
		//System.out.println(CommonUtil.getWeekDate("20151214", 1));
		//System.out.println(CommonUtil.getWeekDate("20151220", 7));
	}
	
}
