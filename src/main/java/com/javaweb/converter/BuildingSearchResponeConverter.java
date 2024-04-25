package com.javaweb.converter;

import com.javaweb.entity.BuildingEntity;
import com.javaweb.entity.RentAreaEntity;
import com.javaweb.enums.Districts;
import com.javaweb.model.response.BuildingSearchResponse;
import com.javaweb.utils.StringUtils;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Component
public class BuildingSearchResponeConverter {

    @Autowired
    private ModelMapper modelMapper;
    public BuildingSearchResponse toBuildingSearchResponse(BuildingEntity item) {
        List<RentAreaEntity> rentAreaEntities = item.getRentAreaEntities();
        String joinRentArea = rentAreaEntities.stream().map(it -> it.getValue().toString()).collect(Collectors.joining(","));
        BuildingSearchResponse building = modelMapper.map(item, BuildingSearchResponse.class);
        building.setRentArea(joinRentArea);
        Map<String, String> dtricts = Districts.type();
        String districtName = StringUtils.check(item.getDistrict()) ? dtricts.get(item.getDistrict()) : "";
        building.setAddress(item.getStreet() + ", " + item.getWard() + ", " + districtName);
        return building;
    }
}
