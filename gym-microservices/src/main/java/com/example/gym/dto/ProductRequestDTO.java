package com.example.gym.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import java.math.BigDecimal;

public record ProductRequestDTO(
        @NotBlank String name,
        String brand,
        String category,
        @NotNull BigDecimal price,
        Integer stockQuantity
){ }
