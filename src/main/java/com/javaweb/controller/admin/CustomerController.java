package com.javaweb.controller.admin;

import com.javaweb.constant.SystemConstant;
import com.javaweb.enums.Districts;
import com.javaweb.enums.Status;
import com.javaweb.enums.TransactionType;
import com.javaweb.enums.TypeCodes;
import com.javaweb.model.dto.BuildingDTO;
import com.javaweb.model.dto.CustomerDTO;
import com.javaweb.model.dto.TransactionDTO;
import com.javaweb.model.request.CustomerSearchRequest;
import com.javaweb.model.response.BuildingSearchResponse;
import com.javaweb.model.response.CustomerSearchReponse;
import com.javaweb.security.utils.SecurityUtils;
import com.javaweb.service.ICustomerService;
import com.javaweb.service.ITransactionService;
import com.javaweb.service.IUserService;
import com.javaweb.utils.DisplayTagUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
@Controller(value="customerControllerOfAdmin")
public class CustomerController {
    @Autowired
    private IUserService userService;
    @Autowired
    private ICustomerService customerService;
    @Autowired
    private ITransactionService transactionService;
    @GetMapping(value = "/admin/customer-list")
    public ModelAndView buildingList(@ModelAttribute(SystemConstant.MODEL) CustomerSearchRequest model, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/customer/list");
        mav.addObject("modelSearch", model);
        DisplayTagUtils.of(request, model);
        if(SecurityUtils.getAuthorities().contains("ROLE_STAFF")){
            Long staffId = SecurityUtils.getPrincipal().getId();
            model.setStaffId(staffId);
        }
        List<CustomerSearchReponse> customerList = customerService.findCustomers(model, PageRequest.of(model.getPage() - 1, model.getMaxPageItems()));
        model.setListResult(customerList);
        model.setTotalItems(customerService.countTotalItems(model, PageRequest.of(model.getPage() - 1, model.getMaxPageItems())));
        mav.addObject(SystemConstant.MODEL, model);
        mav.addObject("listStaffs", userService.getStaffs());
        return mav;
    }
    @GetMapping(value = "/admin/customer-edit")
    public ModelAndView customerEdit(@ModelAttribute("customerEdit") CustomerDTO customerDTO) {
        ModelAndView mav = new ModelAndView("admin/customer/edit");
        mav.addObject("Status", Status.type());
        return mav;
    }
    @GetMapping(value = "/admin/customer-edit-{id}")
    public ModelAndView customerEdit(@PathVariable("id") Long Id) {
        ModelAndView mav = new ModelAndView("admin/customer/edit");
        CustomerDTO customerDTO = customerService.findCustomerById(Id);
        mav.addObject("customerEdit", customerDTO);
        mav.addObject("Status", Status.type());
        mav.addObject("transactionType", TransactionType.type());
        List<TransactionDTO> transactionDDX = transactionService.findTransactionByCodeAndCustomerId("DDX", Id);
        List<TransactionDTO> transactionCSKH = transactionService.findTransactionByCodeAndCustomerId("CSKH", Id);
        mav.addObject("transactionDDX", transactionDDX);
        mav.addObject("transactionCSKH", transactionCSKH);
        return mav;
    }
}
