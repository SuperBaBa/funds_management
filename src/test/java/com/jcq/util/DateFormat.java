package com.jcq.util;

import org.junit.Test;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

public class DateFormat {

	public static String msecToDateHH(Object date) {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 24小时制
		return simpleDateFormat.format(date);
	}

	public static String msecToDatehh(Object date) {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss a", Locale.ENGLISH);// 12小时制
		return simpleDateFormat.format(date);
	}
	public static String msecToDate(Object date) {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmss");// 年月日
		return simpleDateFormat.format(date);
	}

	@Test
	public void test() {
		long time = System.currentTimeMillis();
		System.out.println(time);
		Date date = new Date();
		System.out.println(date);
		System.out.println(date.getTime());
		System.out.println(msecToDate(date.getTime() + 1000 * 18000));
	}
}
