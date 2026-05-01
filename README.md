# Automatización API — Tosca Cloud CoffeeShop

Proyecto de automatización de servicios REST sobre la API de Tosca Cloud usando Karate DSL.

## Tecnologías
- Java 11
- Karate DSL 1.4.1
- JUnit 5
- Karate Netty (Mock Server)
- Gradle
- Azure DevOps

## Flujo automatizado — CRUD Coffees

| Bloque | Método | Endpoint |
|--------|--------|----------|
| 1. Crear | POST | /api/v1/Coffees |
| 2. Consultar | GET | /api/v1/Coffees/{id} |
| 3. Actualizar | PUT | /api/v1/Coffees |
| 4. Eliminar | DELETE | /api/v1/Coffees?id={id} |
| 5. Validar eliminación | GET | /api/v1/Coffees/{id} |

## Cómo ejecutar

```bash
# API real
./gradlew test -Dkarate.env=real

# Mock local
./gradlew test -Dkarate.env=mock
```

## CI/CD
Pipeline configurado en Azure DevOps. Se ejecuta automáticamente con push a `main` o al crear un PR hacia `main`.
