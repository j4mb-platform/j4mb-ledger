package com.j4mb.ledger;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.ApplicationListener;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Component;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.nio.file.Files;
import java.nio.file.Path;

@Component
public class StartupInfoListener implements ApplicationListener<ApplicationReadyEvent> {

    private static final Logger log = LoggerFactory.getLogger(StartupInfoListener.class);

    private final Environment environment;

    public StartupInfoListener(Environment environment) {
        this.environment = environment;
    }

    @Override
    public void onApplicationEvent(ApplicationReadyEvent event) {
        String port = environment.getProperty("server.port", "8080");
        String contextPath = environment.getProperty("server.servlet.context-path", "");
        String[] activeProfiles = environment.getActiveProfiles();
        String profiles = activeProfiles.length > 0 ? String.join(", ", activeProfiles) : "default";

        String externalHost;
        try {
            externalHost = InetAddress.getLocalHost().getHostAddress();
        } catch (UnknownHostException e) {
            externalHost = "unknown";
        }

        String localUrl = "http://localhost:" + port + contextPath;
        String externalUrl = "http://" + externalHost + ":" + port + contextPath;

        StringBuilder banner = new StringBuilder();
        banner.append("\n----------------------------------------------------------\n");
        banner.append("  J4MB Ledger is running!\n");
        banner.append("----------------------------------------------------------\n");
        banner.append("  Local:     ").append(localUrl).append("\n");
        banner.append("  External:  ").append(externalUrl).append("\n");
        banner.append("  API:       ").append(localUrl).append("/api/v1\n");
        banner.append("  Actuator:  ").append(localUrl).append("/actuator\n");
        banner.append("  Profiles:  ").append(profiles).append("\n");

        if (Files.exists(Path.of("frontend"))) {
            String vitePort = environment.getProperty("VITE_PORT", "5173");
            banner.append("  Frontend:  http://localhost:").append(vitePort).append("\n");
        }

        banner.append("----------------------------------------------------------");
        log.info(banner.toString());
    }
}
