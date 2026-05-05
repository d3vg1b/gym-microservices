# Customers Microservice

Microservicio para la gestión integral de clientes dentro del ecosistema. Provee operaciones CRUD mediante una API REST para administrar la información de los usuarios.

## Requisitos previos
- Java 21+
- Gradle 8+
- Spring Boot 3.5.14
- Eureka Server (opcional, recomendado para descubrimiento)

## Instalación

```bash
git clone <url-del-repo>
cd backend/customers/customers
./gradlew clean build
```

## Ejemplo de uso rápido

Para levantar el servicio de forma local y validar su funcionamiento:

```bash
./gradlew bootRun
```
El servicio estará disponible en `http://localhost:8083`. Puedes acceder al endpoint `GET /api/v1/customers` para verificar que retorna un array vacío o la lista de clientes.

## Estructura del proyecto

```text
src/main/java/com/octavo/customers/
├── controller/     # Controladores REST que exponen la API
├── dto/            # Data Transfer Objects para peticiones y respuestas
├── entity/         # Entidades JPA (modelo de base de datos)
├── repository/     # Interfaces de acceso a datos (Spring Data JPA)
└── service/        # Lógica de negocio e interfaces de servicio
```

## Variables de entorno

| Nombre | Descripción | Ejemplo | Obligatoria |
|---|---|---|---|
| `server.port` | Puerto de ejecución del servidor | `8083` | No (por defecto 8080) |
| `spring.datasource.url` | URL de conexión JDBC | `jdbc:h2:mem:customersdb` | Sí |
| `eureka.client.server-url.defaultZone` | URL de Eureka Server | `http://localhost:8761/eureka/` | Sí |

## Cómo ejecutar los tests

```bash
./gradlew test
```

## Guía de API

### 1. Obtener todos los clientes
- **Método**: `GET`
- **Ruta**: `/api/v1/customers`
- **Descripción**: Recupera el listado completo de clientes registrados.
- **Respuesta Exitosa (200 OK)**:
```json
[
  {
    "id": "123e4567-e89b-12d3-a456-426614174000",
    "firstName": "Juan",
    "lastName": "Perez",
    "email": "juan@example.com",
    "phone": "123456789",
    "createdAt": "2026-05-05T00:00:00",
    "updatedAt": "2026-05-05T00:00:00"
  }
]
```

### 2. Obtener cliente por ID
- **Método**: `GET`
- **Ruta**: `/api/v1/customers/{id}`
- **Descripción**: Obtiene los detalles de un cliente específico mediante su UUID.
- **Parámetros**: `id` (UUID del cliente en el path).
- **Posibles errores**: `404 Not Found` (Cliente no existe) u `500 Internal Server Error`.

### 3. Crear cliente
- **Método**: `POST`
- **Ruta**: `/api/v1/customers`
- **Descripción**: Registra un nuevo cliente en el sistema.
- **Body de ejemplo**:
```json
{
  "firstName": "Juan",
  "lastName": "Perez",
  "email": "juan@example.com",
  "phone": "123456789"
}
```
- **Respuesta Exitosa (201 Created)**: El objeto del cliente recién creado con su UUID asignado.

## Contribución
1. Haz un fork del repositorio.
2. Crea una rama para tu feature (`git checkout -b feature/nueva-feature`).
3. Haz commit de tus cambios (`git commit -m 'Añadir nueva feature'`).
4. Haz push a la rama (`git push origin feature/nueva-feature`).
5. Abre un Pull Request.
