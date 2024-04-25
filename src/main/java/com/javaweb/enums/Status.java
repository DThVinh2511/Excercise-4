package com.javaweb.enums;

import java.util.Map;
import java.util.TreeMap;

public enum Status {
    DANG_XL ("Đang xử lý"),
    DA_XL ("Đã xử lý"),
    CHUA_XL ("Chưa xử lý");

    private final String statusName;
    Status(String statusName) {
        this.statusName = statusName;
    }

    public String getStatusName() {
        return statusName;
    }

    public static Map<String,String> type(){
        Map<String,String> listStatus = new TreeMap<>();
        for(Status item : Status.values()){
            listStatus.put(item.toString() , item.statusName);
        }
        return listStatus;
    }
}
