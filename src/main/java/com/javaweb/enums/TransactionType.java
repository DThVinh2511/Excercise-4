package com.javaweb.enums;

import java.util.Map;
import java.util.TreeMap;

public enum TransactionType {
    CSKH("Chăm sóc khách hàng"),

    DDX("Dẫn đi xem");

    private final String transactionType;
    TransactionType(String transactionType) {
        this.transactionType = transactionType;
    }

    public String getTransactionType() {
        return transactionType;
    }

    public static Map<String,String> type(){
        Map<String,String> typeCodes = new TreeMap<>();
        for(TransactionType item : TransactionType.values()){
            typeCodes.put(item.toString() , item.transactionType);
        }
        return typeCodes;
    }
}
