package com.javaweb.converter;

import com.javaweb.entity.TransactionEntity;
import com.javaweb.model.dto.TransactionDTO;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class TransactionConverter {
    @Autowired
    private ModelMapper modelMapper;

    public TransactionEntity toTransactionEntity(TransactionDTO item) {
        return modelMapper.map(item, TransactionEntity.class);
    }
    public TransactionDTO toTransactionDTO(TransactionEntity item) {
        return modelMapper.map(item, TransactionDTO.class);
    }
}
