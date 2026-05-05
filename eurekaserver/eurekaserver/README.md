# Eureka Server

Servidor de descubrimiento de servicios (Service Discovery) usando Spring Cloud Netflix Eureka. Centraliza y orquesta el registro de todos los microservicios del ecosistema (Customers, Gym, etc.).

## Requisitos previos
- Java 21+
- Gradle 8+
- Spring Boot 3.5.14
- Spring Cloud 2025.0.2

## Instalación

```bash
git clone <url-del-repo>
cd backend/eurekaserver/eurekaserver
./gradlew clean build
```

## Ejemplo de uso rápido

Levanta el servidor Eureka:

```bash
./gradlew bootRun
```
Accede a `http://localhost:8761` en tu navegador para ver el panel de control de Eureka y comprobar las instancias conectadas.

## Estructura del proyecto

```text
src/main/java/com/octavo/eurekaserver/
└── EurekaserverApplication.java  # Clase principal que arranca el servidor
```

## Variables de entorno

| Nombre | Descripción | Ejemplo | Obligatoria |
|---|---|---|---|
| `server.port` | Puerto de ejecución del servidor Eureka | `8761` | Sí |
| `eureka.client.register-with-eureka` | Indica si Eureka debe registrarse a sí mismo | `false` | Sí |
| `eureka.client.fetch-registry` | Indica si debe obtener el registro de otros | `false` | Sí |

## Cómo ejecutar los tests

```bash
./gradlew test
```

## Guía de API
No se exponen endpoints de negocio personalizados. La comunicación se realiza mediante el cliente Eureka que se embebe en los microservicios, el cual se encarga de enviar heartbeats periódicos a la ruta `/eureka/apps`.

## Contribución
1. Fork al repositorio.
2. Crea una rama para los cambios.
3. Commit y push.
4. Abre un Pull Request para revisión.
