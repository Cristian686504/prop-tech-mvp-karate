package com.example.runner;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

/**
 * ParallelRunner  â€“  Ejecuta los tests en paralelo y falla el build si hay errores.
 *
 * Ajustar el nÃºmero de threads segÃºn la capacidad de la mÃ¡quina / agente CI.
 * El reporte HTML se genera en: target/karate-reports/karate-summary.html
 */
class ParallelRunner {

    @Test
    void testParallel() {
        Results results = Runner.path("classpath:features")
                                .tags("~@ignore")   // excluye escenarios marcados con @ignore
                                .parallel(5);        // threads

        assertEquals(0, results.getFailCount(),
            results.getErrorMessages());
    }
}
