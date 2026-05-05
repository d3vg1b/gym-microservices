package com.example.gym.controller;

import com.example.gym.dto.ProductPatchDTO;
import com.example.gym.dto.ProductRequestDTO;
import com.example.gym.dto.ProductResponseDTO;
import com.example.gym.service.ProductService;
import jakarta.validation.Valid;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("/api/v1/products")
@CrossOrigin(origins = "*")
public class ProductController {

    private final ProductService service;

    public ProductController(ProductService service) {
        this.service = service;
    }

    @GetMapping
    public Page<ProductResponseDTO> list(Pageable pageable) {
        return service.findAll(pageable);
    }

    @GetMapping("/{id}")
    public ProductResponseDTO getById(@PathVariable("id") UUID id) {
        return service.findById(id);
    }

    @PostMapping
    public ResponseEntity<ProductResponseDTO> create(@Valid @RequestBody ProductRequestDTO request) {
        ProductResponseDTO created = service.create(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(created);
    }

    @PutMapping("/{id}")
    public ProductResponseDTO update(@PathVariable("id") UUID id, @Valid @RequestBody ProductRequestDTO request) {
        return service.update(id, request);
    }

    @PatchMapping("/{id}")
    public ProductResponseDTO patch(@PathVariable("id") UUID id, @RequestBody ProductPatchDTO patch) {
        return service.patch(id, patch);
    }

    @DeleteMapping("/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void delete(@PathVariable("id") UUID id) {
        service.delete(id);
    }
}
