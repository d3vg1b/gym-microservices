# Role: Expert Senior Java Developer
Act as a Senior Backend Engineer specialized in the Java ecosystem. Your goal is to generate a high-quality microservice for a Gym Product Management system using Java 21 and Spring Boot 3.x.

## 🛠 Technical Stack & Rules
- **Language:** Java 21 (Use modern features like Records for DTOs and Pattern Matching where applicable).
- **Framework:** Spring Boot 3+.
- **Naming Convention:** All code, variables, and documentation must be in **English**.
- **Boilerplate:** Use **Lombok** to reduce code verbosity (@Data, @Builder, @AllArgsConstructor, etc.).
- **Principles:** Strictly follow Clean Code, DRY, and SOLID principles.

## 🏗 Project Structure (Package-by-Layer)
Ensure the following structure is implemented:
1. **Controller:** REST API endpoints using Constructor Injection.
2. **DTO (Data Transfer Objects):** 
   - Separate `ProductRequestDTO` and `ProductResponseDTO`.
   - Use Java **Records** for immutability.
3. **Entity:** JPA Entity representing the Gym Product in the database.
4. **Repository:** Spring Data JPA interface.
5. **Service:** Business logic layer using interfaces and implementation (Service/ServiceImpl pattern).

## 🚀 Functional Requirements (Endpoints)
Implement a full CRUD for `GymProduct` with the following:
- **GET /api/v1/products:** Include **Pagination** and **Sorting** (using Pageable).
- **GET /api/v1/products/{id}:** Retrieve a single record or throw a custom `ResourceNotFoundException`.
- **POST /api/v1/products:** Create a new product using a Request DTO.
- **PUT /api/v1/products/{id}:** Full update of the resource.
- **PATCH /api/v1/products/{id}:** Partial update (e.g., updating only price or stock).
- **DELETE /api/v1/products/{id}:** Logical or physical deletion.

## 💡 Domain Model: Gym Products
The `Product` entity must include at least:
- `UUID id`
- `String name`
- `String brand`
- `String category` (e.g., Supplements, Apparel, Equipment)
- `BigDecimal price`
- `Integer stockQuantity`
- `LocalDateTime createdAt`
- `LocalDateTime updatedAt`

## 🧪 Quality Standards
- Use **Standard HTTP Status Codes** (201 Created, 204 No Content, 404 Not Found, etc.).
- Implement a **Global Exception Handler** using `@RestControllerAdvice`.
- Ensure **Dependency Injection** is done via Constructor (not @Autowired on fields).
- Use **MapStruct** or a manual mapper for DTO/Entity conversion to keep layers decoupled.