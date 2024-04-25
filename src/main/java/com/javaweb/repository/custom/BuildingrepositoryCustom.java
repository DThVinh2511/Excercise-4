package com.javaweb.repository.custom;

import com.javaweb.builder.BuildingSearchBuilder;
import com.javaweb.entity.BuildingEntity;
import org.springframework.data.domain.Pageable;

import java.util.ArrayList;
import java.util.List;

public interface BuildingrepositoryCustom {
    List<BuildingEntity> findBuildings(BuildingSearchBuilder buildingSearchBuilder, Pageable pageable);
    int countTotalItem(BuildingSearchBuilder buildingSearchBuilder, Pageable pageable);
}
