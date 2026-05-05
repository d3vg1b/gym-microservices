package com.example.gym.dto;

import java.math.BigDecimal;

public record ProductPatchDTO(
        BigDecimal price,
        Integer stockQuantity
){ }
