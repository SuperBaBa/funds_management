package com.jcq.service.records;

import java.util.List;
import java.util.Map;

import com.jcq.model.Records;

public interface RecordsService {
	public int addRecord(Records records);

	public List<Object> showRecords(Map<String, Object> map);
	public int recordsCount(Map<String, Object> map);

}
