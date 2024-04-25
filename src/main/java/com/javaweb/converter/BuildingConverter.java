package com.javaweb.converter;

import com.javaweb.entity.BuildingEntity;
import com.javaweb.entity.RentAreaEntity;
import com.javaweb.model.dto.BuildingDTO;
import com.javaweb.model.response.BuildingSearchResponse;
import com.javaweb.repository.RentAreaRepository;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class BuildingConverter {
    @Autowired
    private ModelMapper modelMapper;

    public BuildingDTO toBuildingDTO(BuildingEntity item) {
        List<RentAreaEntity> rentAreaEntities = item.getRentAreaEntities();
        String joinRentArea = rentAreaEntities.stream().map(it -> it.getValue().toString()).collect(Collectors.joining(","));
        BuildingDTO building = modelMapper.map(item, BuildingDTO.class);
        building.setRentArea(joinRentArea);
        if(item.getType() != null) {
            String[] tmp = item.getType().split(",");
            List<String> typeCodes = new ArrayList<>();
            for (String it: tmp) {
                typeCodes.add(it);
            }
            building.setTypeCode(typeCodes);
        }
        return building;
    }

    public BuildingEntity toBuildingEntity(BuildingDTO item) {
        BuildingEntity building = modelMapper.map(item, BuildingEntity.class);
        String typeCode = item.getTypeCode().stream().map(it ->  "" + it + "" ).collect(Collectors.joining(","));
        building.setType(typeCode);
        return building;
    }
}
