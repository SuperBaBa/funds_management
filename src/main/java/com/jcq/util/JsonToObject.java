package com.jcq.util;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

public class JsonToObject {
	
public static String jsonGetProperty(String json,String propertyName,String dataName) {
	JSONObject object = JSONObject.parseObject(json);
	JSONArray array = object.getJSONArray(dataName);
	for(int i = 0;i<array.size();i++) {
		JSONObject o = array.getJSONObject(i);
		o.put(propertyName, DateFormat.msecToDateHH( o.get(propertyName)));
	}
	return object.toString();
}
}
