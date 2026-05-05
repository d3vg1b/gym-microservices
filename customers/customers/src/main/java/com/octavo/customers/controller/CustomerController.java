package com.octavo.customers.controller;

import com.octavo.customers.dto.CustomerRequestDTO;
import com.octavo.customers.dto.CustomerResponseDTO;
import com.octavo.customers.service.CustomerService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/customers")
@CrossOrigin(origins = "*")
public class CustomerController {

    private final CustomerService service;

    public CustomerController(CustomerService service) {
        this.service = service;
    }

    @GetMapping
    public List<CustomerResponseDTO> getAll() {
        return service.findAll();
    }

    @GetMapping("/{id}")
    public CustomerResponseDTO getById(@PathVariable("id") UUID id) {
        return service.findById(id);
    }

    @PostMapping
    public ResponseEntity<CustomerResponseDTO> create(@RequestBody CustomerRequestDTO request) {
        CustomerResponseDTO created = service.create(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(created);
    }
}
