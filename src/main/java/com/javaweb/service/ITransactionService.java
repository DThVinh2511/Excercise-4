package com.javaweb.service;

import com.javaweb.model.dto.TransactionDTO;

import java.util.List;

public interface ITransactionService {
    List<TransactionDTO> findTransactionByCodeAndCustomerId(String code, Long id);

    void addOrUpdateTransaction(TransactionDTO transactionDTO);
}
