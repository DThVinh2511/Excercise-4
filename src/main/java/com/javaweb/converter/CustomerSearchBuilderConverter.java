package com.javaweb.converter;

import com.javaweb.builder.CustomerSearchBuilder;
import com.javaweb.model.request.CustomerSearchRequest;
import org.springframework.stereotype.Component;

@Component
public class CustomerSearchBuilderConverter {
    public CustomerSearchBuilder toCustomerSearchBuilder(CustomerSearchRequest customerSearchRequest) {
        CustomerSearchBuilder customerSearchBuilder = new CustomerSearchBuilder.BuilderCustomer()
                .setFullName(customerSearchRequest.getFullName())
                .setPhone(customerSearchRequest.getPhone())
                .setEmail(customerSearchRequest.getEmail())
                .setStaffId(customerSearchRequest.getStaffId())
                .build();
        return customerSearchBuilder;
    }
}
