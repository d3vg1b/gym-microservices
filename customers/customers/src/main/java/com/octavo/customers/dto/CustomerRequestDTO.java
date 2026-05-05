package com.octavo.customers.dto;

import lombok.Data;

@Data
public class CustomerRequestDTO {
    private String firstName;
    private String lastName;
    private String email;
    private String phone;
}
