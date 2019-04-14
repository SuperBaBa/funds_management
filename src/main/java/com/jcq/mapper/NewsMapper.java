package com.jcq.mapper;

import java.util.List;

import com.jcq.model.News;
import com.jcq.util.TurnPage;

public interface NewsMapper {
    int deleteByPrimaryKey(String id);

    int insert(News record);

    int insertSelective(News record);

    News selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(News record);

    int updateByPrimaryKey(News record);
    
    List<Object> queryAll(TurnPage turnPage);
}