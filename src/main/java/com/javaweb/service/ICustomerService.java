package com.javaweb.service;

import com.javaweb.model.dto.AssignmentDTO;
import com.javaweb.model.dto.CustomerDTO;
import com.javaweb.model.dto.TransactionDTO;
import com.javaweb.model.request.CustomerSearchRequest;
import com.javaweb.model.response.CustomerSearchReponse;
import com.javaweb.model.response.ResponseDTO;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface ICustomerService {
    List<CustomerSearchReponse> findCustomers(CustomerSearchRequest customerSearchRequest, Pageable pageable);
    int countTotalItems(CustomerSearchRequest customerSearchRequest, Pageable pageable);

    CustomerDTO findCustomerById(Long id);

    ResponseDTO loadStaffs(Long id);

    void updateAssignment(AssignmentDTO assignmentBuildingDTO);

    void deleteCustomers(List<Long> ids);

    void updateOraddCustomer(CustomerDTO customerDTO);
}
