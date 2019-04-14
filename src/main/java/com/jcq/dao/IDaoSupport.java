package com.jcq.dao;

import java.util.List;
import java.util.Map;

public interface IDaoSupport {
	/**
	 * 传入mapper映射文件中的命名空间及方法的id
	 * 
	 * @param str
	 *            mapper映射文件中的命名空间+方法的id
	 * @param t
	 *            mapper映射文件中sql语句所需要传入的参数
	 * @return
	 */
	public int save(String str, Object t);

	public int delete(String str, Object t);

	public int update(String str, Object t);

	public Map<String, Object> findOne(String str, Object t);

	public List<Object> findList(String str, Map<String, Object> map);

	// 用于查询记录数
	public Object findOne(String str);

}
