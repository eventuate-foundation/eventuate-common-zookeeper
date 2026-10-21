package io.eventuate.common.testcontainers;

import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

public class EventuateZookeeperContainerImageTest {

    @Test
    public void shouldUseTheImageOfTheProjectVersion() {
        String version = System.getProperty("eventuate.common.zookeeper.version");

        assertThat(new EventuateZookeeperContainer().getDockerImageName())
                .isEqualTo("eventuateio/eventuate-zookeeper:" + version);
    }
}
