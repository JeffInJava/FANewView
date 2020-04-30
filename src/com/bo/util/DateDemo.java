package com.bo.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

public class DateDemo {
	Calendar ca1 = new GregorianCalendar();
	Calendar ca2 = new GregorianCalendar();
	DateFormat df = new SimpleDateFormat("yyyyMMdd");
	Date date_1 = new Date();
	Date date_2 = new Date();
	/***敬老卡/保通卡判定***/
	public String compareCardDate(String t1){
		try {
			date_1 = df.parse(t1);
			date_2 = df.parse("20160701");//之前为敬老卡，之后为保通卡
		} catch (ParseException e) {
			e.printStackTrace();
		}
		int cn = date_1.compareTo(date_2);
		if(cn>=0){
			return "保通卡";
		}
		return "敬老卡";
	}
	public String getToday() {
		String str = this.df.format(this.ca1.getTime());
		return str;
	}

	public int getYear() {
		Calendar c = Calendar.getInstance();
		int year = c.get(Calendar.YEAR);
		return year;
	}
	public int getPreYear() {
		Calendar c = Calendar.getInstance();
		c.add(Calendar.YEAR,-1);
		int year = c.get(Calendar.YEAR);
		return year;
	}
	public String getYesterday() {
		this.ca2.add(5, -1);
		String str = this.df.format(this.ca2.getTime());
		return str;
	}

	public String getCutday(String strday, int days) {
		Calendar c = Calendar.getInstance();// 获得一个日历的实例
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Date date = null;
		try {
			date = sdf.parse(strday);// 初始日期
		} catch (Exception e) {

		}
		c.setTime(date);// 设置日历时间
		c.add(Calendar.DAY_OF_MONTH, days);
		String str = this.df.format(c.getTime());
		return str;
	}

	public int getDays(String paramString1, String paramString2)
			throws ParseException {
		this.date_1 = this.df.parse(paramString1);
		this.date_2 = this.df.parse(paramString2);
		long l = (this.date_2.getTime() - this.date_1.getTime()) / 86400000L;
		System.out.println(l);
		return (int) l;
	}

	public String getSQL(String paramString1, String paramString2,
			String paramString3, String paramString4, String paramString5)
			throws ParseException {
		String str1 = new String();
		String str2 = new String();
		String str3 = new String();
		int i = 0;

		if ("".equals(paramString4))
			str1 = "null";
		else {
			str1 = paramString4;
		}
		if ("".equals(paramString5))
			str2 = "null";
		else {
			str2 = paramString5;
		}

		if (("".equals(paramString2)) && ("".equals(paramString3))) {
			str3 = getToday();
		} else if ("".equals(paramString2)) {
			str3 = paramString3;
		} else if ("".equals(paramString3)) {
			str3 = paramString2;
		} else {
			i = getDays(paramString2, paramString3);
			str3 = paramString2;
		}

		StringBuffer localStringBuffer = new StringBuffer(paramString1 + str3);
		localStringBuffer.append(" where (line_id=");
		localStringBuffer.append(str1);
		localStringBuffer.append(" or ");
		localStringBuffer.append(str1);
		localStringBuffer.append(" is null) and (station_id=");
		localStringBuffer.append(str2);
		localStringBuffer.append(" or ");
		localStringBuffer.append(str2);
		localStringBuffer.append(" is null)");
		this.ca1.setTime(this.date_1);
		for (int j = 1; j <= i; j++) {
			this.ca1.add(5, 1);
			str3 = this.df.format(this.ca1.getTime());
			localStringBuffer.append(" union all ");
			localStringBuffer.append(paramString1 + str3);
			localStringBuffer.append(" where (line_id=");
			localStringBuffer.append(str1);
			localStringBuffer.append(" or ");
			localStringBuffer.append(str1);
			localStringBuffer.append(" is null) and (station_id=");
			localStringBuffer.append(str2);
			localStringBuffer.append(" or ");
			localStringBuffer.append(str2);
			localStringBuffer.append(" is null)");
		}
		return localStringBuffer.toString();
	}

	public String getSQL_group_by(String paramString1, String paramString2,
			String paramString3, String paramString4) throws ParseException {
		String str1 = new String();
		String str2 = new String();
		int i = 0;

		if ("".equals(paramString4))
			str1 = "null";
		else {
			str1 = paramString4;
		}

		if (("".equals(paramString2)) && ("".equals(paramString3))) {
			str2 = getToday();
		} else if ("".equals(paramString2)) {
			str2 = paramString3;
		} else if ("".equals(paramString3)) {
			str2 = paramString2;
		} else {
			i = getDays(paramString2, paramString3);
			str2 = paramString2;
		}

		StringBuffer localStringBuffer = new StringBuffer(paramString1 + str2);
		localStringBuffer.append(" where (line_id=");
		localStringBuffer.append(str1);
		localStringBuffer.append(" or ");
		localStringBuffer.append(str1);
		localStringBuffer
				.append(" is null) group by stmt_day,line_id,station_id ");
		this.ca1.setTime(this.date_1);
		for (int j = 1; j <= i; j++) {
			this.ca1.add(5, 1);
			str2 = this.df.format(this.ca1.getTime());
			localStringBuffer.append(" union all ");
			localStringBuffer.append(paramString1 + str2);
			localStringBuffer.append(" where (line_id=");
			localStringBuffer.append(str1);
			localStringBuffer.append(" or ");
			localStringBuffer.append(str1);
			localStringBuffer
					.append(" is null) group by stmt_day,line_id,station_id ");
		}

		return localStringBuffer.toString();
	}

}