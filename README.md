# Microservices

Plataforma de microservicios backend diseñada para aplicaciones de gestión de gimnasios. 
Arquitectura basada en Spring Cloud con descubrimiento de servicios, persistencia de datos y API RESTful escalables.

### 📦 Microservicios

| Servicio | Puerto | Descripción | Tecnología |
|----------|--------|-------------|------------|
| **Eureka Server** | 8761 | Descubrimiento de servicios | Spring Cloud Netflix |
| **Customers Service** | 8083 | Gestión de clientes | Spring Boot + JPA |
| **Gym Products Service** | 8082 | Catálogo de productos y suplementos | Spring Boot + JPA |

## 🚀 Inicio Rápido

### Prerrequisitos

- **Java 21+** - JDK compatible con Spring Boot 3.x
- **Maven 3.8+** o **Gradle 8+** - Gestión de dependencias
- **Spring Boot 3.5.14** - Framework principal
- **Spring Cloud 2025.0.2** - Framework de microservicios

### Instalación y Ejecución

1. **Clonar el repositorio**
   ```bash
   git clone <repository-url>
   cd backend
   ```

2. **Construir todos los módulos**
   ```bash
   # Para módulos Maven (Gym Products)
   cd gym-microservices
   mvn clean install
   
   # Para módulos Gradle (Customers, Eureka)
   cd ../customers/customers
   ./gradlew clean build
   
   cd ../../eurekaserver/eurekaserver
   ./gradlew clean build
   ```

3. **Iniciar los servicios en orden**

   **Paso 1: Iniciar Eureka Server**
   ```bash
   cd eurekaserver/eurekaserver
   ./gradlew bootRun
   ```
   Accede a: http://localhost:8761

   **Paso 2: Iniciar Customers Service**
   ```bash
   cd customers/customers
   ./gradlew bootRun
   ```
   Disponible en: http://localhost:8083

   **Paso 3: Iniciar Gym Products Service**
   ```bash
   cd gym-microservices
   mvn spring-boot:run
   ```
   Disponible en: http://localhost:8082

## 🔧 Configuración

### Variables de Entorno Globales

| Variable | Descripción | Valor por Defecto |
|----------|-------------|-------------------|
| `EUREKA_SERVER_URL` | URL del servidor Eureka | `http://localhost:8761/eureka/` |
| `DB_URL` | URL de base de datos H2 | `jdbc:h2:mem:testdb` |
| `DB_DRIVER` | Driver JDBC | `org.h2.Driver` |

### Configuración por Servicio

#### Eureka Server
- **Puerto**: 8761
- **Auto-registro**: false
- **Fetch Registry**: false

#### Customers Service
- **Puerto**: 8083
- **Base Path**: `/api/v1/customers`
- **Base de datos**: `customersdb`

#### Gym Products Service
- **Puerto**: 8082
- **Base Path**: `/api/v1/products`
- **Base de datos**: `gymdb`

## 📚 Documentación de APIs

### Customers Service API

#### Endpoints Principales

| Método | Endpoint | Descripción |
|--------|----------|-------------|
| `GET` | `/api/v1/customers` | Listar todos los clientes |
| `GET` | `/api/v1/customers/{id}` | Obtener cliente por UUID |
| `POST` | `/api/v1/customers` | Crear nuevo cliente |
| `PUT` | `/api/v1/customers/{id}` | Actualizar cliente completo |
| `DELETE` | `/api/v1/customers/{id}` | Eliminar cliente |

#### Ejemplo de Request (POST)
```json
{
  "firstName": "Juan",
  "lastName": "Perez",
  "email": "juan@example.com",
  "phone": "123456789"
}
```

### Gym Products Service API

#### Endpoints Principales

| Método | Endpoint | Descripción |
|--------|----------|-------------|
| `GET` | `/api/v1/products` | Listar productos (paginado) |
| `GET` | `/api/v1/products/{id}` | Obtener producto por UUID |
| `POST` | `/api/v1/products` | Crear nuevo producto |
| `PUT` | `/api/v1/products/{id}` | Actualizar producto completo |
| `PATCH` | `/api/v1/products/{id}` | Actualización parcial |
| `DELETE` | `/api/v1/products/{id}` | Eliminar producto |

#### Ejemplo de Request (POST)
```json
{
  "name": "Whey Protein",
  "brand": "Optimum Nutrition",
  "category": "Suplementos",
  "price": 59.99,
  "stockQuantity": 100
}
```

## 🏛️ Estructura del Proyecto

```
backend/
├── eurekaserver/                 # Servidor de descubrimiento
│   └── eurekaserver/
│       ├── src/main/java/
│       ├── build.gradle
│       └── README.md
├── customers/                    # Microservicio de clientes
│   └── customers/
│       ├── src/main/java/
│       │   └── com/octavo/customers/
│       │       ├── controller/
│       │       ├── dto/
│       │       ├── entity/
│       │       ├── repository/
│       │       └── service/
│       ├── build.gradle
│       └── README.md
├── gym-microservices/            # Microservicio de productos
│   ├── src/main/java/
│   │   └── com/example/gym/
│   │       ├── controller/
│   │       ├── dto/
│   │       ├── entity/
│   │       ├── exception/
│   │       ├── mapper/
│   │       ├── repository/
│   │       └── service/
│   ├── pom.xml
│   └── README.md
├── settings.gradle               # Configuración Gradle multi-módulo
└── README.md                    # Este archivo
```

## 🧪 Testing

### Ejecutar Tests por Servicio

```bash
# Customers Service (Gradle)
cd customers/customers
./gradlew test

# Gym Products Service (Maven)
cd gym-microservices
mvn test

# Eureka Server (Gradle)
cd eurekaserver/eurekaserver
./gradlew test
```

### Cobertura de Pruebas

- **Customers Service**: Tests unitarios y de integración para CRUD
- **Gym Products Service**: Tests unitarios para lógica de negocio y validaciones
- **Eureka Server**: Tests básicos de configuración

### Eureka Dashboard

Accede al panel de control de Eureka para monitorear servicios registrados:
```
http://localhost:8761
```

## 🛠️ Tecnologías y Dependencias

### Stack Principal

| Tecnología | Versión | Uso |
|------------|---------|-----|
| **Java** | 21 | Lenguaje principal |
| **Spring Boot** | 3.5.14 | Framework de aplicaciones |
| **Spring Cloud** | 2025.0.2 | Framework de microservicios |
| **Spring Data JPA** | 3.5.14 | Persistencia de datos |
| **H2 Database** | Runtime | Base de datos en memoria |
| **Lombok** | 1.18.40 | Reducción de código boilerplate |
| **Maven** | 3.8+ | Gestión de dependencias (Gym) |
| **Gradle** | 8+ | Gestión de dependencias (Customers, Eureka) |

### Dependencias Clave

```xml
<!-- Spring Cloud Netflix Eureka -->
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-netflix-eureka-client</artifactId>
</dependency>

<!-- Spring Boot Web -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
</dependency>

<!-- Spring Data JPA -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-data-jpa</artifactId>
</dependency>

<!-- H2 Database -->
<dependency>
    <groupId>com.h2database</groupId>
    <artifactId>h2</artifactId>
    <scope>runtime</scope>
</dependency>
```