package com.javaweb.service.impl;

import com.javaweb.builder.CustomerSearchBuilder;
import com.javaweb.converter.CustomerSearchBuilderConverter;
import com.javaweb.converter.CustomerConverter;
import com.javaweb.entity.CustomerEntity;
import com.javaweb.entity.UserEntity;
import com.javaweb.model.dto.AssignmentDTO;
import com.javaweb.model.dto.CustomerDTO;
import com.javaweb.model.request.CustomerSearchRequest;
import com.javaweb.model.response.CustomerSearchReponse;
import com.javaweb.model.response.ResponseDTO;
import com.javaweb.model.response.StaffResponseDTO;
import com.javaweb.repository.CustomerRepository;
import com.javaweb.repository.UserRepository;
import com.javaweb.service.ICustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.security.acls.model.NotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
@Service
public class CustomerService implements ICustomerService {
    @Autowired
    private CustomerSearchBuilderConverter customerSearchBuilderConverter;
    @Autowired
    private CustomerRepository customerRepository;
    @Autowired
    private CustomerConverter customerConverter;
    @Autowired
    private UserRepository userRepository;
    @Override
    public List<CustomerSearchReponse> findCustomers(CustomerSearchRequest customerSearchRequest, Pageable pageable) {
        CustomerSearchBuilder customerSearchBuilder = customerSearchBuilderConverter.toCustomerSearchBuilder(customerSearchRequest);
        List<CustomerEntity> customerEntities = customerRepository.findCustomers(customerSearchBuilder, pageable);
        List<CustomerSearchReponse> result = new ArrayList<>();
        for(CustomerEntity item : customerEntities) {
            result.add(customerConverter.toCustomerSearchResponse(item));
        }
        return result;
    }
    @Override
    public int countTotalItems(CustomerSearchRequest customerSearchRequest, Pageable pageable) {
        CustomerSearchBuilder customerSearchBuilder = customerSearchBuilderConverter.toCustomerSearchBuilder(customerSearchRequest);
        return customerRepository.countTotalItem(customerSearchBuilder, pageable);
    }

    @Override
    public CustomerDTO findCustomerById(Long id) {
        CustomerEntity customerEntity = customerRepository.findById(id)
                .orElseThrow(() -> new NotFoundException("Customer not found!"));
        CustomerDTO customerDTO = customerConverter.toCustomerDTO(customerEntity);
        return customerDTO;
    }

    @Override
    public ResponseDTO loadStaffs(Long id) {
        CustomerEntity customerEntity = customerRepository.findById(id)
                .orElseThrow(() -> new NotFoundException("Customer not found!"));
        List<UserEntity> staffs = userRepository.findByStatusAndRoles_Code(1, "STAFF");
        List<UserEntity> staffsAssignment = customerEntity.getStaffList();
        List<StaffResponseDTO> staffResponseDTOs = new ArrayList<>();
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
            staffResponseDTOs.add(staffResponseDTO);
        }
        responseDTO.setData(staffResponseDTOs);
        responseDTO.setMessage("Success");
        return responseDTO;
    }

    @Override
    public void updateAssignment(AssignmentDTO assignmentCustomerDTO) {
        CustomerEntity customerEntity = customerRepository.findById(assignmentCustomerDTO.getId())
                .orElseThrow(() -> new NotFoundException("Customer not found!"));
        List<UserEntity> staffs = userRepository.findByIdIn(assignmentCustomerDTO.getStaffs());
        customerEntity.setStaffList(staffs);
        customerRepository.save(customerEntity);
    }

    @Override
    public void deleteCustomers(List<Long> ids) {
        for (Long id: ids) {
            CustomerEntity customerEntity = customerRepository.findById(id).get();
            customerEntity.setIsActive(0L);
            customerRepository.save(customerEntity);
        }
    }

    @Override
    public void updateOraddCustomer(CustomerDTO customerDTO) {
        CustomerEntity customerEntity = customerConverter.toCustomerEntity(customerDTO);
        if(customerDTO.getId() != null) {
            CustomerEntity customer = customerRepository.findById(customerDTO.getId()).get();
//            customerEntity.setIsActive(customer.getIsActive());
            customerEntity.setStaffList(customer.getStaffList());
            customerEntity.setCreatedBy(customer.getCreatedBy());
            customerEntity.setCreatedDate(customer.getCreatedDate());
            customerEntity.setTransactionEntities(customer.getTransactionEntities());
        }
        customerRepository.save(customerEntity);
    }
}
