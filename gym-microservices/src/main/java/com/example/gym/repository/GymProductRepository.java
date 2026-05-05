package com.example.gym.repository;

import com.example.gym.entity.GymProduct;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface GymProductRepository extends JpaRepository<GymProduct, UUID> {
}
