package com.example.runner;

import com.intuit.karate.junit5.Karate;

/**
 * TestRunner  â€“  Runner principal de la suite completa.
 *
 * Ejecutar todos los tests:
 *   mvn test
 *
 * Filtrar por tag:
 *   mvn test -Dkarate.options="--tags @smoke"
 *
 * Cambiar ambiente:
 *   mvn test -Dkarate.env=staging
 */
class TestRunner {

    @Karate.Test
    Karate testAll() {
        return Karate.run("classpath:features")
                     .relativeTo(getClass());
    }
}
