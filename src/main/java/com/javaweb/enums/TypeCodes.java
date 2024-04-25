package com.javaweb.enums;


import java.util.*;

public enum TypeCodes {
    TANG_TRET ("Tầng Trệt "),
    NGUYEN_CAN ("Nguyên Căn "),
    NOI_THAT ("Nội Thất ");

    private final String name;
    TypeCodes(String name) {
        this.name = name;
    }

    public static Map<String,String> type(){
        Map<String,String> listType = new HashMap<>();
        for(TypeCodes item : TypeCodes.values()){
            listType.put(item.toString() , item.name);
        }
        return listType;
    }
}
