package com.javaweb.service.impl;

import com.javaweb.converter.TransactionConverter;
import com.javaweb.entity.CustomerEntity;
import com.javaweb.entity.TransactionEntity;
import com.javaweb.model.dto.TransactionDTO;
import com.javaweb.repository.CustomerRepository;
import com.javaweb.repository.TransactionRepository;
import com.javaweb.service.ITransactionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.acls.model.NotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class TransactionService implements ITransactionService {
    @Autowired
    private TransactionRepository transactionRepository;
    @Autowired
    private TransactionConverter transactionConverter;
    @Autowired
    private CustomerRepository customerRepository;
    @Override
    public List<TransactionDTO> findTransactionByCodeAndCustomerId(String code, Long id) {
        List<TransactionEntity> transactionEntities = transactionRepository.findByCodeAndCustomerId(code, id);
        List<TransactionDTO> transactionDTOS = new ArrayList<>();
        for (TransactionEntity it: transactionEntities) {
            TransactionDTO transactionDTO = transactionConverter.toTransactionDTO(it);
            transactionDTOS.add(transactionDTO);
        }
        return transactionDTOS;
    }

    @Override
    public void addOrUpdateTransaction(TransactionDTO transactionDTO) {
        TransactionEntity transactionEntity = transactionConverter.toTransactionEntity(transactionDTO);
        CustomerEntity customerEntity = customerRepository.findById(transactionDTO.getCustomerId())
                .orElseThrow(() -> new NotFoundException("Customer not found!"));
        if(transactionDTO.getId() != null) {
            TransactionEntity transaction = transactionRepository.findById(transactionDTO.getId()).get();
            transactionEntity.setCode(transaction.getCode());
            transactionEntity.setCreatedBy(transaction.getCreatedBy());
            transactionEntity.setCreatedDate(transaction.getCreatedDate());
        }
        if(customerEntity != null) {
            transactionRepository.save(transactionEntity);
        }
    }
}
