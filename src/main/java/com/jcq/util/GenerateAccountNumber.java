package com.jcq.util;

import org.junit.Test;

public class GenerateAccountNumber {
	// 随机生成一个19位的账号
	public static String getAccountNumber() {
		String num = "62";
		Double end = Math.random()*10;
		for(int i=0;i<4;i++) {
			Double ranum=Math.random()*10000;
			num+=doubleToString(ranum);
		}
		System.out.println("分配账号:"+num+doubleToString(end)+" 给该用户");
		return num+doubleToString(end);
	}
	private static String doubleToString(Double d) {
		Integer param=d.intValue();
		return param.toString();
	}
	@Test
	public void test() {
		System.out.println(Math.random()*10);
		System.out.println(getAccountNumber().length());
	}
}
