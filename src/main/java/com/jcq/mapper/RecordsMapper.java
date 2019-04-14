package com.jcq.mapper;

import java.util.Map;

import com.jcq.model.Records;

public interface RecordsMapper {
    int deleteByPrimaryKey(String id);

    int insert(Records record);

    int insertSelective(Records record);

    Records selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Records record);

    int updateByPrimaryKey(Records record);
    
    int recordsCount(Map<String, Object> map);
}