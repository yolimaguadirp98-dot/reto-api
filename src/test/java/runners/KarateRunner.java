package runners;

import com.intuit.karate.core.MockServer;
import com.intuit.karate.junit5.Karate;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class KarateRunner {

    private static final Logger logger = LoggerFactory.getLogger(KarateRunner.class);
    static MockServer server;
    static final int port = 8090;
    static String env;

    @BeforeAll
    static void setup() {
        env = System.getProperty("karate.env", "real");
        logger.info("Ambiente activo: {}", env);

        if ("mock".equals(env)) {
            server = MockServer
                    .feature("classpath:features/mock/coffee-mock-server.feature")
                    .http(port)
                    .build();
            logger.info("Mock server iniciado en puerto: {}", port);
        } else {
            logger.info("Usando API real: https://webservice.toscacloud.com");
        }
    }

    @AfterAll
    static void tearDown() {
        if (server != null) {
            server.stop();
            logger.info("Mock server detenido");
        }
    }

    @Karate.Test
    Karate runAllTests() {
        logger.info("Iniciando ejecucion de tests Karate en ambiente: {}", env);
        return Karate.run("classpath:features/test")
                .systemProperty("karate.env", env);
    }
}