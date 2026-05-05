package com.example.gym.service;

import com.example.gym.dto.ProductPatchDTO;
import com.example.gym.dto.ProductRequestDTO;
import com.example.gym.dto.ProductResponseDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.UUID;

public interface ProductService {
    Page<ProductResponseDTO> findAll(Pageable pageable);

    ProductResponseDTO findById(UUID id);

    ProductResponseDTO create(ProductRequestDTO request);

    ProductResponseDTO update(UUID id, ProductRequestDTO request);

    ProductResponseDTO patch(UUID id, ProductPatchDTO patch);

    void delete(UUID id);
}
