package runners;

import com.intuit.karate.core.MockServer;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

public class MockRunner {

    static MockServer server;
    static int port = 8090;

    @BeforeAll
    static void startMockServer() {
        server = MockServer
                .feature("classpath:features/mock/coffee-mock-server.feature")
                .http(port)
                .build();
        System.out.println("Mock server started on port: " + port);
    }

    @AfterAll
    static void stopMockServer() {
        if (server != null) {
            server.stop();
            System.out.println("Mock server stopped");
        }
    }

    @Test
    void mockServerRunning() {
        System.out.println("Mock server is running on port: " + server.getPort());
    }
}