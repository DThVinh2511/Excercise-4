package com.javaweb.converter;

import com.javaweb.entity.BuildingEntity;
import com.javaweb.entity.RentAreaEntity;
import com.javaweb.repository.RentAreaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class RentAreaConverter {
    @Autowired
    private RentAreaRepository rentAreaRepository;

    public RentAreaEntity toRentAreaEntity(Long value, BuildingEntity buildingEntity) {
        RentAreaEntity rentAreaEntity= new RentAreaEntity();
        rentAreaEntity.setBuilding(buildingEntity);
        rentAreaEntity.setValue(value);
        return rentAreaEntity;
    }
}