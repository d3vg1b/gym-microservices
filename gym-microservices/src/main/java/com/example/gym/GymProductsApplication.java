package com.example.gym;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

@SpringBootApplication
@EnableDiscoveryClient
public class GymProductsApplication {
    public static void main(String[] args) {
        SpringApplication.run(GymProductsApplication.class, args);
    }
}