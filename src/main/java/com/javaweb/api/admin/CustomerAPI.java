package com.javaweb.api.admin;


import com.javaweb.model.dto.AssignmentDTO;
import com.javaweb.model.dto.CustomerDTO;
import com.javaweb.model.dto.TransactionDTO;
import com.javaweb.model.response.ResponseDTO;
import com.javaweb.service.ICustomerService;
import com.javaweb.service.ITransactionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController(value = "customerAPIOfAdmin")
@RequestMapping("/api/customer")
public class CustomerAPI {
    @Autowired
    private ICustomerService customerService;
    @Autowired
    private ITransactionService transactionService;

    @PostMapping
    public ResponseEntity<?> addOrUpdateCustomer(@RequestBody CustomerDTO customerDTO) {
        try {
            customerService.updateOraddCustomer(customerDTO);
            return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
        } catch (Exception e) {
            return ResponseEntity.ok().body(e.getMessage());
        }
    }

    @DeleteMapping("/{ids}")
    public ResponseEntity<?> deleteCustomers(@PathVariable List<Long> ids) {
        try {
            customerService.deleteCustomers(ids);
            return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }
    @GetMapping("/{id}/staffs")
    public ResponseEntity<?> loadStaffs(@PathVariable Long id) {
        ResponseDTO result = new ResponseDTO();
        try {
            result = customerService.loadStaffs(id);
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            System.out.println("error >>" + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }
    @PostMapping ("/staffs")
    public ResponseEntity<?> aupdateAssignment(@RequestBody AssignmentDTO assignmentCustomerDTO) {
        try {
            customerService.updateAssignment(assignmentCustomerDTO);
            return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }

    @PostMapping("/transaction")
    public ResponseEntity<?>  addOrUpdateTransaction(@RequestBody TransactionDTO transactionDTO) {
        try {
            transactionService.addOrUpdateTransaction(transactionDTO);
            return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }
}
