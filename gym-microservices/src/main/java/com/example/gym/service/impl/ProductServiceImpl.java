package com.example.gym.service.impl;

import com.example.gym.dto.ProductPatchDTO;
import com.example.gym.dto.ProductRequestDTO;
import com.example.gym.dto.ProductResponseDTO;
import com.example.gym.entity.GymProduct;
import com.example.gym.exception.ResourceNotFoundException;
import com.example.gym.mapper.ProductMapper;
import com.example.gym.repository.GymProductRepository;
import com.example.gym.service.ProductService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

@Service
@Transactional
public class ProductServiceImpl implements ProductService {

    private final GymProductRepository repository;

    public ProductServiceImpl(GymProductRepository repository) {
        this.repository = repository;
    }

    @Override
    public Page<ProductResponseDTO> findAll(Pageable pageable) {
        return repository.findAll(pageable).map(ProductMapper::toDto);
    }

    @Override
    public ProductResponseDTO findById(UUID id) {
        GymProduct p = repository.findById(id).orElseThrow(() -> new ResourceNotFoundException("Product not found"));
        return ProductMapper.toDto(p);
    }

    @Override
    public ProductResponseDTO create(ProductRequestDTO request) {
        GymProduct entity = ProductMapper.toEntity(request);
        GymProduct saved = repository.save(entity);
        return ProductMapper.toDto(saved);
    }

    @Override
    public ProductResponseDTO update(UUID id, ProductRequestDTO request) {
        GymProduct existing = repository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Product not found"));
        ProductMapper.updateFromRequest(request, existing);
        GymProduct saved = repository.save(existing);
        return ProductMapper.toDto(saved);
    }

    @Override
    public ProductResponseDTO patch(UUID id, ProductPatchDTO patch) {
        GymProduct existing = repository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Product not found"));
        if (patch.price() != null)
            existing.setPrice(patch.price());
        if (patch.stockQuantity() != null)
            existing.setStockQuantity(patch.stockQuantity());
        GymProduct saved = repository.save(existing);
        return ProductMapper.toDto(saved);
    }

    @Override
    public void delete(UUID id) {
        if (!repository.existsById(id))
            throw new ResourceNotFoundException("Product not found");
        repository.deleteById(id);
    }
}
