package com.javaweb.service.impl;

import com.javaweb.builder.BuildingSearchBuilder;
import com.javaweb.converter.*;
import com.javaweb.entity.BuildingEntity;
import com.javaweb.entity.RentAreaEntity;
import com.javaweb.entity.UserEntity;
import com.javaweb.model.dto.AssignmentDTO;
import com.javaweb.model.dto.BuildingDTO;
import com.javaweb.model.request.BuildingSearchRequest;
import com.javaweb.model.response.BuildingSearchResponse;
import com.javaweb.model.response.ResponseDTO;
import com.javaweb.model.response.StaffResponseDTO;
import com.javaweb.repository.BuildingRepository;
import com.javaweb.repository.UserRepository;
import com.javaweb.service.IBuildingService;
import com.javaweb.utils.NumberUtils;
import com.javaweb.utils.UploadFileUtils;
import org.apache.tomcat.util.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.security.acls.model.NotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
@Service
@Transactional
public class BuildingService implements IBuildingService {
    @Autowired
    private BuildingSearchBuilderConverter buildingSearchBuilderConverter;
    @Autowired
    private BuildingSearchResponeConverter buildingSearchResponeConverter;
    @Autowired
    private BuildingRepository buildingRepository;
    @Autowired
    private BuildingConverter buildingConverter;
    @Autowired
    private RentAreaConverter rentAreaConverter;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private UploadFileUtils uploadFileUtils;
    @Override
    public List<BuildingSearchResponse> findBuildings(BuildingSearchRequest buildingSearchRequest, Pageable pageable) {
        BuildingSearchBuilder buildingSearchBuilder = buildingSearchBuilderConverter.toBuildingSearchBuilder(buildingSearchRequest);
        List<BuildingEntity> buildingEntities = buildingRepository.findBuildings(buildingSearchBuilder, pageable);
        List<BuildingSearchResponse> result = new ArrayList<>();
        for(BuildingEntity item : buildingEntities) {
            result.add(buildingSearchResponeConverter.toBuildingSearchResponse(item));
        }
        return result;
    }

    @Override
    public BuildingDTO findBuildingById(Long Id) {
        BuildingEntity buildingEntity = buildingRepository.findById(Id)
                .orElseThrow(() -> new NotFoundException("Building not found!"));
        BuildingDTO buildingDTO = buildingConverter.toBuildingDTO(buildingEntity);
        return buildingDTO;
    }

    @Override
    public void updateOraddBuilding(BuildingDTO buildingDTO) {
        BuildingEntity buildingEntity = buildingConverter.toBuildingEntity(buildingDTO);
        if(buildingDTO.getId() != null) {
            BuildingEntity building = buildingRepository.findById(buildingDTO.getId())
                    .orElseThrow(() -> new NotFoundException("Building not found!"));
            buildingEntity.setStaffs(building.getStaffs());
            buildingEntity.setAvatar(building.getAvatar());
        }
        saveThumbnail(buildingDTO, buildingEntity);
        String[] rentAreaValues = buildingDTO.getRentArea().split(",");
        List<RentAreaEntity> rentAreaEntities = new ArrayList<>();
        for (String value: rentAreaValues) {
            if(NumberUtils.isLong(value)) {
                RentAreaEntity rentAreaEntityNew = rentAreaConverter.toRentAreaEntity(Long.valueOf(value), buildingEntity);
                rentAreaEntities.add(rentAreaEntityNew);
            }
        }
        buildingEntity.setRentAreaEntities(rentAreaEntities);
        buildingRepository.save(buildingEntity);
    }

    @Override
    public void deleteBuildings(List<Long> ids) {
        buildingRepository.deleteByIdIn(ids);
    }

    @Override
    public ResponseDTO loadStaffs(Long buildingId) {
        BuildingEntity buildingEntity = buildingRepository.findById(buildingId)
                .orElseThrow(() -> new NotFoundException("Building not found!"));
        List<UserEntity> staffs = userRepository.findByStatusAndRoles_Code(1, "STAFF");
        List<UserEntity> staffsAssignment = buildingEntity.getStaffs();
        List<StaffResponseDTO> staffResponseDTOS = new ArrayList<>();
        ResponseDTO responseDTO = new ResponseDTO();
        for (UserEntity it: staffs) {
            StaffResponseDTO staffResponseDTO = new StaffResponseDTO();
            staffResponseDTO.setStaffId(it.getId());
            staffResponseDTO.setFullName(it.getFullName());
            if(staffsAssignment.contains(it)) {
                staffResponseDTO.setChecked("checked");
            } else {
                staffResponseDTO.setChecked("");
            }
            staffResponseDTOS.add(staffResponseDTO);
        }
        responseDTO.setData(staffResponseDTOS);
        responseDTO.setMessage("Success");
        return responseDTO;
    }

    @Override
    public void updateAssignment(AssignmentDTO assignmentBuildingDTO) {
        BuildingEntity buildingEntity = buildingRepository.findById(assignmentBuildingDTO.getId())
                .orElseThrow(() -> new NotFoundException("Building not found!"));
        List<UserEntity> staffs = userRepository.findByIdIn(assignmentBuildingDTO.getStaffs());
        buildingEntity.setStaffs(staffs);
        buildingRepository.save(buildingEntity);
    }
    @Override
    public int countTotalItems(BuildingSearchRequest buildingSearchRequest, Pageable pageable) {
        BuildingSearchBuilder buildingSearchBuilder = buildingSearchBuilderConverter.toBuildingSearchBuilder(buildingSearchRequest);
        return buildingRepository.countTotalItem(buildingSearchBuilder, pageable);
    }
    private void saveThumbnail(BuildingDTO buildingDTO, BuildingEntity buildingEntity) {
        String path = "/building/" + buildingDTO.getImageName();
        if (null != buildingDTO.getImageBase64()) {
            if (null != buildingEntity.getAvatar()) {
                if (!path.equals(buildingEntity.getAvatar())) {
                    File file = new File("C://home/office" + buildingEntity.getAvatar());
                    file.delete();
                }
            }
            byte[] bytes = Base64.decodeBase64(buildingDTO.getImageBase64().getBytes());
            uploadFileUtils.writeOrUpdate(path, bytes);
            buildingEntity.setAvatar(path);
        }
    }
}
