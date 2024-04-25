package com.javaweb.service;

import com.javaweb.model.dto.AssignmentDTO;
import com.javaweb.model.dto.BuildingDTO;
import com.javaweb.model.request.BuildingSearchRequest;
import com.javaweb.model.response.BuildingSearchResponse;
import com.javaweb.model.response.ResponseDTO;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface IBuildingService {
    List<BuildingSearchResponse> findBuildings(BuildingSearchRequest buildingSearchRequest, Pageable pageable);
    BuildingDTO findBuildingById(Long Id);
    void updateOraddBuilding(BuildingDTO buildingDTO);
    void deleteBuildings(List<Long> ids);
    ResponseDTO loadStaffs(Long buildingId);
    void updateAssignment(AssignmentDTO assignmentBuildingDTO);
    int countTotalItems(BuildingSearchRequest buildingSearchRequest, Pageable pageable);
}
