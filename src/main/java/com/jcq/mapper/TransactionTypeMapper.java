package com.jcq.mapper;

import com.jcq.model.TransactionType;

public interface TransactionTypeMapper {
    int deleteByPrimaryKey(String id);

    int insert(TransactionType record);

    int insertSelective(TransactionType record);

    TransactionType selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(TransactionType record);

    int updateByPrimaryKey(TransactionType record);
}