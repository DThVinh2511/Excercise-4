package com.javaweb.converter;

import com.javaweb.entity.CustomerEntity;
import com.javaweb.enums.Status;
import com.javaweb.model.dto.CustomerDTO;
import com.javaweb.model.response.CustomerSearchReponse;
import com.javaweb.utils.StringUtils;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Map;

@Component
public class CustomerConverter {
    @Autowired
    private ModelMapper modelMapper;

    public CustomerSearchReponse toCustomerSearchResponse(CustomerEntity customer) {
        CustomerSearchReponse customerSearchResponse = modelMapper.map(customer, CustomerSearchReponse.class);
        Map<String, String> statusCode = Status.type();
        String status = StringUtils.check(customer.getStatus()) ? statusCode.get(customer.getStatus()) : "" ;
        customerSearchResponse.setStatus(status);
        return customerSearchResponse;
    }
    public CustomerEntity toCustomerEntity(CustomerDTO customerDTO) {
        return modelMapper.map(customerDTO, CustomerEntity.class);
    }
    public CustomerDTO toCustomerDTO(CustomerEntity customerEntity) {
        return modelMapper.map(customerEntity, CustomerDTO.class);
    }
}
