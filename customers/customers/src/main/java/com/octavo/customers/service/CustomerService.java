package com.octavo.customers.service;

import com.octavo.customers.dto.CustomerRequestDTO;
import com.octavo.customers.dto.CustomerResponseDTO;
import java.util.List;
import java.util.UUID;

public interface CustomerService {
    List<CustomerResponseDTO> findAll();
    CustomerResponseDTO findById(UUID id);
    CustomerResponseDTO create(CustomerRequestDTO request);
}
