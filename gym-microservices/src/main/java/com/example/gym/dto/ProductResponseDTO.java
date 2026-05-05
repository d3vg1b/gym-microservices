package com.example.gym.dto;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.UUID;

public record ProductResponseDTO(
        UUID id,
        String name,
        String brand,
        String category,
        BigDecimal price,
        Integer stockQuantity,
        LocalDateTime createdAt,
        LocalDateTime updatedAt
){ }
