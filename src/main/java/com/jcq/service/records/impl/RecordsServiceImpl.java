package com.jcq.service.records.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jcq.dao.IDaoSupport;
import com.jcq.mapper.RecordsMapper;
import com.jcq.model.Records;
import com.jcq.service.records.RecordsService;
import com.jcq.util.DateFormat;
import com.jcq.util.UUIDUtil;

@Service("recordsService")
public class RecordsServiceImpl implements RecordsService{
	@Autowired
	private RecordsMapper recordsMapper;
	@Autowired
	private IDaoSupport daoRecords;

	public int addRecord(Records records) {
		records.setId(UUIDUtil.getUUID());
		records.setTransactionDate(DateFormat.msecToDateHH(new Date()));
		return recordsMapper.insert(records);
	}
	// 查看交易记录通过record的showList
		public List<Object> showRecords(Map<String, Object> map) {
			return daoRecords.findList("com.jcq.mapper.RecordsMapper.showRecords", map);
		}
		@Override
		public int recordsCount(Map<String, Object> map) {
			return recordsMapper.recordsCount(map);
		}
}
