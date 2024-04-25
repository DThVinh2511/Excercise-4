package com.javaweb.controller.admin;



import com.javaweb.constant.SystemConstant;
import com.javaweb.enums.Districts;
import com.javaweb.enums.TypeCodes;
import com.javaweb.model.dto.BuildingDTO;
import com.javaweb.model.request.BuildingSearchRequest;
import com.javaweb.model.response.BuildingSearchResponse;
import com.javaweb.security.utils.SecurityUtils;
import com.javaweb.service.IBuildingService;
import com.javaweb.service.IUserService;
import com.javaweb.utils.DisplayTagUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Controller(value="buildingControllerOfAdmin")
public class BuildingController {
    @Autowired
    private IUserService userService;
    @Autowired
    private IBuildingService buildingService;
    @GetMapping(value = "/admin/building-list")
    public ModelAndView buildingList(@ModelAttribute(SystemConstant.MODEL) BuildingSearchRequest model, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/building/list");
        mav.addObject("modelSearch", model);
        DisplayTagUtils.of(request, model);
        if(SecurityUtils.getAuthorities().contains("ROLE_STAFF")){
            Long staffId = SecurityUtils.getPrincipal().getId();
            model.setStaffId(staffId);
        }
        List<BuildingSearchResponse> buildingList = buildingService.findBuildings(model, PageRequest.of(model.getPage() - 1, model.getMaxPageItems()));
        model.setListResult(buildingList);
        model.setTotalItems(buildingService.countTotalItems(model, PageRequest.of(model.getPage() - 1, model.getMaxPageItems())));
        mav.addObject(SystemConstant.MODEL, model);
        mav.addObject("listStaffs", userService.getStaffs());
        mav.addObject("districts", Districts.type());
        mav.addObject("typeCodes", TypeCodes.type());
        return mav;
    }

    @GetMapping(value = "/admin/building-edit")
    public ModelAndView buildingEdit(@ModelAttribute("buildingEdit") BuildingDTO buildingDTO, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/building/edit");
        mav.addObject("districts", Districts.type());
        mav.addObject("typeCodes", TypeCodes.type());
        return mav;
    }
    @GetMapping(value = "/admin/building-edit-{id}")
    public ModelAndView buildingEdit(@PathVariable("id") Long Id, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/building/edit");
        BuildingDTO buildingDTO = buildingService.findBuildingById(Id);
        mav.addObject("buildingEdit", buildingDTO);
        mav.addObject("districts", Districts.type());
        mav.addObject("typeCodes", TypeCodes.type());
        return mav;
    }
}
