package com.javaweb.model.dto;

import java.util.List;

public class AssignmentDTO {
    private Long id;
    private List<Long> staffs;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public List<Long> getStaffs() {
        return staffs;
    }

    public void setStaffs(List<Long> staffs) {
        this.staffs = staffs;
    }
}
