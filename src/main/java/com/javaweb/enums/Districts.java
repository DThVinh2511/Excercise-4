package com.javaweb.enums;

import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

public enum Districts {
    QUAN_1 ("Quận 1"),
    QUAN_2 ("Quận 2"),
    QUAN_3 ("Quận 3"),
    QUAN_4 ("Quận 4");

    private final String districtName;
    Districts(String districtName) {
        this.districtName = districtName;
    }

    public String getDistrictName() {
        return districtName;
    }

    public static Map<String,String> type(){
        Map<String,String> listType = new TreeMap<>();
        for(Districts item : Districts.values()){
            listType.put(item.toString() , item.districtName);
        }
        return listType;
    }
}
