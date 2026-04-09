# prop-tech-mvp-karate

Pruebas de API con **Karate** para el MVP de PropTech. Cubre las historias de usuario:

| HU | Historia | Features |
|----|----------|---------|
| HU001 | Registro de Usuario | register-happy-path, register-duplicate-email, register-email-validation, register-name-boundary, register-phone-validation, register-required-fields |
| HU003 | Inicio de Sesión | login-happy-path, login-invalid-credentials, login-format-validation, login-required-fields, login-security |
| HU004 | Publicar Propiedad | publish-setup, publish-required-fields, publish-address-boundary, publish-description-boundary, publish-price-validation, publish-security, publish-title-boundary |
| HU005 | Visualizar Propiedades | view-properties |

---

## Estructura del proyecto

```
prop-tech-mvp-karate/
├── src/test/java/
│   ├── features/
│   │   ├── auth/
│   │   │   ├── login/        # Escenarios de inicio de sesión (HU003)
│   │   │   └── register/     # Escenarios de registro (HU001)
│   │   ├── common/
│   │   │   └── auth.feature  # Helper de autenticación (@ignore)
│   │   └── properties/
│   │       ├── publish/      # Escenarios de publicación (HU004)
│   │       └── view/         # Escenarios de visualización (HU005)
│   ├── runner/
│   │   ├── ParallelRunner.java   # Runner paralelo (5 hilos)
│   │   └── TestRunner.java       # Runner secuencial
│   └── karate-config.js          # Configuración global (URL base, auth)
└── pom.xml
```

---

## Prerrequisitos

- Java 17+
- Maven 3.6+
- Backend corriendo en `http://localhost:8080`

---

## Comandos para ejecutar las pruebas

### Ejecutar todos los tests

```bash
mvn test
```

### Ejecutar una historia de usuario específica

```bash
# HU001 — Registro de Usuario
mvn "-Dkarate.options=--tags @hu001" test

# HU003 — Inicio de Sesión
mvn "-Dkarate.options=--tags @hu003" test

# HU004 — Publicar Propiedad
mvn "-Dkarate.options=--tags @hu004" test

# HU005 — Visualizar Propiedades
mvn "-Dkarate.options=--tags @hu005" test
```

### Ejecutar por tipo de prueba

```bash
# Solo pruebas de validación
mvn "-Dkarate.options=--tags @validation" test

# Solo pruebas de boundary
mvn "-Dkarate.options=--tags @boundary" test

# Solo happy path
mvn "-Dkarate.options=--tags @happy-path" test
```

### Ejecutar un único caso de prueba (por tag TC)

```bash
mvn "-Dkarate.options=--tags @TC-039" test
```

### Ver el reporte HTML

Tras ejecutar los tests, el reporte se genera en:

```
target/karate-reports/karate-summary.html
```

Abrirlo en el navegador pegando la ruta que se muestra en la salida de la consola.
