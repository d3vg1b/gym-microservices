package com.example.gym.mapper;

import com.example.gym.dto.ProductRequestDTO;
import com.example.gym.dto.ProductResponseDTO;
import com.example.gym.entity.GymProduct;

import java.util.UUID;

public final class ProductMapper {
    private ProductMapper() {}

    public static ProductResponseDTO toDto(GymProduct e) {
        if (e == null) return null;
        return new ProductResponseDTO(
                e.getId(),
                e.getName(),
                e.getBrand(),
                e.getCategory(),
                e.getPrice(),
                e.getStockQuantity(),
                e.getCreatedAt(),
                e.getUpdatedAt()
        );
    }

    public static GymProduct toEntity(ProductRequestDTO r) {
        if (r == null) return null;
        return GymProduct.builder()
                .id(UUID.randomUUID())
                .name(r.name())
                .brand(r.brand())
                .category(r.category())
                .price(r.price())
                .stockQuantity(r.stockQuantity())
                .build();
    }

    public static void updateFromRequest(ProductRequestDTO r, GymProduct e) {
        if (r == null || e == null) return;
        e.setName(r.name());
        e.setBrand(r.brand());
        e.setCategory(r.category());
        e.setPrice(r.price());
        e.setStockQuantity(r.stockQuantity());
    }
}
